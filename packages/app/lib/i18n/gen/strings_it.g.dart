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
class TranslationsIt extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsIt({
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
             locale: AppLocale.it,
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

  /// Metadata for the translations of <it>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsIt _root = this; // ignore: unused_field

  @override
  TranslationsIt $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => TranslationsIt(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppIt app = _TranslationsAppIt._(_root);
  @override
  late final _TranslationsCommonIt common = _TranslationsCommonIt._(_root);
  @override
  late final _TranslationsLightningAddressIt lightningAddress =
      _TranslationsLightningAddressIt._(_root);
  @override
  late final _TranslationsOffersIt offers = _TranslationsOffersIt._(_root);
  @override
  late final _TranslationsReservationsIt reservations =
      _TranslationsReservationsIt._(_root);
  @override
  late final _TranslationsExchangeIt exchange = _TranslationsExchangeIt._(
    _root,
  );
  @override
  late final _TranslationsCoordinatorIt coordinator =
      _TranslationsCoordinatorIt._(_root);
  @override
  late final _TranslationsMakerIt maker = _TranslationsMakerIt._(_root);
  @override
  late final _TranslationsTakerIt taker = _TranslationsTakerIt._(_root);
  @override
  late final _TranslationsBlikIt blik = _TranslationsBlikIt._(_root);
  @override
  late final _TranslationsHomeIt home = _TranslationsHomeIt._(_root);
  @override
  late final _TranslationsNekoInfoIt nekoInfo = _TranslationsNekoInfoIt._(
    _root,
  );
  @override
  late final _TranslationsGenerateNewKeyIt generateNewKey =
      _TranslationsGenerateNewKeyIt._(_root);
  @override
  late final _TranslationsBackupIt backup = _TranslationsBackupIt._(_root);
  @override
  late final _TranslationsRestoreIt restore = _TranslationsRestoreIt._(_root);
  @override
  late final _TranslationsSystemIt system = _TranslationsSystemIt._(_root);
  @override
  late final _TranslationsLandingIt landing = _TranslationsLandingIt._(_root);
  @override
  late final _TranslationsFaqIt faq = _TranslationsFaqIt._(_root);
  @override
  late final _TranslationsSettingsIt settings = _TranslationsSettingsIt._(
    _root,
  );
  @override
  late final _TranslationsWalletIt wallet = _TranslationsWalletIt._(_root);
  @override
  late final _TranslationsNwcIt nwc = _TranslationsNwcIt._(_root);
  @override
  late final _TranslationsNekoManagementIt nekoManagement =
      _TranslationsNekoManagementIt._(_root);
  @override
  late final _TranslationsRelaysIt relays = _TranslationsRelaysIt._(_root);
  @override
  late final _TranslationsAltstoreIt altstore = _TranslationsAltstoreIt._(
    _root,
  );
}

// Path: app
class _TranslationsAppIt extends TranslationsAppEn {
  _TranslationsAppIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'BitBlik';
  @override
  String get greeting => 'Ciao!';
  @override
  String get changelog => 'Registro modifiche';
}

// Path: common
class _TranslationsCommonIt extends TranslationsCommonEn {
  _TranslationsCommonIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsCommonButtonsIt buttons =
      _TranslationsCommonButtonsIt._(_root);
  @override
  late final _TranslationsCommonLabelsIt labels = _TranslationsCommonLabelsIt._(
    _root,
  );
  @override
  late final _TranslationsCommonNotificationsIt notifications =
      _TranslationsCommonNotificationsIt._(_root);
  @override
  late final _TranslationsCommonClipboardIt clipboard =
      _TranslationsCommonClipboardIt._(_root);
  @override
  late final _TranslationsCommonActionsIt actions =
      _TranslationsCommonActionsIt._(_root);
}

// Path: lightningAddress
class _TranslationsLightningAddressIt extends TranslationsLightningAddressEn {
  _TranslationsLightningAddressIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsLightningAddressLabelsIt labels =
      _TranslationsLightningAddressLabelsIt._(_root);
  @override
  late final _TranslationsLightningAddressPromptsIt prompts =
      _TranslationsLightningAddressPromptsIt._(_root);
  @override
  late final _TranslationsLightningAddressFeedbackIt feedback =
      _TranslationsLightningAddressFeedbackIt._(_root);
  @override
  late final _TranslationsLightningAddressErrorsIt errors =
      _TranslationsLightningAddressErrorsIt._(_root);
}

// Path: offers
class _TranslationsOffersIt extends TranslationsOffersEn {
  _TranslationsOffersIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsOffersDetailsIt details =
      _TranslationsOffersDetailsIt._(_root);
  @override
  late final _TranslationsOffersTooltipsIt tooltips =
      _TranslationsOffersTooltipsIt._(_root);
  @override
  late final _TranslationsOffersActionsIt actions =
      _TranslationsOffersActionsIt._(_root);
  @override
  late final _TranslationsOffersStatusIt status = _TranslationsOffersStatusIt._(
    _root,
  );
  @override
  late final _TranslationsOffersStatusMessagesIt statusMessages =
      _TranslationsOffersStatusMessagesIt._(_root);
  @override
  late final _TranslationsOffersProgressIt progress =
      _TranslationsOffersProgressIt._(_root);
  @override
  late final _TranslationsOffersErrorsIt errors = _TranslationsOffersErrorsIt._(
    _root,
  );
  @override
  late final _TranslationsOffersSuccessIt success =
      _TranslationsOffersSuccessIt._(_root);
}

// Path: reservations
class _TranslationsReservationsIt extends TranslationsReservationsEn {
  _TranslationsReservationsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsReservationsActionsIt actions =
      _TranslationsReservationsActionsIt._(_root);
  @override
  late final _TranslationsReservationsFeedbackIt feedback =
      _TranslationsReservationsFeedbackIt._(_root);
  @override
  late final _TranslationsReservationsErrorsIt errors =
      _TranslationsReservationsErrorsIt._(_root);
}

// Path: exchange
class _TranslationsExchangeIt extends TranslationsExchangeEn {
  _TranslationsExchangeIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsExchangeLabelsIt labels =
      _TranslationsExchangeLabelsIt._(_root);
  @override
  late final _TranslationsExchangeFeedbackIt feedback =
      _TranslationsExchangeFeedbackIt._(_root);
  @override
  late final _TranslationsExchangeErrorsIt errors =
      _TranslationsExchangeErrorsIt._(_root);
}

// Path: coordinator
class _TranslationsCoordinatorIt extends TranslationsCoordinatorEn {
  _TranslationsCoordinatorIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Coordinatori';
  @override
  late final _TranslationsCoordinatorInfoIt info =
      _TranslationsCoordinatorInfoIt._(_root);
  @override
  late final _TranslationsCoordinatorSelectorIt selector =
      _TranslationsCoordinatorSelectorIt._(_root);
  @override
  late final _TranslationsCoordinatorDialogIt dialog =
      _TranslationsCoordinatorDialogIt._(_root);
  @override
  late final _TranslationsCoordinatorManagementIt management =
      _TranslationsCoordinatorManagementIt._(_root);
}

// Path: maker
class _TranslationsMakerIt extends TranslationsMakerEn {
  _TranslationsMakerIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsMakerRoleSelectionIt roleSelection =
      _TranslationsMakerRoleSelectionIt._(_root);
  @override
  late final _TranslationsMakerAmountFormIt amountForm =
      _TranslationsMakerAmountFormIt._(_root);
  @override
  late final _TranslationsMakerPayInvoiceIt payInvoice =
      _TranslationsMakerPayInvoiceIt._(_root);
  @override
  late final _TranslationsMakerWaitTakerIt waitTaker =
      _TranslationsMakerWaitTakerIt._(_root);
  @override
  late final _TranslationsMakerWaitForBlikIt waitForBlik =
      _TranslationsMakerWaitForBlikIt._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentIt confirmPayment =
      _TranslationsMakerConfirmPaymentIt._(_root);
  @override
  late final _TranslationsMakerInvalidBlikIt invalidBlik =
      _TranslationsMakerInvalidBlikIt._(_root);
  @override
  late final _TranslationsMakerConflictIt conflict =
      _TranslationsMakerConflictIt._(_root);
  @override
  late final _TranslationsMakerSuccessIt success =
      _TranslationsMakerSuccessIt._(_root);
}

// Path: taker
class _TranslationsTakerIt extends TranslationsTakerEn {
  _TranslationsTakerIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTakerRoleSelectionIt roleSelection =
      _TranslationsTakerRoleSelectionIt._(_root);
  @override
  late final _TranslationsTakerProgressIt progress =
      _TranslationsTakerProgressIt._(_root);
  @override
  late final _TranslationsTakerSubmitBlikIt submitBlik =
      _TranslationsTakerSubmitBlikIt._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationIt waitConfirmation =
      _TranslationsTakerWaitConfirmationIt._(_root);
  @override
  late final _TranslationsTakerPaymentProcessIt paymentProcess =
      _TranslationsTakerPaymentProcessIt._(_root);
  @override
  late final _TranslationsTakerPaymentFailedIt paymentFailed =
      _TranslationsTakerPaymentFailedIt._(_root);
  @override
  late final _TranslationsTakerPaymentSuccessIt paymentSuccess =
      _TranslationsTakerPaymentSuccessIt._(_root);
  @override
  late final _TranslationsTakerInvalidBlikIt invalidBlik =
      _TranslationsTakerInvalidBlikIt._(_root);
  @override
  late final _TranslationsTakerConflictIt conflict =
      _TranslationsTakerConflictIt._(_root);
}

// Path: blik
class _TranslationsBlikIt extends TranslationsBlikEn {
  _TranslationsBlikIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsBlikInstructionsIt instructions =
      _TranslationsBlikInstructionsIt._(_root);
}

// Path: home
class _TranslationsHomeIt extends TranslationsHomeEn {
  _TranslationsHomeIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsHomeNotificationsIt notifications =
      _TranslationsHomeNotificationsIt._(_root);
  @override
  late final _TranslationsHomeStatisticsIt statistics =
      _TranslationsHomeStatisticsIt._(_root);
}

// Path: nekoInfo
class _TranslationsNekoInfoIt extends TranslationsNekoInfoEn {
  _TranslationsNekoInfoIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Cos\'è un Neko?';
  @override
  String get description =>
      'Il tuo Neko è la tua identità per usare BitBlik. È composto da una chiave privata e pubblica per garantire una comunicazione crittograficamente sicura con il coordinatore.\n\nPer garantire maggiore anonimato, si consiglia di usare un nuovo Neko per ogni offerta.\n\n⚠️ IMPORTANTE: La tua chiave privata è memorizzata solo sul tuo dispositivo (lato client). È fondamentale fare il backup della tua chiave privata, poiché perderla potrebbe impedirti di risolvere dispute e recuperare i tuoi fondi.';
  @override
  String get backupWarning => 'Ricorda di fare il backup del tuo Neko';
}

// Path: generateNewKey
class _TranslationsGenerateNewKeyIt extends TranslationsGenerateNewKeyEn {
  _TranslationsGenerateNewKeyIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Nuovo';
  @override
  String get description =>
      'Sei sicuro di voler generare un nuovo Neko? Quello attuale andrà perso per sempre se non ne hai fatto il backup.';
  @override
  late final _TranslationsGenerateNewKeyButtonsIt buttons =
      _TranslationsGenerateNewKeyButtonsIt._(_root);
  @override
  late final _TranslationsGenerateNewKeyErrorsIt errors =
      _TranslationsGenerateNewKeyErrorsIt._(_root);
  @override
  late final _TranslationsGenerateNewKeyFeedbackIt feedback =
      _TranslationsGenerateNewKeyFeedbackIt._(_root);
  @override
  late final _TranslationsGenerateNewKeyTooltipsIt tooltips =
      _TranslationsGenerateNewKeyTooltipsIt._(_root);
}

// Path: backup
class _TranslationsBackupIt extends TranslationsBackupEn {
  _TranslationsBackupIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Backup';
  @override
  String get description =>
      'Questa è la tua chiave privata. Protegge la comunicazione con il coordinatore. Non rivelarla mai a nessuno. Fai il backup in un luogo sicuro per prevenire problemi durante le dispute.';
  @override
  late final _TranslationsBackupFeedbackIt feedback =
      _TranslationsBackupFeedbackIt._(_root);
  @override
  late final _TranslationsBackupTooltipsIt tooltips =
      _TranslationsBackupTooltipsIt._(_root);
}

// Path: restore
class _TranslationsRestoreIt extends TranslationsRestoreEn {
  _TranslationsRestoreIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ripristina';
  @override
  late final _TranslationsRestoreLabelsIt labels =
      _TranslationsRestoreLabelsIt._(_root);
  @override
  late final _TranslationsRestoreButtonsIt buttons =
      _TranslationsRestoreButtonsIt._(_root);
  @override
  late final _TranslationsRestoreErrorsIt errors =
      _TranslationsRestoreErrorsIt._(_root);
  @override
  late final _TranslationsRestoreFeedbackIt feedback =
      _TranslationsRestoreFeedbackIt._(_root);
  @override
  late final _TranslationsRestoreTooltipsIt tooltips =
      _TranslationsRestoreTooltipsIt._(_root);
}

// Path: system
class _TranslationsSystemIt extends TranslationsSystemEn {
  _TranslationsSystemIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get loadingPublicKey => 'Caricamento della tua chiave pubblica...';
  @override
  late final _TranslationsSystemErrorsIt errors = _TranslationsSystemErrorsIt._(
    _root,
  );
  @override
  late final _TranslationsSystemBlikIt blik = _TranslationsSystemBlikIt._(
    _root,
  );
}

// Path: landing
class _TranslationsLandingIt extends TranslationsLandingEn {
  _TranslationsLandingIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get mainTitle => 'Il tuo ponte BLIK ⇄ bitcoin';
  @override
  String get subtitle => 'Paga o vendi il tuo codice BLIK con bitcoin';
  @override
  late final _TranslationsLandingActionsIt actions =
      _TranslationsLandingActionsIt._(_root);
}

// Path: faq
class _TranslationsFaqIt extends TranslationsFaqEn {
  _TranslationsFaqIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get screenTitle => 'FAQ';
  @override
  String get tooltip => 'FAQ';
}

// Path: settings
class _TranslationsSettingsIt extends TranslationsSettingsEn {
  _TranslationsSettingsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Impostazioni';
}

// Path: wallet
class _TranslationsWalletIt extends TranslationsWalletEn {
  _TranslationsWalletIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Portafoglio';
  @override
  String get description =>
      'Gestisci le impostazioni del tuo portafoglio Lightning';
  @override
  late final _TranslationsWalletMissingReceivingIt missingReceiving =
      _TranslationsWalletMissingReceivingIt._(_root);
}

// Path: nwc
class _TranslationsNwcIt extends TranslationsNwcEn {
  _TranslationsNwcIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Nostr Wallet Connect (NWC)';
  @override
  String get description => 'Connetti il tuo portafoglio Lightning tramite NWC';
  @override
  late final _TranslationsNwcLabelsIt labels = _TranslationsNwcLabelsIt._(
    _root,
  );
  @override
  late final _TranslationsNwcPromptsIt prompts = _TranslationsNwcPromptsIt._(
    _root,
  );
  @override
  late final _TranslationsNwcActionsIt actions = _TranslationsNwcActionsIt._(
    _root,
  );
  @override
  late final _TranslationsNwcFeedbackIt feedback = _TranslationsNwcFeedbackIt._(
    _root,
  );
  @override
  late final _TranslationsNwcErrorsIt errors = _TranslationsNwcErrorsIt._(
    _root,
  );
  @override
  late final _TranslationsNwcTimeIt time = _TranslationsNwcTimeIt._(_root);
}

// Path: nekoManagement
class _TranslationsNekoManagementIt extends TranslationsNekoManagementEn {
  _TranslationsNekoManagementIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Neko';
}

// Path: relays
class _TranslationsRelaysIt extends TranslationsRelaysEn {
  _TranslationsRelaysIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Relay';
  @override
  late final _TranslationsRelaysStatusIt status = _TranslationsRelaysStatusIt._(
    _root,
  );
  @override
  late final _TranslationsRelaysPopupIt popup = _TranslationsRelaysPopupIt._(
    _root,
  );
}

// Path: altstore
class _TranslationsAltstoreIt extends TranslationsAltstoreEn {
  _TranslationsAltstoreIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get dialogTitle => 'AltStore Non Installato';
  @override
  String get step1Title => 'Scarica e installa AltStore PAL';
  @override
  String get step1Button => 'altstore.io/download';
  @override
  String get step1Warning =>
      'Hai bisogno di Safari per installare AltStore PAL!';
  @override
  String get step2Title => 'Installa BitBlik';
  @override
  String get step2Button => 'Installa BitBlik';
  @override
  String get step2Fallback => 'Non funziona? Incolla la sorgente in AltStore';
}

// Path: common.buttons
class _TranslationsCommonButtonsIt extends TranslationsCommonButtonsEn {
  _TranslationsCommonButtonsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'Annulla';
  @override
  String get save => 'Salva';
  @override
  String get done => 'Fatto';
  @override
  String get retry => 'Riprova';
  @override
  String get goHome => 'Vai alla Home';
  @override
  String get saveAndContinue => 'Salva e Continua';
  @override
  String get reveal => 'Mostra';
  @override
  String get hide => 'Nascondi';
  @override
  String get copy => 'Copia';
  @override
  String get close => 'Chiudi';
  @override
  String get restore => 'Ripristina';
  @override
  String get faq => 'FAQ';
}

// Path: common.labels
class _TranslationsCommonLabelsIt extends TranslationsCommonLabelsEn {
  _TranslationsCommonLabelsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get amount => 'Importo (PLN)';
  @override
  String status({required Object status}) => 'Stato: ${status}';
  @override
  String role({required Object role}) => 'Ruolo: ${role}';
}

// Path: common.notifications
class _TranslationsCommonNotificationsIt
    extends TranslationsCommonNotificationsEn {
  _TranslationsCommonNotificationsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get success => 'Successo';
  @override
  String get error => 'Errore';
  @override
  String get loading => 'Caricamento...';
}

// Path: common.clipboard
class _TranslationsCommonClipboardIt extends TranslationsCommonClipboardEn {
  _TranslationsCommonClipboardIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get copyToClipboard => 'Copia negli appunti';
  @override
  String get pasteFromClipboard => 'Incolla dagli appunti';
  @override
  String get copied => 'Copiato negli appunti!';
}

// Path: common.actions
class _TranslationsCommonActionsIt extends TranslationsCommonActionsEn {
  _TranslationsCommonActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get cancelAndReturnToOffers => 'Annulla e torna alle offerte';
  @override
  String get cancelAndReturnHome => 'Annulla e torna alla Home';
}

// Path: lightningAddress.labels
class _TranslationsLightningAddressLabelsIt
    extends TranslationsLightningAddressLabelsEn {
  _TranslationsLightningAddressLabelsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get address => 'Indirizzo Lightning (LNURL)';
  @override
  String get hint => 'utente@dominio.com';
  @override
  String short({required Object address}) => 'Indirizzo Lightning: ${address}';
  @override
  String get receivingAddress => 'Il tuo indirizzo di ricezione:';
}

// Path: lightningAddress.prompts
class _TranslationsLightningAddressPromptsIt
    extends TranslationsLightningAddressPromptsEn {
  _TranslationsLightningAddressPromptsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get enter => 'Inserisci il tuo indirizzo Lightning per continuare';
  @override
  String get edit => 'Modifica';
  @override
  String get invalid => 'Inserisci un indirizzo Lightning valido';
  @override
  String get required => 'L\'indirizzo Lightning è obbligatorio.';
  @override
  String get enterToTakeOffer =>
      'Devi impostare un indirizzo Lightning per accettare un\'offerta.';
  @override
  String get missing =>
      'Indirizzo Lightning mancante. Aggiungine uno per poter accettare offerte.';
  @override
  String get add => 'Aggiungi';
  @override
  String get delete => 'Elimina';
  @override
  String get confirmDelete =>
      'Sei sicuro di voler eliminare il tuo indirizzo Lightning?';
  @override
  String get howToGet =>
      'Non hai ancora un indirizzo Lightning? Scopri come ottenerne uno!';
  @override
  String get learnMore => 'Scopri di più sull\'indirizzo Lightning';
}

// Path: lightningAddress.feedback
class _TranslationsLightningAddressFeedbackIt
    extends TranslationsLightningAddressFeedbackEn {
  _TranslationsLightningAddressFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get saved => 'Indirizzo Lightning salvato!';
  @override
  String get updated => 'Indirizzo Lightning aggiornato!';
  @override
  String get valid => 'Indirizzo Lightning valido';
}

// Path: lightningAddress.errors
class _TranslationsLightningAddressErrorsIt
    extends TranslationsLightningAddressErrorsEn {
  _TranslationsLightningAddressErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String saving({required Object details}) =>
      'Errore nel salvataggio dell\'indirizzo: ${details}';
  @override
  String loading({required Object details}) =>
      'Errore nel caricamento dell\'indirizzo Lightning: ${details}';
}

// Path: offers.details
class _TranslationsOffersDetailsIt extends TranslationsOffersDetailsEn {
  _TranslationsOffersDetailsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get yourOffer => 'La tua offerta:';
  @override
  String get selectedOffer => 'Offerta:';
  @override
  String get activeOffer => 'Hai un\'offerta attiva:';
  @override
  String get finishedOffers => 'Offerte completate';
  @override
  String get finishedOffersWithTime => 'Offerte completate (ultime 24h):';
  @override
  String get noAvailable => 'Nessuna offerta disponibile.';
  @override
  String get noAvailableTip =>
      'Suggerimento: condividi Bitblik nella tua community e tra i tuoi amici per aumentare gli ordini su Bitblik.';
  @override
  String get noSuccessfulTrades => 'Nessuna transazione completata.';
  @override
  String get loadingDetails => 'Caricamento dettagli offerta...';
  @override
  String amount({required Object amount}) => 'Importo: ${amount} satoshi';
  @override
  String amountWithCurrency({
    required Object amount,
    required Object currency,
  }) => '${amount} ${currency}';
  @override
  String makerFee({required Object fee}) => 'Commissione: ${fee} sats';
  @override
  String takerFee({required Object fee}) => 'Commissione: ${fee} sats';
  @override
  String subtitle({
    required Object sats,
    required Object fee,
    required Object status,
  }) => '${sats} + ${fee} (commissione) satoshi\nStato: ${status}';
  @override
  String subtitleWithDate({
    required Object sats,
    required Object fee,
    required Object status,
    required Object date,
  }) =>
      '${sats} + ${fee} (commissione) satoshi\nStato: ${status}\nPagato: ${date}';
  @override
  String activeSubtitle({required Object status, required Object amount}) =>
      'Stato: ${status}\nImporto: ${amount} satoshi';
  @override
  String id({required Object id}) => 'ID Offerta: ${id}...';
  @override
  String created({required Object dateTime}) => 'Creata: ${dateTime}';
  @override
  String takenAfter({required Object duration}) =>
      'Accettata dopo: ${duration}';
  @override
  String paidAfter({required Object duration}) => 'Pagata dopo: ${duration}';
  @override
  String get exchangeRate => 'Tasso di Cambio';
  @override
  String get amountLabel => 'Importo';
  @override
  String get makerFeeLabel => 'Commissione maker';
  @override
  String get takerFeeLabel => 'Commissione taker';
  @override
  String get feeLabel => 'Commissione';
  @override
  String get statusLabel => 'Stato';
  @override
  String get youllReceive => 'Riceverai';
  @override
  String get coordinator => 'Coordinatore';
}

// Path: offers.tooltips
class _TranslationsOffersTooltipsIt extends TranslationsOffersTooltipsEn {
  _TranslationsOffersTooltipsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String takerFeeInfo({required Object feePercent}) =>
      'Il coordinatore applica una commissione taker del ${feePercent}%. Questo include le commissioni di routing Lightning ed è detratto dall\'importo che ricevi';
}

// Path: offers.actions
class _TranslationsOffersActionsIt extends TranslationsOffersActionsEn {
  _TranslationsOffersActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get take => 'ACCETTA';
  @override
  String get takeOffer => 'Accetta Offerta';
  @override
  String get resume => 'INSERISCI BLIK';
  @override
  String get cancel => 'Annulla offerta';
  @override
  String get view => 'Visualizza dettagli';
}

// Path: offers.status
class _TranslationsOffersStatusIt extends TranslationsOffersStatusEn {
  _TranslationsOffersStatusIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get created => 'Creata';
  @override
  String get funded => 'Finanziata';
  @override
  String get expired => 'Scaduta';
  @override
  String get cancelled => 'Annullata';
  @override
  String get reserved => 'Riservata';
  @override
  String get blikReceived => 'BLIK Inviato';
  @override
  String get blikSentToMaker => 'BLIK Ricevuto';
  @override
  String get invalidBlik => 'BLIK Non Valido';
  @override
  String get conflict => 'Conflitto';
  @override
  String get dispute => 'Disputa';
  @override
  String get makerConfirmed => 'Confermata';
  @override
  String get settled => 'Conclusa';
  @override
  String get payingTaker => 'Pagamento Taker';
  @override
  String get takerPaymentFailed => 'Pagamento Fallito';
  @override
  String get takerPaid => 'Taker Pagato';
}

// Path: offers.statusMessages
class _TranslationsOffersStatusMessagesIt
    extends TranslationsOffersStatusMessagesEn {
  _TranslationsOffersStatusMessagesIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get reserved => 'Offerta riservata dal Taker!';
  @override
  String get cancelled => 'Offerta annullata con successo.';
  @override
  String get cancelledOrExpired => 'L\'offerta è stata annullata o è scaduta.';
  @override
  String noLongerAvailable({required Object status}) =>
      'L\'offerta non è più disponibile (Stato: ${status}).';
}

// Path: offers.progress
class _TranslationsOffersProgressIt extends TranslationsOffersProgressEn {
  _TranslationsOffersProgressIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String waitingForTaker({required Object time}) =>
      'In attesa del taker: ${time}';
  @override
  String reserved({required Object seconds}) =>
      'Riservata: ${seconds} s rimanenti';
  @override
  String confirming({required Object seconds}) =>
      'Conferma in corso: ${seconds} s rimanenti';
}

// Path: offers.errors
class _TranslationsOffersErrorsIt extends TranslationsOffersErrorsEn {
  _TranslationsOffersErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String loading({required Object details}) =>
      'Errore nel caricamento delle offerte: ${details}';
  @override
  String loadingDetails({required Object details}) =>
      'Errore nel caricamento dei dettagli dell\'offerta: ${details}';
  @override
  String get detailsMissing =>
      'Errore: Dettagli dell\'offerta mancanti o non validi.';
  @override
  String get detailsNotLoaded =>
      'Impossibile caricare i dettagli dell\'offerta.';
  @override
  String get notFound => 'Errore: Offerta non trovata.';
  @override
  String get unexpectedState => 'Errore: L\'offerta è in uno stato imprevisto.';
  @override
  String unexpectedStateWithStatus({required Object status}) =>
      'L\'offerta è in uno stato imprevisto (${status}). Riprova o contatta l\'assistenza.';
  @override
  String get invalidStatus => 'L\'offerta ha uno stato non valido.';
  @override
  String get couldNotIdentify =>
      'Errore: Impossibile identificare l\'offerta da annullare.';
  @override
  String cannotBeCancelled({required Object status}) =>
      'L\'offerta non può essere annullata nello stato attuale (${status}).';
  @override
  String failedToCancel({required Object details}) =>
      'Impossibile annullare l\'offerta: ${details}';
  @override
  String get activeDetailsLost =>
      'Errore: Dettagli dell\'offerta attiva persi.';
  @override
  String checkingActive({required Object details}) =>
      'Errore nel controllo delle offerte attive: ${details}';
  @override
  String loadingFinished({required Object details}) =>
      'Errore nel caricamento delle offerte completate: ${details}';
  @override
  String cannotResume({required Object status}) =>
      'Impossibile riprendere l\'offerta nello stato: ${status}';
  @override
  String cannotResumeTaker({required Object status}) =>
      'Impossibile riprendere l\'offerta taker nello stato: ${status}';
  @override
  String resuming({required Object details}) =>
      'Errore nel riprendere l\'offerta: ${details}';
  @override
  String get makerPublicKeyNotFound => 'Chiave pubblica del maker non trovata';
  @override
  String get takerPublicKeyNotFound => 'Chiave pubblica del taker non trovata.';
}

// Path: offers.success
class _TranslationsOffersSuccessIt extends TranslationsOffersSuccessEn {
  _TranslationsOffersSuccessIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Offerta completata';
  @override
  String get headline => 'Pagamento confermato!';
  @override
  String get subtitle => 'Il taker verrà pagato ora.';
  @override
  String get detailsTitle => 'Dettagli offerta:';
  @override
  String duration({required Object time}) =>
      'L\'offerta è stata completata in ${time}.';
}

// Path: reservations.actions
class _TranslationsReservationsActionsIt
    extends TranslationsReservationsActionsEn {
  _TranslationsReservationsActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'Annulla prenotazione';
}

// Path: reservations.feedback
class _TranslationsReservationsFeedbackIt
    extends TranslationsReservationsFeedbackEn {
  _TranslationsReservationsFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get cancelled => 'Prenotazione annullata.';
}

// Path: reservations.errors
class _TranslationsReservationsErrorsIt
    extends TranslationsReservationsErrorsEn {
  _TranslationsReservationsErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String cancelling({required Object error}) =>
      'Impossibile annullare la prenotazione: ${error}';
  @override
  String failedToReserve({required Object details}) =>
      'Impossibile riservare l\'offerta: ${details}';
  @override
  String get failedNoTimestamp =>
      'Impossibile riservare l\'offerta (timestamp mancante).';
  @override
  String get timestampMissing =>
      'Timestamp della prenotazione offerta mancante.';
  @override
  String notReserved({required Object status}) =>
      'L\'offerta non è più nello stato riservato (${status}).';
}

// Path: exchange.labels
class _TranslationsExchangeLabelsIt extends TranslationsExchangeLabelsEn {
  _TranslationsExchangeLabelsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get enterAmount => 'Inserisci l\'importo (PLN) da pagare:';
  @override
  String equivalent({required Object sats}) => '≈ ${sats} satoshi';
  @override
  String rate({required Object rate}) => 'Tasso di cambio ≈ ${rate} PLN/BTC';
}

// Path: exchange.feedback
class _TranslationsExchangeFeedbackIt extends TranslationsExchangeFeedbackEn {
  _TranslationsExchangeFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get fetching => 'Recupero tasso di cambio...';
}

// Path: exchange.errors
class _TranslationsExchangeErrorsIt extends TranslationsExchangeErrorsEn {
  _TranslationsExchangeErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get fetchingRate => 'Impossibile recuperare il tasso di cambio.';
  @override
  String get invalidFormat => 'Formato numero non valido';
  @override
  String get mustBePositive => 'L\'importo deve essere positivo';
  @override
  String get invalidFeePercentage => 'Percentuale commissione non valida';
  @override
  String tooLowFiat({required Object minAmount, required Object currency}) =>
      'L\'importo è troppo basso. Il minimo è ${minAmount} ${currency}.';
  @override
  String tooHighFiat({required Object maxAmount, required Object currency}) =>
      'L\'importo è troppo alto. Il massimo è ${maxAmount} ${currency}.';
}

// Path: coordinator.info
class _TranslationsCoordinatorInfoIt extends TranslationsCoordinatorInfoEn {
  _TranslationsCoordinatorInfoIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get fee => 'commissione';
  @override
  String rangeDisplay({
    required Object minAmount,
    required Object maxAmount,
    required Object currency,
  }) => 'Importo: ${minAmount}-${maxAmount} ${currency}';
  @override
  String feeDisplay({required Object fee}) => '${fee}% commissione';
}

// Path: coordinator.selector
class _TranslationsCoordinatorSelectorIt
    extends TranslationsCoordinatorSelectorEn {
  _TranslationsCoordinatorSelectorIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get loading => 'Caricamento Coordinatori...';
  @override
  String get errorLoading => 'Errore nel Caricamento Coordinatori';
  @override
  String get choose => 'Scegli Coordinatore';
  @override
  String get viewNostrProfile => 'Visualizza profilo Nostr';
  @override
  String get unresponsive => 'Questo coordinatore non risponde';
  @override
  String get waitingResponse => 'In attesa della risposta del coordinatore';
  @override
  String get termsAccept => 'Accetto i ';
  @override
  String get termsOfUsage => 'Termini di utilizzo';
}

// Path: coordinator.dialog
class _TranslationsCoordinatorDialogIt extends TranslationsCoordinatorDialogEn {
  _TranslationsCoordinatorDialogIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get makerFee => 'Commissione Maker';
  @override
  String get takerFee => 'Commissione Taker';
  @override
  String get amountRange => 'Range Importo';
  @override
  String get reservationTime => 'Tempo di Prenotazione';
  @override
  String get currencies => 'Valute';
  @override
  String get viewTerms => 'Visualizza Termini';
}

// Path: coordinator.management
class _TranslationsCoordinatorManagementIt
    extends TranslationsCoordinatorManagementEn {
  _TranslationsCoordinatorManagementIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Gestione Coordinatori';
  @override
  String get availableCoordinators => 'Coordinatori Disponibili';
  @override
  String get noCoordinators => 'Nessun coordinatore trovato.';
  @override
  String get online => 'Online';
  @override
  String get unknownOffline => 'Sconosciuto/Offline';
  @override
  String get openNostrProfile => 'Apri Profilo Nostr';
  @override
  String get enable => 'Abilita';
  @override
  String get remove => 'Rimuovi';
  @override
  String get addCustomWhitelist => 'Aggiungi coordinatore personalizzato';
  @override
  String get addCustomWhitelistHint => 'npub1...';
  @override
  String get add => 'Aggiungi';
  @override
  String get coordinatorBlacklisted => 'Coordinatore inserito in blacklist';
  @override
  String get coordinatorUnblacklisted => 'Coordinatore rimosso dalla blacklist';
  @override
  String get coordinatorAdded =>
      'Coordinatore aggiunto alla whitelist personalizzata';
  @override
  String get coordinatorRemoved =>
      'Coordinatore rimosso dalla whitelist personalizzata';
  @override
  String get pleaseEnterNpub => 'Inserisci un npub';
  @override
  String get error => 'Errore';
}

// Path: maker.roleSelection
class _TranslationsMakerRoleSelectionIt
    extends TranslationsMakerRoleSelectionEn {
  _TranslationsMakerRoleSelectionIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get button => 'PAGA con Lightning';
}

// Path: maker.amountForm
class _TranslationsMakerAmountFormIt extends TranslationsMakerAmountFormEn {
  _TranslationsMakerAmountFormIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsMakerAmountFormProgressIt progress =
      _TranslationsMakerAmountFormProgressIt._(_root);
  @override
  late final _TranslationsMakerAmountFormLabelsIt labels =
      _TranslationsMakerAmountFormLabelsIt._(_root);
  @override
  late final _TranslationsMakerAmountFormActionsIt actions =
      _TranslationsMakerAmountFormActionsIt._(_root);
  @override
  late final _TranslationsMakerAmountFormTooltipsIt tooltips =
      _TranslationsMakerAmountFormTooltipsIt._(_root);
  @override
  late final _TranslationsMakerAmountFormErrorsIt errors =
      _TranslationsMakerAmountFormErrorsIt._(_root);
}

// Path: maker.payInvoice
class _TranslationsMakerPayInvoiceIt extends TranslationsMakerPayInvoiceEn {
  _TranslationsMakerPayInvoiceIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Paga questa fattura Hold:';
  @override
  late final _TranslationsMakerPayInvoiceActionsIt actions =
      _TranslationsMakerPayInvoiceActionsIt._(_root);
  @override
  late final _TranslationsMakerPayInvoiceFeedbackIt feedback =
      _TranslationsMakerPayInvoiceFeedbackIt._(_root);
  @override
  late final _TranslationsMakerPayInvoiceErrorsIt errors =
      _TranslationsMakerPayInvoiceErrorsIt._(_root);
}

// Path: maker.waitTaker
class _TranslationsMakerWaitTakerIt extends TranslationsMakerWaitTakerEn {
  _TranslationsMakerWaitTakerIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'In attesa che un Taker riservi la tua offerta...';
  @override
  String progressLabel({required Object time}) =>
      'In attesa del taker: ${time}';
  @override
  String get errorActiveOfferDetailsLost =>
      'Errore: Dettagli dell\'offerta attiva persi.';
  @override
  String get errorFailedToRetrieveBlik =>
      'Errore: Impossibile recuperare il codice BLIK.';
  @override
  String errorRetrievingBlik({required Object details}) =>
      'Errore nel recupero del codice BLIK: ${details}';
  @override
  String offerNoLongerAvailable({required Object status}) =>
      'L\'offerta non è più disponibile (Stato: ${status}).';
  @override
  String get errorCouldNotIdentifyOffer =>
      'Errore: Impossibile identificare l\'offerta da annullare.';
  @override
  String offerCannotBeCancelled({required Object status}) =>
      'L\'offerta non può essere annullata nello stato attuale (${status}).';
  @override
  String get offerCancelledSuccessfully => 'Offerta annullata con successo.';
  @override
  String failedToCancelOffer({required Object details}) =>
      'Impossibile annullare l\'offerta: ${details}';
}

// Path: maker.waitForBlik
class _TranslationsMakerWaitForBlikIt extends TranslationsMakerWaitForBlikEn {
  _TranslationsMakerWaitForBlikIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'In attesa di BLIK';
  @override
  String get messageInfo => 'Il Taker ha riservato l\'offerta!';
  @override
  String get messageWaiting => 'In attesa del codice BLIK...';
  @override
  String progressLabel({required Object seconds}) =>
      'Riservata: ${seconds} s rimanenti';
}

// Path: maker.confirmPayment
class _TranslationsMakerConfirmPaymentIt
    extends TranslationsMakerConfirmPaymentEn {
  _TranslationsMakerConfirmPaymentIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Codice BLIK ricevuto!';
  @override
  String get retrieving => 'Recupero codice BLIK...';
  @override
  String get instructions =>
      'Inserisci questo codice nel terminale di pagamento. Quando il Taker conferma nella sua app bancaria e il pagamento va a buon fine, premi Conferma qui sotto.';
  @override
  String get instruction1 =>
      'Inserisci il codice nella richiesta di pagamento BLIK.';
  @override
  String get instruction2 =>
      'Attendi che il Taker confermi il pagamento nella sua app.';
  @override
  String get instruction3 =>
      'Quando il pagamento va a buon fine, premi Conferma qui sotto:';
  @override
  String get takerChargedWarning =>
      'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto bancario. Se lo contrassegni come non valido, si creerà un conflitto.';
  @override
  String get expiredTitle => 'Codice BLIK Scaduto';
  @override
  String get expiredWarning =>
      'Il codice BLIK è scaduto. Devi confermare manualmente lo stato del pagamento:';
  @override
  String get expiredInstruction1 =>
      'Se il pagamento BLIK è andato a buon fine e hai completato l\'acquisto, clicca "Conferma pagamento riuscito" qui sotto.';
  @override
  String get expiredInstruction2 =>
      'Se il pagamento BLIK è fallito o non è stato completato, clicca "Codice BLIK Non Valido" qui sotto.';
  @override
  late final _TranslationsMakerConfirmPaymentActionsIt actions =
      _TranslationsMakerConfirmPaymentActionsIt._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentConfirmDialogIt confirmDialog =
      _TranslationsMakerConfirmPaymentConfirmDialogIt._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogIt
  invalidBlikDisputeDialog =
      _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogIt._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentFeedbackIt feedback =
      _TranslationsMakerConfirmPaymentFeedbackIt._(_root);
  @override
  late final _TranslationsMakerConfirmPaymentErrorsIt errors =
      _TranslationsMakerConfirmPaymentErrorsIt._(_root);
}

// Path: maker.invalidBlik
class _TranslationsMakerInvalidBlikIt extends TranslationsMakerInvalidBlikEn {
  _TranslationsMakerInvalidBlikIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Codice BLIK Non Valido';
  @override
  String get info =>
      'Hai contrassegnato il codice BLIK come non valido. In attesa che il taker fornisca un nuovo codice o avvii una disputa.';
}

// Path: maker.conflict
class _TranslationsMakerConflictIt extends TranslationsMakerConflictEn {
  _TranslationsMakerConflictIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Conflitto Offerta';
  @override
  String get headline => 'Conflitto Offerta Segnalato';
  @override
  String get body =>
      'Hai contrassegnato il codice BLIK come non valido, ma il Taker ha segnalato un conflitto, indicando che ritiene il pagamento andato a buon fine.';
  @override
  String get instructions =>
      'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.';
  @override
  late final _TranslationsMakerConflictActionsIt actions =
      _TranslationsMakerConflictActionsIt._(_root);
  @override
  late final _TranslationsMakerConflictDisputeDialogIt disputeDialog =
      _TranslationsMakerConflictDisputeDialogIt._(_root);
  @override
  late final _TranslationsMakerConflictFeedbackIt feedback =
      _TranslationsMakerConflictFeedbackIt._(_root);
  @override
  late final _TranslationsMakerConflictErrorsIt errors =
      _TranslationsMakerConflictErrorsIt._(_root);
}

// Path: maker.success
class _TranslationsMakerSuccessIt extends TranslationsMakerSuccessEn {
  _TranslationsMakerSuccessIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Offerta completata';
  @override
  String get headline => 'Pagamento confermato!';
  @override
  String get subtitle => 'Il Taker verrà ora pagato.';
  @override
  String get detailsTitle => 'Dettagli offerta:';
}

// Path: taker.roleSelection
class _TranslationsTakerRoleSelectionIt
    extends TranslationsTakerRoleSelectionEn {
  _TranslationsTakerRoleSelectionIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get button => 'VENDI codice BLIK per satoshi';
}

// Path: taker.progress
class _TranslationsTakerProgressIt extends TranslationsTakerProgressEn {
  _TranslationsTakerProgressIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get step1 => 'Invia BLIK';
  @override
  String get step2 => 'Conferma BLIK';
  @override
  String get step3 => 'Ricevi Pagamento';
}

// Path: taker.submitBlik
class _TranslationsTakerSubmitBlikIt extends TranslationsTakerSubmitBlikEn {
  _TranslationsTakerSubmitBlikIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Inserisci BLIK a 6 cifre';
  @override
  String get label => 'Codice BLIK';
  @override
  String get instruction => 'Inserisci BLIK prima che scada il tempo...';
  @override
  String timeLimit({required Object seconds}) =>
      'Inserisci BLIK entro: ${seconds} s';
  @override
  String get timeExpired => 'Il tempo per inserire il codice BLIK è scaduto.';
  @override
  late final _TranslationsTakerSubmitBlikActionsIt actions =
      _TranslationsTakerSubmitBlikActionsIt._(_root);
  @override
  late final _TranslationsTakerSubmitBlikFeedbackIt feedback =
      _TranslationsTakerSubmitBlikFeedbackIt._(_root);
  @override
  late final _TranslationsTakerSubmitBlikValidationIt validation =
      _TranslationsTakerSubmitBlikValidationIt._(_root);
  @override
  late final _TranslationsTakerSubmitBlikErrorsIt errors =
      _TranslationsTakerSubmitBlikErrorsIt._(_root);
  @override
  late final _TranslationsTakerSubmitBlikDetailsIt details =
      _TranslationsTakerSubmitBlikDetailsIt._(_root);
}

// Path: taker.waitConfirmation
class _TranslationsTakerWaitConfirmationIt
    extends TranslationsTakerWaitConfirmationEn {
  _TranslationsTakerWaitConfirmationIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'In attesa del Maker';
  @override
  String statusLabel({required Object status}) => 'Stato offerta: ${status}';
  @override
  String waitingMaker({required Object seconds}) =>
      'In attesa della conferma del Maker: ${seconds} s';
  @override
  String waitingMakerConfirmation({required Object seconds}) =>
      'In attesa che il Maker confermi che il BLIK è corretto. Tempo rimanente: ${seconds}s';
  @override
  String importantNotice({required Object amount, required Object currency}) =>
      'MOLTO IMPORTANTE: Assicurati di accettare solo la conferma BLIK per ${amount} ${currency}';
  @override
  String importantBlikAmountConfirmation({
    required Object amount,
    required Object currency,
  }) =>
      'MOLTO IMPORTANTE: Nella tua app bancaria, assicurati di confermare un pagamento BLIK per esattamente ${amount} ${currency}.';
  @override
  String get instructions =>
      'Il maker deve ora inserirlo nel terminale di pagamento entro 2 minuti. Dovrai poi accettare il codice BLIK nella tua app bancaria.';
  @override
  String get waitingForMakerToReceive =>
      'In attesa che il maker riceva il tuo codice BLIK...';
  @override
  String get makerReceivedBlik => 'Il maker ha ricevuto il tuo codice BLIK.';
  @override
  String get timerExpiredMessage =>
      'Il tempo di scadenza BLIK di 2 minuti è passato. In attesa che il maker confermi o contrassegni il codice come non valido.';
  @override
  String get timerExpiredActions =>
      'Il tempo di scadenza BLIK di 2 minuti è passato ma il maker non ha ricevuto il codice BLIK. Puoi rinviare un nuovo codice BLIK o annullare.';
  @override
  String get resendBlikButton => 'Rinvia Nuovo Codice BLIK';
  @override
  String get navigatedHome => 'Tornato alla home.';
  @override
  String get expiredTitle => 'Codice BLIK Scaduto';
  @override
  String get expiredWarning =>
      'Il maker non ha ricevuto il codice BLIK quindi non ha potuto utilizzarlo.';
  @override
  String get expiredSentWarning =>
      'Il maker non ha ancora confermato il pagamento. Cosa vuoi fare?';
  @override
  String get expiredInstruction1 =>
      'Se vuoi riprovare con un nuovo codice BLIK, rinnova la prenotazione.';
  @override
  String get expiredInstruction2 =>
      'Se non vuoi più completare questa transazione, annulla la prenotazione.';
  @override
  String get expiredInstruction3 =>
      'Se il pagamento BLIK è stato addebitato sul tuo conto bancario, non preoccuparti, i bitcoin sono ancora al sicuro presso il coordinatore.';
  @override
  late final _TranslationsTakerWaitConfirmationTakerChargedIt takerCharged =
      _TranslationsTakerWaitConfirmationTakerChargedIt._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationExpiredActionsIt expiredActions =
      _TranslationsTakerWaitConfirmationExpiredActionsIt._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationFeedbackIt feedback =
      _TranslationsTakerWaitConfirmationFeedbackIt._(_root);
  @override
  late final _TranslationsTakerWaitConfirmationErrorsIt errors =
      _TranslationsTakerWaitConfirmationErrorsIt._(_root);
}

// Path: taker.paymentProcess
class _TranslationsTakerPaymentProcessIt
    extends TranslationsTakerPaymentProcessEn {
  _TranslationsTakerPaymentProcessIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Processo di Pagamento';
  @override
  String get waitingForOfferUpdate =>
      'In attesa dell\'aggiornamento dello stato dell\'offerta...';
  @override
  late final _TranslationsTakerPaymentProcessStatesIt states =
      _TranslationsTakerPaymentProcessStatesIt._(_root);
  @override
  late final _TranslationsTakerPaymentProcessStepsIt steps =
      _TranslationsTakerPaymentProcessStepsIt._(_root);
  @override
  late final _TranslationsTakerPaymentProcessErrorsIt errors =
      _TranslationsTakerPaymentProcessErrorsIt._(_root);
  @override
  late final _TranslationsTakerPaymentProcessLoadingIt loading =
      _TranslationsTakerPaymentProcessLoadingIt._(_root);
  @override
  late final _TranslationsTakerPaymentProcessActionsIt actions =
      _TranslationsTakerPaymentProcessActionsIt._(_root);
}

// Path: taker.paymentFailed
class _TranslationsTakerPaymentFailedIt
    extends TranslationsTakerPaymentFailedEn {
  _TranslationsTakerPaymentFailedIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Pagamento Fallito';
  @override
  String instructions({required Object netAmount}) =>
      'Fornisci una nuova fattura Lightning per ${netAmount} satoshi';
  @override
  late final _TranslationsTakerPaymentFailedFormIt form =
      _TranslationsTakerPaymentFailedFormIt._(_root);
  @override
  late final _TranslationsTakerPaymentFailedActionsIt actions =
      _TranslationsTakerPaymentFailedActionsIt._(_root);
  @override
  late final _TranslationsTakerPaymentFailedErrorsIt errors =
      _TranslationsTakerPaymentFailedErrorsIt._(_root);
  @override
  late final _TranslationsTakerPaymentFailedLoadingIt loading =
      _TranslationsTakerPaymentFailedLoadingIt._(_root);
  @override
  late final _TranslationsTakerPaymentFailedSuccessIt success =
      _TranslationsTakerPaymentFailedSuccessIt._(_root);
}

// Path: taker.paymentSuccess
class _TranslationsTakerPaymentSuccessIt
    extends TranslationsTakerPaymentSuccessEn {
  _TranslationsTakerPaymentSuccessIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Pagamento Riuscito';
  @override
  String get message => 'Il tuo pagamento è stato elaborato con successo.';
  @override
  late final _TranslationsTakerPaymentSuccessActionsIt actions =
      _TranslationsTakerPaymentSuccessActionsIt._(_root);
}

// Path: taker.invalidBlik
class _TranslationsTakerInvalidBlikIt extends TranslationsTakerInvalidBlikEn {
  _TranslationsTakerInvalidBlikIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Codice BLIK Non Valido';
  @override
  String get message => 'Il Maker ha Rifiutato il Codice BLIK';
  @override
  String get explanation =>
      'Il maker dell\'offerta ha indicato che il codice BLIK fornito non era valido o non ha funzionato.\n\nCosa vuoi fare?';
  @override
  String get werentCharged => 'Se NON ti è stato addebitato:';
  @override
  String get wereCharged => 'Se ti è stato addebitato:';
  @override
  late final _TranslationsTakerInvalidBlikActionsIt actions =
      _TranslationsTakerInvalidBlikActionsIt._(_root);
  @override
  late final _TranslationsTakerInvalidBlikFeedbackIt feedback =
      _TranslationsTakerInvalidBlikFeedbackIt._(_root);
  @override
  late final _TranslationsTakerInvalidBlikErrorsIt errors =
      _TranslationsTakerInvalidBlikErrorsIt._(_root);
}

// Path: taker.conflict
class _TranslationsTakerConflictIt extends TranslationsTakerConflictEn {
  _TranslationsTakerConflictIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Conflitto Offerta';
  @override
  String get headline => 'Conflitto Offerta Segnalato';
  @override
  String get body =>
      'Il Maker ha contrassegnato il codice BLIK come non valido, ma tu hai segnalato un conflitto, indicando che ritieni il pagamento andato a buon fine.';
  @override
  String get instructions =>
      'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.';
  @override
  late final _TranslationsTakerConflictActionsIt actions =
      _TranslationsTakerConflictActionsIt._(_root);
  @override
  late final _TranslationsTakerConflictFeedbackIt feedback =
      _TranslationsTakerConflictFeedbackIt._(_root);
  @override
  late final _TranslationsTakerConflictErrorsIt errors =
      _TranslationsTakerConflictErrorsIt._(_root);
}

// Path: blik.instructions
class _TranslationsBlikInstructionsIt extends TranslationsBlikInstructionsEn {
  _TranslationsBlikInstructionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get taker =>
      'Una volta che il Maker inserisce il codice BLIK, dovrai confermare il pagamento nella tua app bancaria. Assicurati che l\'importo sia corretto prima di confermare.';
}

// Path: home.notifications
class _TranslationsHomeNotificationsIt extends TranslationsHomeNotificationsEn {
  _TranslationsHomeNotificationsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ricevi notifiche sulle nuove offerte tramite:';
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
class _TranslationsHomeStatisticsIt extends TranslationsHomeStatisticsEn {
  _TranslationsHomeStatisticsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Offerte Completate';
  @override
  String lifetimeCompact({
    required Object count,
    required Object avgBlikTime,
    required Object avgPaidTime,
  }) =>
      'Totale: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}';
  @override
  String last7DaysCompact({
    required Object count,
    required Object avgBlikTime,
    required Object avgPaidTime,
  }) =>
      'Ultimi 7g: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}';
  @override
  String last7DaysSingleLine({
    required Object count,
    required Object avgBlikTime,
    required Object avgPaidTime,
  }) =>
      'Ultimi 7g: ${count} offerte  |  Media BLIK: ${avgBlikTime}  |  Media Pagato: ${avgPaidTime}';
  @override
  late final _TranslationsHomeStatisticsErrorsIt errors =
      _TranslationsHomeStatisticsErrorsIt._(_root);
}

// Path: generateNewKey.buttons
class _TranslationsGenerateNewKeyButtonsIt
    extends TranslationsGenerateNewKeyButtonsEn {
  _TranslationsGenerateNewKeyButtonsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get generate => 'Genera';
}

// Path: generateNewKey.errors
class _TranslationsGenerateNewKeyErrorsIt
    extends TranslationsGenerateNewKeyErrorsEn {
  _TranslationsGenerateNewKeyErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get activeOffer =>
      'Non puoi generare un nuovo Neko mentre hai un\'offerta attiva.';
  @override
  String get failed => 'Impossibile generare un nuovo Neko';
}

// Path: generateNewKey.feedback
class _TranslationsGenerateNewKeyFeedbackIt
    extends TranslationsGenerateNewKeyFeedbackEn {
  _TranslationsGenerateNewKeyFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get success => 'Nuovo Neko generato con successo!';
}

// Path: generateNewKey.tooltips
class _TranslationsGenerateNewKeyTooltipsIt
    extends TranslationsGenerateNewKeyTooltipsEn {
  _TranslationsGenerateNewKeyTooltipsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get generate => 'Genera Nuovo Neko';
}

// Path: backup.feedback
class _TranslationsBackupFeedbackIt extends TranslationsBackupFeedbackEn {
  _TranslationsBackupFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get copied => 'Chiave privata copiata negli appunti!';
}

// Path: backup.tooltips
class _TranslationsBackupTooltipsIt extends TranslationsBackupTooltipsEn {
  _TranslationsBackupTooltipsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get backup => 'Backup Neko';
}

// Path: restore.labels
class _TranslationsRestoreLabelsIt extends TranslationsRestoreLabelsEn {
  _TranslationsRestoreLabelsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get privateKey => 'Chiave Privata';
}

// Path: restore.buttons
class _TranslationsRestoreButtonsIt extends TranslationsRestoreButtonsEn {
  _TranslationsRestoreButtonsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get restore => 'Ripristina';
}

// Path: restore.errors
class _TranslationsRestoreErrorsIt extends TranslationsRestoreErrorsEn {
  _TranslationsRestoreErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get invalidKey =>
      'Deve essere una stringa esadecimale di 64 caratteri.';
  @override
  String get failed => 'Ripristino fallito';
}

// Path: restore.feedback
class _TranslationsRestoreFeedbackIt extends TranslationsRestoreFeedbackEn {
  _TranslationsRestoreFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get success =>
      'Neko ripristinato con successo! L\'app verrà riavviata.';
}

// Path: restore.tooltips
class _TranslationsRestoreTooltipsIt extends TranslationsRestoreTooltipsEn {
  _TranslationsRestoreTooltipsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get restore => 'Ripristina Neko';
}

// Path: system.errors
class _TranslationsSystemErrorsIt extends TranslationsSystemErrorsEn {
  _TranslationsSystemErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get generic => 'Si è verificato un errore imprevisto. Riprova.';
  @override
  String get loadingTimeoutConfig =>
      'Errore nel caricamento della configurazione timeout.';
  @override
  String get loadingCoordinatorConfig =>
      'Errore nel caricamento della configurazione del coordinatore. Riprova.';
  @override
  String get noPublicKey =>
      'La tua chiave pubblica non è disponibile. Impossibile procedere.';
  @override
  String get internalOfferIncomplete =>
      'Errore interno: I dettagli dell\'offerta sono incompleti. Riprova.';
  @override
  String get loadingPublicKey =>
      'Errore nel caricamento della tua chiave pubblica. Riavvia l\'app.';
}

// Path: system.blik
class _TranslationsSystemBlikIt extends TranslationsSystemBlikEn {
  _TranslationsSystemBlikIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get copied => 'Codice BLIK copiato negli appunti';
}

// Path: landing.actions
class _TranslationsLandingActionsIt extends TranslationsLandingActionsEn {
  _TranslationsLandingActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get payBlik => 'Paga BLIK';
  @override
  String get payBlikSubtitle => 'con bitcoin';
  @override
  String get sellBlik => 'Compra bitcoin';
  @override
  String get sellBlikSubtitle => 'con BLIK';
  @override
  String get howItWorks => 'Come funziona?';
}

// Path: wallet.missingReceiving
class _TranslationsWalletMissingReceivingIt
    extends TranslationsWalletMissingReceivingEn {
  _TranslationsWalletMissingReceivingIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Portafoglio di ricezione richiesto';
  @override
  String get message =>
      'Nessun portafoglio configurato per ricevere. Aggiungine uno nelle impostazioni Portafoglio per accettare offerte.';
  @override
  String get openSettings => 'Impostazioni portafoglio';
}

// Path: nwc.labels
class _TranslationsNwcLabelsIt extends TranslationsNwcLabelsEn {
  _TranslationsNwcLabelsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get connectionString => 'Stringa di Connessione NWC';
  @override
  String get hint => 'nostr+walletconnect://...';
  @override
  String get status => 'Stato Connessione';
  @override
  String get connected => 'Connesso';
  @override
  String get disconnected => 'Disconnesso';
  @override
  String get scanQrCode => 'Scansiona il codice QR con la tua connessione NWC';
  @override
  String get balance => 'Saldo';
  @override
  String get budget => 'Budget';
  @override
  String get usedBudget => 'Usato';
  @override
  String get totalBudget => 'Totale';
  @override
  String get renewsIn => 'Si rinnova tra';
  @override
  String get renewalPeriod => 'Periodo di Rinnovo';
  @override
  String get relay => 'Relay';
  @override
  String get relays => 'Relay';
}

// Path: nwc.prompts
class _TranslationsNwcPromptsIt extends TranslationsNwcPromptsEn {
  _TranslationsNwcPromptsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get enter => 'Inserisci la tua stringa di connessione NWC';
  @override
  String get connect => 'Connetti Portafoglio';
  @override
  String get disconnect => 'Disconnetti';
  @override
  String get confirmDisconnect =>
      'Sei sicuro di voler disconnettere il tuo portafoglio NWC?';
  @override
  String get pasteConnection => 'Incolla stringa di connessione';
  @override
  String get chooseMethod =>
      'Scegli come connettere il tuo portafoglio Lightning';
  @override
  String get howToGet =>
      'Non hai ancora una connessione NWC? Scopri come ottenerla!';
  @override
  String get learnMore => 'Scopri di più su NWC';
}

// Path: nwc.actions
class _TranslationsNwcActionsIt extends TranslationsNwcActionsEn {
  _TranslationsNwcActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get connectAlbyGo => 'Connetti con Alby Go';
  @override
  String get connectNwc => 'Scansiona QR Code NWC';
}

// Path: nwc.feedback
class _TranslationsNwcFeedbackIt extends TranslationsNwcFeedbackEn {
  _TranslationsNwcFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Portafoglio NWC connesso con successo!';
  @override
  String get disconnected => 'Portafoglio NWC disconnesso';
  @override
  String get connecting => 'Connessione al portafoglio NWC...';
  @override
  String get loadingWalletInfo => 'Caricamento informazioni portafoglio...';
}

// Path: nwc.errors
class _TranslationsNwcErrorsIt extends TranslationsNwcErrorsEn {
  _TranslationsNwcErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String connecting({required Object details}) =>
      'Errore nella connessione a NWC: ${details}';
  @override
  String disconnecting({required Object details}) =>
      'Errore nella disconnessione da NWC: ${details}';
  @override
  String get invalid => 'Stringa di connessione NWC non valida';
  @override
  String get required => 'La stringa di connessione NWC è obbligatoria';
  @override
  String get loadingBalance => 'Impossibile caricare il saldo del portafoglio';
  @override
  String get loadingBudget => 'Impossibile caricare il budget del portafoglio';
}

// Path: nwc.time
class _TranslationsNwcTimeIt extends TranslationsNwcTimeEn {
  _TranslationsNwcTimeIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String minutes({required Object count}) => '${count}m';
  @override
  String hours({required Object count}) => '${count}h';
  @override
  String days({required Object count}) => '${count}g';
  @override
  String get justNow => 'adesso';
}

// Path: relays.status
class _TranslationsRelaysStatusIt extends TranslationsRelaysStatusEn {
  _TranslationsRelaysStatusIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Connesso';
  @override
  String get connecting => 'Connessione';
  @override
  String get reconnecting => 'Riconnessione';
  @override
  String get disconnected => 'Disconnesso';
}

// Path: relays.popup
class _TranslationsRelaysPopupIt extends TranslationsRelaysPopupEn {
  _TranslationsRelaysPopupIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object connected, required Object total}) =>
      'Relay (${connected}/${total} connessi)';
  @override
  String get connectingMessage => 'Connessione ai relay...';
}

// Path: maker.amountForm.progress
class _TranslationsMakerAmountFormProgressIt
    extends TranslationsMakerAmountFormProgressEn {
  _TranslationsMakerAmountFormProgressIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get step1 => '1. Crea Offerta';
  @override
  String get step2 => '2. Attendi Taker';
  @override
  String get step3 => '3. Usa BLIK';
}

// Path: maker.amountForm.labels
class _TranslationsMakerAmountFormLabelsIt
    extends TranslationsMakerAmountFormLabelsEn {
  _TranslationsMakerAmountFormLabelsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get coordinator => 'Coordinatore';
  @override
  String get exchangeRate => 'Tasso di Cambio';
  @override
  String get fee => 'Commissione';
  @override
  String get satoshisToPay => 'Importo da Pagare';
  @override
  String get enterAmount => 'Inserisci importo';
  @override
  String get tapToSelect => 'Tocca per selezionare';
}

// Path: maker.amountForm.actions
class _TranslationsMakerAmountFormActionsIt
    extends TranslationsMakerAmountFormActionsEn {
  _TranslationsMakerAmountFormActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get generateInvoice => 'Genera Fattura';
}

// Path: maker.amountForm.tooltips
class _TranslationsMakerAmountFormTooltipsIt
    extends TranslationsMakerAmountFormTooltipsEn {
  _TranslationsMakerAmountFormTooltipsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String feeInfo({required Object feePercent}) =>
      'Il coordinatore applica una commissione maker del ${feePercent}%. Questa commissione viene detratta dal tuo pagamento Lightning.';
  @override
  String get payInfo =>
      'Questo calcolo si basa sui tassi di cambio recuperati dal client. Il coordinatore calcolerà l\'importo esatto, e l\'importo della fattura sarà quello finale e definitivo da pagare.';
}

// Path: maker.amountForm.errors
class _TranslationsMakerAmountFormErrorsIt
    extends TranslationsMakerAmountFormErrorsEn {
  _TranslationsMakerAmountFormErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String initiating({required Object details}) =>
      'Errore nell\'avvio dell\'offerta: ${details}';
  @override
  String get publicKeyNotLoaded =>
      'Errore: Chiave pubblica non ancora caricata.';
}

// Path: maker.payInvoice.actions
class _TranslationsMakerPayInvoiceActionsIt
    extends TranslationsMakerPayInvoiceActionsEn {
  _TranslationsMakerPayInvoiceActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get copy => 'Copia Fattura';
  @override
  String get payInWallet => 'Apri nel Wallet Esterno';
  @override
  String get connectWallet => 'Connetti Wallet';
  @override
  String get payWithNwc => 'Paga';
  @override
  String get paying => 'Pagamento in corso...';
}

// Path: maker.payInvoice.feedback
class _TranslationsMakerPayInvoiceFeedbackIt
    extends TranslationsMakerPayInvoiceFeedbackEn {
  _TranslationsMakerPayInvoiceFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get copied => 'Fattura copiata negli appunti!';
  @override
  String get waitingConfirmation => 'In attesa della conferma del pagamento...';
  @override
  String get nwcConnected => 'Wallet NWC connesso!';
  @override
  String get nwcPaymentSuccess => 'Pagamento riuscito!';
}

// Path: maker.payInvoice.errors
class _TranslationsMakerPayInvoiceErrorsIt
    extends TranslationsMakerPayInvoiceErrorsEn {
  _TranslationsMakerPayInvoiceErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get couldNotOpenApp =>
      'Impossibile aprire l\'app Lightning per la fattura.';
  @override
  String openingApp({required Object details}) =>
      'Errore nell\'apertura dell\'app Lightning: ${details}';
  @override
  String get publicKeyNotAvailable => 'La chiave pubblica non è disponibile.';
  @override
  String get couldNotFetchActive =>
      'Impossibile recuperare i dettagli dell\'offerta attiva. Potrebbe essere scaduta.';
  @override
  String nwcPaymentFailed({required Object details}) =>
      'Pagamento fallito: ${details}';
  @override
  String get nwcNotConnected => 'Wallet NWC non connesso';
  @override
  String insufficientBalance({
    required Object required,
    required Object available,
  }) =>
      'Saldo insufficiente. Necessari ${required} sats, disponibili ${available} sats';
}

// Path: maker.confirmPayment.actions
class _TranslationsMakerConfirmPaymentActionsIt
    extends TranslationsMakerConfirmPaymentActionsEn {
  _TranslationsMakerConfirmPaymentActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get confirm => 'Conferma pagamento riuscito';
  @override
  String get markInvalid => 'Codice BLIK Non Valido';
  @override
  String get copyBlik => 'Copia BLIK';
}

// Path: maker.confirmPayment.confirmDialog
class _TranslationsMakerConfirmPaymentConfirmDialogIt
    extends TranslationsMakerConfirmPaymentConfirmDialogEn {
  _TranslationsMakerConfirmPaymentConfirmDialogIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Confermare il Pagamento?';
  @override
  String get content =>
      'Questa azione è irreversibile. Dopo la conferma:\n\n• Il Taker riceverà i fondi immediatamente\n• Il coordinatore non potrà contestare i fondi\n• Non puoi annullare questa azione\n\nConferma solo se il pagamento BLIK è andato a buon fine.';
  @override
  String get cancel => 'Annulla';
  @override
  String get confirmButton => 'Sì, Conferma Pagamento';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogIt
    extends TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogEn {
  _TranslationsMakerConfirmPaymentInvalidBlikDisputeDialogIt._(
    TranslationsIt root,
  ) : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Aprire una Disputa?';
  @override
  String get content =>
      'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto.\n\nContrassegnarlo come non valido aprirà immediatamente una DISPUTA che richiede l\'intervento del coordinatore.\n\n• Potrebbe essere addebitata una commissione per disputa se il verdetto sarà contro di te\n• La fattura hold verrà saldata immediatamente\n• Sarà necessaria una verifica manuale\n\nProcedi solo se sei certo che il pagamento BLIK NON è andato a buon fine.';
  @override
  String get cancel => 'Annulla';
  @override
  String get confirmButton => 'Sì, Apri Disputa';
}

// Path: maker.confirmPayment.feedback
class _TranslationsMakerConfirmPaymentFeedbackIt
    extends TranslationsMakerConfirmPaymentFeedbackEn {
  _TranslationsMakerConfirmPaymentFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get confirmed => 'Il Maker ha confermato il pagamento.';
  @override
  String get confirmedTakerPaid =>
      'Pagamento confermato! Il Taker riceverà i fondi.';
  @override
  String progressLabel({required Object seconds}) =>
      'Conferma in corso: ${seconds} s rimanenti';
}

// Path: maker.confirmPayment.errors
class _TranslationsMakerConfirmPaymentErrorsIt
    extends TranslationsMakerConfirmPaymentErrorsEn {
  _TranslationsMakerConfirmPaymentErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get failedToRetrieve =>
      'Errore: Impossibile recuperare il codice BLIK.';
  @override
  String retrieving({required Object details}) =>
      'Errore nel recupero del codice BLIK: ${details}';
  @override
  String get missingHashOrKey =>
      'Errore: Hash di pagamento o chiave pubblica mancante.';
  @override
  String incorrectState({required Object status}) =>
      'L\'offerta non è nello stato corretto per la conferma (Stato: ${status})';
  @override
  String confirming({required Object details}) =>
      'Errore nella conferma del pagamento: ${details}';
  @override
  String get invalidState => 'Errore: Stato dell\'offerta non valido ricevuto.';
  @override
  String get internalIncomplete =>
      'Errore interno: Dettagli dell\'offerta incompleti.';
  @override
  String notAwaitingConfirmation({required Object status}) =>
      'L\'offerta non è più in attesa di conferma (Stato: ${status}).';
  @override
  String get unexpectedStatus =>
      'Stato dell\'offerta inaspettato ricevuto dal server.';
}

// Path: maker.conflict.actions
class _TranslationsMakerConflictActionsIt
    extends TranslationsMakerConflictActionsEn {
  _TranslationsMakerConflictActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get back => 'Torna alla Home';
  @override
  String get confirmPayment =>
      'Ho sbagliato, conferma che il pagamento BLIK è riuscito';
  @override
  String get openDispute => 'Il pagamento BLIK NON è riuscito, APRI DISPUTA';
  @override
  String get submitDispute => 'Invia Disputa';
}

// Path: maker.conflict.disputeDialog
class _TranslationsMakerConflictDisputeDialogIt
    extends TranslationsMakerConflictDisputeDialogEn {
  _TranslationsMakerConflictDisputeDialogIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Aprire una disputa?';
  @override
  String get content =>
      'Aprire una disputa richiede una verifica manuale da parte del coordinatore, che richiederà tempo. Una commissione per disputa sarà addebitata se la disputa sarà risolta contro di te. La fattura hold verrà saldata per evitare che scada. Se la disputa sarà risolta a tuo favore, riceverai un rimborso (meno le commissioni) sul tuo indirizzo Lightning.';
  @override
  String get contentDetailed =>
      'Aprire una disputa richiederà l\'intervento manuale del coordinatore, che richiede tempo e comporta una commissione per disputa.\n\nLa fattura hold verrà saldata immediatamente per evitare che scada prima della risoluzione della disputa.\n\nSe la disputa sarà risolta a tuo favore, l\'importo in satoshi verrà rimborsato sul tuo indirizzo Lightning (meno le commissioni). Assicurati di aver configurato un indirizzo Lightning.';
  @override
  late final _TranslationsMakerConflictDisputeDialogActionsIt actions =
      _TranslationsMakerConflictDisputeDialogActionsIt._(_root);
}

// Path: maker.conflict.feedback
class _TranslationsMakerConflictFeedbackIt
    extends TranslationsMakerConflictFeedbackEn {
  _TranslationsMakerConflictFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get disputeOpenedSuccess =>
      'Disputa aperta con successo. Il coordinatore esaminerà la situazione.';
}

// Path: maker.conflict.errors
class _TranslationsMakerConflictErrorsIt
    extends TranslationsMakerConflictErrorsEn {
  _TranslationsMakerConflictErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String openingDispute({required Object error}) =>
      'Errore nell\'apertura della disputa: ${error}';
}

// Path: taker.submitBlik.actions
class _TranslationsTakerSubmitBlikActionsIt
    extends TranslationsTakerSubmitBlikActionsEn {
  _TranslationsTakerSubmitBlikActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get submit => 'Invia BLIK';
}

// Path: taker.submitBlik.feedback
class _TranslationsTakerSubmitBlikFeedbackIt
    extends TranslationsTakerSubmitBlikFeedbackEn {
  _TranslationsTakerSubmitBlikFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get pasted => 'Codice BLIK incollato.';
}

// Path: taker.submitBlik.validation
class _TranslationsTakerSubmitBlikValidationIt
    extends TranslationsTakerSubmitBlikValidationEn {
  _TranslationsTakerSubmitBlikValidationIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get invalidFormat => 'Inserisci un codice BLIK valido a 6 cifre.';
}

// Path: taker.submitBlik.errors
class _TranslationsTakerSubmitBlikErrorsIt
    extends TranslationsTakerSubmitBlikErrorsEn {
  _TranslationsTakerSubmitBlikErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String submitting({required Object details}) =>
      'Errore nell\'invio del codice BLIK: ${details}';
  @override
  String get clipboardInvalid =>
      'Gli appunti non contengono un codice BLIK valido a 6 cifre.';
  @override
  String get stateChanged => 'Errore: Lo stato dell\'offerta è cambiato.';
  @override
  String get stateNotValid =>
      'Errore: Lo stato dell\'offerta non è più valido.';
  @override
  String fetchedIdMismatch({
    required Object fetchedId,
    required Object initialId,
  }) =>
      'L\'ID dell\'offerta attiva recuperata (${fetchedId}) non corrisponde all\'ID iniziale (${initialId}). Mismatch di stato?';
  @override
  String get paymentHashMissing =>
      'Hash di pagamento dell\'offerta mancante dopo il recupero.';
}

// Path: taker.submitBlik.details
class _TranslationsTakerSubmitBlikDetailsIt
    extends TranslationsTakerSubmitBlikDetailsEn {
  _TranslationsTakerSubmitBlikDetailsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get requestedAmount => 'Importo BLIK richiesto';
  @override
  String get exchangeRate => 'Tasso di Cambio';
  @override
  String get takerFee => 'Commissione taker';
  @override
  String get status => 'Stato';
  @override
  String get youllReceive => 'Riceverai';
}

// Path: taker.waitConfirmation.takerCharged
class _TranslationsTakerWaitConfirmationTakerChargedIt
    extends TranslationsTakerWaitConfirmationTakerChargedEn {
  _TranslationsTakerWaitConfirmationTakerChargedIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Hai segnalato che il BLIK è stato addebitato';
  @override
  String get message =>
      'Il maker ha 60 minuti per confermare il pagamento o contestarlo. Se non fa nulla, il pagamento verrà confermato automaticamente e riceverai i bitcoin.';
}

// Path: taker.waitConfirmation.expiredActions
class _TranslationsTakerWaitConfirmationExpiredActionsIt
    extends TranslationsTakerWaitConfirmationExpiredActionsEn {
  _TranslationsTakerWaitConfirmationExpiredActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get reportConflict =>
      'Il BLIK è stato addebitato sul mio conto bancario';
  @override
  String get renewReservation => 'Riprova con un nuovo codice BLIK';
  @override
  String get cancelReservation => 'Annulla prenotazione';
}

// Path: taker.waitConfirmation.feedback
class _TranslationsTakerWaitConfirmationFeedbackIt
    extends TranslationsTakerWaitConfirmationFeedbackEn {
  _TranslationsTakerWaitConfirmationFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get makerConfirmed => 'Il Maker ha confermato il pagamento.';
  @override
  String get paymentSuccessful =>
      'Pagamento riuscito! Riceverai i fondi a breve.';
  @override
  String get conflictReported =>
      'Conflitto segnalato. Il coordinatore esaminerà la situazione.';
}

// Path: taker.waitConfirmation.errors
class _TranslationsTakerWaitConfirmationErrorsIt
    extends TranslationsTakerWaitConfirmationErrorsEn {
  _TranslationsTakerWaitConfirmationErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get invalidOfferStateReceived =>
      'Ricevuta un\'offerta con stato non valido per questa schermata. Ripristino in corso.';
  @override
  String reportingConflict({required Object details}) =>
      'Errore nella segnalazione del conflitto: ${details}';
}

// Path: taker.paymentProcess.states
class _TranslationsTakerPaymentProcessStatesIt
    extends TranslationsTakerPaymentProcessStatesEn {
  _TranslationsTakerPaymentProcessStatesIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get preparing => 'Preparazione invio pagamento...';
  @override
  String get sending => 'Invio pagamento...';
  @override
  String get received => 'Pagamento ricevuto!';
  @override
  String get failed => 'Pagamento fallito';
  @override
  String get waitingUpdate => 'In attesa dell\'aggiornamento dell\'offerta...';
}

// Path: taker.paymentProcess.steps
class _TranslationsTakerPaymentProcessStepsIt
    extends TranslationsTakerPaymentProcessStepsEn {
  _TranslationsTakerPaymentProcessStepsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get makerConfirmedBlik => 'Il Maker ha confermato il pagamento BLIK';
  @override
  String get makerInvoiceSettled => 'Fattura hold del Maker saldata';
  @override
  String get payingTakerInvoice => 'Pagamento della tua fattura Lightning';
  @override
  String get takerInvoicePaid => 'La tua fattura Lightning è stata pagata';
  @override
  String get takerPaymentFailed => 'Pagamento alla tua fattura fallito';
}

// Path: taker.paymentProcess.errors
class _TranslationsTakerPaymentProcessErrorsIt
    extends TranslationsTakerPaymentProcessErrorsEn {
  _TranslationsTakerPaymentProcessErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String sending({required Object details}) =>
      'Errore nell\'invio del pagamento: ${details}';
  @override
  String get notConfirmed => 'Offerta non confermata dal Maker.';
  @override
  String get expired => 'Offerta scaduta.';
  @override
  String get cancelled => 'Offerta annullata.';
  @override
  String get paymentFailed => 'Pagamento dell\'offerta fallito.';
  @override
  String get unknown => 'Errore offerta sconosciuto.';
  @override
  String get takerPaymentFailed =>
      'Il pagamento alla tua fattura Lightning è fallito.';
  @override
  String get noPublicKey =>
      'Errore: Impossibile recuperare la tua chiave pubblica.';
  @override
  String get loadingPublicKey => 'Errore nel caricamento dei tuoi dati';
  @override
  String get missingPaymentHash => 'Errore: Dettagli di pagamento mancanti.';
}

// Path: taker.paymentProcess.loading
class _TranslationsTakerPaymentProcessLoadingIt
    extends TranslationsTakerPaymentProcessLoadingEn {
  _TranslationsTakerPaymentProcessLoadingIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get publicKey => 'Caricamento dei tuoi dati...';
}

// Path: taker.paymentProcess.actions
class _TranslationsTakerPaymentProcessActionsIt
    extends TranslationsTakerPaymentProcessActionsEn {
  _TranslationsTakerPaymentProcessActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get goToFailureDetails => 'Riprova con nuova fattura';
}

// Path: taker.paymentFailed.form
class _TranslationsTakerPaymentFailedFormIt
    extends TranslationsTakerPaymentFailedFormEn {
  _TranslationsTakerPaymentFailedFormIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get newInvoiceLabel => 'Nuova fattura Lightning';
  @override
  String get newInvoiceHint => 'Inserisci la tua fattura BOLT11';
}

// Path: taker.paymentFailed.actions
class _TranslationsTakerPaymentFailedActionsIt
    extends TranslationsTakerPaymentFailedActionsEn {
  _TranslationsTakerPaymentFailedActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get retryPayment => 'Invia Nuova Fattura';
}

// Path: taker.paymentFailed.errors
class _TranslationsTakerPaymentFailedErrorsIt
    extends TranslationsTakerPaymentFailedErrorsEn {
  _TranslationsTakerPaymentFailedErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get enterValidInvoice => 'Inserisci una fattura valida';
  @override
  String updatingInvoice({required Object details}) =>
      'Errore nell\'aggiornamento della fattura: ${details}';
  @override
  String get paymentRetryFailed =>
      'Nuovo tentativo di pagamento fallito. Controlla la fattura o riprova più tardi.';
  @override
  String get takerPublicKeyNotFound => 'Chiave pubblica del taker non trovata.';
}

// Path: taker.paymentFailed.loading
class _TranslationsTakerPaymentFailedLoadingIt
    extends TranslationsTakerPaymentFailedLoadingEn {
  _TranslationsTakerPaymentFailedLoadingIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get processingPayment =>
      'Elaborazione del nuovo tentativo di pagamento...';
}

// Path: taker.paymentFailed.success
class _TranslationsTakerPaymentFailedSuccessIt
    extends TranslationsTakerPaymentFailedSuccessEn {
  _TranslationsTakerPaymentFailedSuccessIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Pagamento Riuscito';
  @override
  String get message => 'Il tuo pagamento è stato elaborato con successo.';
}

// Path: taker.paymentSuccess.actions
class _TranslationsTakerPaymentSuccessActionsIt
    extends TranslationsTakerPaymentSuccessActionsEn {
  _TranslationsTakerPaymentSuccessActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get goHome => 'Vai alla home';
}

// Path: taker.invalidBlik.actions
class _TranslationsTakerInvalidBlikActionsIt
    extends TranslationsTakerInvalidBlikActionsEn {
  _TranslationsTakerInvalidBlikActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get retry => 'Invia nuovo codice BLIK';
  @override
  String get cancelReservation => 'Annulla Transazione';
  @override
  String get reportConflict => 'Avvia Disputa';
  @override
  String get returnHome => 'Torna alla home';
}

// Path: taker.invalidBlik.feedback
class _TranslationsTakerInvalidBlikFeedbackIt
    extends TranslationsTakerInvalidBlikFeedbackEn {
  _TranslationsTakerInvalidBlikFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get conflictReportedSuccess =>
      'Conflitto segnalato. Il coordinatore lo esaminerà.';
}

// Path: taker.invalidBlik.errors
class _TranslationsTakerInvalidBlikErrorsIt
    extends TranslationsTakerInvalidBlikErrorsEn {
  _TranslationsTakerInvalidBlikErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get reservationFailed => 'Impossibile riservare nuovamente l\'offerta';
  @override
  String conflictReport({required Object details}) =>
      'Errore nella segnalazione del conflitto: ${details}';
}

// Path: taker.conflict.actions
class _TranslationsTakerConflictActionsIt
    extends TranslationsTakerConflictActionsEn {
  _TranslationsTakerConflictActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get back => 'Torna alla Home';
}

// Path: taker.conflict.feedback
class _TranslationsTakerConflictFeedbackIt
    extends TranslationsTakerConflictFeedbackEn {
  _TranslationsTakerConflictFeedbackIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get reported => 'Conflitto segnalato. Il coordinatore esaminerà.';
}

// Path: taker.conflict.errors
class _TranslationsTakerConflictErrorsIt
    extends TranslationsTakerConflictErrorsEn {
  _TranslationsTakerConflictErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String reporting({required Object details}) =>
      'Errore nella segnalazione del conflitto: ${details}';
}

// Path: home.statistics.errors
class _TranslationsHomeStatisticsErrorsIt
    extends TranslationsHomeStatisticsErrorsEn {
  _TranslationsHomeStatisticsErrorsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String loading({required Object error}) =>
      'Errore nel caricamento delle statistiche: ${error}';
}

// Path: maker.conflict.disputeDialog.actions
class _TranslationsMakerConflictDisputeDialogActionsIt
    extends TranslationsMakerConflictDisputeDialogActionsEn {
  _TranslationsMakerConflictDisputeDialogActionsIt._(TranslationsIt root)
    : this._root = root,
      super.internal(root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get confirm => 'Apri Disputa';
  @override
  String get cancel => 'Annulla';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsIt {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'app.title':
        return 'BitBlik';
      case 'app.greeting':
        return 'Ciao!';
      case 'app.changelog':
        return 'Registro modifiche';
      case 'common.buttons.cancel':
        return 'Annulla';
      case 'common.buttons.save':
        return 'Salva';
      case 'common.buttons.done':
        return 'Fatto';
      case 'common.buttons.retry':
        return 'Riprova';
      case 'common.buttons.goHome':
        return 'Vai alla Home';
      case 'common.buttons.saveAndContinue':
        return 'Salva e Continua';
      case 'common.buttons.reveal':
        return 'Mostra';
      case 'common.buttons.hide':
        return 'Nascondi';
      case 'common.buttons.copy':
        return 'Copia';
      case 'common.buttons.close':
        return 'Chiudi';
      case 'common.buttons.restore':
        return 'Ripristina';
      case 'common.buttons.faq':
        return 'FAQ';
      case 'common.labels.amount':
        return 'Importo (PLN)';
      case 'common.labels.status':
        return ({required Object status}) => 'Stato: ${status}';
      case 'common.labels.role':
        return ({required Object role}) => 'Ruolo: ${role}';
      case 'common.notifications.success':
        return 'Successo';
      case 'common.notifications.error':
        return 'Errore';
      case 'common.notifications.loading':
        return 'Caricamento...';
      case 'common.clipboard.copyToClipboard':
        return 'Copia negli appunti';
      case 'common.clipboard.pasteFromClipboard':
        return 'Incolla dagli appunti';
      case 'common.clipboard.copied':
        return 'Copiato negli appunti!';
      case 'common.actions.cancelAndReturnToOffers':
        return 'Annulla e torna alle offerte';
      case 'common.actions.cancelAndReturnHome':
        return 'Annulla e torna alla Home';
      case 'lightningAddress.labels.address':
        return 'Indirizzo Lightning (LNURL)';
      case 'lightningAddress.labels.hint':
        return 'utente@dominio.com';
      case 'lightningAddress.labels.short':
        return ({required Object address}) => 'Indirizzo Lightning: ${address}';
      case 'lightningAddress.labels.receivingAddress':
        return 'Il tuo indirizzo di ricezione:';
      case 'lightningAddress.prompts.enter':
        return 'Inserisci il tuo indirizzo Lightning per continuare';
      case 'lightningAddress.prompts.edit':
        return 'Modifica';
      case 'lightningAddress.prompts.invalid':
        return 'Inserisci un indirizzo Lightning valido';
      case 'lightningAddress.prompts.required':
        return 'L\'indirizzo Lightning è obbligatorio.';
      case 'lightningAddress.prompts.enterToTakeOffer':
        return 'Devi impostare un indirizzo Lightning per accettare un\'offerta.';
      case 'lightningAddress.prompts.missing':
        return 'Indirizzo Lightning mancante. Aggiungine uno per poter accettare offerte.';
      case 'lightningAddress.prompts.add':
        return 'Aggiungi';
      case 'lightningAddress.prompts.delete':
        return 'Elimina';
      case 'lightningAddress.prompts.confirmDelete':
        return 'Sei sicuro di voler eliminare il tuo indirizzo Lightning?';
      case 'lightningAddress.prompts.howToGet':
        return 'Non hai ancora un indirizzo Lightning? Scopri come ottenerne uno!';
      case 'lightningAddress.prompts.learnMore':
        return 'Scopri di più sull\'indirizzo Lightning';
      case 'lightningAddress.feedback.saved':
        return 'Indirizzo Lightning salvato!';
      case 'lightningAddress.feedback.updated':
        return 'Indirizzo Lightning aggiornato!';
      case 'lightningAddress.feedback.valid':
        return 'Indirizzo Lightning valido';
      case 'lightningAddress.errors.saving':
        return ({required Object details}) =>
            'Errore nel salvataggio dell\'indirizzo: ${details}';
      case 'lightningAddress.errors.loading':
        return ({required Object details}) =>
            'Errore nel caricamento dell\'indirizzo Lightning: ${details}';
      case 'offers.details.yourOffer':
        return 'La tua offerta:';
      case 'offers.details.selectedOffer':
        return 'Offerta:';
      case 'offers.details.activeOffer':
        return 'Hai un\'offerta attiva:';
      case 'offers.details.finishedOffers':
        return 'Offerte completate';
      case 'offers.details.finishedOffersWithTime':
        return 'Offerte completate (ultime 24h):';
      case 'offers.details.noAvailable':
        return 'Nessuna offerta disponibile.';
      case 'offers.details.noAvailableTip':
        return 'Suggerimento: condividi Bitblik nella tua community e tra i tuoi amici per aumentare gli ordini su Bitblik.';
      case 'offers.details.noSuccessfulTrades':
        return 'Nessuna transazione completata.';
      case 'offers.details.loadingDetails':
        return 'Caricamento dettagli offerta...';
      case 'offers.details.amount':
        return ({required Object amount}) => 'Importo: ${amount} satoshi';
      case 'offers.details.amountWithCurrency':
        return ({required Object amount, required Object currency}) =>
            '${amount} ${currency}';
      case 'offers.details.makerFee':
        return ({required Object fee}) => 'Commissione: ${fee} sats';
      case 'offers.details.takerFee':
        return ({required Object fee}) => 'Commissione: ${fee} sats';
      case 'offers.details.subtitle':
        return ({
          required Object sats,
          required Object fee,
          required Object status,
        }) => '${sats} + ${fee} (commissione) satoshi\nStato: ${status}';
      case 'offers.details.subtitleWithDate':
        return ({
          required Object sats,
          required Object fee,
          required Object status,
          required Object date,
        }) =>
            '${sats} + ${fee} (commissione) satoshi\nStato: ${status}\nPagato: ${date}';
      case 'offers.details.activeSubtitle':
        return ({required Object status, required Object amount}) =>
            'Stato: ${status}\nImporto: ${amount} satoshi';
      case 'offers.details.id':
        return ({required Object id}) => 'ID Offerta: ${id}...';
      case 'offers.details.created':
        return ({required Object dateTime}) => 'Creata: ${dateTime}';
      case 'offers.details.takenAfter':
        return ({required Object duration}) => 'Accettata dopo: ${duration}';
      case 'offers.details.paidAfter':
        return ({required Object duration}) => 'Pagata dopo: ${duration}';
      case 'offers.details.exchangeRate':
        return 'Tasso di Cambio';
      case 'offers.details.amountLabel':
        return 'Importo';
      case 'offers.details.makerFeeLabel':
        return 'Commissione maker';
      case 'offers.details.takerFeeLabel':
        return 'Commissione taker';
      case 'offers.details.feeLabel':
        return 'Commissione';
      case 'offers.details.statusLabel':
        return 'Stato';
      case 'offers.details.youllReceive':
        return 'Riceverai';
      case 'offers.details.coordinator':
        return 'Coordinatore';
      case 'offers.tooltips.takerFeeInfo':
        return ({required Object feePercent}) =>
            'Il coordinatore applica una commissione taker del ${feePercent}%. Questo include le commissioni di routing Lightning ed è detratto dall\'importo che ricevi';
      case 'offers.actions.take':
        return 'ACCETTA';
      case 'offers.actions.takeOffer':
        return 'Accetta Offerta';
      case 'offers.actions.resume':
        return 'INSERISCI BLIK';
      case 'offers.actions.cancel':
        return 'Annulla offerta';
      case 'offers.actions.view':
        return 'Visualizza dettagli';
      case 'offers.status.created':
        return 'Creata';
      case 'offers.status.funded':
        return 'Finanziata';
      case 'offers.status.expired':
        return 'Scaduta';
      case 'offers.status.cancelled':
        return 'Annullata';
      case 'offers.status.reserved':
        return 'Riservata';
      case 'offers.status.blikReceived':
        return 'BLIK Inviato';
      case 'offers.status.blikSentToMaker':
        return 'BLIK Ricevuto';
      case 'offers.status.invalidBlik':
        return 'BLIK Non Valido';
      case 'offers.status.conflict':
        return 'Conflitto';
      case 'offers.status.dispute':
        return 'Disputa';
      case 'offers.status.makerConfirmed':
        return 'Confermata';
      case 'offers.status.settled':
        return 'Conclusa';
      case 'offers.status.payingTaker':
        return 'Pagamento Taker';
      case 'offers.status.takerPaymentFailed':
        return 'Pagamento Fallito';
      case 'offers.status.takerPaid':
        return 'Taker Pagato';
      case 'offers.statusMessages.reserved':
        return 'Offerta riservata dal Taker!';
      case 'offers.statusMessages.cancelled':
        return 'Offerta annullata con successo.';
      case 'offers.statusMessages.cancelledOrExpired':
        return 'L\'offerta è stata annullata o è scaduta.';
      case 'offers.statusMessages.noLongerAvailable':
        return ({required Object status}) =>
            'L\'offerta non è più disponibile (Stato: ${status}).';
      case 'offers.progress.waitingForTaker':
        return ({required Object time}) => 'In attesa del taker: ${time}';
      case 'offers.progress.reserved':
        return ({required Object seconds}) =>
            'Riservata: ${seconds} s rimanenti';
      case 'offers.progress.confirming':
        return ({required Object seconds}) =>
            'Conferma in corso: ${seconds} s rimanenti';
      case 'offers.errors.loading':
        return ({required Object details}) =>
            'Errore nel caricamento delle offerte: ${details}';
      case 'offers.errors.loadingDetails':
        return ({required Object details}) =>
            'Errore nel caricamento dei dettagli dell\'offerta: ${details}';
      case 'offers.errors.detailsMissing':
        return 'Errore: Dettagli dell\'offerta mancanti o non validi.';
      case 'offers.errors.detailsNotLoaded':
        return 'Impossibile caricare i dettagli dell\'offerta.';
      case 'offers.errors.notFound':
        return 'Errore: Offerta non trovata.';
      case 'offers.errors.unexpectedState':
        return 'Errore: L\'offerta è in uno stato imprevisto.';
      case 'offers.errors.unexpectedStateWithStatus':
        return ({required Object status}) =>
            'L\'offerta è in uno stato imprevisto (${status}). Riprova o contatta l\'assistenza.';
      case 'offers.errors.invalidStatus':
        return 'L\'offerta ha uno stato non valido.';
      case 'offers.errors.couldNotIdentify':
        return 'Errore: Impossibile identificare l\'offerta da annullare.';
      case 'offers.errors.cannotBeCancelled':
        return ({required Object status}) =>
            'L\'offerta non può essere annullata nello stato attuale (${status}).';
      case 'offers.errors.failedToCancel':
        return ({required Object details}) =>
            'Impossibile annullare l\'offerta: ${details}';
      case 'offers.errors.activeDetailsLost':
        return 'Errore: Dettagli dell\'offerta attiva persi.';
      case 'offers.errors.checkingActive':
        return ({required Object details}) =>
            'Errore nel controllo delle offerte attive: ${details}';
      case 'offers.errors.loadingFinished':
        return ({required Object details}) =>
            'Errore nel caricamento delle offerte completate: ${details}';
      case 'offers.errors.cannotResume':
        return ({required Object status}) =>
            'Impossibile riprendere l\'offerta nello stato: ${status}';
      case 'offers.errors.cannotResumeTaker':
        return ({required Object status}) =>
            'Impossibile riprendere l\'offerta taker nello stato: ${status}';
      case 'offers.errors.resuming':
        return ({required Object details}) =>
            'Errore nel riprendere l\'offerta: ${details}';
      case 'offers.errors.makerPublicKeyNotFound':
        return 'Chiave pubblica del maker non trovata';
      case 'offers.errors.takerPublicKeyNotFound':
        return 'Chiave pubblica del taker non trovata.';
      case 'offers.success.title':
        return 'Offerta completata';
      case 'offers.success.headline':
        return 'Pagamento confermato!';
      case 'offers.success.subtitle':
        return 'Il taker verrà pagato ora.';
      case 'offers.success.detailsTitle':
        return 'Dettagli offerta:';
      case 'offers.success.duration':
        return ({required Object time}) =>
            'L\'offerta è stata completata in ${time}.';
      case 'reservations.actions.cancel':
        return 'Annulla prenotazione';
      case 'reservations.feedback.cancelled':
        return 'Prenotazione annullata.';
      case 'reservations.errors.cancelling':
        return ({required Object error}) =>
            'Impossibile annullare la prenotazione: ${error}';
      case 'reservations.errors.failedToReserve':
        return ({required Object details}) =>
            'Impossibile riservare l\'offerta: ${details}';
      case 'reservations.errors.failedNoTimestamp':
        return 'Impossibile riservare l\'offerta (timestamp mancante).';
      case 'reservations.errors.timestampMissing':
        return 'Timestamp della prenotazione offerta mancante.';
      case 'reservations.errors.notReserved':
        return ({required Object status}) =>
            'L\'offerta non è più nello stato riservato (${status}).';
      case 'exchange.labels.enterAmount':
        return 'Inserisci l\'importo (PLN) da pagare:';
      case 'exchange.labels.equivalent':
        return ({required Object sats}) => '≈ ${sats} satoshi';
      case 'exchange.labels.rate':
        return ({required Object rate}) => 'Tasso di cambio ≈ ${rate} PLN/BTC';
      case 'exchange.feedback.fetching':
        return 'Recupero tasso di cambio...';
      case 'exchange.errors.fetchingRate':
        return 'Impossibile recuperare il tasso di cambio.';
      case 'exchange.errors.invalidFormat':
        return 'Formato numero non valido';
      case 'exchange.errors.mustBePositive':
        return 'L\'importo deve essere positivo';
      case 'exchange.errors.invalidFeePercentage':
        return 'Percentuale commissione non valida';
      case 'exchange.errors.tooLowFiat':
        return ({required Object minAmount, required Object currency}) =>
            'L\'importo è troppo basso. Il minimo è ${minAmount} ${currency}.';
      case 'exchange.errors.tooHighFiat':
        return ({required Object maxAmount, required Object currency}) =>
            'L\'importo è troppo alto. Il massimo è ${maxAmount} ${currency}.';
      case 'coordinator.title':
        return 'Coordinatori';
      case 'coordinator.info.fee':
        return 'commissione';
      case 'coordinator.info.rangeDisplay':
        return ({
          required Object minAmount,
          required Object maxAmount,
          required Object currency,
        }) => 'Importo: ${minAmount}-${maxAmount} ${currency}';
      case 'coordinator.info.feeDisplay':
        return ({required Object fee}) => '${fee}% commissione';
      case 'coordinator.selector.loading':
        return 'Caricamento Coordinatori...';
      case 'coordinator.selector.errorLoading':
        return 'Errore nel Caricamento Coordinatori';
      case 'coordinator.selector.choose':
        return 'Scegli Coordinatore';
      case 'coordinator.selector.viewNostrProfile':
        return 'Visualizza profilo Nostr';
      case 'coordinator.selector.unresponsive':
        return 'Questo coordinatore non risponde';
      case 'coordinator.selector.waitingResponse':
        return 'In attesa della risposta del coordinatore';
      case 'coordinator.selector.termsAccept':
        return 'Accetto i ';
      case 'coordinator.selector.termsOfUsage':
        return 'Termini di utilizzo';
      case 'coordinator.dialog.makerFee':
        return 'Commissione Maker';
      case 'coordinator.dialog.takerFee':
        return 'Commissione Taker';
      case 'coordinator.dialog.amountRange':
        return 'Range Importo';
      case 'coordinator.dialog.reservationTime':
        return 'Tempo di Prenotazione';
      case 'coordinator.dialog.currencies':
        return 'Valute';
      case 'coordinator.dialog.viewTerms':
        return 'Visualizza Termini';
      case 'coordinator.management.title':
        return 'Gestione Coordinatori';
      case 'coordinator.management.availableCoordinators':
        return 'Coordinatori Disponibili';
      case 'coordinator.management.noCoordinators':
        return 'Nessun coordinatore trovato.';
      case 'coordinator.management.online':
        return 'Online';
      case 'coordinator.management.unknownOffline':
        return 'Sconosciuto/Offline';
      case 'coordinator.management.openNostrProfile':
        return 'Apri Profilo Nostr';
      case 'coordinator.management.enable':
        return 'Abilita';
      case 'coordinator.management.remove':
        return 'Rimuovi';
      case 'coordinator.management.addCustomWhitelist':
        return 'Aggiungi coordinatore personalizzato';
      case 'coordinator.management.addCustomWhitelistHint':
        return 'npub1...';
      case 'coordinator.management.add':
        return 'Aggiungi';
      case 'coordinator.management.coordinatorBlacklisted':
        return 'Coordinatore inserito in blacklist';
      case 'coordinator.management.coordinatorUnblacklisted':
        return 'Coordinatore rimosso dalla blacklist';
      case 'coordinator.management.coordinatorAdded':
        return 'Coordinatore aggiunto alla whitelist personalizzata';
      case 'coordinator.management.coordinatorRemoved':
        return 'Coordinatore rimosso dalla whitelist personalizzata';
      case 'coordinator.management.pleaseEnterNpub':
        return 'Inserisci un npub';
      case 'coordinator.management.error':
        return 'Errore';
      case 'maker.roleSelection.button':
        return 'PAGA con Lightning';
      case 'maker.amountForm.progress.step1':
        return '1. Crea Offerta';
      case 'maker.amountForm.progress.step2':
        return '2. Attendi Taker';
      case 'maker.amountForm.progress.step3':
        return '3. Usa BLIK';
      case 'maker.amountForm.labels.coordinator':
        return 'Coordinatore';
      case 'maker.amountForm.labels.exchangeRate':
        return 'Tasso di Cambio';
      case 'maker.amountForm.labels.fee':
        return 'Commissione';
      case 'maker.amountForm.labels.satoshisToPay':
        return 'Importo da Pagare';
      case 'maker.amountForm.labels.enterAmount':
        return 'Inserisci importo';
      case 'maker.amountForm.labels.tapToSelect':
        return 'Tocca per selezionare';
      case 'maker.amountForm.actions.generateInvoice':
        return 'Genera Fattura';
      case 'maker.amountForm.tooltips.feeInfo':
        return ({required Object feePercent}) =>
            'Il coordinatore applica una commissione maker del ${feePercent}%. Questa commissione viene detratta dal tuo pagamento Lightning.';
      case 'maker.amountForm.tooltips.payInfo':
        return 'Questo calcolo si basa sui tassi di cambio recuperati dal client. Il coordinatore calcolerà l\'importo esatto, e l\'importo della fattura sarà quello finale e definitivo da pagare.';
      case 'maker.amountForm.errors.initiating':
        return ({required Object details}) =>
            'Errore nell\'avvio dell\'offerta: ${details}';
      case 'maker.amountForm.errors.publicKeyNotLoaded':
        return 'Errore: Chiave pubblica non ancora caricata.';
      case 'maker.payInvoice.title':
        return 'Paga questa fattura Hold:';
      case 'maker.payInvoice.actions.copy':
        return 'Copia Fattura';
      case 'maker.payInvoice.actions.payInWallet':
        return 'Apri nel Wallet Esterno';
      case 'maker.payInvoice.actions.connectWallet':
        return 'Connetti Wallet';
      case 'maker.payInvoice.actions.payWithNwc':
        return 'Paga';
      case 'maker.payInvoice.actions.paying':
        return 'Pagamento in corso...';
      case 'maker.payInvoice.feedback.copied':
        return 'Fattura copiata negli appunti!';
      case 'maker.payInvoice.feedback.waitingConfirmation':
        return 'In attesa della conferma del pagamento...';
      case 'maker.payInvoice.feedback.nwcConnected':
        return 'Wallet NWC connesso!';
      case 'maker.payInvoice.feedback.nwcPaymentSuccess':
        return 'Pagamento riuscito!';
      case 'maker.payInvoice.errors.couldNotOpenApp':
        return 'Impossibile aprire l\'app Lightning per la fattura.';
      case 'maker.payInvoice.errors.openingApp':
        return ({required Object details}) =>
            'Errore nell\'apertura dell\'app Lightning: ${details}';
      case 'maker.payInvoice.errors.publicKeyNotAvailable':
        return 'La chiave pubblica non è disponibile.';
      case 'maker.payInvoice.errors.couldNotFetchActive':
        return 'Impossibile recuperare i dettagli dell\'offerta attiva. Potrebbe essere scaduta.';
      case 'maker.payInvoice.errors.nwcPaymentFailed':
        return ({required Object details}) => 'Pagamento fallito: ${details}';
      case 'maker.payInvoice.errors.nwcNotConnected':
        return 'Wallet NWC non connesso';
      case 'maker.payInvoice.errors.insufficientBalance':
        return ({required Object required, required Object available}) =>
            'Saldo insufficiente. Necessari ${required} sats, disponibili ${available} sats';
      case 'maker.waitTaker.message':
        return 'In attesa che un Taker riservi la tua offerta...';
      case 'maker.waitTaker.progressLabel':
        return ({required Object time}) => 'In attesa del taker: ${time}';
      case 'maker.waitTaker.errorActiveOfferDetailsLost':
        return 'Errore: Dettagli dell\'offerta attiva persi.';
      case 'maker.waitTaker.errorFailedToRetrieveBlik':
        return 'Errore: Impossibile recuperare il codice BLIK.';
      case 'maker.waitTaker.errorRetrievingBlik':
        return ({required Object details}) =>
            'Errore nel recupero del codice BLIK: ${details}';
      case 'maker.waitTaker.offerNoLongerAvailable':
        return ({required Object status}) =>
            'L\'offerta non è più disponibile (Stato: ${status}).';
      case 'maker.waitTaker.errorCouldNotIdentifyOffer':
        return 'Errore: Impossibile identificare l\'offerta da annullare.';
      case 'maker.waitTaker.offerCannotBeCancelled':
        return ({required Object status}) =>
            'L\'offerta non può essere annullata nello stato attuale (${status}).';
      case 'maker.waitTaker.offerCancelledSuccessfully':
        return 'Offerta annullata con successo.';
      case 'maker.waitTaker.failedToCancelOffer':
        return ({required Object details}) =>
            'Impossibile annullare l\'offerta: ${details}';
      case 'maker.waitForBlik.title':
        return 'In attesa di BLIK';
      case 'maker.waitForBlik.messageInfo':
        return 'Il Taker ha riservato l\'offerta!';
      case 'maker.waitForBlik.messageWaiting':
        return 'In attesa del codice BLIK...';
      case 'maker.waitForBlik.progressLabel':
        return ({required Object seconds}) =>
            'Riservata: ${seconds} s rimanenti';
      case 'maker.confirmPayment.title':
        return 'Codice BLIK ricevuto!';
      case 'maker.confirmPayment.retrieving':
        return 'Recupero codice BLIK...';
      case 'maker.confirmPayment.instructions':
        return 'Inserisci questo codice nel terminale di pagamento. Quando il Taker conferma nella sua app bancaria e il pagamento va a buon fine, premi Conferma qui sotto.';
      case 'maker.confirmPayment.instruction1':
        return 'Inserisci il codice nella richiesta di pagamento BLIK.';
      case 'maker.confirmPayment.instruction2':
        return 'Attendi che il Taker confermi il pagamento nella sua app.';
      case 'maker.confirmPayment.instruction3':
        return 'Quando il pagamento va a buon fine, premi Conferma qui sotto:';
      case 'maker.confirmPayment.takerChargedWarning':
        return 'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto bancario. Se lo contrassegni come non valido, si creerà un conflitto.';
      case 'maker.confirmPayment.expiredTitle':
        return 'Codice BLIK Scaduto';
      case 'maker.confirmPayment.expiredWarning':
        return 'Il codice BLIK è scaduto. Devi confermare manualmente lo stato del pagamento:';
      case 'maker.confirmPayment.expiredInstruction1':
        return 'Se il pagamento BLIK è andato a buon fine e hai completato l\'acquisto, clicca "Conferma pagamento riuscito" qui sotto.';
      case 'maker.confirmPayment.expiredInstruction2':
        return 'Se il pagamento BLIK è fallito o non è stato completato, clicca "Codice BLIK Non Valido" qui sotto.';
      case 'maker.confirmPayment.actions.confirm':
        return 'Conferma pagamento riuscito';
      case 'maker.confirmPayment.actions.markInvalid':
        return 'Codice BLIK Non Valido';
      case 'maker.confirmPayment.actions.copyBlik':
        return 'Copia BLIK';
      case 'maker.confirmPayment.confirmDialog.title':
        return 'Confermare il Pagamento?';
      case 'maker.confirmPayment.confirmDialog.content':
        return 'Questa azione è irreversibile. Dopo la conferma:\n\n• Il Taker riceverà i fondi immediatamente\n• Il coordinatore non potrà contestare i fondi\n• Non puoi annullare questa azione\n\nConferma solo se il pagamento BLIK è andato a buon fine.';
      case 'maker.confirmPayment.confirmDialog.cancel':
        return 'Annulla';
      case 'maker.confirmPayment.confirmDialog.confirmButton':
        return 'Sì, Conferma Pagamento';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.title':
        return 'Aprire una Disputa?';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.content':
        return 'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto.\n\nContrassegnarlo come non valido aprirà immediatamente una DISPUTA che richiede l\'intervento del coordinatore.\n\n• Potrebbe essere addebitata una commissione per disputa se il verdetto sarà contro di te\n• La fattura hold verrà saldata immediatamente\n• Sarà necessaria una verifica manuale\n\nProcedi solo se sei certo che il pagamento BLIK NON è andato a buon fine.';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.cancel':
        return 'Annulla';
      case 'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton':
        return 'Sì, Apri Disputa';
      case 'maker.confirmPayment.feedback.confirmed':
        return 'Il Maker ha confermato il pagamento.';
      case 'maker.confirmPayment.feedback.confirmedTakerPaid':
        return 'Pagamento confermato! Il Taker riceverà i fondi.';
      case 'maker.confirmPayment.feedback.progressLabel':
        return ({required Object seconds}) =>
            'Conferma in corso: ${seconds} s rimanenti';
      case 'maker.confirmPayment.errors.failedToRetrieve':
        return 'Errore: Impossibile recuperare il codice BLIK.';
      case 'maker.confirmPayment.errors.retrieving':
        return ({required Object details}) =>
            'Errore nel recupero del codice BLIK: ${details}';
      case 'maker.confirmPayment.errors.missingHashOrKey':
        return 'Errore: Hash di pagamento o chiave pubblica mancante.';
      case 'maker.confirmPayment.errors.incorrectState':
        return ({required Object status}) =>
            'L\'offerta non è nello stato corretto per la conferma (Stato: ${status})';
      case 'maker.confirmPayment.errors.confirming':
        return ({required Object details}) =>
            'Errore nella conferma del pagamento: ${details}';
      case 'maker.confirmPayment.errors.invalidState':
        return 'Errore: Stato dell\'offerta non valido ricevuto.';
      case 'maker.confirmPayment.errors.internalIncomplete':
        return 'Errore interno: Dettagli dell\'offerta incompleti.';
      case 'maker.confirmPayment.errors.notAwaitingConfirmation':
        return ({required Object status}) =>
            'L\'offerta non è più in attesa di conferma (Stato: ${status}).';
      case 'maker.confirmPayment.errors.unexpectedStatus':
        return 'Stato dell\'offerta inaspettato ricevuto dal server.';
      case 'maker.invalidBlik.title':
        return 'Codice BLIK Non Valido';
      case 'maker.invalidBlik.info':
        return 'Hai contrassegnato il codice BLIK come non valido. In attesa che il taker fornisca un nuovo codice o avvii una disputa.';
      case 'maker.conflict.title':
        return 'Conflitto Offerta';
      case 'maker.conflict.headline':
        return 'Conflitto Offerta Segnalato';
      case 'maker.conflict.body':
        return 'Hai contrassegnato il codice BLIK come non valido, ma il Taker ha segnalato un conflitto, indicando che ritiene il pagamento andato a buon fine.';
      case 'maker.conflict.instructions':
        return 'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.';
      case 'maker.conflict.actions.back':
        return 'Torna alla Home';
      case 'maker.conflict.actions.confirmPayment':
        return 'Ho sbagliato, conferma che il pagamento BLIK è riuscito';
      case 'maker.conflict.actions.openDispute':
        return 'Il pagamento BLIK NON è riuscito, APRI DISPUTA';
      case 'maker.conflict.actions.submitDispute':
        return 'Invia Disputa';
      case 'maker.conflict.disputeDialog.title':
        return 'Aprire una disputa?';
      case 'maker.conflict.disputeDialog.content':
        return 'Aprire una disputa richiede una verifica manuale da parte del coordinatore, che richiederà tempo. Una commissione per disputa sarà addebitata se la disputa sarà risolta contro di te. La fattura hold verrà saldata per evitare che scada. Se la disputa sarà risolta a tuo favore, riceverai un rimborso (meno le commissioni) sul tuo indirizzo Lightning.';
      case 'maker.conflict.disputeDialog.contentDetailed':
        return 'Aprire una disputa richiederà l\'intervento manuale del coordinatore, che richiede tempo e comporta una commissione per disputa.\n\nLa fattura hold verrà saldata immediatamente per evitare che scada prima della risoluzione della disputa.\n\nSe la disputa sarà risolta a tuo favore, l\'importo in satoshi verrà rimborsato sul tuo indirizzo Lightning (meno le commissioni). Assicurati di aver configurato un indirizzo Lightning.';
      case 'maker.conflict.disputeDialog.actions.confirm':
        return 'Apri Disputa';
      case 'maker.conflict.disputeDialog.actions.cancel':
        return 'Annulla';
      case 'maker.conflict.feedback.disputeOpenedSuccess':
        return 'Disputa aperta con successo. Il coordinatore esaminerà la situazione.';
      case 'maker.conflict.errors.openingDispute':
        return ({required Object error}) =>
            'Errore nell\'apertura della disputa: ${error}';
      case 'maker.success.title':
        return 'Offerta completata';
      case 'maker.success.headline':
        return 'Pagamento confermato!';
      case 'maker.success.subtitle':
        return 'Il Taker verrà ora pagato.';
      case 'maker.success.detailsTitle':
        return 'Dettagli offerta:';
      case 'taker.roleSelection.button':
        return 'VENDI codice BLIK per satoshi';
      case 'taker.progress.step1':
        return 'Invia BLIK';
      case 'taker.progress.step2':
        return 'Conferma BLIK';
      case 'taker.progress.step3':
        return 'Ricevi Pagamento';
      case 'taker.submitBlik.title':
        return 'Inserisci BLIK a 6 cifre';
      case 'taker.submitBlik.label':
        return 'Codice BLIK';
      case 'taker.submitBlik.instruction':
        return 'Inserisci BLIK prima che scada il tempo...';
      case 'taker.submitBlik.timeLimit':
        return ({required Object seconds}) =>
            'Inserisci BLIK entro: ${seconds} s';
      case 'taker.submitBlik.timeExpired':
        return 'Il tempo per inserire il codice BLIK è scaduto.';
      case 'taker.submitBlik.actions.submit':
        return 'Invia BLIK';
      case 'taker.submitBlik.feedback.pasted':
        return 'Codice BLIK incollato.';
      case 'taker.submitBlik.validation.invalidFormat':
        return 'Inserisci un codice BLIK valido a 6 cifre.';
      case 'taker.submitBlik.errors.submitting':
        return ({required Object details}) =>
            'Errore nell\'invio del codice BLIK: ${details}';
      case 'taker.submitBlik.errors.clipboardInvalid':
        return 'Gli appunti non contengono un codice BLIK valido a 6 cifre.';
      case 'taker.submitBlik.errors.stateChanged':
        return 'Errore: Lo stato dell\'offerta è cambiato.';
      case 'taker.submitBlik.errors.stateNotValid':
        return 'Errore: Lo stato dell\'offerta non è più valido.';
      case 'taker.submitBlik.errors.fetchedIdMismatch':
        return ({required Object fetchedId, required Object initialId}) =>
            'L\'ID dell\'offerta attiva recuperata (${fetchedId}) non corrisponde all\'ID iniziale (${initialId}). Mismatch di stato?';
      case 'taker.submitBlik.errors.paymentHashMissing':
        return 'Hash di pagamento dell\'offerta mancante dopo il recupero.';
      case 'taker.submitBlik.details.requestedAmount':
        return 'Importo BLIK richiesto';
      case 'taker.submitBlik.details.exchangeRate':
        return 'Tasso di Cambio';
      case 'taker.submitBlik.details.takerFee':
        return 'Commissione taker';
      case 'taker.submitBlik.details.status':
        return 'Stato';
      case 'taker.submitBlik.details.youllReceive':
        return 'Riceverai';
      case 'taker.waitConfirmation.title':
        return 'In attesa del Maker';
      case 'taker.waitConfirmation.statusLabel':
        return ({required Object status}) => 'Stato offerta: ${status}';
      case 'taker.waitConfirmation.waitingMaker':
        return ({required Object seconds}) =>
            'In attesa della conferma del Maker: ${seconds} s';
      case 'taker.waitConfirmation.waitingMakerConfirmation':
        return ({required Object seconds}) =>
            'In attesa che il Maker confermi che il BLIK è corretto. Tempo rimanente: ${seconds}s';
      case 'taker.waitConfirmation.importantNotice':
        return ({required Object amount, required Object currency}) =>
            'MOLTO IMPORTANTE: Assicurati di accettare solo la conferma BLIK per ${amount} ${currency}';
      case 'taker.waitConfirmation.importantBlikAmountConfirmation':
        return ({required Object amount, required Object currency}) =>
            'MOLTO IMPORTANTE: Nella tua app bancaria, assicurati di confermare un pagamento BLIK per esattamente ${amount} ${currency}.';
      case 'taker.waitConfirmation.instructions':
        return 'Il maker deve ora inserirlo nel terminale di pagamento entro 2 minuti. Dovrai poi accettare il codice BLIK nella tua app bancaria.';
      case 'taker.waitConfirmation.waitingForMakerToReceive':
        return 'In attesa che il maker riceva il tuo codice BLIK...';
      case 'taker.waitConfirmation.makerReceivedBlik':
        return 'Il maker ha ricevuto il tuo codice BLIK.';
      case 'taker.waitConfirmation.timerExpiredMessage':
        return 'Il tempo di scadenza BLIK di 2 minuti è passato. In attesa che il maker confermi o contrassegni il codice come non valido.';
      case 'taker.waitConfirmation.timerExpiredActions':
        return 'Il tempo di scadenza BLIK di 2 minuti è passato ma il maker non ha ricevuto il codice BLIK. Puoi rinviare un nuovo codice BLIK o annullare.';
      case 'taker.waitConfirmation.resendBlikButton':
        return 'Rinvia Nuovo Codice BLIK';
      case 'taker.waitConfirmation.navigatedHome':
        return 'Tornato alla home.';
      case 'taker.waitConfirmation.expiredTitle':
        return 'Codice BLIK Scaduto';
      case 'taker.waitConfirmation.expiredWarning':
        return 'Il maker non ha ricevuto il codice BLIK quindi non ha potuto utilizzarlo.';
      case 'taker.waitConfirmation.expiredSentWarning':
        return 'Il maker non ha ancora confermato il pagamento. Cosa vuoi fare?';
      case 'taker.waitConfirmation.expiredInstruction1':
        return 'Se vuoi riprovare con un nuovo codice BLIK, rinnova la prenotazione.';
      case 'taker.waitConfirmation.expiredInstruction2':
        return 'Se non vuoi più completare questa transazione, annulla la prenotazione.';
      case 'taker.waitConfirmation.expiredInstruction3':
        return 'Se il pagamento BLIK è stato addebitato sul tuo conto bancario, non preoccuparti, i bitcoin sono ancora al sicuro presso il coordinatore.';
      case 'taker.waitConfirmation.takerCharged.title':
        return 'Hai segnalato che il BLIK è stato addebitato';
      case 'taker.waitConfirmation.takerCharged.message':
        return 'Il maker ha 60 minuti per confermare il pagamento o contestarlo. Se non fa nulla, il pagamento verrà confermato automaticamente e riceverai i bitcoin.';
      case 'taker.waitConfirmation.expiredActions.reportConflict':
        return 'Il BLIK è stato addebitato sul mio conto bancario';
      case 'taker.waitConfirmation.expiredActions.renewReservation':
        return 'Riprova con un nuovo codice BLIK';
      case 'taker.waitConfirmation.expiredActions.cancelReservation':
        return 'Annulla prenotazione';
      case 'taker.waitConfirmation.feedback.makerConfirmed':
        return 'Il Maker ha confermato il pagamento.';
      case 'taker.waitConfirmation.feedback.paymentSuccessful':
        return 'Pagamento riuscito! Riceverai i fondi a breve.';
      case 'taker.waitConfirmation.feedback.conflictReported':
        return 'Conflitto segnalato. Il coordinatore esaminerà la situazione.';
      case 'taker.waitConfirmation.errors.invalidOfferStateReceived':
        return 'Ricevuta un\'offerta con stato non valido per questa schermata. Ripristino in corso.';
      case 'taker.waitConfirmation.errors.reportingConflict':
        return ({required Object details}) =>
            'Errore nella segnalazione del conflitto: ${details}';
      case 'taker.paymentProcess.title':
        return 'Processo di Pagamento';
      case 'taker.paymentProcess.waitingForOfferUpdate':
        return 'In attesa dell\'aggiornamento dello stato dell\'offerta...';
      case 'taker.paymentProcess.states.preparing':
        return 'Preparazione invio pagamento...';
      case 'taker.paymentProcess.states.sending':
        return 'Invio pagamento...';
      case 'taker.paymentProcess.states.received':
        return 'Pagamento ricevuto!';
      case 'taker.paymentProcess.states.failed':
        return 'Pagamento fallito';
      case 'taker.paymentProcess.states.waitingUpdate':
        return 'In attesa dell\'aggiornamento dell\'offerta...';
      case 'taker.paymentProcess.steps.makerConfirmedBlik':
        return 'Il Maker ha confermato il pagamento BLIK';
      case 'taker.paymentProcess.steps.makerInvoiceSettled':
        return 'Fattura hold del Maker saldata';
      case 'taker.paymentProcess.steps.payingTakerInvoice':
        return 'Pagamento della tua fattura Lightning';
      case 'taker.paymentProcess.steps.takerInvoicePaid':
        return 'La tua fattura Lightning è stata pagata';
      case 'taker.paymentProcess.steps.takerPaymentFailed':
        return 'Pagamento alla tua fattura fallito';
      case 'taker.paymentProcess.errors.sending':
        return ({required Object details}) =>
            'Errore nell\'invio del pagamento: ${details}';
      case 'taker.paymentProcess.errors.notConfirmed':
        return 'Offerta non confermata dal Maker.';
      case 'taker.paymentProcess.errors.expired':
        return 'Offerta scaduta.';
      case 'taker.paymentProcess.errors.cancelled':
        return 'Offerta annullata.';
      case 'taker.paymentProcess.errors.paymentFailed':
        return 'Pagamento dell\'offerta fallito.';
      case 'taker.paymentProcess.errors.unknown':
        return 'Errore offerta sconosciuto.';
      case 'taker.paymentProcess.errors.takerPaymentFailed':
        return 'Il pagamento alla tua fattura Lightning è fallito.';
      case 'taker.paymentProcess.errors.noPublicKey':
        return 'Errore: Impossibile recuperare la tua chiave pubblica.';
      case 'taker.paymentProcess.errors.loadingPublicKey':
        return 'Errore nel caricamento dei tuoi dati';
      case 'taker.paymentProcess.errors.missingPaymentHash':
        return 'Errore: Dettagli di pagamento mancanti.';
      case 'taker.paymentProcess.loading.publicKey':
        return 'Caricamento dei tuoi dati...';
      case 'taker.paymentProcess.actions.goToFailureDetails':
        return 'Riprova con nuova fattura';
      case 'taker.paymentFailed.title':
        return 'Pagamento Fallito';
      case 'taker.paymentFailed.instructions':
        return ({required Object netAmount}) =>
            'Fornisci una nuova fattura Lightning per ${netAmount} satoshi';
      case 'taker.paymentFailed.form.newInvoiceLabel':
        return 'Nuova fattura Lightning';
      case 'taker.paymentFailed.form.newInvoiceHint':
        return 'Inserisci la tua fattura BOLT11';
      case 'taker.paymentFailed.actions.retryPayment':
        return 'Invia Nuova Fattura';
      case 'taker.paymentFailed.errors.enterValidInvoice':
        return 'Inserisci una fattura valida';
      case 'taker.paymentFailed.errors.updatingInvoice':
        return ({required Object details}) =>
            'Errore nell\'aggiornamento della fattura: ${details}';
      case 'taker.paymentFailed.errors.paymentRetryFailed':
        return 'Nuovo tentativo di pagamento fallito. Controlla la fattura o riprova più tardi.';
      case 'taker.paymentFailed.errors.takerPublicKeyNotFound':
        return 'Chiave pubblica del taker non trovata.';
      case 'taker.paymentFailed.loading.processingPayment':
        return 'Elaborazione del nuovo tentativo di pagamento...';
      case 'taker.paymentFailed.success.title':
        return 'Pagamento Riuscito';
      case 'taker.paymentFailed.success.message':
        return 'Il tuo pagamento è stato elaborato con successo.';
      case 'taker.paymentSuccess.title':
        return 'Pagamento Riuscito';
      case 'taker.paymentSuccess.message':
        return 'Il tuo pagamento è stato elaborato con successo.';
      case 'taker.paymentSuccess.actions.goHome':
        return 'Vai alla home';
      case 'taker.invalidBlik.title':
        return 'Codice BLIK Non Valido';
      case 'taker.invalidBlik.message':
        return 'Il Maker ha Rifiutato il Codice BLIK';
      case 'taker.invalidBlik.explanation':
        return 'Il maker dell\'offerta ha indicato che il codice BLIK fornito non era valido o non ha funzionato.\n\nCosa vuoi fare?';
      case 'taker.invalidBlik.werentCharged':
        return 'Se NON ti è stato addebitato:';
      case 'taker.invalidBlik.wereCharged':
        return 'Se ti è stato addebitato:';
      case 'taker.invalidBlik.actions.retry':
        return 'Invia nuovo codice BLIK';
      case 'taker.invalidBlik.actions.cancelReservation':
        return 'Annulla Transazione';
      case 'taker.invalidBlik.actions.reportConflict':
        return 'Avvia Disputa';
      case 'taker.invalidBlik.actions.returnHome':
        return 'Torna alla home';
      case 'taker.invalidBlik.feedback.conflictReportedSuccess':
        return 'Conflitto segnalato. Il coordinatore lo esaminerà.';
      case 'taker.invalidBlik.errors.reservationFailed':
        return 'Impossibile riservare nuovamente l\'offerta';
      case 'taker.invalidBlik.errors.conflictReport':
        return ({required Object details}) =>
            'Errore nella segnalazione del conflitto: ${details}';
      case 'taker.conflict.title':
        return 'Conflitto Offerta';
      case 'taker.conflict.headline':
        return 'Conflitto Offerta Segnalato';
      case 'taker.conflict.body':
        return 'Il Maker ha contrassegnato il codice BLIK come non valido, ma tu hai segnalato un conflitto, indicando che ritieni il pagamento andato a buon fine.';
      case 'taker.conflict.instructions':
        return 'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.';
      case 'taker.conflict.actions.back':
        return 'Torna alla Home';
      case 'taker.conflict.feedback.reported':
        return 'Conflitto segnalato. Il coordinatore esaminerà.';
      case 'taker.conflict.errors.reporting':
        return ({required Object details}) =>
            'Errore nella segnalazione del conflitto: ${details}';
      case 'blik.instructions.taker':
        return 'Una volta che il Maker inserisce il codice BLIK, dovrai confermare il pagamento nella tua app bancaria. Assicurati che l\'importo sia corretto prima di confermare.';
      case 'home.notifications.title':
        return 'Ricevi notifiche sulle nuove offerte tramite:';
      case 'home.notifications.telegram':
        return 'Telegram';
      case 'home.notifications.simplex':
        return 'SimpleX';
      case 'home.notifications.element':
        return 'Element';
      case 'home.notifications.signal':
        return 'Signal';
      case 'home.statistics.title':
        return 'Offerte Completate';
      case 'home.statistics.lifetimeCompact':
        return ({
          required Object count,
          required Object avgBlikTime,
          required Object avgPaidTime,
        }) =>
            'Totale: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}';
      case 'home.statistics.last7DaysCompact':
        return ({
          required Object count,
          required Object avgBlikTime,
          required Object avgPaidTime,
        }) =>
            'Ultimi 7g: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}';
      case 'home.statistics.last7DaysSingleLine':
        return ({
          required Object count,
          required Object avgBlikTime,
          required Object avgPaidTime,
        }) =>
            'Ultimi 7g: ${count} offerte  |  Media BLIK: ${avgBlikTime}  |  Media Pagato: ${avgPaidTime}';
      case 'home.statistics.errors.loading':
        return ({required Object error}) =>
            'Errore nel caricamento delle statistiche: ${error}';
      case 'nekoInfo.title':
        return 'Cos\'è un Neko?';
      case 'nekoInfo.description':
        return 'Il tuo Neko è la tua identità per usare BitBlik. È composto da una chiave privata e pubblica per garantire una comunicazione crittograficamente sicura con il coordinatore.\n\nPer garantire maggiore anonimato, si consiglia di usare un nuovo Neko per ogni offerta.\n\n⚠️ IMPORTANTE: La tua chiave privata è memorizzata solo sul tuo dispositivo (lato client). È fondamentale fare il backup della tua chiave privata, poiché perderla potrebbe impedirti di risolvere dispute e recuperare i tuoi fondi.';
      case 'nekoInfo.backupWarning':
        return 'Ricorda di fare il backup del tuo Neko';
      case 'generateNewKey.title':
        return 'Nuovo';
      case 'generateNewKey.description':
        return 'Sei sicuro di voler generare un nuovo Neko? Quello attuale andrà perso per sempre se non ne hai fatto il backup.';
      case 'generateNewKey.buttons.generate':
        return 'Genera';
      case 'generateNewKey.errors.activeOffer':
        return 'Non puoi generare un nuovo Neko mentre hai un\'offerta attiva.';
      case 'generateNewKey.errors.failed':
        return 'Impossibile generare un nuovo Neko';
      case 'generateNewKey.feedback.success':
        return 'Nuovo Neko generato con successo!';
      case 'generateNewKey.tooltips.generate':
        return 'Genera Nuovo Neko';
      case 'backup.title':
        return 'Backup';
      case 'backup.description':
        return 'Questa è la tua chiave privata. Protegge la comunicazione con il coordinatore. Non rivelarla mai a nessuno. Fai il backup in un luogo sicuro per prevenire problemi durante le dispute.';
      case 'backup.feedback.copied':
        return 'Chiave privata copiata negli appunti!';
      case 'backup.tooltips.backup':
        return 'Backup Neko';
      case 'restore.title':
        return 'Ripristina';
      case 'restore.labels.privateKey':
        return 'Chiave Privata';
      case 'restore.buttons.restore':
        return 'Ripristina';
      case 'restore.errors.invalidKey':
        return 'Deve essere una stringa esadecimale di 64 caratteri.';
      case 'restore.errors.failed':
        return 'Ripristino fallito';
      case 'restore.feedback.success':
        return 'Neko ripristinato con successo! L\'app verrà riavviata.';
      case 'restore.tooltips.restore':
        return 'Ripristina Neko';
      case 'system.loadingPublicKey':
        return 'Caricamento della tua chiave pubblica...';
      case 'system.errors.generic':
        return 'Si è verificato un errore imprevisto. Riprova.';
      case 'system.errors.loadingTimeoutConfig':
        return 'Errore nel caricamento della configurazione timeout.';
      case 'system.errors.loadingCoordinatorConfig':
        return 'Errore nel caricamento della configurazione del coordinatore. Riprova.';
      case 'system.errors.noPublicKey':
        return 'La tua chiave pubblica non è disponibile. Impossibile procedere.';
      case 'system.errors.internalOfferIncomplete':
        return 'Errore interno: I dettagli dell\'offerta sono incompleti. Riprova.';
      case 'system.errors.loadingPublicKey':
        return 'Errore nel caricamento della tua chiave pubblica. Riavvia l\'app.';
      case 'system.blik.copied':
        return 'Codice BLIK copiato negli appunti';
      case 'landing.mainTitle':
        return 'Il tuo ponte BLIK ⇄ bitcoin';
      case 'landing.subtitle':
        return 'Paga o vendi il tuo codice BLIK con bitcoin';
      case 'landing.actions.payBlik':
        return 'Paga BLIK';
      case 'landing.actions.payBlikSubtitle':
        return 'con bitcoin';
      case 'landing.actions.sellBlik':
        return 'Compra bitcoin';
      case 'landing.actions.sellBlikSubtitle':
        return 'con BLIK';
      case 'landing.actions.howItWorks':
        return 'Come funziona?';
      case 'faq.screenTitle':
        return 'FAQ';
      case 'faq.tooltip':
        return 'FAQ';
      case 'settings.title':
        return 'Impostazioni';
      case 'wallet.title':
        return 'Portafoglio';
      case 'wallet.description':
        return 'Gestisci le impostazioni del tuo portafoglio Lightning';
      case 'wallet.missingReceiving.title':
        return 'Portafoglio di ricezione richiesto';
      case 'wallet.missingReceiving.message':
        return 'Nessun portafoglio configurato per ricevere. Aggiungine uno nelle impostazioni Portafoglio per accettare offerte.';
      case 'wallet.missingReceiving.openSettings':
        return 'Impostazioni portafoglio';
      case 'nwc.title':
        return 'Nostr Wallet Connect (NWC)';
      case 'nwc.description':
        return 'Connetti il tuo portafoglio Lightning tramite NWC';
      case 'nwc.labels.connectionString':
        return 'Stringa di Connessione NWC';
      case 'nwc.labels.hint':
        return 'nostr+walletconnect://...';
      case 'nwc.labels.status':
        return 'Stato Connessione';
      case 'nwc.labels.connected':
        return 'Connesso';
      case 'nwc.labels.disconnected':
        return 'Disconnesso';
      case 'nwc.labels.scanQrCode':
        return 'Scansiona il codice QR con la tua connessione NWC';
      case 'nwc.labels.balance':
        return 'Saldo';
      case 'nwc.labels.budget':
        return 'Budget';
      case 'nwc.labels.usedBudget':
        return 'Usato';
      case 'nwc.labels.totalBudget':
        return 'Totale';
      case 'nwc.labels.renewsIn':
        return 'Si rinnova tra';
      case 'nwc.labels.renewalPeriod':
        return 'Periodo di Rinnovo';
      case 'nwc.labels.relay':
        return 'Relay';
      case 'nwc.labels.relays':
        return 'Relay';
      case 'nwc.prompts.enter':
        return 'Inserisci la tua stringa di connessione NWC';
      case 'nwc.prompts.connect':
        return 'Connetti Portafoglio';
      case 'nwc.prompts.disconnect':
        return 'Disconnetti';
      case 'nwc.prompts.confirmDisconnect':
        return 'Sei sicuro di voler disconnettere il tuo portafoglio NWC?';
      case 'nwc.prompts.pasteConnection':
        return 'Incolla stringa di connessione';
      case 'nwc.prompts.chooseMethod':
        return 'Scegli come connettere il tuo portafoglio Lightning';
      case 'nwc.prompts.howToGet':
        return 'Non hai ancora una connessione NWC? Scopri come ottenerla!';
      case 'nwc.prompts.learnMore':
        return 'Scopri di più su NWC';
      case 'nwc.actions.connectAlbyGo':
        return 'Connetti con Alby Go';
      case 'nwc.actions.connectNwc':
        return 'Scansiona QR Code NWC';
      case 'nwc.feedback.connected':
        return 'Portafoglio NWC connesso con successo!';
      case 'nwc.feedback.disconnected':
        return 'Portafoglio NWC disconnesso';
      case 'nwc.feedback.connecting':
        return 'Connessione al portafoglio NWC...';
      case 'nwc.feedback.loadingWalletInfo':
        return 'Caricamento informazioni portafoglio...';
      case 'nwc.errors.connecting':
        return ({required Object details}) =>
            'Errore nella connessione a NWC: ${details}';
      case 'nwc.errors.disconnecting':
        return ({required Object details}) =>
            'Errore nella disconnessione da NWC: ${details}';
      case 'nwc.errors.invalid':
        return 'Stringa di connessione NWC non valida';
      case 'nwc.errors.required':
        return 'La stringa di connessione NWC è obbligatoria';
      case 'nwc.errors.loadingBalance':
        return 'Impossibile caricare il saldo del portafoglio';
      case 'nwc.errors.loadingBudget':
        return 'Impossibile caricare il budget del portafoglio';
      case 'nwc.time.minutes':
        return ({required Object count}) => '${count}m';
      case 'nwc.time.hours':
        return ({required Object count}) => '${count}h';
      case 'nwc.time.days':
        return ({required Object count}) => '${count}g';
      case 'nwc.time.justNow':
        return 'adesso';
      case 'nekoManagement.title':
        return 'Neko';
      case 'relays.title':
        return 'Relay';
      case 'relays.status.connected':
        return 'Connesso';
      case 'relays.status.connecting':
        return 'Connessione';
      case 'relays.status.reconnecting':
        return 'Riconnessione';
      case 'relays.status.disconnected':
        return 'Disconnesso';
      case 'relays.popup.title':
        return ({required Object connected, required Object total}) =>
            'Relay (${connected}/${total} connessi)';
      case 'relays.popup.connectingMessage':
        return 'Connessione ai relay...';
      case 'altstore.dialogTitle':
        return 'AltStore Non Installato';
      case 'altstore.step1Title':
        return 'Scarica e installa AltStore PAL';
      case 'altstore.step1Button':
        return 'altstore.io/download';
      case 'altstore.step1Warning':
        return 'Hai bisogno di Safari per installare AltStore PAL!';
      case 'altstore.step2Title':
        return 'Installa BitBlik';
      case 'altstore.step2Button':
        return 'Installa BitBlik';
      case 'altstore.step2Fallback':
        return 'Non funziona? Incolla la sorgente in AltStore';
      default:
        return null;
    }
  }
}
