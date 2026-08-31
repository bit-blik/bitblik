import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

import '../../i18n/gen/strings.g.dart';
import '../coordinator_console/coordinator_console.dart';
import '../services/coordinator_console_account_store.dart';

class CoordinatorConsoleAccessScreen extends StatefulWidget {
  static const routeName = '/settings/coordinator-console';

  final Ndk Function()? ndkFactory;
  final CoordinatorConsoleAccountStore accountStore;

  const CoordinatorConsoleAccessScreen({
    super.key,
    this.ndkFactory,
    this.accountStore = const CoordinatorConsoleAccountStore(),
  });

  @override
  State<CoordinatorConsoleAccessScreen> createState() =>
      _CoordinatorConsoleAccessScreenState();
}

class _CoordinatorConsoleAccessScreenState
    extends State<CoordinatorConsoleAccessScreen> {
  late final Ndk _coordinatorNdk;
  late final NdkFlutter _coordinatorNdkFlutter;
  late final CoordinatorSession _session;
  late final Future<void> _startup;
  bool _loginBusy = false;
  bool _loginFailed = false;

  bool get _supportsNip55 =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  bool get _supportsNip07 => kIsWeb;
  bool get _supportsNsec =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  @override
  void initState() {
    super.initState();
    _coordinatorNdk =
        widget.ndkFactory?.call() ??
        Ndk(
          NdkConfig(
            cache: MemCacheManager(),
            eventVerifier: Bip340EventVerifier(),
            bootstrapRelays: const [],
            logLevel: LogLevel.warning,
          ),
        );
    _coordinatorNdkFlutter = NdkFlutter(ndk: _coordinatorNdk);
    _session = CoordinatorSession(
      ndkFlutter: _coordinatorNdkFlutter,
      accountStateSaver: () => widget.accountStore.save(_coordinatorNdk),
    );
    _startup = _initialize();
  }

  Future<void> _initialize() async {
    await widget.accountStore.restore(_coordinatorNdk);
    await _session.restoreActiveCoordinator();
    await _session.refreshCoordinatorProfiles();
  }

  @override
  void dispose() {
    _session.dispose();
    unawaited(_shutdownCoordinatorNdk());
    super.dispose();
  }

  Future<void> _shutdownCoordinatorNdk() async {
    await _session.close();
    for (final account in _coordinatorNdk.accounts.accounts.values.toList()) {
      await account.dispose();
    }
    await _coordinatorNdk.destroy();
  }

  Future<void> _login() async {
    if (_loginBusy) return;
    setState(() {
      _loginBusy = true;
      _loginFailed = false;
    });
    try {
      if (_supportsNip07) {
        final signer = Nip07EventSigner();
        if (!signer.canSign()) {
          throw StateError('NIP-07 extension unavailable');
        }
        final pubkey = (await signer.getPublicKeyAsync()).toLowerCase();
        if (_coordinatorNdk.accounts.hasAccount(pubkey)) {
          _coordinatorNdk.accounts.switchAccount(pubkey: pubkey);
        } else {
          _coordinatorNdk.accounts.loginExternalSigner(signer: signer);
        }
      } else if (_supportsNip55) {
        const signerApp = Nip55Signer();
        if (!await signerApp.isAppInstalled()) {
          throw StateError('NIP-55 signer app unavailable');
        }
        final login = await signerApp.login();
        if (login == null) return;
        final pubkey = login.pubkey.toLowerCase();
        if (_coordinatorNdk.accounts.hasAccount(pubkey)) {
          _coordinatorNdk.accounts.switchAccount(pubkey: pubkey);
        } else {
          _coordinatorNdk.accounts.loginExternalSigner(
            signer: Nip55EventSigner(
              publicKey: pubkey,
              nip55Signer: Nip55Signer(package: login.package),
            ),
          );
        }
      } else {
        throw UnsupportedError('External coordinator login is unsupported');
      }
      await widget.accountStore.save(_coordinatorNdk);
      await _session.activateLoggedInAccount();
      await _session.refreshCoordinatorProfiles();
    } catch (error) {
      debugPrint('Coordinator console login failed: $error');
      if (mounted) setState(() => _loginFailed = true);
    } finally {
      if (mounted) setState(() => _loginBusy = false);
    }
  }

  Future<void> _loginWithNsec() async {
    if (_loginBusy) return;
    final strings = Translations.of(context).settings.coordinatorConsole;
    final controller = TextEditingController();
    var obscureText = true;
    final input = await showDialog<String>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(strings.nsecDialogTitle),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  obscureText: obscureText,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    labelText: strings.nsecFieldLabel,
                    hintText: 'nsec1…',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setDialogState(() => obscureText = !obscureText),
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  onSubmitted: (value) =>
                      Navigator.of(dialogContext).pop(value),
                ),
                const SizedBox(height: 12),
                Text(
                  strings.nsecSecurityNote,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(controller.text),
              child: Text(strings.loginWithNsec),
            ),
          ],
        ),
      ),
    );
    controller.dispose();
    if (input == null || input.trim().isEmpty || !mounted) return;

    setState(() {
      _loginBusy = true;
      _loginFailed = false;
    });
    try {
      final value = input.trim();
      if (!Nip19.isPrivateKey(value)) {
        throw const FormatException('Invalid nsec');
      }
      final privateKey = Nip19.decode(value).toLowerCase();
      if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(privateKey)) {
        throw const FormatException('Invalid nsec');
      }
      final pubkey = _coordinatorNdk.config.eventSignerFactory
          .derivePublicKey(privateKey)
          .toLowerCase();
      if (_coordinatorNdk.accounts.hasAccount(pubkey)) {
        final existing = _coordinatorNdk.accounts.accounts[pubkey]!;
        final existingSigner = existing.signer;
        if (existingSigner is Bip340EventSigner &&
            existingSigner.privateKey == privateKey) {
          _coordinatorNdk.accounts.switchAccount(pubkey: pubkey);
        } else {
          _coordinatorNdk.accounts.removeAccount(pubkey: pubkey);
          await existing.dispose();
          _coordinatorNdk.accounts.loginPrivateKey(
            pubkey: pubkey,
            privkey: privateKey,
          );
        }
      } else {
        _coordinatorNdk.accounts.loginPrivateKey(
          pubkey: pubkey,
          privkey: privateKey,
        );
      }
      await widget.accountStore.save(_coordinatorNdk);
      await _session.activateLoggedInAccount();
      await _session.refreshCoordinatorProfiles();
    } catch (error) {
      debugPrint('Coordinator nsec login failed: $error');
      if (mounted) setState(() => _loginFailed = true);
    } finally {
      if (mounted) setState(() => _loginBusy = false);
    }
  }

  Future<void> _activateAccount(String pubkey) async {
    if (_loginBusy) return;
    setState(() {
      _loginBusy = true;
      _loginFailed = false;
    });
    try {
      _coordinatorNdk.accounts.switchAccount(pubkey: pubkey);
      await widget.accountStore.save(_coordinatorNdk);
      await _session.activateLoggedInAccount();
      await _session.refreshCoordinatorProfiles();
    } catch (error) {
      debugPrint('Coordinator account switch failed: $error');
      if (mounted) setState(() => _loginFailed = true);
    } finally {
      if (mounted) setState(() => _loginBusy = false);
    }
  }

  Future<void> _prepareAddAccount() async {
    await _session.prepareAddCoordinator();
    if (mounted) setState(() => _loginFailed = false);
  }

  Future<void> _removeAccount(Account account) async {
    if (account.pubkey == _coordinatorNdk.accounts.getPublicKey()) return;
    _coordinatorNdk.accounts.removeAccount(pubkey: account.pubkey);
    await account.dispose();
    await widget.accountStore.save(_coordinatorNdk);
    await _session.refreshCoordinatorProfiles();
  }

  Future<void> _showAccounts() async {
    await _session.refreshCoordinatorProfiles();
    if (!mounted) return;
    final strings = Translations.of(context).settings.coordinatorConsole;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final activePubkey = _coordinatorNdk.accounts.getPublicKey();
          final accounts = _session.accounts;
          return AlertDialog(
            title: Text(strings.accountsTitle),
            content: SizedBox(
              width: 620,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final account in accounts)
                    ListTile(
                      leading: NPicture(
                        ndkFlutter: _coordinatorNdkFlutter,
                        pubkey: account.pubkey,
                      ),
                      title: NName(
                        ndkFlutter: _coordinatorNdkFlutter,
                        pubkey: account.pubkey,
                      ),
                      trailing: account.pubkey == activePubkey
                          ? Icon(
                              Icons.radio_button_checked,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : IconButton(
                              tooltip: strings.removeAccount,
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () async {
                                try {
                                  await _removeAccount(account);
                                  if (dialogContext.mounted) {
                                    setDialogState(() {});
                                  }
                                } catch (error) {
                                  debugPrint(
                                    'Coordinator account removal failed: $error',
                                  );
                                  if (mounted) {
                                    setState(() => _loginFailed = true);
                                  }
                                }
                              },
                            ),
                      onTap: account.pubkey == activePubkey
                          ? null
                          : () {
                              Navigator.of(dialogContext).pop();
                              unawaited(_activateAccount(account.pubkey));
                            },
                    ),
                ],
              ),
            ),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  unawaited(_prepareAddAccount());
                },
                icon: const Icon(Icons.add),
                label: Text(strings.addAccount),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(MaterialLocalizations.of(context).closeButtonLabel),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = Translations.of(context).settings.coordinatorConsole;
    return FutureBuilder<void>(
      future: _startup,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: Text(strings.title)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return AnimatedBuilder(
          animation: _session,
          builder: (context, _) {
            if (_session.isAuthenticated) {
              return DisputeQueueScreen(
                key: ValueKey(_session.expectedCoordinatorPubkey),
                session: _session,
                allowAccountManagement: false,
                onManageAccounts: _showAccounts,
                onLogout: _session.logout,
              );
            }
            return Scaffold(
              appBar: AppBar(title: Text(strings.title)),
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    shrinkWrap: true,
                    children: [
                      Icon(
                        Icons.admin_panel_settings_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        strings.signInTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.signInDescription,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.separateIdentityNote,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (_session.accounts.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          strings.savedAccounts,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        for (final account in _session.accounts)
                          Card(
                            child: ListTile(
                              leading: NPicture(
                                ndkFlutter: _coordinatorNdkFlutter,
                                pubkey: account.pubkey,
                              ),
                              title: NName(
                                ndkFlutter: _coordinatorNdkFlutter,
                                pubkey: account.pubkey,
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: _loginBusy
                                  ? null
                                  : () => _activateAccount(account.pubkey),
                            ),
                          ),
                      ],
                      const SizedBox(height: 24),
                      if (_supportsNip55 || _supportsNip07)
                        FilledButton.icon(
                          onPressed: _loginBusy ? null : _login,
                          icon: _loginBusy
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  _supportsNip07
                                      ? Icons.extension_outlined
                                      : Icons.key_outlined,
                                ),
                          label: Text(
                            _supportsNip07
                                ? strings.loginWithExtension
                                : strings.loginWithSignerApp,
                          ),
                        )
                      else if (!_supportsNsec)
                        Text(
                          strings.unsupportedPlatform,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      if (_supportsNsec)
                        FilledButton.icon(
                          onPressed: _loginBusy ? null : _loginWithNsec,
                          icon: _loginBusy
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.password_outlined),
                          label: Text(strings.loginWithNsec),
                        ),
                      if (_loginFailed || snapshot.hasError) ...[
                        const SizedBox(height: 16),
                        Text(
                          strings.loginFailed,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
