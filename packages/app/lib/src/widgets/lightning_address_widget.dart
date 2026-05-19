import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../utils/ln.dart';

class LightningAddressWidget extends ConsumerStatefulWidget {
  const LightningAddressWidget({super.key});

  @override
  ConsumerState<LightningAddressWidget> createState() =>
      _LightningAddressWidgetState();

  static void showLightningAddressRequiredDialog(
    BuildContext context,
    WidgetRef ref,
    dynamic keyService,
    Translations t,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(t.lightningAddress.prompts.required),
          content: Text(t.lightningAddress.prompts.enterToTakeOffer),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(t.common.buttons.cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                // Show the edit dialog directly
                await _showEditLightningAddressDialogStatic(
                  context,
                  ref,
                  null,
                  keyService,
                  t,
                );
              },
              child: Text(t.lightningAddress.prompts.add),
            ),
          ],
        );
      },
    );
  }

  static void showReceivingWalletRequiredDialog(
    BuildContext context,
    WidgetRef ref,
    Translations t,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(t.wallet.missingReceiving.title),
          content: Text(t.wallet.missingReceiving.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(t.common.buttons.cancel),
            ),
            FilledButton.icon(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await context.push('/wallet');
                ref.invalidate(hasReceivingWalletProvider);
              },
              icon: const Icon(Icons.account_balance_wallet_outlined, size: 18),
              label: Text(t.wallet.missingReceiving.openSettings),
            ),
          ],
        );
      },
    );
  }

  static Widget buildMissingReceivingWalletWarning(
    BuildContext context,
    WidgetRef ref,
    Translations t,
  ) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        const Icon(Icons.warning, color: Colors.orange, size: 20),
        Text(
          t.wallet.missingReceiving.message,
          style: const TextStyle(fontSize: 14, color: Colors.orange),
          textAlign: TextAlign.center,
        ),
        OutlinedButton.icon(
          onPressed: () async {
            await context.push('/wallet');
            ref.invalidate(hasReceivingWalletProvider);
          },
          icon: const Icon(Icons.account_balance_wallet_outlined, size: 18),
          label: Text(t.wallet.missingReceiving.openSettings),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.orange[800],
            side: BorderSide(color: Colors.orange[300]!),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> _showEditLightningAddressDialogStatic(
    BuildContext context,
    WidgetRef ref,
    String? currentAddress,
    dynamic keyService,
    Translations t,
  ) async {
    final editController = TextEditingController(text: currentAddress);
    final editFormKey = GlobalKey<FormState>();
    final editFocusNode = FocusNode();
    String? editValidationError;

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          editFocusNode.requestFocus();
        });
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                currentAddress == null
                    ? t.lightningAddress.prompts.add
                    : t.lightningAddress.prompts.edit,
              ),
              content: Form(
                key: editFormKey,
                child: TextFormField(
                  controller: editController,
                  focusNode: editFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: t.lightningAddress.labels.hint,
                    labelText: t.lightningAddress.labels.address,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return t.lightningAddress.prompts.invalid;
                    }
                    return editValidationError;
                  },
                  onChanged: (value) async {
                    if (value.isNotEmpty && value.contains('@')) {
                      final error = await validateLightningAddress(value, t);
                      setState(() {
                        editValidationError = error;
                      });
                    } else {
                      setState(() {
                        editValidationError = null;
                      });
                    }
                  },
                  onFieldSubmitted: (value) async {
                    if (!editFormKey.currentState!.validate()) {
                      return;
                    }

                    if (value.isNotEmpty && value.contains('@')) {
                      try {
                        final error = await validateLightningAddress(value, t);
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError = error;
                        });

                        if (error != null) {
                          editFormKey.currentState!.validate();
                          return;
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError =
                              t.lightningAddress.prompts.invalid;
                        });
                        editFormKey.currentState!.validate();
                        return;
                      }
                    }

                    try {
                      await keyService.saveLightningAddress(
                        editController.text,
                      );
                      if (!context.mounted) return;
                      ref.invalidate(lightningAddressProvider);
                      Navigator.of(context).pop(editController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            currentAddress == null
                                ? t.lightningAddress.feedback.saved
                                : t.lightningAddress.feedback.updated,
                          ),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            t.lightningAddress.errors.saving(
                              details: e.toString(),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(t.common.buttons.cancel),
                ),
                TextButton(
                  onPressed: () async {
                    if (!editFormKey.currentState!.validate()) {
                      return;
                    }

                    final value = editController.text;
                    if (value.isNotEmpty && value.contains('@')) {
                      try {
                        final error = await validateLightningAddress(value, t);
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError = error;
                        });

                        if (error != null) {
                          editFormKey.currentState!.validate();
                          return;
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError =
                              t.lightningAddress.prompts.invalid;
                        });
                        editFormKey.currentState!.validate();
                        return;
                      }
                    }

                    try {
                      await keyService.saveLightningAddress(
                        editController.text,
                      );
                      if (!context.mounted) return;
                      ref.invalidate(lightningAddressProvider);
                      Navigator.of(context).pop(editController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            currentAddress == null
                                ? t.lightningAddress.feedback.saved
                                : t.lightningAddress.feedback.updated,
                          ),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            t.lightningAddress.errors.saving(
                              details: e.toString(),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(t.common.buttons.save),
                ),
              ],
            );
          },
        );
      },
    );
    if (result != null && result != currentAddress) {
      ref.invalidate(lightningAddressProvider);
    }
  }
}

class _LightningAddressWidgetState
    extends ConsumerState<LightningAddressWidget> {
  String? _validationError;
  bool _hasValidatedInitialAddress = false;
  bool _isValidating = false;

  @override
  void initState() {
    super.initState();
    _hasValidatedInitialAddress = false;
    _isValidating = false;
  }

  @override
  Widget build(BuildContext context) {
    final lightningAddressAsync = ref.watch(lightningAddressProvider);
    final keyService = ref.read(keyServiceProvider);
    final t = Translations.of(context);

    return lightningAddressAsync.when(
      loading:
          () => const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      error:
          (e, s) => Center(
            child: Text(
              t.lightningAddress.errors.loading(details: e.toString()),
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      data: (lightningAddress) {
        // Perform one-time validation when address is loaded
        if (!_hasValidatedInitialAddress &&
            lightningAddress != null &&
            lightningAddress.isNotEmpty) {
          _hasValidatedInitialAddress = true;
          setState(() {
            _isValidating = true;
          });
          validateLightningAddress(lightningAddress, t).then((error) {
            if (mounted) {
              setState(() {
                _validationError = error;
                _isValidating = false;
              });
            }
          });
        }

        final hasLightningAddress =
            lightningAddress != null && lightningAddress.isNotEmpty;

        if (hasLightningAddress) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.lightningAddress.labels.receivingAddress,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(width: 8),
              if (_isValidating)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else if (_validationError == null && _hasValidatedInitialAddress)
                Tooltip(
                  message: t.lightningAddress.feedback.valid,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 14,
                  ),
                )
              else if (_validationError != null)
                Tooltip(
                  message: _validationError!,
                  child: const Icon(Icons.error, color: Colors.red, size: 20),
                ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  lightningAddress!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                tooltip: t.lightningAddress.prompts.edit,
                iconSize: 18,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: () async {
                  await _showEditLightningAddressDialog(
                    context,
                    ref,
                    lightningAddress,
                    keyService,
                    t,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 18),
                tooltip: t.lightningAddress.prompts.delete,
                iconSize: 18,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: () async {
                  await _showDeleteLightningAddressDialog(
                    context,
                    ref,
                    keyService,
                    t,
                  );
                },
              ),
            ],
          );
        } else {
          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 20),
              Text(
                t.lightningAddress.prompts.enterToTakeOffer,
                style: const TextStyle(fontSize: 14, color: Colors.orange),
                textAlign: TextAlign.center,
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, size: 18),
                tooltip: t.lightningAddress.prompts.add,
                iconSize: 18,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: () async {
                  await _showEditLightningAddressDialog(
                    context,
                    ref,
                    null,
                    keyService,
                    t,
                  );
                },
              ),
            ],
          );

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  t.lightningAddress.prompts.enterToTakeOffer,
                  style: const TextStyle(fontSize: 14, color: Colors.orange),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, size: 18),
                tooltip: t.lightningAddress.prompts.add,
                iconSize: 18,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: () async {
                  await _showEditLightningAddressDialog(
                    context,
                    ref,
                    null,
                    keyService,
                    t,
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> _showEditLightningAddressDialog(
    BuildContext context,
    WidgetRef ref,
    String? currentAddress,
    dynamic keyService,
    Translations t,
  ) async {
    final editController = TextEditingController(text: currentAddress);
    final editFormKey = GlobalKey<FormState>();
    final editFocusNode = FocusNode();
    String? editValidationError;

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          editFocusNode.requestFocus();
        });
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                currentAddress == null
                    ? t.lightningAddress.prompts.add
                    : t.lightningAddress.prompts.edit,
              ),
              content: Form(
                key: editFormKey,
                child: TextFormField(
                  controller: editController,
                  focusNode: editFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: t.lightningAddress.labels.hint,
                    labelText: t.lightningAddress.labels.address,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return t.lightningAddress.prompts.invalid;
                    }
                    // Return null here - async validation is handled separately
                    return null;
                  },
                  onChanged: (value) async {
                    if (value.isNotEmpty && value.contains('@')) {
                      final error = await validateLightningAddress(value, t);
                      setState(() {
                        editValidationError = error;
                      });
                    } else {
                      setState(() {
                        editValidationError = null;
                      });
                    }
                  },
                  onFieldSubmitted: (value) async {
                    Logger.log.d(
                      () =>
                          '[LN Address Dialog] onFieldSubmitted called with: $value',
                    );

                    // First validate the form format
                    if (!editFormKey.currentState!.validate()) {
                      Logger.log.d(
                        () => '[LN Address Dialog] Form validation failed',
                      );
                      return;
                    }

                    // Then perform async validation
                    if (value.isNotEmpty && value.contains('@')) {
                      Logger.log.d(
                        () =>
                            '[LN Address Dialog] Starting async validation...',
                      );
                      try {
                        final error = await validateLightningAddress(value, t);
                        Logger.log.d(
                          () =>
                              '[LN Address Dialog] Validation result: ${error ?? "SUCCESS"}',
                        );
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError = error;
                        });

                        // If there's a validation error, show it and return
                        if (error != null) {
                          Logger.log.d(
                            () =>
                                '[LN Address Dialog] Validation failed, showing error',
                          );
                          editFormKey.currentState!.validate();
                          return;
                        }
                      } catch (e) {
                        Logger.log.d(
                          () =>
                              '[LN Address Dialog] Validation threw exception: $e',
                        );
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError =
                              t.lightningAddress.prompts.invalid;
                        });
                        editFormKey.currentState!.validate();
                        return;
                      }
                    }

                    // Save the address
                    Logger.log.d(
                      () => '[LN Address Dialog] Attempting to save address...',
                    );
                    try {
                      await keyService.saveLightningAddress(
                        editController.text,
                      );
                      Logger.log.d(
                        () => '[LN Address Dialog] Address saved successfully',
                      );
                      if (!context.mounted) return;
                      ref.invalidate(lightningAddressProvider);
                      Navigator.of(context).pop(editController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            currentAddress == null
                                ? t.lightningAddress.feedback.saved
                                : t.lightningAddress.feedback.updated,
                          ),
                        ),
                      );
                    } catch (e) {
                      Logger.log.d(() => '[LN Address Dialog] Save failed: $e');
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            t.lightningAddress.errors.saving(
                              details: e.toString(),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(t.common.buttons.cancel),
                ),
                TextButton(
                  onPressed: () async {
                    // First validate the form format
                    if (!editFormKey.currentState!.validate()) {
                      return;
                    }

                    // Then perform async validation
                    final value = editController.text;
                    if (value.isNotEmpty && value.contains('@')) {
                      try {
                        final error = await validateLightningAddress(value, t);
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError = error;
                        });

                        // If there's a validation error, show it and return
                        if (error != null) {
                          editFormKey.currentState!.validate();
                          return;
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        setState(() {
                          editValidationError =
                              t.lightningAddress.prompts.invalid;
                        });
                        editFormKey.currentState!.validate();
                        return;
                      }
                    }

                    // Save the address
                    try {
                      await keyService.saveLightningAddress(
                        editController.text,
                      );
                      if (!context.mounted) return;
                      ref.invalidate(lightningAddressProvider);
                      Navigator.of(context).pop(editController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            currentAddress == null
                                ? t.lightningAddress.feedback.saved
                                : t.lightningAddress.feedback.updated,
                          ),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            t.lightningAddress.errors.saving(
                              details: e.toString(),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(t.common.buttons.save),
                ),
              ],
            );
          },
        );
      },
    );
    if (result != null && result != currentAddress) {
      ref.invalidate(lightningAddressProvider);
    }
  }

  Future<void> _showDeleteLightningAddressDialog(
    BuildContext context,
    WidgetRef ref,
    dynamic keyService,
    Translations t,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.lightningAddress.prompts.delete),
          content: Text(t.lightningAddress.prompts.confirmDelete),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.common.buttons.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(t.lightningAddress.prompts.delete),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await keyService.saveLightningAddress('');
        ref.invalidate(lightningAddressProvider);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.lightningAddress.feedback.updated)),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                t.lightningAddress.errors.saving(details: e.toString()),
              ),
            ),
          );
        }
      }
    }
  }
}
