import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/entities.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

/// Detail view for a single wallet, reached by tapping a wallet card.
///
/// Shows the wallet actions (send/receive/etc.) plus its pending and finished
/// transactions.
class WalletDetailsScreen extends ConsumerWidget {
  const WalletDetailsScreen({super.key, required this.walletId});

  final String walletId;

  static const routeName = '/wallet/details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final ndkFlutter = ref.watch(ndkFlutterProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.wallet.details.title)),
      body: ndkFlutter == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Wallet>>(
              stream: ndkFlutter.ndk.wallets.walletsStream,
              builder: (context, snapshot) {
                final wallets = snapshot.data;
                if (wallets == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                final wallet =
                    wallets.where((w) => w.id == walletId).firstOrNull;
                // Wallet deleted (e.g. from the actions menu) -> leave page.
                if (wallet == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final navigator = Navigator.of(context);
                    if (navigator.canPop()) navigator.pop();
                  });
                  return const SizedBox.shrink();
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return NWalletCard(
                            wallet: wallet,
                            ndkFlutter: ndkFlutter,
                            isSelected: true,
                            width: constraints.maxWidth,
                            onTap: () {},
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      NWalletActions(
                        ndkFlutter: ndkFlutter,
                        selectedWalletId: walletId,
                        onClearSelection: () => Navigator.of(context).pop(),
                        showTitle: false,
                        showCloseButton: false,
                      ),
                      const SizedBox(height: 24),
                      NPendingTransactions(
                        ndkFlutter: ndkFlutter,
                        walletId: walletId,
                        title: t.wallet.details.pendingTitle,
                      ),
                      Text(
                        t.wallet.details.finishedTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 320,
                        child: NRecentTransactions(
                          ndkFlutter: ndkFlutter,
                          walletId: walletId,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
