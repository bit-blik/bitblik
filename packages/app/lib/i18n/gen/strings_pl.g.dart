///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsPl extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsPl({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.pl,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(
         cardinalResolver: cardinalResolver,
         ordinalResolver: ordinalResolver,
       ) {
    super.$meta.setFlatMapFunction(
      $meta.getTranslation,
    ); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <pl>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsPl _root = this; // ignore: unused_field

  @override
  TranslationsPl $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => TranslationsPl(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppPl app = _TranslationsAppPl._(_root);
  @override
  late final _TranslationsCommonPl common = _TranslationsCommonPl._(_root);
  @override
  late final _TranslationsLightningAddressPl lightningAddress =
      _TranslationsLightningAddressPl._(_root);
  @override
  late final _TranslationsOffersPl offers = _TranslationsOffersPl._(_root);
  @override
  late final _TranslationsReservationsPl reservations =
      _TranslationsReservationsPl._(_root);
  @override
  late final _TranslationsExchangePl exchange = _TranslationsExchangePl._(
    _root,
  );
  @override
  late final _TranslationsCoordinatorPl coordinator =
      _TranslationsCoordinatorPl._(_root);
  @override
  late final _TranslationsMakerPl maker = _TranslationsMakerPl._(_root);
  @override
  late final _TranslationsTakerPl taker = _TranslationsTakerPl._(_root);
  @override
  late final _TranslationsBlikPl blik = _TranslationsBlikPl._(_root);
  @override
  late final _TranslationsNekoInfoPl nekoInfo = _TranslationsNekoInfoPl._(
    _root,
  );
  @override
  late final _TranslationsGenerateNewKeyPl generateNewKey =
      _TranslationsGenerateNewKeyPl._(_root);
  @override
  late final _TranslationsBackupPl backup = _TranslationsBackupPl._(_root);
  @override
  late final _TranslationsRestorePl restore = _TranslationsRestorePl._(_root);
  @override
  late final _TranslationsHomePl home = _TranslationsHomePl._(_root);
  @override
  late final _TranslationsSystemPl system = _TranslationsSystemPl._(_root);
  @override
  late final _TranslationsLandingPl landing = _TranslationsLandingPl._(_root);
  @override
  late final _TranslationsFaqPl faq = _TranslationsFaqPl._(_root);
  @override
  late final _TranslationsSettingsPl settings = _TranslationsSettingsPl._(
    _root,
  );
  @override
  late final _TranslationsWalletPl wallet = _TranslationsWalletPl._(_root);
  @override
  late final _TranslationsNwcPl nwc = _TranslationsNwcPl._(_root);
  @override
  late final _TranslationsNekoManagementPl nekoManagement =
      _TranslationsNekoManagementPl._(_root);
  @override
  late final _TranslationsRelaysPl relays = _TranslationsRelaysPl._(_root);
  @override
  late final _TranslationsAltstorePl altstore = _TranslationsAltstorePl._(
    _root,
  );
}

// Path: app
class _TranslationsAppPl extends TranslationsAppEn {
  _TranslationsAppPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'BitBlik';
  @override
  String get greeting => 'Cześć!';
  @override
  String get changelog => 'Historia zmian';
}

// Path: common
class _TranslationsCommonPl extends TranslationsCommonEn {
  _TranslationsCommonPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsCommonButtonsPl buttons =
      _TranslationsCommonButtonsPl._(_root);
  @override
  late final _TranslationsCommonLabelsPl labels = _TranslationsCommonLabelsPl._(
    _root,
  );
  @override
  late final _TranslationsCommonNotificationsPl notifications =
      _TranslationsCommonNotificationsPl._(_root);
  @override
  late final _TranslationsCommonClipboardPl clipboard =
      _TranslationsCommonClipboardPl._(_root);
  @override
  late final _TranslationsCommonActionsPl actions =
      _TranslationsCommonActionsPl._(_root);
}

// Path: lightningAddress
class _TranslationsLightningAddressPl extends TranslationsLightningAddressEn {
  _TranslationsLightningAddressPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsLightningAddressLabelsPl labels =
      _TranslationsLightningAddressLabelsPl._(_root);
  @override
  late final _TranslationsLightningAddressPromptsPl prompts =
      _TranslationsLightningAddressPromptsPl._(_root);
  @override
  late final _TranslationsLightningAddressFeedbackPl feedback =
      _TranslationsLightningAddressFeedbackPl._(_root);
  @override
  late final _TranslationsLightningAddressErrorsPl errors =
      _TranslationsLightningAddressErrorsPl._(_root);
}

// Path: offers
class _TranslationsOffersPl extends TranslationsOffersEn {
  _TranslationsOffersPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsOffersDetailsPl details =
      _TranslationsOffersDetailsPl._(_root);
  @override
  late final _TranslationsOffersTooltipsPl tooltips =
      _TranslationsOffersTooltipsPl._(_root);
  @override
  late final _TranslationsOffersActionsPl actions =
      _TranslationsOffersActionsPl._(_root);
  @override
  late final _TranslationsOffersStatusPl status = _TranslationsOffersStatusPl._(
    _root,
  );
  @override
  late final _TranslationsOffersStatusMessagesPl statusMessages =
      _TranslationsOffersStatusMessagesPl._(_root);
  @override
  late final _TranslationsOffersProgressPl progress =
      _TranslationsOffersProgressPl._(_root);
  @override
  late final _TranslationsOffersErrorsPl errors = _TranslationsOffersErrorsPl._(
    _root,
  );
  @override
  late final _TranslationsOffersSuccessPl success =
      _TranslationsOffersSuccessPl._(_root);
}

// Path: reservations
class _TranslationsReservationsPl extends TranslationsReservationsEn {
  _TranslationsReservationsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsReservationsActionsPl actions =
      _TranslationsReservationsActionsPl._(_root);
  @override
  late final _TranslationsReservationsFeedbackPl feedback =
      _TranslationsReservationsFeedbackPl._(_root);
  @override
  late final _TranslationsReservationsErrorsPl errors =
      _TranslationsReservationsErrorsPl._(_root);
}

// Path: exchange
class _TranslationsExchangePl extends TranslationsExchangeEn {
  _TranslationsExchangePl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsExchangeLabelsPl labels =
      _TranslationsExchangeLabelsPl._(_root);
  @override
  late final _TranslationsExchangeFeedbackPl feedback =
      _TranslationsExchangeFeedbackPl._(_root);
  @override
  late final _TranslationsExchangeErrorsPl errors =
      _TranslationsExchangeErrorsPl._(_root);
}

// Path: coordinator
class _TranslationsCoordinatorPl extends TranslationsCoordinatorEn {
  _TranslationsCoordinatorPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Koordynatorzy';
  @override
  late final _TranslationsCoordinatorInfoPl info =
      _TranslationsCoordinatorInfoPl._(_root);
  @override
  late final _TranslationsCoordinatorSelectorPl selector =
      _TranslationsCoordinatorSelectorPl._(_root);
  @override
  late final _TranslationsCoordinatorDialogPl dialog =
      _TranslationsCoordinatorDialogPl._(_root);
  @override
  late final _TranslationsCoordinatorManagementPl management =
      _TranslationsCoordinatorManagementPl._(_root);
}

// Path: maker
class _TranslationsMakerPl extends TranslationsMakerEn {
  _TranslationsMakerPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsMakerRoleSelectionPl roleSelection =
      _TranslationsMakerRoleSelectionPl._(_root);
  @override
  late final _TranslationsMakerAmountFormPl amountForm =
      _TranslationsMakerAmountFormPl._(_root);
  @override
  late final _TranslationsMakerPayInvoicePl payInvoice =
      _TranslationsMakerPayInvoicePl._(_root);
  @override
  late final _TranslationsMakerWaitTakerPl waitTaker =
      _TranslationsMakerWaitTakerPl._(_root);
  @override
  late final _TranslationsMakerWaitForBlikPl waitForBlik =
      _TranslationsMakerWaitForBlikPl._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentPl confirmPayment =
      _TranslationsMakerConfirmPaymentPl._(_root);
  @override
  late final _TranslationsMakerInvalidBlikPl invalidBlik =
      _TranslationsMakerInvalidBlikPl._(_root);
  @override
  late final _TranslationsMakerConflictPl conflict =
      _TranslationsMakerConflictPl._(_root);
  @override
  late final _TranslationsMakerSuccessPl success =
      _TranslationsMakerSuccessPl._(_root);
}

// Path: taker
class _TranslationsTakerPl extends TranslationsTakerEn {
  _TranslationsTakerPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTakerRoleSelectionPl roleSelection =
      _TranslationsTakerRoleSelectionPl._(_root);
  @override
  late final _TranslationsTakerProgressPl progress =
      _TranslationsTakerProgressPl._(_root);
  @override
  late final _TranslationsTakerSubmitBlikPl submitBlik =
      _TranslationsTakerSubmitBlikPl._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationPl waitConfirmation =
      _TranslationsTakerWaitConfirmationPl._(_root);
  @override
  late final _TranslationsTakerPaymentProcessPl paymentProcess =
      _TranslationsTakerPaymentProcessPl._(_root);
  @override
  late final _TranslationsTakerPaymentFailedPl paymentFailed =
      _TranslationsTakerPaymentFailedPl._(_root);
  @override
  late final _TranslationsTakerPaymentSuccessPl paymentSuccess =
      _TranslationsTakerPaymentSuccessPl._(_root);
  @override
  late final _TranslationsTakerInvalidBlikPl invalidBlik =
      _TranslationsTakerInvalidBlikPl._(_root);
  @override
  late final _TranslationsTakerConflictPl conflict =
      _TranslationsTakerConflictPl._(_root);
}

// Path: blik
class _TranslationsBlikPl extends TranslationsBlikEn {
  _TranslationsBlikPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsBlikInstructionsPl instructions =
      _TranslationsBlikInstructionsPl._(_root);
}

// Path: nekoInfo
class _TranslationsNekoInfoPl extends TranslationsNekoInfoEn {
  _TranslationsNekoInfoPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Czym jest Neko?';
  @override
  String get description =>
      'Twoje Neko to Twoja tożsamość do korzystania z BitBlik. Składa się z klucza prywatnego i publicznego, aby zapewnić kryptograficznie bezpieczną komunikację z koordynatorem.\n\nAby zapewnić większą anonimowość, zaleca się używanie nowego, świeżego Neko dla każdej oferty.\n\n⚠️ WAŻNE: Twój klucz prywatny jest przechowywany tylko na Twoim urządzeniu (po stronie klienta). Niezwykle ważne jest zarchiwizowanie klucza prywatnego, ponieważ utrata dostępu do niego może uniemożliwić rozstrzygnięcie sporów i odzyskanie środków.';
  @override
  String get backupWarning => 'Pamiętaj, aby zarchiwizować swoje Neko';
}

// Path: generateNewKey
class _TranslationsGenerateNewKeyPl extends TranslationsGenerateNewKeyEn {
  _TranslationsGenerateNewKeyPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Nowy';
  @override
  String get description =>
      'Czy na pewno chcesz wygenerować nowe Neko? Twoje obecne zostanie utracone na zawsze, jeśli go nie zarchiwizowałeś.';
  @override
  late final _TranslationsGenerateNewKeyButtonsPl buttons =
      _TranslationsGenerateNewKeyButtonsPl._(_root);
  @override
  late final _TranslationsGenerateNewKeyErrorsPl errors =
      _TranslationsGenerateNewKeyErrorsPl._(_root);
  @override
  late final _TranslationsGenerateNewKeyFeedbackPl feedback =
      _TranslationsGenerateNewKeyFeedbackPl._(_root);
  @override
  late final _TranslationsGenerateNewKeyTooltipsPl tooltips =
      _TranslationsGenerateNewKeyTooltipsPl._(_root);
}

// Path: backup
class _TranslationsBackupPl extends TranslationsBackupEn {
  _TranslationsBackupPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Zarchiwizuj';
  @override
  String get description =>
      'To jest Twój klucz prywatny. Zabezpiecza on komunikację z koordynatorem. Nigdy nikomu go nie ujawniaj. Zarchiwizuj go w bezpiecznym miejscu, aby uniknąć problemów podczas sporów.';
  @override
  late final _TranslationsBackupFeedbackPl feedback =
      _TranslationsBackupFeedbackPl._(_root);
  @override
  late final _TranslationsBackupTooltipsPl tooltips =
      _TranslationsBackupTooltipsPl._(_root);
}

// Path: restore
class _TranslationsRestorePl extends TranslationsRestoreEn {
  _TranslationsRestorePl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Przywróć';
  @override
  late final _TranslationsRestoreLabelsPl labels =
      _TranslationsRestoreLabelsPl._(_root);
  @override
  late final _TranslationsRestoreButtonsPl buttons =
      _TranslationsRestoreButtonsPl._(_root);
  @override
  late final _TranslationsRestoreErrorsPl errors =
      _TranslationsRestoreErrorsPl._(_root);
  @override
  late final _TranslationsRestoreFeedbackPl feedback =
      _TranslationsRestoreFeedbackPl._(_root);
  @override
  late final _TranslationsRestoreTooltipsPl tooltips =
      _TranslationsRestoreTooltipsPl._(_root);
}

// Path: home
class _TranslationsHomePl extends TranslationsHomeEn {
  _TranslationsHomePl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsHomeNotificationsPl notifications =
      _TranslationsHomeNotificationsPl._(_root);
  @override
  late final _TranslationsHomeStatisticsPl statistics =
      _TranslationsHomeStatisticsPl._(_root);
}

// Path: system
class _TranslationsSystemPl extends TranslationsSystemEn {
  _TranslationsSystemPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get loadingPublicKey => 'Ładowanie Twojego klucza publicznego...';
  @override
  late final _TranslationsSystemErrorsPl errors = _TranslationsSystemErrorsPl._(
    _root,
  );
  @override
  late final _TranslationsSystemBlikPl blik = _TranslationsSystemBlikPl._(
    _root,
  );
}

// Path: landing
class _TranslationsLandingPl extends TranslationsLandingEn {
  _TranslationsLandingPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get mainTitle => 'Wymiana\n BLIK ⇄ bitcoin';
  @override
  String get subtitle => 'Płać lub sprzedawaj kod BLIK za bitcoin';
  @override
  late final _TranslationsLandingActionsPl actions =
      _TranslationsLandingActionsPl._(_root);
}

// Path: faq
class _TranslationsFaqPl extends TranslationsFaqEn {
  _TranslationsFaqPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get screenTitle => 'FAQ';
  @override
  String get tooltip => 'FAQ';
}

// Path: settings
class _TranslationsSettingsPl extends TranslationsSettingsEn {
  _TranslationsSettingsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ustawienia';
}

// Path: wallet
class _TranslationsWalletPl extends TranslationsWalletEn {
  _TranslationsWalletPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Portfel';
  @override
  String get description => 'Zarządzaj ustawieniami portfela Lightning';
  @override
  late final _TranslationsWalletMissingReceivingPl missingReceiving =
      _TranslationsWalletMissingReceivingPl._(_root);
}

// Path: nwc
class _TranslationsNwcPl extends TranslationsNwcEn {
  _TranslationsNwcPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Nostr Wallet Connect (NWC)';
  @override
  String get description => 'Połącz swój portfel Lightning przez NWC';
  @override
  late final _TranslationsNwcLabelsPl labels = _TranslationsNwcLabelsPl._(
    _root,
  );
  @override
  late final _TranslationsNwcPromptsPl prompts = _TranslationsNwcPromptsPl._(
    _root,
  );
  @override
  late final _TranslationsNwcActionsPl actions = _TranslationsNwcActionsPl._(
    _root,
  );
  @override
  late final _TranslationsNwcFeedbackPl feedback = _TranslationsNwcFeedbackPl._(
    _root,
  );
  @override
  late final _TranslationsNwcErrorsPl errors = _TranslationsNwcErrorsPl._(
    _root,
  );
  @override
  late final _TranslationsNwcTimePl time = _TranslationsNwcTimePl._(_root);
}

// Path: nekoManagement
class _TranslationsNekoManagementPl extends TranslationsNekoManagementEn {
  _TranslationsNekoManagementPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Neko';
}

// Path: relays
class _TranslationsRelaysPl extends TranslationsRelaysEn {
  _TranslationsRelaysPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Przekaźniki';
  @override
  late final _TranslationsRelaysStatusPl status = _TranslationsRelaysStatusPl._(
    _root,
  );
  @override
  late final _TranslationsRelaysPopupPl popup = _TranslationsRelaysPopupPl._(
    _root,
  );
}

// Path: altstore
class _TranslationsAltstorePl extends TranslationsAltstoreEn {
  _TranslationsAltstorePl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get dialogTitle => 'AltStore Nie Zainstalowany';
  @override
  String get step1Title => 'Pobierz i zainstaluj AltStore PAL';
  @override
  String get step1Button => 'altstore.io/download';
  @override
  String get step1Warning =>
      'Potrzebujesz Safari, aby zainstalować AltStore PAL!';
  @override
  String get step2Title => 'Zainstaluj BitBlik';
  @override
  String get step2Button => 'Zainstaluj BitBlik';
  @override
  String get step2Fallback => 'Nie działa? Wklej źródło do AltStore';
}

// Path: common.buttons
class _TranslationsCommonButtonsPl extends TranslationsCommonButtonsEn {
  _TranslationsCommonButtonsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'Anuluj';
  @override
  String get save => 'Zapisz';
  @override
  String get done => 'Gotowe';
  @override
  String get retry => 'Spróbuj ponownie';
  @override
  String get goHome => 'Wróć do strony głównej';
  @override
  String get saveAndContinue => 'Zapisz i kontynuuj';
  @override
  String get reveal => 'Pokaż';
  @override
  String get hide => 'Ukryj';
  @override
  String get copy => 'Kopiuj';
  @override
  String get close => 'Zamknij';
  @override
  String get restore => 'Przywróć';
  @override
  String get faq => 'FAQ';
}

// Path: common.labels
class _TranslationsCommonLabelsPl extends TranslationsCommonLabelsEn {
  _TranslationsCommonLabelsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get amount => 'Kwota (PLN)';
  @override
  String status({required Object status}) => 'Status: ${status}';
  @override
  String role({required Object role}) => 'Rola: ${role}';
}

// Path: common.notifications
class _TranslationsCommonNotificationsPl
    extends TranslationsCommonNotificationsEn {
  _TranslationsCommonNotificationsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get success => 'Sukces';
  @override
  String get error => 'Błąd';
  @override
  String get loading => 'Ładowanie...';
}

// Path: common.clipboard
class _TranslationsCommonClipboardPl extends TranslationsCommonClipboardEn {
  _TranslationsCommonClipboardPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get copyToClipboard => 'Kopiuj do schowka';
  @override
  String get pasteFromClipboard => 'Wklej ze schowka';
  @override
  String get copied => 'Skopiowano do schowka!';
}

// Path: common.actions
class _TranslationsCommonActionsPl extends TranslationsCommonActionsEn {
  _TranslationsCommonActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get cancelAndReturnToOffers => 'Anuluj i wróć do ofert';
  @override
  String get cancelAndReturnHome => 'Anuluj i wróć do strony głównej';
}

// Path: lightningAddress.labels
class _TranslationsLightningAddressLabelsPl
    extends TranslationsLightningAddressLabelsEn {
  _TranslationsLightningAddressLabelsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get address => 'Adres Lightning (LNURL)';
  @override
  String get hint => 'uzytkownik@domena.com';
  @override
  String short({required Object address}) => 'Adres Lightning: ${address}';
  @override
  String get receivingAddress => 'Twój adres odbiorczy:';
}

// Path: lightningAddress.prompts
class _TranslationsLightningAddressPromptsPl
    extends TranslationsLightningAddressPromptsEn {
  _TranslationsLightningAddressPromptsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get enter => 'Wprowadź swój adres Lightning, aby kontynuować';
  @override
  String get edit => 'Edytuj';
  @override
  String get invalid => 'Wprowadź prawidłowy adres Lightning';
  @override
  String get required => 'Adres Lightning jest wymagany.';
  @override
  String get enterToTakeOffer =>
      'Musisz ustawić adres Lightning, aby przyjąć ofertę.';
  @override
  String get missing =>
      'Brak adresu Lightning. Dodaj go, aby móc przyjmować oferty.';
  @override
  String get add => 'Dodaj';
  @override
  String get delete => 'Usuń';
  @override
  String get confirmDelete =>
      'Czy na pewno chcesz usunąć swój adres Lightning?';
  @override
  String get howToGet =>
      'Nie masz jeszcze adresu Lightning? Dowiedz się, jak go zdobyć!';
  @override
  String get learnMore => 'Dowiedz się więcej o adresach Lightning';
}

// Path: lightningAddress.feedback
class _TranslationsLightningAddressFeedbackPl
    extends TranslationsLightningAddressFeedbackEn {
  _TranslationsLightningAddressFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get saved => 'Adres Lightning zapisany!';
  @override
  String get updated => 'Adres Lightning zaktualizowany!';
  @override
  String get valid => 'Prawidłowy adres Lightning';
}

// Path: lightningAddress.errors
class _TranslationsLightningAddressErrorsPl
    extends TranslationsLightningAddressErrorsEn {
  _TranslationsLightningAddressErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String saving({required Object details}) =>
      'Błąd podczas zapisywania adresu: ${details}';
  @override
  String loading({required Object details}) =>
      'Błąd podczas ładowania adresu Lightning: ${details}';
}

// Path: offers.details
class _TranslationsOffersDetailsPl extends TranslationsOffersDetailsEn {
  _TranslationsOffersDetailsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get yourOffer => 'Twoja oferta:';
  @override
  String get selectedOffer => 'Oferta:';
  @override
  String get activeOffer => 'Masz aktywną ofertę:';
  @override
  String get finishedOffers => 'Zakończone oferty';
  @override
  String get finishedOffersWithTime => 'Zakończone oferty (ostatnie 24h):';
  @override
  String get noAvailable => 'Brak dostępnych ofert.';
  @override
  String get noAvailableTip =>
      'Wskazówka: udostępnij Bitblik w swojej społeczności i wśród znajomych, aby zwiększyć liczbę zamówień w Bitblik.';
  @override
  String get noSuccessfulTrades => 'Brak udanych transakcji.';
  @override
  String get loadingDetails => 'Ładowanie szczegółów oferty...';
  @override
  String amount({required Object amount}) => 'Kwota: ${amount} satoshi';
  @override
  String amountWithCurrency({
    required Object amount,
    required Object currency,
  }) => '${amount} ${currency}';
  @override
  String makerFee({required Object fee}) => 'Opłata: ${fee} sats';
  @override
  String takerFee({required Object fee}) => 'Opłata: ${fee} sats';
  @override
  String subtitle({
    required Object sats,
    required Object fee,
    required Object status,
  }) => '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}';
  @override
  String subtitleWithDate({
    required Object sats,
    required Object fee,
    required Object status,
    required Object date,
  }) =>
      '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}\nZapłacono: ${date}';
  @override
  String activeSubtitle({required Object status, required Object amount}) =>
      'Status: ${status}\nKwota: ${amount} satoshi';
  @override
  String id({required Object id}) => 'ID Oferty: ${id}...';
  @override
  String created({required Object dateTime}) => 'Utworzono: ${dateTime}';
  @override
  String takenAfter({required Object duration}) => 'Przyjęto po: ${duration}';
  @override
  String paidAfter({required Object duration}) => 'Zapłacono po: ${duration}';
  @override
  String get exchangeRate => 'Kurs wymiany';
  @override
  String get takerFeeLabel => 'Opłata';
  @override
  String get amountLabel => 'Kwota';
  @override
  String get feeLabel => 'Opłata';
  @override
  String get statusLabel => 'Status';
  @override
  String get youllReceive => 'Otrzymasz';
  @override
  String get coordinator => 'Koordynator';
}

// Path: offers.tooltips
class _TranslationsOffersTooltipsPl extends TranslationsOffersTooltipsEn {
  _TranslationsOffersTooltipsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String takerFeeInfo({required Object feePercent}) =>
      'Koordynator pobiera ${feePercent}% opłaty dla kupującego. To obejmuje opłaty za routing Lightning i jest potrącane z kwoty, którą otrzymujesz.';
}

// Path: offers.actions
class _TranslationsOffersActionsPl extends TranslationsOffersActionsEn {
  _TranslationsOffersActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get take => 'WEŹ';
  @override
  String get takeOffer => 'Weź ofertę';
  @override
  String get resume => 'Wprowadź BLIK';
  @override
  String get cancel => 'Anuluj ofertę';
  @override
  String get view => 'Zobacz';
}

// Path: offers.status
class _TranslationsOffersStatusPl extends TranslationsOffersStatusEn {
  _TranslationsOffersStatusPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get created => 'Utworzona';
  @override
  String get funded => 'Sfinansowana';
  @override
  String get expired => 'Wygasła';
  @override
  String get cancelled => 'Anulowana';
  @override
  String get reserved => 'Zarezerwowana';
  @override
  String get blikReceived => 'BLIK wysłany';
  @override
  String get blikSentToMaker => 'Otrzymano BLIK';
  @override
  String get invalidBlik => 'Nieprawidłowy BLIK';
  @override
  String get conflict => 'Konflikt';
  @override
  String get dispute => 'Spór';
  @override
  String get makerConfirmed => 'Potwierdzona';
  @override
  String get settled => 'Rozliczona';
  @override
  String get payingTaker => 'Płacenie Takera';
  @override
  String get takerPaymentFailed => 'Płatność Takera nieudana';
  @override
  String get takerPaid => 'Zapłacony';
}

// Path: offers.statusMessages
class _TranslationsOffersStatusMessagesPl
    extends TranslationsOffersStatusMessagesEn {
  _TranslationsOffersStatusMessagesPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get reserved => 'Oferta zarezerwowana przez Takera!';
  @override
  String get cancelled => 'Oferta anulowana pomyślnie.';
  @override
  String get cancelledOrExpired => 'Oferta została anulowana lub wygasła.';
  @override
  String noLongerAvailable({required Object status}) =>
      'Oferta nie jest już dostępna (Status: ${status}).';
}

// Path: offers.progress
class _TranslationsOffersProgressPl extends TranslationsOffersProgressEn {
  _TranslationsOffersProgressPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String waitingForTaker({required Object time}) =>
      'Oczekiwanie na takera: ${time}';
  @override
  String reserved({required Object seconds}) =>
      'Zarezerwowano: ${seconds} s pozostało';
  @override
  String confirming({required Object seconds}) =>
      'Potwierdzanie: ${seconds} s pozostało';
}

// Path: offers.errors
class _TranslationsOffersErrorsPl extends TranslationsOffersErrorsEn {
  _TranslationsOffersErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String loading({required Object details}) =>
      'Błąd ładowania ofert: ${details}';
  @override
  String loadingDetails({required Object details}) =>
      'Błąd ładowania szczegółów oferty: ${details}';
  @override
  String get detailsMissing =>
      'Błąd: Brakujące lub nieprawidłowe szczegóły oferty.';
  @override
  String get detailsNotLoaded => 'Nie udało się załadować szczegółów oferty.';
  @override
  String get notFound => 'Błąd: Oferta nie znaleziona.';
  @override
  String get unexpectedState => 'Błąd: Oferta jest w nieoczekiwanym stanie.';
  @override
  String unexpectedStateWithStatus({required Object status}) =>
      'Oferta jest w nieoczekiwanym stanie (${status}). Spróbuj ponownie lub skontaktuj się z pomocą.';
  @override
  String get invalidStatus => 'Oferta ma nieprawidłowy status.';
  @override
  String get couldNotIdentify =>
      'Błąd: Nie można zidentyfikować oferty do anulowania.';
  @override
  String cannotBeCancelled({required Object status}) =>
      'Oferty nie można anulować w obecnym stanie (${status}).';
  @override
  String failedToCancel({required Object details}) =>
      'Nie udało się anulować oferty: ${details}';
  @override
  String get activeDetailsLost => 'Błąd: Utracono szczegóły aktywnej oferty.';
  @override
  String checkingActive({required Object details}) =>
      'Błąd sprawdzania aktywnych ofert: ${details}';
  @override
  String loadingFinished({required Object details}) =>
      'Błąd ładowania zakończonych ofert: ${details}';
  @override
  String cannotResume({required Object status}) =>
      'Nie można wznowić oferty w stanie: ${status}';
  @override
  String cannotResumeTaker({required Object status}) =>
      'Nie można wznowić oferty takera w stanie: ${status}';
  @override
  String resuming({required Object details}) =>
      'Błąd wznawiania oferty: ${details}';
  @override
  String get makerPublicKeyNotFound =>
      'Nie znaleziono klucza publicznego Makera';
  @override
  String get takerPublicKeyNotFound =>
      'Nie znaleziono klucza publicznego Takera.';
}

// Path: offers.success
class _TranslationsOffersSuccessPl extends TranslationsOffersSuccessEn {
  _TranslationsOffersSuccessPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Oferta zakończona';
  @override
  String get headline => 'Płatność potwierdzona!';
  @override
  String get subtitle => 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.';
  @override
  String get detailsTitle => 'Szczegóły oferty:';
  @override
  String duration({required Object time}) =>
      'Realizacja oferty zajęła ${time}.';
}

// Path: reservations.actions
class _TranslationsReservationsActionsPl
    extends TranslationsReservationsActionsEn {
  _TranslationsReservationsActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'Anuluj rezerwację';
}

// Path: reservations.feedback
class _TranslationsReservationsFeedbackPl
    extends TranslationsReservationsFeedbackEn {
  _TranslationsReservationsFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get cancelled => 'Rezerwacja anulowana.';
}

// Path: reservations.errors
class _TranslationsReservationsErrorsPl
    extends TranslationsReservationsErrorsEn {
  _TranslationsReservationsErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String cancelling({required Object error}) =>
      'Nie udało się anulować rezerwacji: ${error}';
  @override
  String failedToReserve({required Object details}) =>
      'Nie udało się zarezerwować oferty: ${details}';
  @override
  String get failedNoTimestamp =>
      'Nie udało się zarezerwować oferty (brak znacznika czasu).';
  @override
  String get timestampMissing => 'Brak znacznika czasu rezerwacji oferty.';
  @override
  String notReserved({required Object status}) =>
      'Oferta nie jest już w stanie zarezerwowanym (${status}).';
}

// Path: exchange.labels
class _TranslationsExchangeLabelsPl extends TranslationsExchangeLabelsEn {
  _TranslationsExchangeLabelsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get enterAmount => 'Wprowadź kwotę (PLN) do zapłaty:';
  @override
  String equivalent({required Object sats}) => '≈ ${sats} satoshi';
  @override
  String rate({required Object rate}) => 'Kurs wymiany ≈ ${rate} PLN/BTC';
}

// Path: exchange.feedback
class _TranslationsExchangeFeedbackPl extends TranslationsExchangeFeedbackEn {
  _TranslationsExchangeFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get fetching => 'Pobieranie kursu wymiany...';
}

// Path: exchange.errors
class _TranslationsExchangeErrorsPl extends TranslationsExchangeErrorsEn {
  _TranslationsExchangeErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get fetchingRate => 'Nie udało się pobrać kursu wymiany.';
  @override
  String get invalidFormat => 'Nieprawidłowy format liczby';
  @override
  String get mustBePositive => 'Kwota musi być dodatnia';
  @override
  String get invalidFeePercentage => 'Nieprawidłowy procent opłaty';
  @override
  String tooLowFiat({required Object minAmount, required Object currency}) =>
      'Kwota jest za niska. Minimum to ${minAmount} ${currency}.';
  @override
  String tooHighFiat({required Object maxAmount, required Object currency}) =>
      'Kwota jest za wysoka. Maksimum to ${maxAmount} ${currency}.';
}

// Path: coordinator.info
class _TranslationsCoordinatorInfoPl extends TranslationsCoordinatorInfoEn {
  _TranslationsCoordinatorInfoPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get fee => 'opłata';
  @override
  String rangeDisplay({
    required Object minAmount,
    required Object maxAmount,
    required Object currency,
  }) => 'Kwota: ${minAmount}-${maxAmount} ${currency}';
  @override
  String feeDisplay({required Object fee}) => '${fee}% opłata';
}

// Path: coordinator.selector
class _TranslationsCoordinatorSelectorPl
    extends TranslationsCoordinatorSelectorEn {
  _TranslationsCoordinatorSelectorPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get loading => 'Ładowanie koordynatorów...';
  @override
  String get errorLoading => 'Błąd ładowania koordynatorów';
  @override
  String get choose => 'Wybierz koordynatora';
  @override
  String get viewNostrProfile => 'Zobacz profil Nostr';
  @override
  String get unresponsive => 'Ten koordynator nie odpowiada';
  @override
  String get waitingResponse => 'Oczekiwanie na odpowiedź koordynatora';
  @override
  String get termsAccept => 'Akceptuję ';
  @override
  String get termsOfUsage => 'Warunki użytkowania';
}

// Path: coordinator.dialog
class _TranslationsCoordinatorDialogPl extends TranslationsCoordinatorDialogEn {
  _TranslationsCoordinatorDialogPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get makerFee => 'Opłata twórcy';
  @override
  String get takerFee => 'Opłata odbiorcy';
  @override
  String get amountRange => 'Zakres kwoty';
  @override
  String get reservationTime => 'Czas rezerwacji';
  @override
  String get currencies => 'Waluty';
  @override
  String get viewTerms => 'Zobacz warunki';
}

// Path: coordinator.management
class _TranslationsCoordinatorManagementPl
    extends TranslationsCoordinatorManagementEn {
  _TranslationsCoordinatorManagementPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Zarządzanie Koordynatorami';
  @override
  String get availableCoordinators => 'Dostępni Koordynatorzy';
  @override
  String get noCoordinators => 'Nie odkryto jeszcze żadnych koordynatorów.';
  @override
  String get online => 'Online';
  @override
  String get unknownOffline => 'Nieznany/Offline';
  @override
  String get openNostrProfile => 'Otwórz profil Nostr';
  @override
  String get enable => 'Włącz';
  @override
  String get remove => 'Usuń';
  @override
  String get addCustomWhitelist => 'Dodaj koordynatora';
  @override
  String get addCustomWhitelistHint => 'npub1...';
  @override
  String get add => 'Dodaj';
  @override
  String get coordinatorBlacklisted => 'Koordynator zablokowany';
  @override
  String get coordinatorUnblacklisted => 'Koordynator odblokowany';
  @override
  String get coordinatorAdded =>
      'Koordynator dodany do niestandardowej białej listy';
  @override
  String get coordinatorRemoved =>
      'Koordynator usunięty z niestandardowej białej listy';
  @override
  String get pleaseEnterNpub => 'Proszę wprowadzić npub';
  @override
  String get error => 'Błąd';
}

// Path: maker.roleSelection
class _TranslationsMakerRoleSelectionPl
    extends TranslationsMakerRoleSelectionEn {
  _TranslationsMakerRoleSelectionPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get button => 'ZAPŁAĆ przez Lightning';
}

// Path: maker.amountForm
class _TranslationsMakerAmountFormPl extends TranslationsMakerAmountFormEn {
  _TranslationsMakerAmountFormPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsMakerAmountFormProgressPl progress =
      _TranslationsMakerAmountFormProgressPl._(_root);
  @override
  late final _TranslationsMakerAmountFormLabelsPl labels =
      _TranslationsMakerAmountFormLabelsPl._(_root);
  @override
  late final _TranslationsMakerAmountFormActionsPl actions =
      _TranslationsMakerAmountFormActionsPl._(_root);
  @override
  late final _TranslationsMakerAmountFormTooltipsPl tooltips =
      _TranslationsMakerAmountFormTooltipsPl._(_root);
  @override
  late final _TranslationsMakerAmountFormErrorsPl errors =
      _TranslationsMakerAmountFormErrorsPl._(_root);
}

// Path: maker.payInvoice
class _TranslationsMakerPayInvoicePl extends TranslationsMakerPayInvoiceEn {
  _TranslationsMakerPayInvoicePl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Zapłać tę fakturę Hold:';
  @override
  late final _TranslationsMakerPayInvoiceActionsPl actions =
      _TranslationsMakerPayInvoiceActionsPl._(_root);
  @override
  late final _TranslationsMakerPayInvoiceFeedbackPl feedback =
      _TranslationsMakerPayInvoiceFeedbackPl._(_root);
  @override
  late final _TranslationsMakerPayInvoiceErrorsPl errors =
      _TranslationsMakerPayInvoiceErrorsPl._(_root);
}

// Path: maker.waitTaker
class _TranslationsMakerWaitTakerPl extends TranslationsMakerWaitTakerEn {
  _TranslationsMakerWaitTakerPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Oczekiwanie na rezerwację przez Kupującego...';
  @override
  String get errorActiveOfferDetailsLost =>
      'Błąd: Utracono szczegóły aktywnej oferty.';
  @override
  String get errorFailedToRetrieveBlik =>
      'Błąd: Nie udało się pobrać kodu BLIK.';
  @override
  String errorRetrievingBlik({required Object details}) =>
      'Błąd pobierania kodu BLIK: ${details}';
  @override
  String offerNoLongerAvailable({required Object status}) =>
      'Oferta nie jest już dostępna (Status: ${status}).';
  @override
  String get errorCouldNotIdentifyOffer =>
      'Błąd: Nie można zidentyfikować oferty do anulowania.';
  @override
  String offerCannotBeCancelled({required Object status}) =>
      'Oferty nie można anulować w obecnym stanie (${status}).';
  @override
  String get offerCancelledSuccessfully => 'Oferta anulowana pomyślnie.';
  @override
  String failedToCancelOffer({required Object details}) =>
      'Nie udało się anulować oferty: ${details}';
}

// Path: maker.waitForBlik
class _TranslationsMakerWaitForBlikPl extends TranslationsMakerWaitForBlikEn {
  _TranslationsMakerWaitForBlikPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Oczekiwanie na BLIK';
  @override
  String get messageInfo => 'Ktoś zarezerwował twoją ofertę!';
  @override
  String get messageWaiting => 'Oczekiwanie na kod BLIK...';
  @override
  String progressLabel({required Object seconds}) =>
      'Zarezerwowano: ${seconds} s pozostało';
}

// Path: maker.confirmPayment
class _TranslationsMakerConfirmPaymentPl
    extends TranslationsMakerConfirmPaymentEn {
  _TranslationsMakerConfirmPaymentPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Otrzymano kod BLIK!';
  @override
  String get retrieving => 'Pobieranie kodu BLIK...';
  @override
  String get instruction1 => 'Wprowadź kod do systemu płatności BLIK.';
  @override
  String get instruction2 =>
      'Poczekaj, aż Kupujący potwierdzi płatność w swojej aplikacji banku.';
  @override
  String get instruction3 =>
      'Gdy płatność zakończy się sukcesem, naciśnij Potwierdź poniżej:';
  @override
  String get takerChargedWarning =>
      'Pobierający zgłosił, że płatność BLIK została pobrana z jego konta bankowego. Oznaczenie tego jako nieprawidłowe spowoduje konflikt.';
  @override
  String get expiredTitle => 'Kod BLIK wygasł';
  @override
  String get expiredWarning =>
      'Kod BLIK wygasł. Musisz ręcznie potwierdzić status płatności:';
  @override
  String get expiredInstruction1 =>
      'Jeśli płatność BLIK zakończyła się sukcesem i zrealizowałeś zakup, kliknij "Potwierdź udaną płatność" poniżej.';
  @override
  String get expiredInstruction2 =>
      'Jeśli płatność BLIK nie powiodła się lub nie została zrealizowana, kliknij "Nieprawidłowy kod BLIK" poniżej.';
  @override
  late final _TranslationsMakerConfirmPaymentActionsPl actions =
      _TranslationsMakerConfirmPaymentActionsPl._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentConfirmDialogPl confirmDialog =
      _TranslationsMakerConfirmPaymentConfirmDialogPl._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogPl
  invalidBlikDisputeDialog =
      _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogPl._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentFeedbackPl feedback =
      _TranslationsMakerConfirmPaymentFeedbackPl._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentErrorsPl errors =
      _TranslationsMakerConfirmPaymentErrorsPl._(_root);
}

// Path: maker.invalidBlik
class _TranslationsMakerInvalidBlikPl extends TranslationsMakerInvalidBlikEn {
  _TranslationsMakerInvalidBlikPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Nieprawidłowy kod BLIK';
  @override
  String get info =>
      'Oznaczyłeś kod BLIK jako nieprawidłowy. Oczekiwanie na podanie nowego kodu przez takera lub rozpoczęcie sporu.';
}

// Path: maker.conflict
class _TranslationsMakerConflictPl extends TranslationsMakerConflictEn {
  _TranslationsMakerConflictPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Konflikt Oferty';
  @override
  String get headline => 'Zgłoszono Konflikt Oferty';
  @override
  String get body =>
      'Oznaczyłeś kod BLIK jako nieprawidłowy, ale Taker zgłosił konflikt, wskazując, że uważa, iż płatność zakończyła się sukcesem.';
  @override
  String get instructions =>
      'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.';
  @override
  late final _TranslationsMakerConflictActionsPl actions =
      _TranslationsMakerConflictActionsPl._(_root);
  @override
  late final _TranslationsMakerConflictDisputeDialogPl disputeDialog =
      _TranslationsMakerConflictDisputeDialogPl._(_root);
  @override
  late final _TranslationsMakerConflictFeedbackPl feedback =
      _TranslationsMakerConflictFeedbackPl._(_root);
  @override
  late final _TranslationsMakerConflictErrorsPl errors =
      _TranslationsMakerConflictErrorsPl._(_root);
}

// Path: maker.success
class _TranslationsMakerSuccessPl extends TranslationsMakerSuccessEn {
  _TranslationsMakerSuccessPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Oferta zakończona';
  @override
  String get headline => 'Płatność potwierdzona!';
  @override
  String get subtitle => 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.';
  @override
  String get detailsTitle => 'Szczegóły oferty:';
  @override
  String duration({required Object time}) => 'Oferta zajęła ${time}!';
}

// Path: taker.roleSelection
class _TranslationsTakerRoleSelectionPl
    extends TranslationsTakerRoleSelectionEn {
  _TranslationsTakerRoleSelectionPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get button => 'SPRZEDAJ kod BLIK za satoshi';
}

// Path: taker.progress
class _TranslationsTakerProgressPl extends TranslationsTakerProgressEn {
  _TranslationsTakerProgressPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get step1 => 'Wyślij BLIK';
  @override
  String get step2 => 'Potwierdź BLIK';
  @override
  String get step3 => 'Otrzymaj płatność';
}

// Path: taker.submitBlik
class _TranslationsTakerSubmitBlikPl extends TranslationsTakerSubmitBlikEn {
  _TranslationsTakerSubmitBlikPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Wpisz 6-cyfr BLIK';
  @override
  String get label => 'Kod BLIK';
  @override
  String get instruction => 'Wprowadź BLIK zanim upłynie czas...';
  @override
  String timeLimit({required Object seconds}) =>
      'Wprowadź BLIK w ciągu: ${seconds} s';
  @override
  String get timeExpired => 'Czas na wprowadzenie kodu BLIK minął.';
  @override
  late final _TranslationsTakerSubmitBlikActionsPl actions =
      _TranslationsTakerSubmitBlikActionsPl._(_root);
  @override
  late final _TranslationsTakerSubmitBlikFeedbackPl feedback =
      _TranslationsTakerSubmitBlikFeedbackPl._(_root);
  @override
  late final _TranslationsTakerSubmitBlikValidationPl validation =
      _TranslationsTakerSubmitBlikValidationPl._(_root);
  @override
  late final _TranslationsTakerSubmitBlikErrorsPl errors =
      _TranslationsTakerSubmitBlikErrorsPl._(_root);
  @override
  late final _TranslationsTakerSubmitBlikDetailsPl details =
      _TranslationsTakerSubmitBlikDetailsPl._(_root);
}

// Path: taker.waitConfirmation
class _TranslationsTakerWaitConfirmationPl
    extends TranslationsTakerWaitConfirmationEn {
  _TranslationsTakerWaitConfirmationPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Oczekiwanie na Makera';
  @override
  String statusLabel({required Object status}) => 'Status oferty: ${status}';
  @override
  String waitingMaker({required Object seconds}) =>
      'Oczekiwanie na potwierdzenie Makera: ${seconds} s';
  @override
  String waitingMakerConfirmation({required Object seconds}) =>
      'Oczekiwanie na potwierdzenie płatności BLIK przez Makera w jego aplikacji bankowej. Pozostały czas: ${seconds}s';
  @override
  String importantNotice({required Object amount, required Object currency}) =>
      'BARDZO WAŻNE: Upewnij się, że akceptujesz potwierdzenie BLIK tylko na kwotę ${amount} ${currency}';
  @override
  String importantBlikAmountConfirmation({
    required Object amount,
    required Object currency,
  }) =>
      'BARDZO WAŻNE: W swojej aplikacji bankowej upewnij się, że potwierdzasz płatność BLIK na kwotę dokładnie ${amount} ${currency}.';
  @override
  String get instructions =>
      'Osoba wystawiająca ofertę musi teraz wpisać kod BLIK w ciągu 2 minut. Następnie musisz zaakceptować kod BLIK w swojej aplikacji bankowej.';
  @override
  String get waitingForMakerToReceive =>
      'Czekamy, aż twórca oferty otrzyma Twój kod BLIK...';
  @override
  String get makerReceivedBlik => 'Twórca oferty otrzymał Twój kod BLIK';
  @override
  String get timerExpiredMessage =>
      'Minął termin ważności kodu BLIK 2m. Czekamy na potwierdzenie lub oznaczenie kodu jako nieważnego przez wystawcę oferty.';
  @override
  String get timerExpiredActions =>
      'Minął termin ważności kodu BLIK 2m, ale wystawca nie otrzymał kodu BLIK. Możesz wysłać nowy kod BLIK lub anulować.';
  @override
  String get resendBlikButton => 'Wyślij nowy kod BLIK';
  @override
  String get navigatedHome => 'Przeniesiono na stronę główną.';
  @override
  String get expiredTitle => 'Kod BLIK wygasł';
  @override
  String get expiredWarning =>
      'Twórca oferty nie otrzymał kodu BLIK, więc nie mógł go użyć.';
  @override
  String get expiredSentWarning =>
      'Twórca oferty jeszcze nie potwierdził płatności. Co chcesz zrobić?';
  @override
  String get expiredInstruction1 =>
      'Jeśli chcesz spróbować ponownie z nowym kodem BLIK, odnów rezerwację.';
  @override
  String get expiredInstruction2 =>
      'Jeśli nie chcesz już dokończyć tej transakcji, anuluj rezerwację.';
  @override
  String get expiredInstruction3 =>
      'Jeśli płatność BLIK została pobrana z Twojego konta bankowego, nie martw się, bitcoin jest nadal bezpiecznie zablokowany u koordynatora.';
  @override
  late final _TranslationsTakerWaitConfirmationTakerChargedPl takerCharged =
      _TranslationsTakerWaitConfirmationTakerChargedPl._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationExpiredActionsPl expiredActions =
      _TranslationsTakerWaitConfirmationExpiredActionsPl._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationFeedbackPl feedback =
      _TranslationsTakerWaitConfirmationFeedbackPl._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationErrorsPl errors =
      _TranslationsTakerWaitConfirmationErrorsPl._(_root);
}

// Path: taker.paymentProcess
class _TranslationsTakerPaymentProcessPl
    extends TranslationsTakerPaymentProcessEn {
  _TranslationsTakerPaymentProcessPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Proces Płatności';
  @override
  String get waitingForOfferUpdate =>
      'Oczekiwanie na aktualizację statusu oferty...';
  @override
  late final _TranslationsTakerPaymentProcessStatesPl states =
      _TranslationsTakerPaymentProcessStatesPl._(_root);
  @override
  late final _TranslationsTakerPaymentProcessStepsPl steps =
      _TranslationsTakerPaymentProcessStepsPl._(_root);
  @override
  late final _TranslationsTakerPaymentProcessErrorsPl errors =
      _TranslationsTakerPaymentProcessErrorsPl._(_root);
  @override
  late final _TranslationsTakerPaymentProcessLoadingPl loading =
      _TranslationsTakerPaymentProcessLoadingPl._(_root);
  @override
  late final _TranslationsTakerPaymentProcessActionsPl actions =
      _TranslationsTakerPaymentProcessActionsPl._(_root);
}

// Path: taker.paymentFailed
class _TranslationsTakerPaymentFailedPl
    extends TranslationsTakerPaymentFailedEn {
  _TranslationsTakerPaymentFailedPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Płatność Nie Powiodła Się';
  @override
  String instructions({required Object netAmount}) =>
      'Proszę podać nową fakturę Lightning na kwotę ${netAmount} satoshi';
  @override
  late final _TranslationsTakerPaymentFailedFormPl form =
      _TranslationsTakerPaymentFailedFormPl._(_root);
  @override
  late final _TranslationsTakerPaymentFailedActionsPl actions =
      _TranslationsTakerPaymentFailedActionsPl._(_root);
  @override
  late final _TranslationsTakerPaymentFailedErrorsPl errors =
      _TranslationsTakerPaymentFailedErrorsPl._(_root);
  @override
  late final _TranslationsTakerPaymentFailedLoadingPl loading =
      _TranslationsTakerPaymentFailedLoadingPl._(_root);
  @override
  late final _TranslationsTakerPaymentFailedSuccessPl success =
      _TranslationsTakerPaymentFailedSuccessPl._(_root);
}

// Path: taker.paymentSuccess
class _TranslationsTakerPaymentSuccessPl
    extends TranslationsTakerPaymentSuccessEn {
  _TranslationsTakerPaymentSuccessPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Płatność Udana';
  @override
  String get message => 'Twoja płatność została przetworzona pomyślnie.';
  @override
  late final _TranslationsTakerPaymentSuccessActionsPl actions =
      _TranslationsTakerPaymentSuccessActionsPl._(_root);
}

// Path: taker.invalidBlik
class _TranslationsTakerInvalidBlikPl extends TranslationsTakerInvalidBlikEn {
  _TranslationsTakerInvalidBlikPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Nieprawidłowy Kod BLIK';
  @override
  String get message => 'Maker Odrzucił Kod BLIK';
  @override
  String get explanation =>
      'Maker oferty wskazał, że podany przez Ciebie kod BLIK był nieprawidłowy lub nie zadziałał.\n\nCo chcesz zrobić?';
  @override
  String get werentCharged => 'Jeśli Twoje konto NIE zostało obciążone:';
  @override
  String get wereCharged => 'Jeśli Twoje konto zostało obciążone:';
  @override
  late final _TranslationsTakerInvalidBlikActionsPl actions =
      _TranslationsTakerInvalidBlikActionsPl._(_root);
  @override
  late final _TranslationsTakerInvalidBlikFeedbackPl feedback =
      _TranslationsTakerInvalidBlikFeedbackPl._(_root);
  @override
  late final _TranslationsTakerInvalidBlikErrorsPl errors =
      _TranslationsTakerInvalidBlikErrorsPl._(_root);
}

// Path: taker.conflict
class _TranslationsTakerConflictPl extends TranslationsTakerConflictEn {
  _TranslationsTakerConflictPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Konflikt Oferty';
  @override
  String get headline => 'Zgłoszono Konflikt Oferty';
  @override
  String get body =>
      'Maker oznaczył kod BLIK jako nieprawidłowy, ale Ty zgłosiłeś konflikt, wskazując, że uważasz, iż płatność zakończyła się sukcesem.';
  @override
  String get instructions =>
      'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.';
  @override
  late final _TranslationsTakerConflictActionsPl actions =
      _TranslationsTakerConflictActionsPl._(_root);
  @override
  late final _TranslationsTakerConflictFeedbackPl feedback =
      _TranslationsTakerConflictFeedbackPl._(_root);
  @override
  late final _TranslationsTakerConflictErrorsPl errors =
      _TranslationsTakerConflictErrorsPl._(_root);
}

// Path: blik.instructions
class _TranslationsBlikInstructionsPl extends TranslationsBlikInstructionsEn {
  _TranslationsBlikInstructionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get taker =>
      'Gdy Maker wprowadzi kod BLIK, będziesz musiał potwierdzić płatność w swojej aplikacji bankowej. Upewnij się, że kwota jest poprawna przed potwierdzeniem.';
}

// Path: generateNewKey.buttons
class _TranslationsGenerateNewKeyButtonsPl
    extends TranslationsGenerateNewKeyButtonsEn {
  _TranslationsGenerateNewKeyButtonsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get generate => 'Generuj';
}

// Path: generateNewKey.errors
class _TranslationsGenerateNewKeyErrorsPl
    extends TranslationsGenerateNewKeyErrorsEn {
  _TranslationsGenerateNewKeyErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get activeOffer =>
      'Nie możesz wygenerować nowego Neko, gdy masz aktywną ofertę.';
  @override
  String get failed => 'Nie udało się wygenerować nowego Neko';
}

// Path: generateNewKey.feedback
class _TranslationsGenerateNewKeyFeedbackPl
    extends TranslationsGenerateNewKeyFeedbackEn {
  _TranslationsGenerateNewKeyFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get success => 'Nowe Neko wygenerowane pomyślnie!';
}

// Path: generateNewKey.tooltips
class _TranslationsGenerateNewKeyTooltipsPl
    extends TranslationsGenerateNewKeyTooltipsEn {
  _TranslationsGenerateNewKeyTooltipsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get generate => 'Wygeneruj nowe Neko';
}

// Path: backup.feedback
class _TranslationsBackupFeedbackPl extends TranslationsBackupFeedbackEn {
  _TranslationsBackupFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get copied => 'Klucz prywatny skopiowany do schowka!';
}

// Path: backup.tooltips
class _TranslationsBackupTooltipsPl extends TranslationsBackupTooltipsEn {
  _TranslationsBackupTooltipsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get backup => 'Zarchiwizuj Neko';
}

// Path: restore.labels
class _TranslationsRestoreLabelsPl extends TranslationsRestoreLabelsEn {
  _TranslationsRestoreLabelsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get privateKey => 'Klucz prywatny';
}

// Path: restore.buttons
class _TranslationsRestoreButtonsPl extends TranslationsRestoreButtonsEn {
  _TranslationsRestoreButtonsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get restore => 'Przywróć';
}

// Path: restore.errors
class _TranslationsRestoreErrorsPl extends TranslationsRestoreErrorsEn {
  _TranslationsRestoreErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get invalidKey => 'Musi to być 64-znakowy ciąg szesnastkowy.';
  @override
  String get failed => 'Przywracanie nie powiodło się';
}

// Path: restore.feedback
class _TranslationsRestoreFeedbackPl extends TranslationsRestoreFeedbackEn {
  _TranslationsRestoreFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get success =>
      'Neko przywrócone pomyślnie! Aplikacja zostanie ponownie uruchomiona.';
}

// Path: restore.tooltips
class _TranslationsRestoreTooltipsPl extends TranslationsRestoreTooltipsEn {
  _TranslationsRestoreTooltipsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get restore => 'Przywróć Neko';
}

// Path: home.notifications
class _TranslationsHomeNotificationsPl extends TranslationsHomeNotificationsEn {
  _TranslationsHomeNotificationsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Otrzymuj powiadomienia o nowych ofertach przez:';
  @override
  String get telegram => 'Telegram';
  @override
  String get simplex => 'SimpleX';
  @override
  String get element => 'Element';
  @override
  String get signal => 'Signal';
}

// Path: home.statistics
class _TranslationsHomeStatisticsPl extends TranslationsHomeStatisticsEn {
  _TranslationsHomeStatisticsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Zakończone oferty';
  @override
  String lifetimeCompact({
    required Object count,
    required Object avgBlikTime,
    required Object avgPaidTime,
  }) =>
      'Wszystkie: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}';
  @override
  String last7DaysCompact({
    required Object count,
    required Object avgBlikTime,
    required Object avgPaidTime,
  }) =>
      'Ost. 7 dni: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}';
  @override
  String last7DaysSingleLine({
    required Object count,
    required Object avgBlikTime,
    required Object avgPaidTime,
  }) =>
      'Ost. 7 dni: ${count} ofert  |  Śr. BLIK: ${avgBlikTime}  |  Śr. płatność: ${avgPaidTime}';
  @override
  late final _TranslationsHomeStatisticsErrorsPl errors =
      _TranslationsHomeStatisticsErrorsPl._(_root);
}

// Path: system.errors
class _TranslationsSystemErrorsPl extends TranslationsSystemErrorsEn {
  _TranslationsSystemErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get generic =>
      'Wystąpił nieoczekiwany błąd. Proszę spróbować ponownie.';
  @override
  String get loadingTimeoutConfig =>
      'Błąd ładowania konfiguracji limitu czasu.';
  @override
  String get loadingCoordinatorConfig =>
      'Błąd ładowania konfiguracji koordynatora. Proszę spróbować ponownie.';
  @override
  String get noPublicKey =>
      'Twój klucz publiczny nie jest dostępny. Nie można kontynuować.';
  @override
  String get internalOfferIncomplete =>
      'Błąd wewnętrzny: Szczegóły oferty są niekompletne. Spróbuj ponownie.';
  @override
  String get loadingPublicKey =>
      'Błąd ładowania Twojego klucza publicznego. Uruchom ponownie aplikację.';
}

// Path: system.blik
class _TranslationsSystemBlikPl extends TranslationsSystemBlikEn {
  _TranslationsSystemBlikPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get copied => 'Kod BLIK skopiowany do schowka';
}

// Path: landing.actions
class _TranslationsLandingActionsPl extends TranslationsLandingActionsEn {
  _TranslationsLandingActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get payBlik => 'Zapłać BLIK';
  @override
  String get payBlikSubtitle => 'używając bitcoin';
  @override
  String get sellBlik => 'Kup bitcoin';
  @override
  String get sellBlikSubtitle => 'używając BLIK';
  @override
  String get howItWorks => 'Jak to działa?';
}

// Path: wallet.missingReceiving
class _TranslationsWalletMissingReceivingPl
    extends TranslationsWalletMissingReceivingEn {
  _TranslationsWalletMissingReceivingPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Wymagany portfel odbiorczy';
  @override
  String get message =>
      'Brak skonfigurowanego portfela do odbierania. Dodaj go w ustawieniach portfela, aby przyjmować oferty.';
  @override
  String get openSettings => 'Ustawienia portfela';
}

// Path: nwc.labels
class _TranslationsNwcLabelsPl extends TranslationsNwcLabelsEn {
  _TranslationsNwcLabelsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get connectionString => 'Ciąg połączenia NWC';
  @override
  String get hint => 'nostr+walletconnect://...';
  @override
  String get status => 'Status połączenia';
  @override
  String get connected => 'Połączono';
  @override
  String get disconnected => 'Rozłączono';
  @override
  String get scanQrCode => 'Zeskanuj kod QR z połączeniem NWC';
  @override
  String get balance => 'Saldo';
  @override
  String get budget => 'Budżet';
  @override
  String get usedBudget => 'Wykorzystano';
  @override
  String get totalBudget => 'Łącznie';
  @override
  String get renewsIn => 'Odnowienie za';
  @override
  String get renewalPeriod => 'Okres odnowienia';
  @override
  String get relay => 'Przekaźnik';
  @override
  String get relays => 'Przekaźniki';
}

// Path: nwc.prompts
class _TranslationsNwcPromptsPl extends TranslationsNwcPromptsEn {
  _TranslationsNwcPromptsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get enter => 'Wprowadź swój ciąg połączenia NWC';
  @override
  String get connect => 'Połącz portfel';
  @override
  String get disconnect => 'Rozłącz';
  @override
  String get confirmDisconnect => 'Czy na pewno chcesz rozłączyć portfel NWC?';
  @override
  String get pasteConnection => 'Wklej ciąg połączenia';
  @override
  String get chooseMethod => 'Wybierz sposób połączenia portfela Lightning';
  @override
  String get howToGet =>
      'Nie masz jeszcze połączenia NWC? Dowiedz się, jak je uzyskać!';
  @override
  String get learnMore => 'Dowiedz się więcej o NWC';
}

// Path: nwc.actions
class _TranslationsNwcActionsPl extends TranslationsNwcActionsEn {
  _TranslationsNwcActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get connectAlbyGo => 'Połącz z Alby Go';
  @override
  String get connectNwc => 'Skanuj kod QR NWC';
}

// Path: nwc.feedback
class _TranslationsNwcFeedbackPl extends TranslationsNwcFeedbackEn {
  _TranslationsNwcFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Portfel NWC połączony pomyślnie!';
  @override
  String get disconnected => 'Portfel NWC rozłączony';
  @override
  String get connecting => 'Łączenie z portfelem NWC...';
  @override
  String get loadingWalletInfo => 'Ładowanie informacji o portfelu...';
}

// Path: nwc.errors
class _TranslationsNwcErrorsPl extends TranslationsNwcErrorsEn {
  _TranslationsNwcErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String connecting({required Object details}) =>
      'Błąd połączenia z NWC: ${details}';
  @override
  String disconnecting({required Object details}) =>
      'Błąd rozłączania NWC: ${details}';
  @override
  String get invalid => 'Nieprawidłowy ciąg połączenia NWC';
  @override
  String get required => 'Wymagany ciąg połączenia NWC';
  @override
  String get loadingBalance => 'Nie udało się załadować salda portfela';
  @override
  String get loadingBudget => 'Nie udało się załadować budżetu portfela';
}

// Path: nwc.time
class _TranslationsNwcTimePl extends TranslationsNwcTimeEn {
  _TranslationsNwcTimePl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String minutes({required Object count}) => '${count}m';
  @override
  String hours({required Object count}) => '${count}h';
  @override
  String days({required Object count}) => '${count}d';
  @override
  String get justNow => 'teraz';
}

// Path: relays.status
class _TranslationsRelaysStatusPl extends TranslationsRelaysStatusEn {
  _TranslationsRelaysStatusPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Połączony';
  @override
  String get connecting => 'Łączenie';
  @override
  String get reconnecting => 'Ponowne łączenie';
  @override
  String get disconnected => 'Rozłączony';
}

// Path: relays.popup
class _TranslationsRelaysPopupPl extends TranslationsRelaysPopupEn {
  _TranslationsRelaysPopupPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object connected, required Object total}) =>
      'Przekaźniki (${connected}/${total} połączonych)';
  @override
  String get connectingMessage => 'Łączenie z przekaźnikami...';
}

// Path: maker.amountForm.progress
class _TranslationsMakerAmountFormProgressPl
    extends TranslationsMakerAmountFormProgressEn {
  _TranslationsMakerAmountFormProgressPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get step1 => '1. Utwórz Ofertę';
  @override
  String get step2 => '2. Czekaj na zabranie';
  @override
  String get step3 => '3. Użyj BLIK';
}

// Path: maker.amountForm.labels
class _TranslationsMakerAmountFormLabelsPl
    extends TranslationsMakerAmountFormLabelsEn {
  _TranslationsMakerAmountFormLabelsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get coordinator => 'Koordynator';
  @override
  String get exchangeRate => 'Kurs wymiany';
  @override
  String get fee => 'Opłata';
  @override
  String get satoshisToPay => 'Do zapłaty';
  @override
  String get enterAmount => 'Wprowadź kwotę';
  @override
  String get tapToSelect => 'Kliknij, aby wybrać';
}

// Path: maker.amountForm.actions
class _TranslationsMakerAmountFormActionsPl
    extends TranslationsMakerAmountFormActionsEn {
  _TranslationsMakerAmountFormActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get generateInvoice => 'Wygeneruj Fakturę';
}

// Path: maker.amountForm.tooltips
class _TranslationsMakerAmountFormTooltipsPl
    extends TranslationsMakerAmountFormTooltipsEn {
  _TranslationsMakerAmountFormTooltipsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String feeInfo({required Object feePercent}) =>
      'Koordynator pobiera od twórcy opłatę w wysokości ${feePercent}%. Ta opłata jest odejmowana od Twojej płatności Lightning.';
  @override
  String get payInfo =>
      'Ta kalkulacja jest oparta na kursach wymiany pobranych po stronie klienta. Koordynator obliczy dokładną kwotę, a kwota faktury będzie ostateczną i dokładną kwotą do zapłaty.';
}

// Path: maker.amountForm.errors
class _TranslationsMakerAmountFormErrorsPl
    extends TranslationsMakerAmountFormErrorsEn {
  _TranslationsMakerAmountFormErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String initiating({required Object details}) =>
      'Błąd inicjowania oferty: ${details}';
  @override
  String get publicKeyNotLoaded =>
      'Błąd: Klucz publiczny nie został jeszcze załadowany.';
}

// Path: maker.payInvoice.actions
class _TranslationsMakerPayInvoiceActionsPl
    extends TranslationsMakerPayInvoiceActionsEn {
  _TranslationsMakerPayInvoiceActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get copy => 'Kopiuj Fakturę';
  @override
  String get payInWallet => 'Otwórz w portfelu zewnętrznym';
  @override
  String get connectWallet => 'Połącz portfel';
  @override
  String get payWithNwc => 'Zapłać';
  @override
  String get paying => 'Płacenie...';
}

// Path: maker.payInvoice.feedback
class _TranslationsMakerPayInvoiceFeedbackPl
    extends TranslationsMakerPayInvoiceFeedbackEn {
  _TranslationsMakerPayInvoiceFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get copied => 'Faktura skopiowana do schowka!';
  @override
  String get waitingConfirmation => 'Oczekiwanie na potwierdzenie płatności...';
  @override
  String get nwcConnected => 'Portfel NWC połączony!';
  @override
  String get nwcPaymentSuccess => 'Płatność udana!';
}

// Path: maker.payInvoice.errors
class _TranslationsMakerPayInvoiceErrorsPl
    extends TranslationsMakerPayInvoiceErrorsEn {
  _TranslationsMakerPayInvoiceErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get couldNotOpenApp =>
      'Nie można otworzyć aplikacji Lightning dla faktury.';
  @override
  String openingApp({required Object details}) =>
      'Błąd otwierania aplikacji Lightning: ${details}';
  @override
  String get publicKeyNotAvailable => 'Klucz publiczny nie jest dostępny.';
  @override
  String get couldNotFetchActive =>
      'Nie udało się pobrać szczegółów aktywnej oferty. Mogła wygasnąć.';
  @override
  String nwcPaymentFailed({required Object details}) =>
      'Płatność nie powiodła się: ${details}';
  @override
  String get nwcNotConnected => 'Portfel NWC nie jest połączony';
  @override
  String insufficientBalance({
    required Object required,
    required Object available,
  }) =>
      'Niewystarczające środki. Potrzeba ${required} sats, dostępne ${available} sats';
}

// Path: maker.confirmPayment.actions
class _TranslationsMakerConfirmPaymentActionsPl
    extends TranslationsMakerConfirmPaymentActionsEn {
  _TranslationsMakerConfirmPaymentActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get confirm => 'Potwierdź udaną płatność';
  @override
  String get markInvalid => 'Nieprawidłowy kod BLIK';
  @override
  String get copyBlik => 'Kopiuj BLIK';
}

// Path: maker.confirmPayment.confirmDialog
class _TranslationsMakerConfirmPaymentConfirmDialogPl
    extends TranslationsMakerConfirmPaymentConfirmDialogEn {
  _TranslationsMakerConfirmPaymentConfirmDialogPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Potwierdzić płatność?';
  @override
  String get content =>
      'Ta akcja jest nieodwracalna. Po potwierdzeniu:\n\n• Kupujący otrzyma środki natychmiast\n• Koordynator nie będzie mógł zakwestionować środków\n• Nie możesz cofnąć tej akcji\n\nPotwierdź tylko wtedy, gdy płatność BLIK zakończyła się sukcesem.';
  @override
  String get cancel => 'Anuluj';
  @override
  String get confirmButton => 'Tak, potwierdź płatność';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogPl
    extends TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogEn {
  _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogPl._(
    TranslationsPl root,
  ) : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Otworzyć spór?';
  @override
  String get content =>
      'Kupujący zgłosił, że płatność BLIK została pobrana z jego konta.\n\nOznaczenie tego jako nieprawidłowe natychmiast otworzy SPÓR wymagający interwencji koordynatora.\n\n• Opłata za spór może zostać naliczona, jeśli zostanie rozstrzygnięty na Twoją niekorzyść\n• Faktura hold zostanie rozliczona natychmiast\n• Wymagana będzie ręczna weryfikacja\n\nKontynuuj tylko wtedy, gdy masz pewność, że płatność BLIK NIE powiodła się.';
  @override
  String get cancel => 'Anuluj';
  @override
  String get confirmButton => 'Tak, otwórz spór';
}

// Path: maker.confirmPayment.feedback
class _TranslationsMakerConfirmPaymentFeedbackPl
    extends TranslationsMakerConfirmPaymentFeedbackEn {
  _TranslationsMakerConfirmPaymentFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get confirmed => 'Maker potwierdził płatność.';
  @override
  String get confirmedTakerPaid =>
      'Płatność potwierdzona! Taker otrzyma środki.';
  @override
  String progressLabel({required Object seconds}) =>
      'Potwierdzanie: ${seconds} s pozostało';
}

// Path: maker.confirmPayment.errors
class _TranslationsMakerConfirmPaymentErrorsPl
    extends TranslationsMakerConfirmPaymentErrorsEn {
  _TranslationsMakerConfirmPaymentErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get failedToRetrieve => 'Błąd: Nie udało się pobrać kodu BLIK.';
  @override
  String retrieving({required Object details}) =>
      'Błąd pobierania kodu BLIK: ${details}';
  @override
  String get missingHashOrKey =>
      'Błąd: Brakujący hash płatności lub klucz publiczny.';
  @override
  String incorrectState({required Object status}) =>
      'Oferta nie jest w prawidłowym stanie do potwierdzenia (Status: ${status})';
  @override
  String confirming({required Object details}) =>
      'Błąd potwierdzania płatności: ${details}';
  @override
  String get invalidState => 'Błąd: Otrzymano nieprawidłowy stan oferty.';
  @override
  String get internalIncomplete =>
      'Błąd wewnętrzny: Niekompletne szczegóły oferty.';
  @override
  String notAwaitingConfirmation({required Object status}) =>
      'Oferta nie oczekuje już na potwierdzenie (Status: ${status}).';
  @override
  String get unexpectedStatus =>
      'Otrzymano nieoczekiwany status oferty z serwera.';
}

// Path: maker.conflict.actions
class _TranslationsMakerConflictActionsPl
    extends TranslationsMakerConflictActionsEn {
  _TranslationsMakerConflictActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get back => 'Powrót do strony głównej';
  @override
  String get confirmPayment => 'Mój błąd, potwierdź sukces płatności BLIK';
  @override
  String get openDispute => 'Płatność BLIK NIE powiodła się, OTWÓRZ SPÓR';
  @override
  String get submitDispute => 'Zgłoś Spór';
}

// Path: maker.conflict.disputeDialog
class _TranslationsMakerConflictDisputeDialogPl
    extends TranslationsMakerConflictDisputeDialogEn {
  _TranslationsMakerConflictDisputeDialogPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Otworzyć spór?';
  @override
  String get content =>
      'Otwarcie sporu wymaga ręcznej weryfikacji przez koordynatora, co zajmie czas. Opłata za spór zostanie potrącona, jeśli spór zostanie rozstrzygnięty na Twoją niekorzyść. Faktura hold zostanie rozliczona, aby zapobiec jej wygaśnięciu. Jeśli spór zostanie rozstrzygnięty na Twoją korzyść, otrzymasz zwrot środków (pomniejszony o opłaty) na Twój adres Lightning.';
  @override
  String get contentDetailed =>
      'Otwarcie sporu będzie wymagało ręcznej interwencji koordynatora, co zajmuje czas i wiąże się z opłatą za spór.\n\nFaktura hold zostanie natychmiast rozliczona, aby zapobiec jej wygaśnięciu przed rozstrzygnięciem sporu.\n\nJeśli spór zostanie rozstrzygnięty na Twoją korzyść, kwota satoshi zostanie zwrócona na Twój adres Lightning (pomniejszona o opłaty). Upewnij się, że masz skonfigurowany adres Lightning.';
  @override
  late final _TranslationsMakerConflictDisputeDialogActionsPl actions =
      _TranslationsMakerConflictDisputeDialogActionsPl._(_root);
}

// Path: maker.conflict.feedback
class _TranslationsMakerConflictFeedbackPl
    extends TranslationsMakerConflictFeedbackEn {
  _TranslationsMakerConflictFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get disputeOpenedSuccess =>
      'Spór pomyślnie otwarty. Koordynator rozpatrzy sprawę.';
}

// Path: maker.conflict.errors
class _TranslationsMakerConflictErrorsPl
    extends TranslationsMakerConflictErrorsEn {
  _TranslationsMakerConflictErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String openingDispute({required Object error}) =>
      'Błąd otwierania sporu: ${error}';
}

// Path: taker.submitBlik.actions
class _TranslationsTakerSubmitBlikActionsPl
    extends TranslationsTakerSubmitBlikActionsEn {
  _TranslationsTakerSubmitBlikActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get submit => 'Wyślij BLIK';
}

// Path: taker.submitBlik.feedback
class _TranslationsTakerSubmitBlikFeedbackPl
    extends TranslationsTakerSubmitBlikFeedbackEn {
  _TranslationsTakerSubmitBlikFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get pasted => 'Wklejono kod BLIK.';
}

// Path: taker.submitBlik.validation
class _TranslationsTakerSubmitBlikValidationPl
    extends TranslationsTakerSubmitBlikValidationEn {
  _TranslationsTakerSubmitBlikValidationPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get invalidFormat => 'Wprowadź prawidłowy 6-cyfrowy kod BLIK.';
}

// Path: taker.submitBlik.errors
class _TranslationsTakerSubmitBlikErrorsPl
    extends TranslationsTakerSubmitBlikErrorsEn {
  _TranslationsTakerSubmitBlikErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String submitting({required Object details}) =>
      'Błąd wysyłania kodu BLIK: ${details}';
  @override
  String get clipboardInvalid =>
      'Schowek nie zawiera prawidłowego 6-cyfrowego kodu BLIK.';
  @override
  String get stateChanged => 'Błąd: Stan oferty uległ zmianie.';
  @override
  String get stateNotValid => 'Błąd: Stan oferty nie jest już ważny.';
  @override
  String fetchedIdMismatch({
    required Object fetchedId,
    required Object initialId,
  }) =>
      'Pobrane ID aktywnej oferty (${fetchedId}) nie pasuje do początkowego ID oferty (${initialId}). Niezgodność stanu?';
  @override
  String get paymentHashMissing => 'Brak hasha płatności oferty po pobraniu.';
}

// Path: taker.submitBlik.details
class _TranslationsTakerSubmitBlikDetailsPl
    extends TranslationsTakerSubmitBlikDetailsEn {
  _TranslationsTakerSubmitBlikDetailsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get requestedAmount => 'Żądana kwota BLIK';
  @override
  String get exchangeRate => 'Kurs wymiany';
  @override
  String get takerFee => 'Opłata Taker';
  @override
  String get status => 'Status';
  @override
  String get youllReceive => 'Otrzymasz';
}

// Path: taker.waitConfirmation.takerCharged
class _TranslationsTakerWaitConfirmationTakerChargedPl
    extends TranslationsTakerWaitConfirmationTakerChargedEn {
  _TranslationsTakerWaitConfirmationTakerChargedPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Oznaczyłeś BLIK jako opłacony';
  @override
  String get message =>
      'Twórca oferty musi potwierdzić płatność lub ją zakwestionować. Jeśli nic nie zrobi, płatność zostanie automatycznie potwierdzona, a Ty otrzymasz bitcoiny.';
}

// Path: taker.waitConfirmation.expiredActions
class _TranslationsTakerWaitConfirmationExpiredActionsPl
    extends TranslationsTakerWaitConfirmationExpiredActionsEn {
  _TranslationsTakerWaitConfirmationExpiredActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get reportConflict => 'BLIK został pobrany z mojego konta';
  @override
  String get renewReservation => 'Spróbuj ponownie z nowym kodem BLIK';
  @override
  String get cancelReservation => 'Anuluj rezerwację';
}

// Path: taker.waitConfirmation.feedback
class _TranslationsTakerWaitConfirmationFeedbackPl
    extends TranslationsTakerWaitConfirmationFeedbackEn {
  _TranslationsTakerWaitConfirmationFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get makerConfirmed => 'Maker potwierdził płatność.';
  @override
  String get paymentSuccessful => 'Płatność udana! Wkrótce otrzymasz środki.';
  @override
  String get conflictReported =>
      'Konflikt zgłoszony. Koordynator rozpatrzy sytuację.';
}

// Path: taker.waitConfirmation.errors
class _TranslationsTakerWaitConfirmationErrorsPl
    extends TranslationsTakerWaitConfirmationErrorsEn {
  _TranslationsTakerWaitConfirmationErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get invalidOfferStateReceived =>
      'Otrzymano ofertę o nieprawidłowym stanie dla tego ekranu. Resetowanie.';
  @override
  String reportingConflict({required Object details}) =>
      'Błąd zgłaszania konfliktu: ${details}';
}

// Path: taker.paymentProcess.states
class _TranslationsTakerPaymentProcessStatesPl
    extends TranslationsTakerPaymentProcessStatesEn {
  _TranslationsTakerPaymentProcessStatesPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get preparing => 'Przygotowywanie do wysłania płatności...';
  @override
  String get sending => 'Wysyłanie płatności...';
  @override
  String get received => 'Płatność otrzymana!';
  @override
  String get failed => 'Płatność nie powiodła się';
  @override
  String get waitingUpdate => 'Oczekiwanie na aktualizację oferty...';
}

// Path: taker.paymentProcess.steps
class _TranslationsTakerPaymentProcessStepsPl
    extends TranslationsTakerPaymentProcessStepsEn {
  _TranslationsTakerPaymentProcessStepsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get makerConfirmedBlik => 'Maker potwierdził płatność BLIK';
  @override
  String get makerInvoiceSettled => 'Faktura hold Makera rozliczona';
  @override
  String get payingTakerInvoice => 'Opłacanie Twojej faktury Lightning';
  @override
  String get takerInvoicePaid => 'Twoja faktura Lightning opłacona';
  @override
  String get takerPaymentFailed => 'Płatność na Twoją fakturę nie powiodła się';
}

// Path: taker.paymentProcess.errors
class _TranslationsTakerPaymentProcessErrorsPl
    extends TranslationsTakerPaymentProcessErrorsEn {
  _TranslationsTakerPaymentProcessErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String sending({required Object details}) =>
      'Błąd wysyłania płatności: ${details}';
  @override
  String get notConfirmed => 'Oferta niepotwierdzona przez Makera.';
  @override
  String get expired => 'Oferta wygasła.';
  @override
  String get cancelled => 'Oferta anulowana.';
  @override
  String get paymentFailed => 'Płatność oferty nie powiodła się.';
  @override
  String get unknown => 'Nieznany błąd oferty.';
  @override
  String get takerPaymentFailed =>
      'Płatność na Twoją fakturę Lightning nie powiodła się.';
  @override
  String get noPublicKey =>
      'Błąd: Nie można pobrać Twojego klucza publicznego.';
  @override
  String get loadingPublicKey => 'Błąd ładowania Twoich danych';
  @override
  String get missingPaymentHash => 'Błąd: Brakujące szczegóły płatności.';
}

// Path: taker.paymentProcess.loading
class _TranslationsTakerPaymentProcessLoadingPl
    extends TranslationsTakerPaymentProcessLoadingEn {
  _TranslationsTakerPaymentProcessLoadingPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get publicKey => 'Ładowanie Twoich danych...';
}

// Path: taker.paymentProcess.actions
class _TranslationsTakerPaymentProcessActionsPl
    extends TranslationsTakerPaymentProcessActionsEn {
  _TranslationsTakerPaymentProcessActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get goToFailureDetails => 'Wprowadź nową fakturę Lightning';
}

// Path: taker.paymentFailed.form
class _TranslationsTakerPaymentFailedFormPl
    extends TranslationsTakerPaymentFailedFormEn {
  _TranslationsTakerPaymentFailedFormPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get newInvoiceLabel => 'Nowa faktura Lightning';
  @override
  String get newInvoiceHint => 'Wprowadź swoją fakturę BOLT11';
}

// Path: taker.paymentFailed.actions
class _TranslationsTakerPaymentFailedActionsPl
    extends TranslationsTakerPaymentFailedActionsEn {
  _TranslationsTakerPaymentFailedActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get retryPayment => 'Wyślij nową fakturę';
}

// Path: taker.paymentFailed.errors
class _TranslationsTakerPaymentFailedErrorsPl
    extends TranslationsTakerPaymentFailedErrorsEn {
  _TranslationsTakerPaymentFailedErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get enterValidInvoice => 'Proszę wprowadzić prawidłową fakturę';
  @override
  String updatingInvoice({required Object details}) =>
      'Błąd aktualizacji faktury: ${details}';
  @override
  String get paymentRetryFailed =>
      'Ponowna próba płatności nie powiodła się. Sprawdź fakturę lub spróbuj ponownie później.';
  @override
  String get takerPublicKeyNotFound =>
      'Nie znaleziono klucza publicznego Kupującego.';
}

// Path: taker.paymentFailed.loading
class _TranslationsTakerPaymentFailedLoadingPl
    extends TranslationsTakerPaymentFailedLoadingEn {
  _TranslationsTakerPaymentFailedLoadingPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get processingPayment => 'Przetwarzanie ponownej płatności...';
}

// Path: taker.paymentFailed.success
class _TranslationsTakerPaymentFailedSuccessPl
    extends TranslationsTakerPaymentFailedSuccessEn {
  _TranslationsTakerPaymentFailedSuccessPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Płatność udana';
  @override
  String get message => 'Twoja płatność została przetworzona pomyślnie.';
}

// Path: taker.paymentSuccess.actions
class _TranslationsTakerPaymentSuccessActionsPl
    extends TranslationsTakerPaymentSuccessActionsEn {
  _TranslationsTakerPaymentSuccessActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get goHome => 'Przejdź do strony głównej';
}

// Path: taker.invalidBlik.actions
class _TranslationsTakerInvalidBlikActionsPl
    extends TranslationsTakerInvalidBlikActionsEn {
  _TranslationsTakerInvalidBlikActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get retry => 'Wyślij nowy kod BLIK';
  @override
  String get cancelReservation => 'Anuluj Transakcję';
  @override
  String get reportConflict => 'Rozpocząć Spór';
  @override
  String get returnHome => 'Wróć do strony głównej';
}

// Path: taker.invalidBlik.feedback
class _TranslationsTakerInvalidBlikFeedbackPl
    extends TranslationsTakerInvalidBlikFeedbackEn {
  _TranslationsTakerInvalidBlikFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get conflictReportedSuccess =>
      'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.';
}

// Path: taker.invalidBlik.errors
class _TranslationsTakerInvalidBlikErrorsPl
    extends TranslationsTakerInvalidBlikErrorsEn {
  _TranslationsTakerInvalidBlikErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get reservationFailed => 'Nie udało się ponownie zarezerwować oferty';
  @override
  String conflictReport({required Object details}) =>
      'Błąd zgłaszania konfliktu: ${details}';
}

// Path: taker.conflict.actions
class _TranslationsTakerConflictActionsPl
    extends TranslationsTakerConflictActionsEn {
  _TranslationsTakerConflictActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get back => 'Powrót do strony głównej';
}

// Path: taker.conflict.feedback
class _TranslationsTakerConflictFeedbackPl
    extends TranslationsTakerConflictFeedbackEn {
  _TranslationsTakerConflictFeedbackPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get reported => 'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.';
}

// Path: taker.conflict.errors
class _TranslationsTakerConflictErrorsPl
    extends TranslationsTakerConflictErrorsEn {
  _TranslationsTakerConflictErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String reporting({required Object details}) =>
      'Błąd zgłaszania konfliktu: ${details}';
}

// Path: home.statistics.errors
class _TranslationsHomeStatisticsErrorsPl
    extends TranslationsHomeStatisticsErrorsEn {
  _TranslationsHomeStatisticsErrorsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String loading({required Object error}) =>
      'Błąd ładowania statystyk: ${error}';
}

// Path: maker.conflict.disputeDialog.actions
class _TranslationsMakerConflictDisputeDialogActionsPl
    extends TranslationsMakerConflictDisputeDialogActionsEn {
  _TranslationsMakerConflictDisputeDialogActionsPl._(TranslationsPl root)
    : this._root = root,
      super.internal(root);

  final TranslationsPl _root; // ignore: unused_field

  // Translations
  @override
  String get confirm => 'Otwórz Spór';
  @override
  String get cancel => 'Anuluj';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPl {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'app.title':
        return 'BitBlik';
      case 'app.greeting':
        return 'Cześć!';
      case 'app.changelog':
        return 'Historia zmian';
      case 'common.buttons.cancel':
        return 'Anuluj';
      case 'common.buttons.save':
        return 'Zapisz';
      case 'common.buttons.done':
        return 'Gotowe';
      case 'common.buttons.retry':
        return 'Spróbuj ponownie';
      case 'common.buttons.goHome':
        return 'Wróć do strony głównej';
      case 'common.buttons.saveAndContinue':
        return 'Zapisz i kontynuuj';
      case 'common.buttons.reveal':
        return 'Pokaż';
      case 'common.buttons.hide':
        return 'Ukryj';
      case 'common.buttons.copy':
        return 'Kopiuj';
      case 'common.buttons.close':
        return 'Zamknij';
      case 'common.buttons.restore':
        return 'Przywróć';
      case 'common.buttons.faq':
        return 'FAQ';
      case 'common.labels.amount':
        return 'Kwota (PLN)';
      case 'common.labels.status':
        return ({required Object status}) => 'Status: ${status}';
      case 'common.labels.role':
        return ({required Object role}) => 'Rola: ${role}';
      case 'common.notifications.success':
        return 'Sukces';
      case 'common.notifications.error':
        return 'Błąd';
      case 'common.notifications.loading':
        return 'Ładowanie...';
      case 'common.clipboard.copyToClipboard':
        return 'Kopiuj do schowka';
      case 'common.clipboard.pasteFromClipboard':
        return 'Wklej ze schowka';
      case 'common.clipboard.copied':
        return 'Skopiowano do schowka!';
      case 'common.actions.cancelAndReturnToOffers':
        return 'Anuluj i wróć do ofert';
      case 'common.actions.cancelAndReturnHome':
        return 'Anuluj i wróć do strony głównej';
      case 'lightningAddress.labels.address':
        return 'Adres Lightning (LNURL)';
      case 'lightningAddress.labels.hint':
        return 'uzytkownik@domena.com';
      case 'lightningAddress.labels.short':
        return ({required Object address}) => 'Adres Lightning: ${address}';
      case 'lightningAddress.labels.receivingAddress':
        return 'Twój adres odbiorczy:';
      case 'lightningAddress.prompts.enter':
        return 'Wprowadź swój adres Lightning, aby kontynuować';
      case 'lightningAddress.prompts.edit':
        return 'Edytuj';
      case 'lightningAddress.prompts.invalid':
        return 'Wprowadź prawidłowy adres Lightning';
      case 'lightningAddress.prompts.required':
        return 'Adres Lightning jest wymagany.';
      case 'lightningAddress.prompts.enterToTakeOffer':
        return 'Musisz ustawić adres Lightning, aby przyjąć ofertę.';
      case 'lightningAddress.prompts.missing':
        return 'Brak adresu Lightning. Dodaj go, aby móc przyjmować oferty.';
      case 'lightningAddress.prompts.add':
        return 'Dodaj';
      case 'lightningAddress.prompts.delete':
        return 'Usuń';
      case 'lightningAddress.prompts.confirmDelete':
        return 'Czy na pewno chcesz usunąć swój adres Lightning?';
      case 'lightningAddress.prompts.howToGet':
        return 'Nie masz jeszcze adresu Lightning? Dowiedz się, jak go zdobyć!';
      case 'lightningAddress.prompts.learnMore':
        return 'Dowiedz się więcej o adresach Lightning';
      case 'lightningAddress.feedback.saved':
        return 'Adres Lightning zapisany!';
      case 'lightningAddress.feedback.updated':
        return 'Adres Lightning zaktualizowany!';
      case 'lightningAddress.feedback.valid':
        return 'Prawidłowy adres Lightning';
      case 'lightningAddress.errors.saving':
        return ({required Object details}) =>
            'Błąd podczas zapisywania adresu: ${details}';
      case 'lightningAddress.errors.loading':
        return ({required Object details}) =>
            'Błąd podczas ładowania adresu Lightning: ${details}';
      case 'offers.details.yourOffer':
        return 'Twoja oferta:';
      case 'offers.details.selectedOffer':
        return 'Oferta:';
      case 'offers.details.activeOffer':
        return 'Masz aktywną ofertę:';
      case 'offers.details.finishedOffers':
        return 'Zakończone oferty';
      case 'offers.details.finishedOffersWithTime':
        return 'Zakończone oferty (ostatnie 24h):';
      case 'offers.details.noAvailable':
        return 'Brak dostępnych ofert.';
      case 'offers.details.noAvailableTip':
        return 'Wskazówka: udostępnij Bitblik w swojej społeczności i wśród znajomych, aby zwiększyć liczbę zamówień w Bitblik.';
      case 'offers.details.noSuccessfulTrades':
        return 'Brak udanych transakcji.';
      case 'offers.details.loadingDetails':
        return 'Ładowanie szczegółów oferty...';
      case 'offers.details.amount':
        return ({required Object amount}) => 'Kwota: ${amount} satoshi';
      case 'offers.details.amountWithCurrency':
        return ({required Object amount, required Object currency}) =>
            '${amount} ${currency}';
      case 'offers.details.makerFee':
        return ({required Object fee}) => 'Opłata: ${fee} sats';
      case 'offers.details.takerFee':
        return ({required Object fee}) => 'Opłata: ${fee} sats';
      case 'offers.details.subtitle':
        return ({
          required Object sats,
          required Object fee,
          required Object status,
        }) => '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}';
      case 'offers.details.subtitleWithDate':
        return ({
          required Object sats,
          required Object fee,
          required Object status,
          required Object date,
        }) =>
            '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}\nZapłacono: ${date}';
      case 'offers.details.activeSubtitle':
        return ({required Object status, required Object amount}) =>
            'Status: ${status}\nKwota: ${amount} satoshi';
      case 'offers.details.id':
        return ({required Object id}) => 'ID Oferty: ${id}...';
      case 'offers.details.created':
        return ({required Object dateTime}) => 'Utworzono: ${dateTime}';
      case 'offers.details.takenAfter':
        return ({required Object duration}) => 'Przyjęto po: ${duration}';
      case 'offers.details.paidAfter':
        return ({required Object duration}) => 'Zapłacono po: ${duration}';
      case 'offers.details.exchangeRate':
        return 'Kurs wymiany';
      case 'offers.details.takerFeeLabel':
        return 'Opłata';
      case 'offers.details.amountLabel':
        return 'Kwota';
      case 'offers.details.feeLabel':
        return 'Opłata';
      case 'offers.details.statusLabel':
        return 'Status';
      case 'offers.details.youllReceive':
        return 'Otrzymasz';
      case 'offers.details.coordinator':
        return 'Koordynator';
      case 'offers.tooltips.takerFeeInfo':
        return ({required Object feePercent}) =>
            'Koordynator pobiera ${feePercent}% opłaty dla kupującego. To obejmuje opłaty za routing Lightning i jest potrącane z kwoty, którą otrzymujesz.';
      case 'offers.actions.take':
        return 'WEŹ';
      case 'offers.actions.takeOffer':
        return 'Weź ofertę';
      case 'offers.actions.resume':
        return 'Wprowadź BLIK';
      case 'offers.actions.cancel':
        return 'Anuluj ofertę';
      case 'offers.actions.view':
        return 'Zobacz';
      case 'offers.status.created':
        return 'Utworzona';
      case 'offers.status.funded':
        return 'Sfinansowana';
      case 'offers.status.expired':
        return 'Wygasła';
      case 'offers.status.cancelled':
        return 'Anulowana';
      case 'offers.status.reserved':
        return 'Zarezerwowana';
      case 'offers.status.blikReceived':
        return 'BLIK wysłany';
      case 'offers.status.blikSentToMaker':
        return 'Otrzymano BLIK';
      case 'offers.status.invalidBlik':
        return 'Nieprawidłowy BLIK';
      case 'offers.status.conflict':
        return 'Konflikt';
      case 'offers.status.dispute':
        return 'Spór';
      case 'offers.status.makerConfirmed':
        return 'Potwierdzona';
      case 'offers.status.settled':
        return 'Rozliczona';
      case 'offers.status.payingTaker':
        return 'Płacenie Takera';
      case 'offers.status.takerPaymentFailed':
        return 'Płatność Takera nieudana';
      case 'offers.status.takerPaid':
        return 'Zapłacony';
      case 'offers.statusMessages.reserved':
        return 'Oferta zarezerwowana przez Takera!';
      case 'offers.statusMessages.cancelled':
        return 'Oferta anulowana pomyślnie.';
      case 'offers.statusMessages.cancelledOrExpired':
        return 'Oferta została anulowana lub wygasła.';
      case 'offers.statusMessages.noLongerAvailable':
        return ({required Object status}) =>
            'Oferta nie jest już dostępna (Status: ${status}).';
      case 'offers.progress.waitingForTaker':
        return ({required Object time}) => 'Oczekiwanie na takera: ${time}';
      case 'offers.progress.reserved':
        return ({required Object seconds}) =>
            'Zarezerwowano: ${seconds} s pozostało';
      case 'offers.progress.confirming':
        return ({required Object seconds}) =>
            'Potwierdzanie: ${seconds} s pozostało';
      case 'offers.errors.loading':
        return ({required Object details}) =>
            'Błąd ładowania ofert: ${details}';
      case 'offers.errors.loadingDetails':
        return ({required Object details}) =>
            'Błąd ładowania szczegółów oferty: ${details}';
      case 'offers.errors.detailsMissing':
        return 'Błąd: Brakujące lub nieprawidłowe szczegóły oferty.';
      case 'offers.errors.detailsNotLoaded':
        return 'Nie udało się załadować szczegółów oferty.';
      case 'offers.errors.notFound':
        return 'Błąd: Oferta nie znaleziona.';
      case 'offers.errors.unexpectedState':
        return 'Błąd: Oferta jest w nieoczekiwanym stanie.';
      case 'offers.errors.unexpectedStateWithStatus':
        return ({required Object status}) =>
            'Oferta jest w nieoczekiwanym stanie (${status}). Spróbuj ponownie lub skontaktuj się z pomocą.';
      case 'offers.errors.invalidStatus':
        return 'Oferta ma nieprawidłowy status.';
      case 'offers.errors.couldNotIdentify':
        return 'Błąd: Nie można zidentyfikować oferty do anulowania.';
      case 'offers.errors.cannotBeCancelled':
        return ({required Object status}) =>
            'Oferty nie można anulować w obecnym stanie (${status}).';
      case 'offers.errors.failedToCancel':
        return ({required Object details}) =>
            'Nie udało się anulować oferty: ${details}';
      case 'offers.errors.activeDetailsLost':
        return 'Błąd: Utracono szczegóły aktywnej oferty.';
      case 'offers.errors.checkingActive':
        return ({required Object details}) =>
            'Błąd sprawdzania aktywnych ofert: ${details}';
      case 'offers.errors.loadingFinished':
        return ({required Object details}) =>
            'Błąd ładowania zakończonych ofert: ${details}';
      case 'offers.errors.cannotResume':
        return ({required Object status}) =>
            'Nie można wznowić oferty w stanie: ${status}';
      case 'offers.errors.cannotResumeTaker':
        return ({required Object status}) =>
            'Nie można wznowić oferty takera w stanie: ${status}';
      case 'offers.errors.resuming':
        return ({required Object details}) =>
            'Błąd wznawiania oferty: ${details}';
      case 'offers.errors.makerPublicKeyNotFound':
        return 'Nie znaleziono klucza publicznego Makera';
      case 'offers.errors.takerPublicKeyNotFound':
        return 'Nie znaleziono klucza publicznego Takera.';
      case 'offers.success.title':
        return 'Oferta zakończona';
      case 'offers.success.headline':
        return 'Płatność potwierdzona!';
      case 'offers.success.subtitle':
        return 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.';
      case 'offers.success.detailsTitle':
        return 'Szczegóły oferty:';
      case 'offers.success.duration':
        return ({required Object time}) => 'Realizacja oferty zajęła ${time}.';
      case 'reservations.actions.cancel':
        return 'Anuluj rezerwację';
      case 'reservations.feedback.cancelled':
        return 'Rezerwacja anulowana.';
      case 'reservations.errors.cancelling':
        return ({required Object error}) =>
            'Nie udało się anulować rezerwacji: ${error}';
      case 'reservations.errors.failedToReserve':
        return ({required Object details}) =>
            'Nie udało się zarezerwować oferty: ${details}';
      case 'reservations.errors.failedNoTimestamp':
        return 'Nie udało się zarezerwować oferty (brak znacznika czasu).';
      case 'reservations.errors.timestampMissing':
        return 'Brak znacznika czasu rezerwacji oferty.';
      case 'reservations.errors.notReserved':
        return ({required Object status}) =>
            'Oferta nie jest już w stanie zarezerwowanym (${status}).';
      case 'exchange.labels.enterAmount':
        return 'Wprowadź kwotę (PLN) do zapłaty:';
      case 'exchange.labels.equivalent':
        return ({required Object sats}) => '≈ ${sats} satoshi';
      case 'exchange.labels.rate':
        return ({required Object rate}) => 'Kurs wymiany ≈ ${rate} PLN/BTC';
      case 'exchange.feedback.fetching':
        return 'Pobieranie kursu wymiany...';
      case 'exchange.errors.fetchingRate':
        return 'Nie udało się pobrać kursu wymiany.';
      case 'exchange.errors.invalidFormat':
        return 'Nieprawidłowy format liczby';
      case 'exchange.errors.mustBePositive':
        return 'Kwota musi być dodatnia';
      case 'exchange.errors.invalidFeePercentage':
        return 'Nieprawidłowy procent opłaty';
      case 'exchange.errors.tooLowFiat':
        return ({required Object minAmount, required Object currency}) =>
            'Kwota jest za niska. Minimum to ${minAmount} ${currency}.';
      case 'exchange.errors.tooHighFiat':
        return ({required Object maxAmount, required Object currency}) =>
            'Kwota jest za wysoka. Maksimum to ${maxAmount} ${currency}.';
      case 'coordinator.title':
        return 'Koordynatorzy';
      case 'coordinator.info.fee':
        return 'opłata';
      case 'coordinator.info.rangeDisplay':
        return ({
          required Object minAmount,
          required Object maxAmount,
          required Object currency,
        }) => 'Kwota: ${minAmount}-${maxAmount} ${currency}';
      case 'coordinator.info.feeDisplay':
        return ({required Object fee}) => '${fee}% opłata';
      case 'coordinator.selector.loading':
        return 'Ładowanie koordynatorów...';
      case 'coordinator.selector.errorLoading':
        return 'Błąd ładowania koordynatorów';
      case 'coordinator.selector.choose':
        return 'Wybierz koordynatora';
      case 'coordinator.selector.viewNostrProfile':
        return 'Zobacz profil Nostr';
      case 'coordinator.selector.unresponsive':
        return 'Ten koordynator nie odpowiada';
      case 'coordinator.selector.waitingResponse':
        return 'Oczekiwanie na odpowiedź koordynatora';
      case 'coordinator.selector.termsAccept':
        return 'Akceptuję ';
      case 'coordinator.selector.termsOfUsage':
        return 'Warunki użytkowania';
      case 'coordinator.dialog.makerFee':
        return 'Opłata twórcy';
      case 'coordinator.dialog.takerFee':
        return 'Opłata odbiorcy';
      case 'coordinator.dialog.amountRange':
        return 'Zakres kwoty';
      case 'coordinator.dialog.reservationTime':
        return 'Czas rezerwacji';
      case 'coordinator.dialog.currencies':
        return 'Waluty';
      case 'coordinator.dialog.viewTerms':
        return 'Zobacz warunki';
      case 'coordinator.management.title':
        return 'Zarządzanie Koordynatorami';
      case 'coordinator.management.availableCoordinators':
        return 'Dostępni Koordynatorzy';
      case 'coordinator.management.noCoordinators':
        return 'Nie odkryto jeszcze żadnych koordynatorów.';
      case 'coordinator.management.online':
        return 'Online';
      case 'coordinator.management.unknownOffline':
        return 'Nieznany/Offline';
      case 'coordinator.management.openNostrProfile':
        return 'Otwórz profil Nostr';
      case 'coordinator.management.enable':
        return 'Włącz';
      case 'coordinator.management.remove':
        return 'Usuń';
      case 'coordinator.management.addCustomWhitelist':
        return 'Dodaj koordynatora';
      case 'coordinator.management.addCustomWhitelistHint':
        return 'npub1...';
      case 'coordinator.management.add':
        return 'Dodaj';
      case 'coordinator.management.coordinatorBlacklisted':
        return 'Koordynator zablokowany';
      case 'coordinator.management.coordinatorUnblacklisted':
        return 'Koordynator odblokowany';
      case 'coordinator.management.coordinatorAdded':
        return 'Koordynator dodany do niestandardowej białej listy';
      case 'coordinator.management.coordinatorRemoved':
        return 'Koordynator usunięty z niestandardowej białej listy';
      case 'coordinator.management.pleaseEnterNpub':
        return 'Proszę wprowadzić npub';
      case 'coordinator.management.error':
        return 'Błąd';
      case 'maker.roleSelection.button':
        return 'ZAPŁAĆ przez Lightning';
      case 'maker.amountForm.progress.step1':
        return '1. Utwórz Ofertę';
      case 'maker.amountForm.progress.step2':
        return '2. Czekaj na zabranie';
      case 'maker.amountForm.progress.step3':
        return '3. Użyj BLIK';
      case 'maker.amountForm.labels.coordinator':
        return 'Koordynator';
      case 'maker.amountForm.labels.exchangeRate':
        return 'Kurs wymiany';
      case 'maker.amountForm.labels.fee':
        return 'Opłata';
      case 'maker.amountForm.labels.satoshisToPay':
        return 'Do zapłaty';
      case 'maker.amountForm.labels.enterAmount':
        return 'Wprowadź kwotę';
      case 'maker.amountForm.labels.tapToSelect':
        return 'Kliknij, aby wybrać';
      case 'maker.amountForm.actions.generateInvoice':
        return 'Wygeneruj Fakturę';
      case 'maker.amountForm.tooltips.feeInfo':
        return ({required Object feePercent}) =>
            'Koordynator pobiera od twórcy opłatę w wysokości ${feePercent}%. Ta opłata jest odejmowana od Twojej płatności Lightning.';
      case 'maker.amountForm.tooltips.payInfo':
        return 'Ta kalkulacja jest oparta na kursach wymiany pobranych po stronie klienta. Koordynator obliczy dokładną kwotę, a kwota faktury będzie ostateczną i dokładną kwotą do zapłaty.';
      case 'maker.amountForm.errors.initiating':
        return ({required Object details}) =>
            'Błąd inicjowania oferty: ${details}';
      case 'maker.amountForm.errors.publicKeyNotLoaded':
        return 'Błąd: Klucz publiczny nie został jeszcze załadowany.';
      case 'maker.payInvoice.title':
        return 'Zapłać tę fakturę Hold:';
      case 'maker.payInvoice.actions.copy':
        return 'Kopiuj Fakturę';
      case 'maker.payInvoice.actions.payInWallet':
        return 'Otwórz w portfelu zewnętrznym';
      case 'maker.payInvoice.actions.connectWallet':
        return 'Połącz portfel';
      case 'maker.payInvoice.actions.payWithNwc':
        return 'Zapłać';
      case 'maker.payInvoice.actions.paying':
        return 'Płacenie...';
      case 'maker.payInvoice.feedback.copied':
        return 'Faktura skopiowana do schowka!';
      case 'maker.payInvoice.feedback.waitingConfirmation':
        return 'Oczekiwanie na potwierdzenie płatności...';
      case 'maker.payInvoice.feedback.nwcConnected':
        return 'Portfel NWC połączony!';
      case 'maker.payInvoice.feedback.nwcPaymentSuccess':
        return 'Płatność udana!';
      case 'maker.payInvoice.errors.couldNotOpenApp':
        return 'Nie można otworzyć aplikacji Lightning dla faktury.';
      case 'maker.payInvoice.errors.openingApp':
        return ({required Object details}) =>
            'Błąd otwierania aplikacji Lightning: ${details}';
      case 'maker.payInvoice.errors.publicKeyNotAvailable':
        return 'Klucz publiczny nie jest dostępny.';
      case 'maker.payInvoice.errors.couldNotFetchActive':
        return 'Nie udało się pobrać szczegółów aktywnej oferty. Mogła wygasnąć.';
      case 'maker.payInvoice.errors.nwcPaymentFailed':
        return ({required Object details}) =>
            'Płatność nie powiodła się: ${details}';
      case 'maker.payInvoice.errors.nwcNotConnected':
        return 'Portfel NWC nie jest połączony';
      case 'maker.payInvoice.errors.insufficientBalance':
        return ({required Object required, required Object available}) =>
            'Niewystarczające środki. Potrzeba ${required} sats, dostępne ${available} sats';
      case 'maker.waitTaker.message':
        return 'Oczekiwanie na rezerwację przez Kupującego...';
      case 'maker.waitTaker.errorActiveOfferDetailsLost':
        return 'Błąd: Utracono szczegóły aktywnej oferty.';
      case 'maker.waitTaker.errorFailedToRetrieveBlik':
        return 'Błąd: Nie udało się pobrać kodu BLIK.';
      case 'maker.waitTaker.errorRetrievingBlik':
        return ({required Object details}) =>
            'Błąd pobierania kodu BLIK: ${details}';
      case 'maker.waitTaker.offerNoLongerAvailable':
        return ({required Object status}) =>
            'Oferta nie jest już dostępna (Status: ${status}).';
      case 'maker.waitTaker.errorCouldNotIdentifyOffer':
        return 'Błąd: Nie można zidentyfikować oferty do anulowania.';
      case 'maker.waitTaker.offerCannotBeCancelled':
        return ({required Object status}) =>
            'Oferty nie można anulować w obecnym stanie (${status}).';
      case 'maker.waitTaker.offerCancelledSuccessfully':
        return 'Oferta anulowana pomyślnie.';
      case 'maker.waitTaker.failedToCancelOffer':
        return ({required Object details}) =>
            'Nie udało się anulować oferty: ${details}';
      case 'maker.waitForBlik.title':
        return 'Oczekiwanie na BLIK';
      case 'maker.waitForBlik.messageInfo':
        return 'Ktoś zarezerwował twoją ofertę!';
      case 'maker.waitForBlik.messageWaiting':
        return 'Oczekiwanie na kod BLIK...';
      case 'maker.waitForBlik.progressLabel':
        return ({required Object seconds}) =>
            'Zarezerwowano: ${seconds} s pozostało';
      case 'maker.confirmPayment.title':
        return 'Otrzymano kod BLIK!';
      case 'maker.confirmPayment.retrieving':
        return 'Pobieranie kodu BLIK...';
      case 'maker.confirmPayment.instruction1':
        return 'Wprowadź kod do systemu płatności BLIK.';
      case 'maker.confirmPayment.instruction2':
        return 'Poczekaj, aż Kupujący potwierdzi płatność w swojej aplikacji banku.';
      case 'maker.confirmPayment.instruction3':
        return 'Gdy płatność zakończy się sukcesem, naciśnij Potwierdź poniżej:';
      case 'maker.confirmPayment.takerChargedWarning':
        return 'Pobierający zgłosił, że płatność BLIK została pobrana z jego konta bankowego. Oznaczenie tego jako nieprawidłowe spowoduje konflikt.';
      case 'maker.confirmPayment.expiredTitle':
        return 'Kod BLIK wygasł';
      case 'maker.confirmPayment.expiredWarning':
        return 'Kod BLIK wygasł. Musisz ręcznie potwierdzić status płatności:';
      case 'maker.confirmPayment.expiredInstruction1':
        return 'Jeśli płatność BLIK zakończyła się sukcesem i zrealizowałeś zakup, kliknij "Potwierdź udaną płatność" poniżej.';
      case 'maker.confirmPayment.expiredInstruction2':
        return 'Jeśli płatność BLIK nie powiodła się lub nie została zrealizowana, kliknij "Nieprawidłowy kod BLIK" poniżej.';
      case 'maker.confirmPayment.actions.confirm':
        return 'Potwierdź udaną płatność';
      case 'maker.confirmPayment.actions.markInvalid':
        return 'Nieprawidłowy kod BLIK';
      case 'maker.confirmPayment.actions.copyBlik':
        return 'Kopiuj BLIK';
      case 'maker.confirmPayment.confirmDialog.title':
        return 'Potwierdzić płatność?';
      case 'maker.confirmPayment.confirmDialog.content':
        return 'Ta akcja jest nieodwracalna. Po potwierdzeniu:\n\n• Kupujący otrzyma środki natychmiast\n• Koordynator nie będzie mógł zakwestionować środków\n• Nie możesz cofnąć tej akcji\n\nPotwierdź tylko wtedy, gdy płatność BLIK zakończyła się sukcesem.';
      case 'maker.confirmPayment.confirmDialog.cancel':
        return 'Anuluj';
      case 'maker.confirmPayment.confirmDialog.confirmButton':
        return 'Tak, potwierdź płatność';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.title':
        return 'Otworzyć spór?';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.content':
        return 'Kupujący zgłosił, że płatność BLIK została pobrana z jego konta.\n\nOznaczenie tego jako nieprawidłowe natychmiast otworzy SPÓR wymagający interwencji koordynatora.\n\n• Opłata za spór może zostać naliczona, jeśli zostanie rozstrzygnięty na Twoją niekorzyść\n• Faktura hold zostanie rozliczona natychmiast\n• Wymagana będzie ręczna weryfikacja\n\nKontynuuj tylko wtedy, gdy masz pewność, że płatność BLIK NIE powiodła się.';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.cancel':
        return 'Anuluj';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton':
        return 'Tak, otwórz spór';
      case 'maker.confirmPayment.feedback.confirmed':
        return 'Maker potwierdził płatność.';
      case 'maker.confirmPayment.feedback.confirmedTakerPaid':
        return 'Płatność potwierdzona! Taker otrzyma środki.';
      case 'maker.confirmPayment.feedback.progressLabel':
        return ({required Object seconds}) =>
            'Potwierdzanie: ${seconds} s pozostało';
      case 'maker.confirmPayment.errors.failedToRetrieve':
        return 'Błąd: Nie udało się pobrać kodu BLIK.';
      case 'maker.confirmPayment.errors.retrieving':
        return ({required Object details}) =>
            'Błąd pobierania kodu BLIK: ${details}';
      case 'maker.confirmPayment.errors.missingHashOrKey':
        return 'Błąd: Brakujący hash płatności lub klucz publiczny.';
      case 'maker.confirmPayment.errors.incorrectState':
        return ({required Object status}) =>
            'Oferta nie jest w prawidłowym stanie do potwierdzenia (Status: ${status})';
      case 'maker.confirmPayment.errors.confirming':
        return ({required Object details}) =>
            'Błąd potwierdzania płatności: ${details}';
      case 'maker.confirmPayment.errors.invalidState':
        return 'Błąd: Otrzymano nieprawidłowy stan oferty.';
      case 'maker.confirmPayment.errors.internalIncomplete':
        return 'Błąd wewnętrzny: Niekompletne szczegóły oferty.';
      case 'maker.confirmPayment.errors.notAwaitingConfirmation':
        return ({required Object status}) =>
            'Oferta nie oczekuje już na potwierdzenie (Status: ${status}).';
      case 'maker.confirmPayment.errors.unexpectedStatus':
        return 'Otrzymano nieoczekiwany status oferty z serwera.';
      case 'maker.invalidBlik.title':
        return 'Nieprawidłowy kod BLIK';
      case 'maker.invalidBlik.info':
        return 'Oznaczyłeś kod BLIK jako nieprawidłowy. Oczekiwanie na podanie nowego kodu przez takera lub rozpoczęcie sporu.';
      case 'maker.conflict.title':
        return 'Konflikt Oferty';
      case 'maker.conflict.headline':
        return 'Zgłoszono Konflikt Oferty';
      case 'maker.conflict.body':
        return 'Oznaczyłeś kod BLIK jako nieprawidłowy, ale Taker zgłosił konflikt, wskazując, że uważa, iż płatność zakończyła się sukcesem.';
      case 'maker.conflict.instructions':
        return 'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.';
      case 'maker.conflict.actions.back':
        return 'Powrót do strony głównej';
      case 'maker.conflict.actions.confirmPayment':
        return 'Mój błąd, potwierdź sukces płatności BLIK';
      case 'maker.conflict.actions.openDispute':
        return 'Płatność BLIK NIE powiodła się, OTWÓRZ SPÓR';
      case 'maker.conflict.actions.submitDispute':
        return 'Zgłoś Spór';
      case 'maker.conflict.disputeDialog.title':
        return 'Otworzyć spór?';
      case 'maker.conflict.disputeDialog.content':
        return 'Otwarcie sporu wymaga ręcznej weryfikacji przez koordynatora, co zajmie czas. Opłata za spór zostanie potrącona, jeśli spór zostanie rozstrzygnięty na Twoją niekorzyść. Faktura hold zostanie rozliczona, aby zapobiec jej wygaśnięciu. Jeśli spór zostanie rozstrzygnięty na Twoją korzyść, otrzymasz zwrot środków (pomniejszony o opłaty) na Twój adres Lightning.';
      case 'maker.conflict.disputeDialog.contentDetailed':
        return 'Otwarcie sporu będzie wymagało ręcznej interwencji koordynatora, co zajmuje czas i wiąże się z opłatą za spór.\n\nFaktura hold zostanie natychmiast rozliczona, aby zapobiec jej wygaśnięciu przed rozstrzygnięciem sporu.\n\nJeśli spór zostanie rozstrzygnięty na Twoją korzyść, kwota satoshi zostanie zwrócona na Twój adres Lightning (pomniejszona o opłaty). Upewnij się, że masz skonfigurowany adres Lightning.';
      case 'maker.conflict.disputeDialog.actions.confirm':
        return 'Otwórz Spór';
      case 'maker.conflict.disputeDialog.actions.cancel':
        return 'Anuluj';
      case 'maker.conflict.feedback.disputeOpenedSuccess':
        return 'Spór pomyślnie otwarty. Koordynator rozpatrzy sprawę.';
      case 'maker.conflict.errors.openingDispute':
        return ({required Object error}) => 'Błąd otwierania sporu: ${error}';
      case 'maker.success.title':
        return 'Oferta zakończona';
      case 'maker.success.headline':
        return 'Płatność potwierdzona!';
      case 'maker.success.subtitle':
        return 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.';
      case 'maker.success.detailsTitle':
        return 'Szczegóły oferty:';
      case 'maker.success.duration':
        return ({required Object time}) => 'Oferta zajęła ${time}!';
      case 'taker.roleSelection.button':
        return 'SPRZEDAJ kod BLIK za satoshi';
      case 'taker.progress.step1':
        return 'Wyślij BLIK';
      case 'taker.progress.step2':
        return 'Potwierdź BLIK';
      case 'taker.progress.step3':
        return 'Otrzymaj płatność';
      case 'taker.submitBlik.title':
        return 'Wpisz 6-cyfr BLIK';
      case 'taker.submitBlik.label':
        return 'Kod BLIK';
      case 'taker.submitBlik.instruction':
        return 'Wprowadź BLIK zanim upłynie czas...';
      case 'taker.submitBlik.timeLimit':
        return ({required Object seconds}) =>
            'Wprowadź BLIK w ciągu: ${seconds} s';
      case 'taker.submitBlik.timeExpired':
        return 'Czas na wprowadzenie kodu BLIK minął.';
      case 'taker.submitBlik.actions.submit':
        return 'Wyślij BLIK';
      case 'taker.submitBlik.feedback.pasted':
        return 'Wklejono kod BLIK.';
      case 'taker.submitBlik.validation.invalidFormat':
        return 'Wprowadź prawidłowy 6-cyfrowy kod BLIK.';
      case 'taker.submitBlik.errors.submitting':
        return ({required Object details}) =>
            'Błąd wysyłania kodu BLIK: ${details}';
      case 'taker.submitBlik.errors.clipboardInvalid':
        return 'Schowek nie zawiera prawidłowego 6-cyfrowego kodu BLIK.';
      case 'taker.submitBlik.errors.stateChanged':
        return 'Błąd: Stan oferty uległ zmianie.';
      case 'taker.submitBlik.errors.stateNotValid':
        return 'Błąd: Stan oferty nie jest już ważny.';
      case 'taker.submitBlik.errors.fetchedIdMismatch':
        return ({required Object fetchedId, required Object initialId}) =>
            'Pobrane ID aktywnej oferty (${fetchedId}) nie pasuje do początkowego ID oferty (${initialId}). Niezgodność stanu?';
      case 'taker.submitBlik.errors.paymentHashMissing':
        return 'Brak hasha płatności oferty po pobraniu.';
      case 'taker.submitBlik.details.requestedAmount':
        return 'Żądana kwota BLIK';
      case 'taker.submitBlik.details.exchangeRate':
        return 'Kurs wymiany';
      case 'taker.submitBlik.details.takerFee':
        return 'Opłata Taker';
      case 'taker.submitBlik.details.status':
        return 'Status';
      case 'taker.submitBlik.details.youllReceive':
        return 'Otrzymasz';
      case 'taker.waitConfirmation.title':
        return 'Oczekiwanie na Makera';
      case 'taker.waitConfirmation.statusLabel':
        return ({required Object status}) => 'Status oferty: ${status}';
      case 'taker.waitConfirmation.waitingMaker':
        return ({required Object seconds}) =>
            'Oczekiwanie na potwierdzenie Makera: ${seconds} s';
      case 'taker.waitConfirmation.waitingMakerConfirmation':
        return ({required Object seconds}) =>
            'Oczekiwanie na potwierdzenie płatności BLIK przez Makera w jego aplikacji bankowej. Pozostały czas: ${seconds}s';
      case 'taker.waitConfirmation.importantNotice':
        return ({required Object amount, required Object currency}) =>
            'BARDZO WAŻNE: Upewnij się, że akceptujesz potwierdzenie BLIK tylko na kwotę ${amount} ${currency}';
      case 'taker.waitConfirmation.importantBlikAmountConfirmation':
        return ({required Object amount, required Object currency}) =>
            'BARDZO WAŻNE: W swojej aplikacji bankowej upewnij się, że potwierdzasz płatność BLIK na kwotę dokładnie ${amount} ${currency}.';
      case 'taker.waitConfirmation.instructions':
        return 'Osoba wystawiająca ofertę musi teraz wpisać kod BLIK w ciągu 2 minut. Następnie musisz zaakceptować kod BLIK w swojej aplikacji bankowej.';
      case 'taker.waitConfirmation.waitingForMakerToReceive':
        return 'Czekamy, aż twórca oferty otrzyma Twój kod BLIK...';
      case 'taker.waitConfirmation.makerReceivedBlik':
        return 'Twórca oferty otrzymał Twój kod BLIK';
      case 'taker.waitConfirmation.timerExpiredMessage':
        return 'Minął termin ważności kodu BLIK 2m. Czekamy na potwierdzenie lub oznaczenie kodu jako nieważnego przez wystawcę oferty.';
      case 'taker.waitConfirmation.timerExpiredActions':
        return 'Minął termin ważności kodu BLIK 2m, ale wystawca nie otrzymał kodu BLIK. Możesz wysłać nowy kod BLIK lub anulować.';
      case 'taker.waitConfirmation.resendBlikButton':
        return 'Wyślij nowy kod BLIK';
      case 'taker.waitConfirmation.navigatedHome':
        return 'Przeniesiono na stronę główną.';
      case 'taker.waitConfirmation.expiredTitle':
        return 'Kod BLIK wygasł';
      case 'taker.waitConfirmation.expiredWarning':
        return 'Twórca oferty nie otrzymał kodu BLIK, więc nie mógł go użyć.';
      case 'taker.waitConfirmation.expiredSentWarning':
        return 'Twórca oferty jeszcze nie potwierdził płatności. Co chcesz zrobić?';
      case 'taker.waitConfirmation.expiredInstruction1':
        return 'Jeśli chcesz spróbować ponownie z nowym kodem BLIK, odnów rezerwację.';
      case 'taker.waitConfirmation.expiredInstruction2':
        return 'Jeśli nie chcesz już dokończyć tej transakcji, anuluj rezerwację.';
      case 'taker.waitConfirmation.expiredInstruction3':
        return 'Jeśli płatność BLIK została pobrana z Twojego konta bankowego, nie martw się, bitcoin jest nadal bezpiecznie zablokowany u koordynatora.';
      case 'taker.waitConfirmation.takerCharged.title':
        return 'Oznaczyłeś BLIK jako opłacony';
      case 'taker.waitConfirmation.takerCharged.message':
        return 'Twórca oferty musi potwierdzić płatność lub ją zakwestionować. Jeśli nic nie zrobi, płatność zostanie automatycznie potwierdzona, a Ty otrzymasz bitcoiny.';
      case 'taker.waitConfirmation.expiredActions.reportConflict':
        return 'BLIK został pobrany z mojego konta';
      case 'taker.waitConfirmation.expiredActions.renewReservation':
        return 'Spróbuj ponownie z nowym kodem BLIK';
      case 'taker.waitConfirmation.expiredActions.cancelReservation':
        return 'Anuluj rezerwację';
      case 'taker.waitConfirmation.feedback.makerConfirmed':
        return 'Maker potwierdził płatność.';
      case 'taker.waitConfirmation.feedback.paymentSuccessful':
        return 'Płatność udana! Wkrótce otrzymasz środki.';
      case 'taker.waitConfirmation.feedback.conflictReported':
        return 'Konflikt zgłoszony. Koordynator rozpatrzy sytuację.';
      case 'taker.waitConfirmation.errors.invalidOfferStateReceived':
        return 'Otrzymano ofertę o nieprawidłowym stanie dla tego ekranu. Resetowanie.';
      case 'taker.waitConfirmation.errors.reportingConflict':
        return ({required Object details}) =>
            'Błąd zgłaszania konfliktu: ${details}';
      case 'taker.paymentProcess.title':
        return 'Proces Płatności';
      case 'taker.paymentProcess.waitingForOfferUpdate':
        return 'Oczekiwanie na aktualizację statusu oferty...';
      case 'taker.paymentProcess.states.preparing':
        return 'Przygotowywanie do wysłania płatności...';
      case 'taker.paymentProcess.states.sending':
        return 'Wysyłanie płatności...';
      case 'taker.paymentProcess.states.received':
        return 'Płatność otrzymana!';
      case 'taker.paymentProcess.states.failed':
        return 'Płatność nie powiodła się';
      case 'taker.paymentProcess.states.waitingUpdate':
        return 'Oczekiwanie na aktualizację oferty...';
      case 'taker.paymentProcess.steps.makerConfirmedBlik':
        return 'Maker potwierdził płatność BLIK';
      case 'taker.paymentProcess.steps.makerInvoiceSettled':
        return 'Faktura hold Makera rozliczona';
      case 'taker.paymentProcess.steps.payingTakerInvoice':
        return 'Opłacanie Twojej faktury Lightning';
      case 'taker.paymentProcess.steps.takerInvoicePaid':
        return 'Twoja faktura Lightning opłacona';
      case 'taker.paymentProcess.steps.takerPaymentFailed':
        return 'Płatność na Twoją fakturę nie powiodła się';
      case 'taker.paymentProcess.errors.sending':
        return ({required Object details}) =>
            'Błąd wysyłania płatności: ${details}';
      case 'taker.paymentProcess.errors.notConfirmed':
        return 'Oferta niepotwierdzona przez Makera.';
      case 'taker.paymentProcess.errors.expired':
        return 'Oferta wygasła.';
      case 'taker.paymentProcess.errors.cancelled':
        return 'Oferta anulowana.';
      case 'taker.paymentProcess.errors.paymentFailed':
        return 'Płatność oferty nie powiodła się.';
      case 'taker.paymentProcess.errors.unknown':
        return 'Nieznany błąd oferty.';
      case 'taker.paymentProcess.errors.takerPaymentFailed':
        return 'Płatność na Twoją fakturę Lightning nie powiodła się.';
      case 'taker.paymentProcess.errors.noPublicKey':
        return 'Błąd: Nie można pobrać Twojego klucza publicznego.';
      case 'taker.paymentProcess.errors.loadingPublicKey':
        return 'Błąd ładowania Twoich danych';
      case 'taker.paymentProcess.errors.missingPaymentHash':
        return 'Błąd: Brakujące szczegóły płatności.';
      case 'taker.paymentProcess.loading.publicKey':
        return 'Ładowanie Twoich danych...';
      case 'taker.paymentProcess.actions.goToFailureDetails':
        return 'Wprowadź nową fakturę Lightning';
      case 'taker.paymentFailed.title':
        return 'Płatność Nie Powiodła Się';
      case 'taker.paymentFailed.instructions':
        return ({required Object netAmount}) =>
            'Proszę podać nową fakturę Lightning na kwotę ${netAmount} satoshi';
      case 'taker.paymentFailed.form.newInvoiceLabel':
        return 'Nowa faktura Lightning';
      case 'taker.paymentFailed.form.newInvoiceHint':
        return 'Wprowadź swoją fakturę BOLT11';
      case 'taker.paymentFailed.actions.retryPayment':
        return 'Wyślij nową fakturę';
      case 'taker.paymentFailed.errors.enterValidInvoice':
        return 'Proszę wprowadzić prawidłową fakturę';
      case 'taker.paymentFailed.errors.updatingInvoice':
        return ({required Object details}) =>
            'Błąd aktualizacji faktury: ${details}';
      case 'taker.paymentFailed.errors.paymentRetryFailed':
        return 'Ponowna próba płatności nie powiodła się. Sprawdź fakturę lub spróbuj ponownie później.';
      case 'taker.paymentFailed.errors.takerPublicKeyNotFound':
        return 'Nie znaleziono klucza publicznego Kupującego.';
      case 'taker.paymentFailed.loading.processingPayment':
        return 'Przetwarzanie ponownej płatności...';
      case 'taker.paymentFailed.success.title':
        return 'Płatność udana';
      case 'taker.paymentFailed.success.message':
        return 'Twoja płatność została przetworzona pomyślnie.';
      case 'taker.paymentSuccess.title':
        return 'Płatność Udana';
      case 'taker.paymentSuccess.message':
        return 'Twoja płatność została przetworzona pomyślnie.';
      case 'taker.paymentSuccess.actions.goHome':
        return 'Przejdź do strony głównej';
      case 'taker.invalidBlik.title':
        return 'Nieprawidłowy Kod BLIK';
      case 'taker.invalidBlik.message':
        return 'Maker Odrzucił Kod BLIK';
      case 'taker.invalidBlik.explanation':
        return 'Maker oferty wskazał, że podany przez Ciebie kod BLIK był nieprawidłowy lub nie zadziałał.\n\nCo chcesz zrobić?';
      case 'taker.invalidBlik.werentCharged':
        return 'Jeśli Twoje konto NIE zostało obciążone:';
      case 'taker.invalidBlik.wereCharged':
        return 'Jeśli Twoje konto zostało obciążone:';
      case 'taker.invalidBlik.actions.retry':
        return 'Wyślij nowy kod BLIK';
      case 'taker.invalidBlik.actions.cancelReservation':
        return 'Anuluj Transakcję';
      case 'taker.invalidBlik.actions.reportConflict':
        return 'Rozpocząć Spór';
      case 'taker.invalidBlik.actions.returnHome':
        return 'Wróć do strony głównej';
      case 'taker.invalidBlik.feedback.conflictReportedSuccess':
        return 'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.';
      case 'taker.invalidBlik.errors.reservationFailed':
        return 'Nie udało się ponownie zarezerwować oferty';
      case 'taker.invalidBlik.errors.conflictReport':
        return ({required Object details}) =>
            'Błąd zgłaszania konfliktu: ${details}';
      case 'taker.conflict.title':
        return 'Konflikt Oferty';
      case 'taker.conflict.headline':
        return 'Zgłoszono Konflikt Oferty';
      case 'taker.conflict.body':
        return 'Maker oznaczył kod BLIK jako nieprawidłowy, ale Ty zgłosiłeś konflikt, wskazując, że uważasz, iż płatność zakończyła się sukcesem.';
      case 'taker.conflict.instructions':
        return 'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.';
      case 'taker.conflict.actions.back':
        return 'Powrót do strony głównej';
      case 'taker.conflict.feedback.reported':
        return 'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.';
      case 'taker.conflict.errors.reporting':
        return ({required Object details}) =>
            'Błąd zgłaszania konfliktu: ${details}';
      case 'blik.instructions.taker':
        return 'Gdy Maker wprowadzi kod BLIK, będziesz musiał potwierdzić płatność w swojej aplikacji bankowej. Upewnij się, że kwota jest poprawna przed potwierdzeniem.';
      case 'nekoInfo.title':
        return 'Czym jest Neko?';
      case 'nekoInfo.description':
        return 'Twoje Neko to Twoja tożsamość do korzystania z BitBlik. Składa się z klucza prywatnego i publicznego, aby zapewnić kryptograficznie bezpieczną komunikację z koordynatorem.\n\nAby zapewnić większą anonimowość, zaleca się używanie nowego, świeżego Neko dla każdej oferty.\n\n⚠️ WAŻNE: Twój klucz prywatny jest przechowywany tylko na Twoim urządzeniu (po stronie klienta). Niezwykle ważne jest zarchiwizowanie klucza prywatnego, ponieważ utrata dostępu do niego może uniemożliwić rozstrzygnięcie sporów i odzyskanie środków.';
      case 'nekoInfo.backupWarning':
        return 'Pamiętaj, aby zarchiwizować swoje Neko';
      case 'generateNewKey.title':
        return 'Nowy';
      case 'generateNewKey.description':
        return 'Czy na pewno chcesz wygenerować nowe Neko? Twoje obecne zostanie utracone na zawsze, jeśli go nie zarchiwizowałeś.';
      case 'generateNewKey.buttons.generate':
        return 'Generuj';
      case 'generateNewKey.errors.activeOffer':
        return 'Nie możesz wygenerować nowego Neko, gdy masz aktywną ofertę.';
      case 'generateNewKey.errors.failed':
        return 'Nie udało się wygenerować nowego Neko';
      case 'generateNewKey.feedback.success':
        return 'Nowe Neko wygenerowane pomyślnie!';
      case 'generateNewKey.tooltips.generate':
        return 'Wygeneruj nowe Neko';
      case 'backup.title':
        return 'Zarchiwizuj';
      case 'backup.description':
        return 'To jest Twój klucz prywatny. Zabezpiecza on komunikację z koordynatorem. Nigdy nikomu go nie ujawniaj. Zarchiwizuj go w bezpiecznym miejscu, aby uniknąć problemów podczas sporów.';
      case 'backup.feedback.copied':
        return 'Klucz prywatny skopiowany do schowka!';
      case 'backup.tooltips.backup':
        return 'Zarchiwizuj Neko';
      case 'restore.title':
        return 'Przywróć';
      case 'restore.labels.privateKey':
        return 'Klucz prywatny';
      case 'restore.buttons.restore':
        return 'Przywróć';
      case 'restore.errors.invalidKey':
        return 'Musi to być 64-znakowy ciąg szesnastkowy.';
      case 'restore.errors.failed':
        return 'Przywracanie nie powiodło się';
      case 'restore.feedback.success':
        return 'Neko przywrócone pomyślnie! Aplikacja zostanie ponownie uruchomiona.';
      case 'restore.tooltips.restore':
        return 'Przywróć Neko';
      case 'home.notifications.title':
        return 'Otrzymuj powiadomienia o nowych ofertach przez:';
      case 'home.notifications.telegram':
        return 'Telegram';
      case 'home.notifications.simplex':
        return 'SimpleX';
      case 'home.notifications.element':
        return 'Element';
      case 'home.notifications.signal':
        return 'Signal';
      case 'home.statistics.title':
        return 'Zakończone oferty';
      case 'home.statistics.lifetimeCompact':
        return ({
          required Object count,
          required Object avgBlikTime,
          required Object avgPaidTime,
        }) =>
            'Wszystkie: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}';
      case 'home.statistics.last7DaysCompact':
        return ({
          required Object count,
          required Object avgBlikTime,
          required Object avgPaidTime,
        }) =>
            'Ost. 7 dni: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}';
      case 'home.statistics.last7DaysSingleLine':
        return ({
          required Object count,
          required Object avgBlikTime,
          required Object avgPaidTime,
        }) =>
            'Ost. 7 dni: ${count} ofert  |  Śr. BLIK: ${avgBlikTime}  |  Śr. płatność: ${avgPaidTime}';
      case 'home.statistics.errors.loading':
        return ({required Object error}) =>
            'Błąd ładowania statystyk: ${error}';
      case 'system.loadingPublicKey':
        return 'Ładowanie Twojego klucza publicznego...';
      case 'system.errors.generic':
        return 'Wystąpił nieoczekiwany błąd. Proszę spróbować ponownie.';
      case 'system.errors.loadingTimeoutConfig':
        return 'Błąd ładowania konfiguracji limitu czasu.';
      case 'system.errors.loadingCoordinatorConfig':
        return 'Błąd ładowania konfiguracji koordynatora. Proszę spróbować ponownie.';
      case 'system.errors.noPublicKey':
        return 'Twój klucz publiczny nie jest dostępny. Nie można kontynuować.';
      case 'system.errors.internalOfferIncomplete':
        return 'Błąd wewnętrzny: Szczegóły oferty są niekompletne. Spróbuj ponownie.';
      case 'system.errors.loadingPublicKey':
        return 'Błąd ładowania Twojego klucza publicznego. Uruchom ponownie aplikację.';
      case 'system.blik.copied':
        return 'Kod BLIK skopiowany do schowka';
      case 'landing.mainTitle':
        return 'Wymiana\n BLIK ⇄ bitcoin';
      case 'landing.subtitle':
        return 'Płać lub sprzedawaj kod BLIK za bitcoin';
      case 'landing.actions.payBlik':
        return 'Zapłać BLIK';
      case 'landing.actions.payBlikSubtitle':
        return 'używając bitcoin';
      case 'landing.actions.sellBlik':
        return 'Kup bitcoin';
      case 'landing.actions.sellBlikSubtitle':
        return 'używając BLIK';
      case 'landing.actions.howItWorks':
        return 'Jak to działa?';
      case 'faq.screenTitle':
        return 'FAQ';
      case 'faq.tooltip':
        return 'FAQ';
      case 'settings.title':
        return 'Ustawienia';
      case 'wallet.title':
        return 'Portfel';
      case 'wallet.description':
        return 'Zarządzaj ustawieniami portfela Lightning';
      case 'wallet.missingReceiving.title':
        return 'Wymagany portfel odbiorczy';
      case 'wallet.missingReceiving.message':
        return 'Brak skonfigurowanego portfela do odbierania. Dodaj go w ustawieniach portfela, aby przyjmować oferty.';
      case 'wallet.missingReceiving.openSettings':
        return 'Ustawienia portfela';
      case 'nwc.title':
        return 'Nostr Wallet Connect (NWC)';
      case 'nwc.description':
        return 'Połącz swój portfel Lightning przez NWC';
      case 'nwc.labels.connectionString':
        return 'Ciąg połączenia NWC';
      case 'nwc.labels.hint':
        return 'nostr+walletconnect://...';
      case 'nwc.labels.status':
        return 'Status połączenia';
      case 'nwc.labels.connected':
        return 'Połączono';
      case 'nwc.labels.disconnected':
        return 'Rozłączono';
      case 'nwc.labels.scanQrCode':
        return 'Zeskanuj kod QR z połączeniem NWC';
      case 'nwc.labels.balance':
        return 'Saldo';
      case 'nwc.labels.budget':
        return 'Budżet';
      case 'nwc.labels.usedBudget':
        return 'Wykorzystano';
      case 'nwc.labels.totalBudget':
        return 'Łącznie';
      case 'nwc.labels.renewsIn':
        return 'Odnowienie za';
      case 'nwc.labels.renewalPeriod':
        return 'Okres odnowienia';
      case 'nwc.labels.relay':
        return 'Przekaźnik';
      case 'nwc.labels.relays':
        return 'Przekaźniki';
      case 'nwc.prompts.enter':
        return 'Wprowadź swój ciąg połączenia NWC';
      case 'nwc.prompts.connect':
        return 'Połącz portfel';
      case 'nwc.prompts.disconnect':
        return 'Rozłącz';
      case 'nwc.prompts.confirmDisconnect':
        return 'Czy na pewno chcesz rozłączyć portfel NWC?';
      case 'nwc.prompts.pasteConnection':
        return 'Wklej ciąg połączenia';
      case 'nwc.prompts.chooseMethod':
        return 'Wybierz sposób połączenia portfela Lightning';
      case 'nwc.prompts.howToGet':
        return 'Nie masz jeszcze połączenia NWC? Dowiedz się, jak je uzyskać!';
      case 'nwc.prompts.learnMore':
        return 'Dowiedz się więcej o NWC';
      case 'nwc.actions.connectAlbyGo':
        return 'Połącz z Alby Go';
      case 'nwc.actions.connectNwc':
        return 'Skanuj kod QR NWC';
      case 'nwc.feedback.connected':
        return 'Portfel NWC połączony pomyślnie!';
      case 'nwc.feedback.disconnected':
        return 'Portfel NWC rozłączony';
      case 'nwc.feedback.connecting':
        return 'Łączenie z portfelem NWC...';
      case 'nwc.feedback.loadingWalletInfo':
        return 'Ładowanie informacji o portfelu...';
      case 'nwc.errors.connecting':
        return ({required Object details}) =>
            'Błąd połączenia z NWC: ${details}';
      case 'nwc.errors.disconnecting':
        return ({required Object details}) =>
            'Błąd rozłączania NWC: ${details}';
      case 'nwc.errors.invalid':
        return 'Nieprawidłowy ciąg połączenia NWC';
      case 'nwc.errors.required':
        return 'Wymagany ciąg połączenia NWC';
      case 'nwc.errors.loadingBalance':
        return 'Nie udało się załadować salda portfela';
      case 'nwc.errors.loadingBudget':
        return 'Nie udało się załadować budżetu portfela';
      case 'nwc.time.minutes':
        return ({required Object count}) => '${count}m';
      case 'nwc.time.hours':
        return ({required Object count}) => '${count}h';
      case 'nwc.time.days':
        return ({required Object count}) => '${count}d';
      case 'nwc.time.justNow':
        return 'teraz';
      case 'nekoManagement.title':
        return 'Neko';
      case 'relays.title':
        return 'Przekaźniki';
      case 'relays.status.connected':
        return 'Połączony';
      case 'relays.status.connecting':
        return 'Łączenie';
      case 'relays.status.reconnecting':
        return 'Ponowne łączenie';
      case 'relays.status.disconnected':
        return 'Rozłączony';
      case 'relays.popup.title':
        return ({required Object connected, required Object total}) =>
            'Przekaźniki (${connected}/${total} połączonych)';
      case 'relays.popup.connectingMessage':
        return 'Łączenie z przekaźnikami...';
      case 'altstore.dialogTitle':
        return 'AltStore Nie Zainstalowany';
      case 'altstore.step1Title':
        return 'Pobierz i zainstaluj AltStore PAL';
      case 'altstore.step1Button':
        return 'altstore.io/download';
      case 'altstore.step1Warning':
        return 'Potrzebujesz Safari, aby zainstalować AltStore PAL!';
      case 'altstore.step2Title':
        return 'Zainstaluj BitBlik';
      case 'altstore.step2Button':
        return 'Zainstaluj BitBlik';
      case 'altstore.step2Fallback':
        return 'Nie działa? Wklej źródło do AltStore';
      default:
        return null;
    }
  }
}
