///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsIt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$it app = _Translations$app$it._(_root);
	@override late final _Translations$common$it common = _Translations$common$it._(_root);
	@override late final _Translations$lightningAddress$it lightningAddress = _Translations$lightningAddress$it._(_root);
	@override late final _Translations$offers$it offers = _Translations$offers$it._(_root);
	@override late final _Translations$reservations$it reservations = _Translations$reservations$it._(_root);
	@override late final _Translations$exchange$it exchange = _Translations$exchange$it._(_root);
	@override late final _Translations$coordinator$it coordinator = _Translations$coordinator$it._(_root);
	@override late final _Translations$maker$it maker = _Translations$maker$it._(_root);
	@override late final _Translations$taker$it taker = _Translations$taker$it._(_root);
	@override late final _Translations$blik$it blik = _Translations$blik$it._(_root);
	@override late final _Translations$home$it home = _Translations$home$it._(_root);
	@override late final _Translations$nekoInfo$it nekoInfo = _Translations$nekoInfo$it._(_root);
	@override late final _Translations$generateNewKey$it generateNewKey = _Translations$generateNewKey$it._(_root);
	@override late final _Translations$backup$it backup = _Translations$backup$it._(_root);
	@override late final _Translations$restore$it restore = _Translations$restore$it._(_root);
	@override late final _Translations$system$it system = _Translations$system$it._(_root);
	@override late final _Translations$myOffers$it myOffers = _Translations$myOffers$it._(_root);
	@override late final _Translations$landing$it landing = _Translations$landing$it._(_root);
	@override late final _Translations$faq$it faq = _Translations$faq$it._(_root);
	@override late final _Translations$settings$it settings = _Translations$settings$it._(_root);
	@override late final _Translations$notificationSettings$it notificationSettings = _Translations$notificationSettings$it._(_root);
	@override late final _Translations$wallet$it wallet = _Translations$wallet$it._(_root);
	@override late final _Translations$nwc$it nwc = _Translations$nwc$it._(_root);
	@override late final _Translations$nekoManagement$it nekoManagement = _Translations$nekoManagement$it._(_root);
	@override late final _Translations$relays$it relays = _Translations$relays$it._(_root);
	@override late final _Translations$offerNotifications$it offerNotifications = _Translations$offerNotifications$it._(_root);
	@override late final _Translations$altstore$it altstore = _Translations$altstore$it._(_root);
}

// Path: app
class _Translations$app$it extends Translations$app$en {
	_Translations$app$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'BitBlik';
	@override String get greeting => 'Ciao!';
	@override String get changelog => 'Registro modifiche';
}

// Path: common
class _Translations$common$it extends Translations$common$en {
	_Translations$common$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$buttons$it buttons = _Translations$common$buttons$it._(_root);
	@override late final _Translations$common$labels$it labels = _Translations$common$labels$it._(_root);
	@override late final _Translations$common$notifications$it notifications = _Translations$common$notifications$it._(_root);
	@override late final _Translations$common$clipboard$it clipboard = _Translations$common$clipboard$it._(_root);
	@override late final _Translations$common$actions$it actions = _Translations$common$actions$it._(_root);
}

// Path: lightningAddress
class _Translations$lightningAddress$it extends Translations$lightningAddress$en {
	_Translations$lightningAddress$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$lightningAddress$labels$it labels = _Translations$lightningAddress$labels$it._(_root);
	@override late final _Translations$lightningAddress$prompts$it prompts = _Translations$lightningAddress$prompts$it._(_root);
	@override late final _Translations$lightningAddress$feedback$it feedback = _Translations$lightningAddress$feedback$it._(_root);
	@override late final _Translations$lightningAddress$errors$it errors = _Translations$lightningAddress$errors$it._(_root);
}

// Path: offers
class _Translations$offers$it extends Translations$offers$en {
	_Translations$offers$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offers$details$it details = _Translations$offers$details$it._(_root);
	@override late final _Translations$offers$labels$it labels = _Translations$offers$labels$it._(_root);
	@override late final _Translations$offers$tooltips$it tooltips = _Translations$offers$tooltips$it._(_root);
	@override late final _Translations$offers$actions$it actions = _Translations$offers$actions$it._(_root);
	@override late final _Translations$offers$status$it status = _Translations$offers$status$it._(_root);
	@override late final _Translations$offers$statusMessages$it statusMessages = _Translations$offers$statusMessages$it._(_root);
	@override late final _Translations$offers$progress$it progress = _Translations$offers$progress$it._(_root);
	@override late final _Translations$offers$errors$it errors = _Translations$offers$errors$it._(_root);
	@override late final _Translations$offers$success$it success = _Translations$offers$success$it._(_root);
}

// Path: reservations
class _Translations$reservations$it extends Translations$reservations$en {
	_Translations$reservations$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reservations$actions$it actions = _Translations$reservations$actions$it._(_root);
	@override late final _Translations$reservations$feedback$it feedback = _Translations$reservations$feedback$it._(_root);
	@override late final _Translations$reservations$errors$it errors = _Translations$reservations$errors$it._(_root);
}

// Path: exchange
class _Translations$exchange$it extends Translations$exchange$en {
	_Translations$exchange$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$exchange$labels$it labels = _Translations$exchange$labels$it._(_root);
	@override late final _Translations$exchange$feedback$it feedback = _Translations$exchange$feedback$it._(_root);
	@override late final _Translations$exchange$errors$it errors = _Translations$exchange$errors$it._(_root);
}

// Path: coordinator
class _Translations$coordinator$it extends Translations$coordinator$en {
	_Translations$coordinator$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Coordinatori';
	@override late final _Translations$coordinator$info$it info = _Translations$coordinator$info$it._(_root);
	@override late final _Translations$coordinator$selector$it selector = _Translations$coordinator$selector$it._(_root);
	@override late final _Translations$coordinator$dialog$it dialog = _Translations$coordinator$dialog$it._(_root);
	@override late final _Translations$coordinator$details$it details = _Translations$coordinator$details$it._(_root);
	@override late final _Translations$coordinator$management$it management = _Translations$coordinator$management$it._(_root);
}

// Path: maker
class _Translations$maker$it extends Translations$maker$en {
	_Translations$maker$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$roleSelection$it roleSelection = _Translations$maker$roleSelection$it._(_root);
	@override late final _Translations$maker$amountForm$it amountForm = _Translations$maker$amountForm$it._(_root);
	@override late final _Translations$maker$payInvoice$it payInvoice = _Translations$maker$payInvoice$it._(_root);
	@override late final _Translations$maker$waitTaker$it waitTaker = _Translations$maker$waitTaker$it._(_root);
	@override late final _Translations$maker$waitForBlik$it waitForBlik = _Translations$maker$waitForBlik$it._(_root);
	@override late final _Translations$maker$confirmPayment$it confirmPayment = _Translations$maker$confirmPayment$it._(_root);
	@override late final _Translations$maker$invalidBlik$it invalidBlik = _Translations$maker$invalidBlik$it._(_root);
	@override late final _Translations$maker$conflict$it conflict = _Translations$maker$conflict$it._(_root);
	@override late final _Translations$maker$success$it success = _Translations$maker$success$it._(_root);
}

// Path: taker
class _Translations$taker$it extends Translations$taker$en {
	_Translations$taker$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$taker$roleSelection$it roleSelection = _Translations$taker$roleSelection$it._(_root);
	@override late final _Translations$taker$progress$it progress = _Translations$taker$progress$it._(_root);
	@override late final _Translations$taker$submitBlik$it submitBlik = _Translations$taker$submitBlik$it._(_root);
	@override late final _Translations$taker$waitConfirmation$it waitConfirmation = _Translations$taker$waitConfirmation$it._(_root);
	@override late final _Translations$taker$paymentProcess$it paymentProcess = _Translations$taker$paymentProcess$it._(_root);
	@override late final _Translations$taker$paymentFailed$it paymentFailed = _Translations$taker$paymentFailed$it._(_root);
	@override late final _Translations$taker$paymentSuccess$it paymentSuccess = _Translations$taker$paymentSuccess$it._(_root);
	@override late final _Translations$taker$invalidBlik$it invalidBlik = _Translations$taker$invalidBlik$it._(_root);
	@override late final _Translations$taker$conflict$it conflict = _Translations$taker$conflict$it._(_root);
}

// Path: blik
class _Translations$blik$it extends Translations$blik$en {
	_Translations$blik$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$blik$instructions$it instructions = _Translations$blik$instructions$it._(_root);
}

// Path: home
class _Translations$home$it extends Translations$home$en {
	_Translations$home$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$home$notifications$it notifications = _Translations$home$notifications$it._(_root);
	@override late final _Translations$home$statistics$it statistics = _Translations$home$statistics$it._(_root);
}

// Path: nekoInfo
class _Translations$nekoInfo$it extends Translations$nekoInfo$en {
	_Translations$nekoInfo$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cos\'è un Neko?';
	@override String get description => 'Il tuo Neko è la tua identità per usare BitBlik. È composto da una chiave privata e pubblica per garantire una comunicazione crittograficamente sicura con il coordinatore.\n\nPer garantire maggiore anonimato, si consiglia di usare un nuovo Neko per ogni offerta.\n\n⚠️ IMPORTANTE: La tua chiave privata è memorizzata solo sul tuo dispositivo (lato client). È fondamentale fare il backup della tua chiave privata, poiché perderla potrebbe impedirti di risolvere dispute e recuperare i tuoi fondi.';
	@override String get backupWarning => 'Ricorda di fare il backup del tuo Neko';
}

// Path: generateNewKey
class _Translations$generateNewKey$it extends Translations$generateNewKey$en {
	_Translations$generateNewKey$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuovo';
	@override String get description => 'Sei sicuro di voler generare un nuovo Neko? Quello attuale andrà perso per sempre se non ne hai fatto il backup.';
	@override late final _Translations$generateNewKey$buttons$it buttons = _Translations$generateNewKey$buttons$it._(_root);
	@override late final _Translations$generateNewKey$errors$it errors = _Translations$generateNewKey$errors$it._(_root);
	@override late final _Translations$generateNewKey$feedback$it feedback = _Translations$generateNewKey$feedback$it._(_root);
	@override late final _Translations$generateNewKey$tooltips$it tooltips = _Translations$generateNewKey$tooltips$it._(_root);
}

// Path: backup
class _Translations$backup$it extends Translations$backup$en {
	_Translations$backup$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Backup';
	@override String get description => 'Questa è la tua chiave privata. Protegge la comunicazione con il coordinatore. Non rivelarla mai a nessuno. Fai il backup in un luogo sicuro per prevenire problemi durante le dispute.';
	@override late final _Translations$backup$feedback$it feedback = _Translations$backup$feedback$it._(_root);
	@override late final _Translations$backup$tooltips$it tooltips = _Translations$backup$tooltips$it._(_root);
}

// Path: restore
class _Translations$restore$it extends Translations$restore$en {
	_Translations$restore$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ripristina';
	@override late final _Translations$restore$labels$it labels = _Translations$restore$labels$it._(_root);
	@override late final _Translations$restore$buttons$it buttons = _Translations$restore$buttons$it._(_root);
	@override late final _Translations$restore$errors$it errors = _Translations$restore$errors$it._(_root);
	@override late final _Translations$restore$feedback$it feedback = _Translations$restore$feedback$it._(_root);
	@override late final _Translations$restore$tooltips$it tooltips = _Translations$restore$tooltips$it._(_root);
}

// Path: system
class _Translations$system$it extends Translations$system$en {
	_Translations$system$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get loadingPublicKey => 'Caricamento della tua chiave pubblica...';
	@override late final _Translations$system$errors$it errors = _Translations$system$errors$it._(_root);
	@override late final _Translations$system$blik$it blik = _Translations$system$blik$it._(_root);
}

// Path: myOffers
class _Translations$myOffers$it extends Translations$myOffers$en {
	_Translations$myOffers$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Le mie offerte';
	@override String get empty => 'Nessuna offerta.';
	@override String get unknownCoordinator => 'Coordinatore sconosciuto';
	@override String get menuLabel => 'Le mie offerte';
	@override late final _Translations$myOffers$filter$it filter = _Translations$myOffers$filter$it._(_root);
	@override late final _Translations$myOffers$details$it details = _Translations$myOffers$details$it._(_root);
}

// Path: landing
class _Translations$landing$it extends Translations$landing$en {
	_Translations$landing$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get mainTitle => 'Il tuo ponte BLIK ⇄ bitcoin';
	@override String get subtitle => 'Paga o vendi il tuo codice BLIK con bitcoin';
	@override String get partnership => 'partnership';
	@override late final _Translations$landing$actions$it actions = _Translations$landing$actions$it._(_root);
}

// Path: faq
class _Translations$faq$it extends Translations$faq$en {
	_Translations$faq$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'FAQ';
	@override String get tooltip => 'FAQ';
}

// Path: settings
class _Translations$settings$it extends Translations$settings$en {
	_Translations$settings$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Impostazioni';
	@override late final _Translations$settings$offerCreation$it offerCreation = _Translations$settings$offerCreation$it._(_root);
	@override late final _Translations$settings$display$it display = _Translations$settings$display$it._(_root);
}

// Path: notificationSettings
class _Translations$notificationSettings$it extends Translations$notificationSettings$en {
	_Translations$notificationSettings$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifiche';
	@override String get androidOnly => 'Le notifiche in background sono attualmente supportate solo su Android.';
	@override late final _Translations$notificationSettings$newOfferAlerts$it newOfferAlerts = _Translations$notificationSettings$newOfferAlerts$it._(_root);
}

// Path: wallet
class _Translations$wallet$it extends Translations$wallet$en {
	_Translations$wallet$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portafoglio';
	@override String get description => 'Gestisci le impostazioni del tuo portafoglio Lightning';
	@override late final _Translations$wallet$missingReceiving$it missingReceiving = _Translations$wallet$missingReceiving$it._(_root);
}

// Path: nwc
class _Translations$nwc$it extends Translations$nwc$en {
	_Translations$nwc$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nostr Wallet Connect (NWC)';
	@override String get description => 'Connetti il tuo portafoglio Lightning tramite NWC';
	@override late final _Translations$nwc$labels$it labels = _Translations$nwc$labels$it._(_root);
	@override late final _Translations$nwc$prompts$it prompts = _Translations$nwc$prompts$it._(_root);
	@override late final _Translations$nwc$actions$it actions = _Translations$nwc$actions$it._(_root);
	@override late final _Translations$nwc$feedback$it feedback = _Translations$nwc$feedback$it._(_root);
	@override late final _Translations$nwc$errors$it errors = _Translations$nwc$errors$it._(_root);
	@override late final _Translations$nwc$time$it time = _Translations$nwc$time$it._(_root);
}

// Path: nekoManagement
class _Translations$nekoManagement$it extends Translations$nekoManagement$en {
	_Translations$nekoManagement$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neko';
}

// Path: relays
class _Translations$relays$it extends Translations$relays$en {
	_Translations$relays$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Relay';
	@override String get coordinatorRelays => 'Relay del coordinatore';
	@override String get discoveryRelays => 'Relay di scoperta';
	@override late final _Translations$relays$status$it status = _Translations$relays$status$it._(_root);
	@override late final _Translations$relays$popup$it popup = _Translations$relays$popup$it._(_root);
}

// Path: offerNotifications
class _Translations$offerNotifications$it extends Translations$offerNotifications$en {
	_Translations$offerNotifications$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offerNotifications$activeService$it activeService = _Translations$offerNotifications$activeService$it._(_root);
	@override late final _Translations$offerNotifications$funded$it funded = _Translations$offerNotifications$funded$it._(_root);
	@override late final _Translations$offerNotifications$reserved$it reserved = _Translations$offerNotifications$reserved$it._(_root);
	@override late final _Translations$offerNotifications$blikReady$it blikReady = _Translations$offerNotifications$blikReady$it._(_root);
	@override late final _Translations$offerNotifications$newOffer$it newOffer = _Translations$offerNotifications$newOffer$it._(_root);
	@override late final _Translations$offerNotifications$categories$it categories = _Translations$offerNotifications$categories$it._(_root);
	@override late final _Translations$offerNotifications$blikPendingReminder$it blikPendingReminder = _Translations$offerNotifications$blikPendingReminder$it._(_root);
	@override late final _Translations$offerNotifications$takerCharged$it takerCharged = _Translations$offerNotifications$takerCharged$it._(_root);
	@override late final _Translations$offerNotifications$invalidBlik$it invalidBlik = _Translations$offerNotifications$invalidBlik$it._(_root);
	@override late final _Translations$offerNotifications$takerPaid$it takerPaid = _Translations$offerNotifications$takerPaid$it._(_root);
}

// Path: altstore
class _Translations$altstore$it extends Translations$altstore$en {
	_Translations$altstore$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'AltStore Non Installato';
	@override String get step1Title => 'Scarica e installa AltStore PAL';
	@override String get step1Button => 'altstore.io/download';
	@override String get step1Warning => 'Hai bisogno di Safari per installare AltStore PAL!';
	@override String get step2Title => 'Installa BitBlik';
	@override String get step2Button => 'Installa BitBlik';
	@override String get step2Fallback => 'Non funziona? Incolla la sorgente in AltStore';
}

// Path: common.buttons
class _Translations$common$buttons$it extends Translations$common$buttons$en {
	_Translations$common$buttons$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annulla';
	@override String get save => 'Salva';
	@override String get done => 'Fatto';
	@override String get retry => 'Riprova';
	@override String get goHome => 'Vai alla Home';
	@override String get saveAndContinue => 'Salva e Continua';
	@override String get reveal => 'Mostra';
	@override String get hide => 'Nascondi';
	@override String get copy => 'Copia';
	@override String get close => 'Chiudi';
	@override String get restore => 'Ripristina';
	@override String get faq => 'FAQ';
}

// Path: common.labels
class _Translations$common$labels$it extends Translations$common$labels$en {
	_Translations$common$labels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get amount => 'Importo (PLN)';
	@override String status({required Object status}) => 'Stato: ${status}';
	@override String role({required Object role}) => 'Ruolo: ${role}';
}

// Path: common.notifications
class _Translations$common$notifications$it extends Translations$common$notifications$en {
	_Translations$common$notifications$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get success => 'Successo';
	@override String get error => 'Errore';
	@override String get loading => 'Caricamento...';
}

// Path: common.clipboard
class _Translations$common$clipboard$it extends Translations$common$clipboard$en {
	_Translations$common$clipboard$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get copyToClipboard => 'Copia negli appunti';
	@override String get pasteFromClipboard => 'Incolla dagli appunti';
	@override String get copied => 'Copiato negli appunti!';
}

// Path: common.actions
class _Translations$common$actions$it extends Translations$common$actions$en {
	_Translations$common$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get cancelAndReturnToOffers => 'Annulla e torna alle offerte';
	@override String get cancelAndReturnHome => 'Annulla e torna alla Home';
}

// Path: lightningAddress.labels
class _Translations$lightningAddress$labels$it extends Translations$lightningAddress$labels$en {
	_Translations$lightningAddress$labels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get address => 'Indirizzo Lightning (LNURL)';
	@override String get hint => 'utente@dominio.com';
	@override String short({required Object address}) => 'Indirizzo Lightning: ${address}';
	@override String get receivingAddress => 'Il tuo indirizzo di ricezione:';
}

// Path: lightningAddress.prompts
class _Translations$lightningAddress$prompts$it extends Translations$lightningAddress$prompts$en {
	_Translations$lightningAddress$prompts$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Inserisci il tuo indirizzo Lightning per continuare';
	@override String get edit => 'Modifica';
	@override String get invalid => 'Inserisci un indirizzo Lightning valido';
	@override String get required => 'L\'indirizzo Lightning è obbligatorio.';
	@override String get enterToTakeOffer => 'Devi impostare un indirizzo Lightning per accettare un\'offerta.';
	@override String get missing => 'Indirizzo Lightning mancante. Aggiungine uno per poter accettare offerte.';
	@override String get add => 'Aggiungi';
	@override String get delete => 'Elimina';
	@override String get confirmDelete => 'Sei sicuro di voler eliminare il tuo indirizzo Lightning?';
	@override String get howToGet => 'Non hai ancora un indirizzo Lightning? Scopri come ottenerne uno!';
	@override String get learnMore => 'Scopri di più sull\'indirizzo Lightning';
}

// Path: lightningAddress.feedback
class _Translations$lightningAddress$feedback$it extends Translations$lightningAddress$feedback$en {
	_Translations$lightningAddress$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Indirizzo Lightning salvato!';
	@override String get updated => 'Indirizzo Lightning aggiornato!';
	@override String get valid => 'Indirizzo Lightning valido';
}

// Path: lightningAddress.errors
class _Translations$lightningAddress$errors$it extends Translations$lightningAddress$errors$en {
	_Translations$lightningAddress$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String saving({required Object details}) => 'Errore nel salvataggio dell\'indirizzo: ${details}';
	@override String loading({required Object details}) => 'Errore nel caricamento dell\'indirizzo Lightning: ${details}';
}

// Path: offers.details
class _Translations$offers$details$it extends Translations$offers$details$en {
	_Translations$offers$details$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get yourOffer => 'La tua offerta:';
	@override String get selectedOffer => 'Offerta:';
	@override String get activeOffer => 'Hai un\'offerta attiva:';
	@override String get finishedOffers => 'Offerte completate';
	@override String get noAvailable => 'Nessuna offerta disponibile.';
	@override String get noAvailableTip => 'Suggerimento: condividi Bitblik nella tua community e tra i tuoi amici per aumentare gli ordini su Bitblik.';
	@override String get noSuccessfulTrades => 'Nessuna transazione completata.';
	@override String get loadingDetails => 'Caricamento dettagli offerta...';
	@override String amount({required Object amount}) => 'Importo: ${amount} satoshi';
	@override String amountWithCurrency({required Object amount, required Object currency}) => '${amount} ${currency}';
	@override String makerFee({required Object fee}) => 'Commissione: ${fee} sats';
	@override String takerFee({required Object fee}) => 'Commissione: ${fee} sats';
	@override String subtitle({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (commissione) satoshi\nStato: ${status}';
	@override String subtitleWithDate({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (commissione) satoshi\nStato: ${status}\nPagato: ${date}';
	@override String activeSubtitle({required Object status, required Object amount}) => 'Stato: ${status}\nImporto: ${amount} satoshi';
	@override String id({required Object id}) => 'ID Offerta: ${id}...';
	@override String created({required Object dateTime}) => 'Creata: ${dateTime}';
	@override String takenAfter({required Object duration}) => 'Accettata dopo: ${duration}';
	@override String paidAfter({required Object duration}) => 'Pagata dopo: ${duration}';
	@override String get exchangeRate => 'Tasso di Cambio';
	@override String get amountLabel => 'Importo';
	@override String get makerFeeLabel => 'Commissione maker';
	@override String get takerFeeLabel => 'Commissione taker';
	@override String get feeLabel => 'Commissione';
	@override String get statusLabel => 'Stato';
	@override String get youllReceive => 'Riceverai';
	@override String get coordinator => 'Coordinatore';
	@override String get categoryLabel => 'Categoria';
	@override late final _Translations$offers$details$categories$it categories = _Translations$offers$details$categories$it._(_root);
	@override late final _Translations$offers$details$consents$it consents = _Translations$offers$details$consents$it._(_root);
}

// Path: offers.labels
class _Translations$offers$labels$it extends Translations$offers$labels$en {
	_Translations$offers$labels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get premium => 'Premio';
	@override String premiumBadge({required Object percent}) => '+${percent}% premio';
}

// Path: offers.tooltips
class _Translations$offers$tooltips$it extends Translations$offers$tooltips$en {
	_Translations$offers$tooltips$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String takerFeeInfo({required Object feePercent}) => 'Il coordinatore applica una commissione taker del ${feePercent}%. Questo include le commissioni di routing Lightning ed è detratto dall\'importo che ricevi';
	@override String get premiumInfoTaker => 'Un premio significa che questa offerta è prezzata sopra il mercato. Per lo stesso importo fiat, il maker blocca meno sat nella fattura hold, quindi paghi sopra il mercato e ricevi meno sat rispetto al tasso di mercato. Il premio massimo è impostato dal coordinatore.';
	@override String get ratesFetchedAt => 'Recuperato alle';
	@override String get ratesSources => 'Fonti tasso medio';
}

// Path: offers.actions
class _Translations$offers$actions$it extends Translations$offers$actions$en {
	_Translations$offers$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get take => 'ACCETTA';
	@override String get takeOffer => 'Accetta Offerta';
	@override String get resume => 'INSERISCI BLIK';
	@override String get cancel => 'Annulla offerta';
	@override String get view => 'Visualizza dettagli';
}

// Path: offers.status
class _Translations$offers$status$it extends Translations$offers$status$en {
	_Translations$offers$status$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get created => 'Creata';
	@override String get funded => 'Finanziata';
	@override String get expired => 'Scaduta';
	@override String get cancelled => 'Annullata';
	@override String get reserved => 'Riservata';
	@override String get blikReceived => 'BLIK Inviato';
	@override String get blikSentToMaker => 'BLIK Ricevuto';
	@override String get expiredBlik => 'BLIK Scaduto';
	@override String get expiredSentBlik => 'BLIK Scaduto';
	@override String get takerCharged => 'Taker Addebitato';
	@override String get invalidBlik => 'BLIK Non Valido';
	@override String get conflict => 'Conflitto';
	@override String get dispute => 'Disputa';
	@override String get makerConfirmed => 'Confermata';
	@override String get settled => 'Conclusa';
	@override String get payingTaker => 'Pagamento wTaker';
	@override String get takerPaymentFailed => 'Taker s1Pagamento Fallito';
	@override String get takerPaid => 'Taker Pagato';
	@override String get unknownStatus => 'Sconosciuto';
}

// Path: offers.statusMessages
class _Translations$offers$statusMessages$it extends Translations$offers$statusMessages$en {
	_Translations$offers$statusMessages$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get reserved => 'Offerta riservata dal Taker!';
	@override String get cancelled => 'Offerta annullata con successo.';
	@override String get cancelledOrExpired => 'L\'offerta è stata annullata o è scaduta.';
	@override String noLongerAvailable({required Object status}) => 'L\'offerta non è più disponibile (Stato: ${status}).';
}

// Path: offers.progress
class _Translations$offers$progress$it extends Translations$offers$progress$en {
	_Translations$offers$progress$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String waitingForTaker({required Object time}) => 'In attesa del taker: ${time}';
	@override String reserved({required Object seconds}) => 'Riservata: ${seconds} s rimanenti';
	@override String confirming({required Object seconds}) => 'Conferma in corso: ${seconds} s rimanenti';
}

// Path: offers.errors
class _Translations$offers$errors$it extends Translations$offers$errors$en {
	_Translations$offers$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String loading({required Object details}) => 'Errore nel caricamento delle offerte: ${details}';
	@override String loadingDetails({required Object details}) => 'Errore nel caricamento dei dettagli dell\'offerta: ${details}';
	@override String get detailsMissing => 'Errore: Dettagli dell\'offerta mancanti o non validi.';
	@override String get detailsNotLoaded => 'Impossibile caricare i dettagli dell\'offerta.';
	@override String get notFound => 'Errore: Offerta non trovata.';
	@override String get unexpectedState => 'Errore: L\'offerta è in uno stato imprevisto.';
	@override String unexpectedStateWithStatus({required Object status}) => 'L\'offerta è in uno stato imprevisto (${status}). Riprova o contatta l\'assistenza.';
	@override String get invalidStatus => 'L\'offerta ha uno stato non valido.';
	@override String get couldNotIdentify => 'Errore: Impossibile identificare l\'offerta da annullare.';
	@override String cannotBeCancelled({required Object status}) => 'L\'offerta non può essere annullata nello stato attuale (${status}).';
	@override String failedToCancel({required Object details}) => 'Impossibile annullare l\'offerta: ${details}';
	@override String get activeDetailsLost => 'Errore: Dettagli dell\'offerta attiva persi.';
	@override String checkingActive({required Object details}) => 'Errore nel controllo delle offerte attive: ${details}';
	@override String cannotResume({required Object status}) => 'Impossibile riprendere l\'offerta nello stato: ${status}';
	@override String cannotResumeTaker({required Object status}) => 'Impossibile riprendere l\'offerta taker nello stato: ${status}';
	@override String resuming({required Object details}) => 'Errore nel riprendere l\'offerta: ${details}';
	@override String get makerPublicKeyNotFound => 'Chiave pubblica del maker non trovata';
	@override String get takerPublicKeyNotFound => 'Chiave pubblica del taker non trovata.';
	@override String get atmConsentRequired => 'Accetta la condizione sulla commissione ATM prima di prendere questa offerta.';
	@override String get ecommerceConsentRequired => 'Accetta la condizione di restituzione del rimborso ecommerce prima di prendere questa offerta.';
	@override String get cannotTakeOwnOffer => 'Non puoi prendere la tua stessa offerta.';
}

// Path: offers.success
class _Translations$offers$success$it extends Translations$offers$success$en {
	_Translations$offers$success$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offerta completata';
	@override String get headline => 'Pagamento confermato!';
	@override String get subtitle => 'Il taker verrà pagato ora.';
	@override String get detailsTitle => 'Dettagli offerta:';
	@override String duration({required Object time}) => 'L\'offerta è stata completata in ${time}.';
}

// Path: reservations.actions
class _Translations$reservations$actions$it extends Translations$reservations$actions$en {
	_Translations$reservations$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annulla prenotazione';
}

// Path: reservations.feedback
class _Translations$reservations$feedback$it extends Translations$reservations$feedback$en {
	_Translations$reservations$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get cancelled => 'Prenotazione annullata.';
}

// Path: reservations.errors
class _Translations$reservations$errors$it extends Translations$reservations$errors$en {
	_Translations$reservations$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String cancelling({required Object error}) => 'Impossibile annullare la prenotazione: ${error}';
	@override String failedToReserve({required Object details}) => 'Impossibile riservare l\'offerta: ${details}';
	@override String get failedNoTimestamp => 'Impossibile riservare l\'offerta (timestamp mancante).';
	@override String get timestampMissing => 'Timestamp della prenotazione offerta mancante.';
	@override String notReserved({required Object status}) => 'L\'offerta non è più nello stato riservato (${status}).';
}

// Path: exchange.labels
class _Translations$exchange$labels$it extends Translations$exchange$labels$en {
	_Translations$exchange$labels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get enterAmount => 'Inserisci l\'importo (PLN) da pagare:';
	@override String equivalent({required Object sats}) => '≈ ${sats} satoshi';
	@override String rate({required Object rate}) => 'Tasso di cambio ≈ ${rate} PLN/BTC';
}

// Path: exchange.feedback
class _Translations$exchange$feedback$it extends Translations$exchange$feedback$en {
	_Translations$exchange$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get fetching => 'Recupero tasso di cambio...';
}

// Path: exchange.errors
class _Translations$exchange$errors$it extends Translations$exchange$errors$en {
	_Translations$exchange$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get fetchingRate => 'Impossibile recuperare il tasso di cambio.';
	@override String get invalidFormat => 'Formato numero non valido';
	@override String get mustBePositive => 'L\'importo deve essere positivo';
	@override String get invalidFeePercentage => 'Percentuale commissione non valida';
	@override String tooLowFiat({required Object minAmount, required Object currency}) => 'L\'importo è troppo basso. Il minimo è ${minAmount} ${currency}.';
	@override String tooHighFiat({required Object maxAmount, required Object currency}) => 'L\'importo è troppo alto. Il massimo è ${maxAmount} ${currency}.';
}

// Path: coordinator.info
class _Translations$coordinator$info$it extends Translations$coordinator$info$en {
	_Translations$coordinator$info$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get fee => 'commissione';
	@override String rangeDisplay({required Object minAmount, required Object maxAmount, required Object currency}) => 'Importo: ${minAmount}-${maxAmount} ${currency}';
	@override String feeDisplay({required Object fee}) => '${fee}% commissione';
}

// Path: coordinator.selector
class _Translations$coordinator$selector$it extends Translations$coordinator$selector$en {
	_Translations$coordinator$selector$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Caricamento Coordinatori...';
	@override String get errorLoading => 'Errore nel Caricamento Coordinatori';
	@override String get choose => 'Scegli Coordinatore';
	@override String get viewNostrProfile => 'Visualizza profilo Nostr';
	@override String get unresponsive => 'Questo coordinatore non risponde';
	@override String get waitingResponse => 'In attesa della risposta del coordinatore';
	@override String get termsAccept => 'Accetto i ';
	@override String get termsOfUsage => 'Termini di utilizzo';
}

// Path: coordinator.dialog
class _Translations$coordinator$dialog$it extends Translations$coordinator$dialog$en {
	_Translations$coordinator$dialog$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get makerFee => 'Commissione Maker';
	@override String get takerFee => 'Commissione Taker';
	@override String get amountRange => 'Range Importo';
	@override String get reservationTime => 'Tempo di Prenotazione';
	@override String get currencies => 'Valute';
	@override String get viewTerms => 'Visualizza Termini';
}

// Path: coordinator.details
class _Translations$coordinator$details$it extends Translations$coordinator$details$en {
	_Translations$coordinator$details$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Coordinatore';
	@override String get relaysInUse => 'Relay in uso';
	@override String get relaysInUseHint => 'Tutta la comunicazione con questo coordinatore passa per questi relay (dalla sua lista NIP-65).';
	@override String get noRelays => 'Nessun relay ancora noto';
	@override String get makerFee => 'Commissione maker';
	@override String get takerFee => 'Commissione taker';
	@override String get amountRange => 'Intervallo importo';
	@override String get maxPremium => 'Premio max';
	@override String get maxPremiumInfoTitle => 'Premio';
	@override String get maxPremiumInfoBody => 'Il premio è un sovrapprezzo opzionale rispetto al tasso di mercato che un maker può impostare su un\'offerta. Con un premio, il maker blocca meno satoshi per lo stesso importo in fiat, quindi il taker paga sopra il mercato e il maker trattiene la differenza. Questo valore è il premio massimo che questo coordinatore consente sulle sue offerte.';
	@override String get reservationTime => 'Tempo di prenotazione';
	@override String get currencies => 'Valute';
	@override String get version => 'Versione';
	@override String get yourOffers => 'Le tue offerte';
	@override String get successfulOffers => 'Offerte riuscite (30g)';
	@override String get statusOnline => 'Online';
	@override String get statusOffline => 'Offline';
	@override String get statusUnknown => 'Sconosciuto';
	@override String get openNostrProfile => 'Apri profilo Nostr';
	@override String get termsOfUsage => 'Termini di utilizzo';
}

// Path: coordinator.management
class _Translations$coordinator$management$it extends Translations$coordinator$management$en {
	_Translations$coordinator$management$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gestione Coordinatori';
	@override String get availableCoordinators => 'Coordinatori';
	@override String get noCoordinators => 'Nessun coordinatore trovato.';
	@override String get online => 'Online';
	@override String get unknownOffline => 'Sconosciuto/Offline';
	@override String get openNostrProfile => 'Apri Profilo Nostr';
	@override String get enable => 'Abilita';
	@override String get remove => 'Rimuovi';
	@override String get addCustomWhitelist => 'Aggiungi coordinatore personalizzato';
	@override String get addCustomWhitelistHint => 'npub1...';
	@override String get add => 'Aggiungi';
	@override String get coordinatorDisabled => 'Coordinatore disabilitato';
	@override String get coordinatorEnabled => 'Coordinatore abilitato';
	@override String get coordinatorAdded => 'Coordinatore aggiunto alla whitelist personalizzata';
	@override String get coordinatorRemoved => 'Coordinatore rimosso dalla whitelist personalizzata';
	@override String get coordinatorAddInfoUnavailable => 'Nessuna informazione sul coordinatore trovata sui relay. Coordinatore non aggiunto.';
	@override String get pleaseEnterNpub => 'Inserisci un npub';
	@override String get error => 'Errore';
	@override String get metricYourOffers => 'Le tue offerte';
	@override String get metricYourOffersTooltip => 'Numero di offerte che hai completato con successo con questo coordinatore.';
	@override String get metricNetworkOffers => 'Offerte (30g)';
	@override String get metricNetworkOffersTooltip => 'Offerte risolte con successo da questo coordinatore tra tutti gli utenti negli ultimi 30 giorni.';
}

// Path: maker.roleSelection
class _Translations$maker$roleSelection$it extends Translations$maker$roleSelection$en {
	_Translations$maker$roleSelection$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get button => 'PAGA con Lightning';
}

// Path: maker.amountForm
class _Translations$maker$amountForm$it extends Translations$maker$amountForm$en {
	_Translations$maker$amountForm$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$amountForm$progress$it progress = _Translations$maker$amountForm$progress$it._(_root);
	@override late final _Translations$maker$amountForm$labels$it labels = _Translations$maker$amountForm$labels$it._(_root);
	@override late final _Translations$maker$amountForm$actions$it actions = _Translations$maker$amountForm$actions$it._(_root);
	@override late final _Translations$maker$amountForm$tooltips$it tooltips = _Translations$maker$amountForm$tooltips$it._(_root);
	@override late final _Translations$maker$amountForm$category$it category = _Translations$maker$amountForm$category$it._(_root);
	@override late final _Translations$maker$amountForm$onboarding$it onboarding = _Translations$maker$amountForm$onboarding$it._(_root);
	@override late final _Translations$maker$amountForm$errors$it errors = _Translations$maker$amountForm$errors$it._(_root);
}

// Path: maker.payInvoice
class _Translations$maker$payInvoice$it extends Translations$maker$payInvoice$en {
	_Translations$maker$payInvoice$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paga questa fattura Hold:';
	@override late final _Translations$maker$payInvoice$actions$it actions = _Translations$maker$payInvoice$actions$it._(_root);
	@override late final _Translations$maker$payInvoice$feedback$it feedback = _Translations$maker$payInvoice$feedback$it._(_root);
	@override late final _Translations$maker$payInvoice$errors$it errors = _Translations$maker$payInvoice$errors$it._(_root);
}

// Path: maker.waitTaker
class _Translations$maker$waitTaker$it extends Translations$maker$waitTaker$en {
	_Translations$maker$waitTaker$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get message => 'In attesa che un Taker riservi la tua offerta...';
	@override String progressLabel({required Object time}) => 'In attesa del taker: ${time}';
	@override String get errorActiveOfferDetailsLost => 'Errore: Dettagli dell\'offerta attiva persi.';
	@override String get errorFailedToRetrieveBlik => 'Errore: Impossibile recuperare il codice BLIK.';
	@override String errorRetrievingBlik({required Object details}) => 'Errore nel recupero del codice BLIK: ${details}';
	@override String offerNoLongerAvailable({required Object status}) => 'L\'offerta non è più disponibile (Stato: ${status}).';
	@override String get errorCouldNotIdentifyOffer => 'Errore: Impossibile identificare l\'offerta da annullare.';
	@override String offerCannotBeCancelled({required Object status}) => 'L\'offerta non può essere annullata nello stato attuale (${status}).';
	@override String get offerCancelledSuccessfully => 'Offerta annullata con successo.';
	@override String failedToCancelOffer({required Object details}) => 'Impossibile annullare l\'offerta: ${details}';
	@override String get offerExpiredTitle => 'Offerta scaduta';
	@override String get offerExpiredMessage => 'Nessun taker ha riservato la tua offerta in tempo.';
	@override String get recreateOffer => 'Nuova offerta — stesso importo';
}

// Path: maker.waitForBlik
class _Translations$maker$waitForBlik$it extends Translations$maker$waitForBlik$en {
	_Translations$maker$waitForBlik$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'In attesa di BLIK';
	@override String get messageInfo => 'Il Taker ha riservato l\'offerta!';
	@override String get messageWaiting => 'In attesa del codice BLIK...';
	@override String progressLabel({required Object seconds}) => 'Riservata: ${seconds} s rimanenti';
}

// Path: maker.confirmPayment
class _Translations$maker$confirmPayment$it extends Translations$maker$confirmPayment$en {
	_Translations$maker$confirmPayment$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Codice BLIK ricevuto!';
	@override String get retrieving => 'Recupero codice BLIK...';
	@override String get instructions => 'Inserisci questo codice nel terminale di pagamento. Quando il Taker conferma nella sua app bancaria e il pagamento va a buon fine, premi Conferma qui sotto.';
	@override String get instruction1 => 'Inserisci il codice nella richiesta di pagamento BLIK.';
	@override String get instruction2 => 'Attendi che il Taker confermi il pagamento nella sua app.';
	@override String get instruction3 => 'Quando il pagamento va a buon fine, premi Conferma qui sotto:';
	@override String get takerChargedWarning => 'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto bancario. Se lo contrassegni come non valido, si creerà un conflitto.';
	@override String get expiredTitle => 'Codice BLIK Scaduto';
	@override String get expiredWarning => 'Il codice BLIK è scaduto. Devi confermare manualmente lo stato del pagamento:';
	@override String get expiredInstruction1 => 'Se il pagamento BLIK è andato a buon fine e hai completato l\'acquisto, clicca "Conferma pagamento riuscito" qui sotto.';
	@override String get expiredInstruction2 => 'Se il pagamento BLIK è fallito o non è stato completato, clicca "Codice BLIK Non Valido" qui sotto.';
	@override late final _Translations$maker$confirmPayment$actions$it actions = _Translations$maker$confirmPayment$actions$it._(_root);
	@override late final _Translations$maker$confirmPayment$confirmDialog$it confirmDialog = _Translations$maker$confirmPayment$confirmDialog$it._(_root);
	@override late final _Translations$maker$confirmPayment$invalidBlikDisputeDialog$it invalidBlikDisputeDialog = _Translations$maker$confirmPayment$invalidBlikDisputeDialog$it._(_root);
	@override late final _Translations$maker$confirmPayment$feedback$it feedback = _Translations$maker$confirmPayment$feedback$it._(_root);
	@override late final _Translations$maker$confirmPayment$errors$it errors = _Translations$maker$confirmPayment$errors$it._(_root);
}

// Path: maker.invalidBlik
class _Translations$maker$invalidBlik$it extends Translations$maker$invalidBlik$en {
	_Translations$maker$invalidBlik$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Codice BLIK Non Valido';
	@override String get info => 'Hai contrassegnato il codice BLIK come non valido. In attesa che il taker fornisca un nuovo codice o avvii una disputa.';
}

// Path: maker.conflict
class _Translations$maker$conflict$it extends Translations$maker$conflict$en {
	_Translations$maker$conflict$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conflitto Offerta';
	@override String get headline => 'Conflitto Offerta Segnalato';
	@override String get body => 'Hai contrassegnato il codice BLIK come non valido, ma il Taker ha segnalato un conflitto, indicando che ritiene il pagamento andato a buon fine.';
	@override String get instructions => 'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.';
	@override late final _Translations$maker$conflict$actions$it actions = _Translations$maker$conflict$actions$it._(_root);
	@override late final _Translations$maker$conflict$disputeDialog$it disputeDialog = _Translations$maker$conflict$disputeDialog$it._(_root);
	@override late final _Translations$maker$conflict$feedback$it feedback = _Translations$maker$conflict$feedback$it._(_root);
	@override late final _Translations$maker$conflict$errors$it errors = _Translations$maker$conflict$errors$it._(_root);
	@override late final _Translations$maker$conflict$nostrContact$it nostrContact = _Translations$maker$conflict$nostrContact$it._(_root);
}

// Path: maker.success
class _Translations$maker$success$it extends Translations$maker$success$en {
	_Translations$maker$success$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offerta completata';
	@override String get headline => 'Pagamento confermato!';
	@override String get subtitle => 'Il Taker verrà ora pagato.';
	@override String get detailsTitle => 'Dettagli offerta:';
	@override String duration({required Object time}) => 'L\'offerta ha richiesto ${time}!';
}

// Path: taker.roleSelection
class _Translations$taker$roleSelection$it extends Translations$taker$roleSelection$en {
	_Translations$taker$roleSelection$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get button => 'VENDI codice BLIK per satoshi';
}

// Path: taker.progress
class _Translations$taker$progress$it extends Translations$taker$progress$en {
	_Translations$taker$progress$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get step1 => 'Invia BLIK';
	@override String get step2 => 'Conferma BLIK';
	@override String get step3 => 'Ricevi Pagamento';
}

// Path: taker.submitBlik
class _Translations$taker$submitBlik$it extends Translations$taker$submitBlik$en {
	_Translations$taker$submitBlik$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inserisci BLIK a 6 cifre';
	@override String get label => 'Codice BLIK';
	@override String get instruction => 'Inserisci BLIK prima che scada il tempo...';
	@override String timeLimit({required Object seconds}) => 'Inserisci BLIK entro: ${seconds} s';
	@override String get timeExpired => 'Il tempo per inserire il codice BLIK è scaduto.';
	@override late final _Translations$taker$submitBlik$actions$it actions = _Translations$taker$submitBlik$actions$it._(_root);
	@override late final _Translations$taker$submitBlik$feedback$it feedback = _Translations$taker$submitBlik$feedback$it._(_root);
	@override late final _Translations$taker$submitBlik$validation$it validation = _Translations$taker$submitBlik$validation$it._(_root);
	@override late final _Translations$taker$submitBlik$errors$it errors = _Translations$taker$submitBlik$errors$it._(_root);
	@override late final _Translations$taker$submitBlik$details$it details = _Translations$taker$submitBlik$details$it._(_root);
}

// Path: taker.waitConfirmation
class _Translations$taker$waitConfirmation$it extends Translations$taker$waitConfirmation$en {
	_Translations$taker$waitConfirmation$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'In attesa del Maker';
	@override String statusLabel({required Object status}) => 'Stato offerta: ${status}';
	@override String waitingMaker({required Object seconds}) => 'In attesa della conferma del Maker: ${seconds} s';
	@override String waitingMakerConfirmation({required Object seconds}) => 'In attesa che il Maker confermi che il BLIK è corretto. Tempo rimanente: ${seconds}s';
	@override String importantNotice({required Object amount, required Object currency}) => 'MOLTO IMPORTANTE: Assicurati di accettare solo la conferma BLIK per ${amount} ${currency}';
	@override String importantBlikAmountConfirmation({required Object amount, required Object currency}) => 'MOLTO IMPORTANTE: Nella tua app bancaria, assicurati di confermare un pagamento BLIK per esattamente ${amount} ${currency}.';
	@override String get instructions => 'Il maker deve ora inserirlo nel terminale di pagamento entro 2 minuti. Dovrai poi accettare il codice BLIK nella tua app bancaria.';
	@override late final _Translations$taker$waitConfirmation$categoryReminder$it categoryReminder = _Translations$taker$waitConfirmation$categoryReminder$it._(_root);
	@override String get waitingForMakerToReceive => 'In attesa che il maker riceva il tuo codice BLIK...';
	@override String get makerReceivedBlik => 'Il maker ha ricevuto il tuo codice BLIK.';
	@override String get timerExpiredMessage => 'Il tempo di scadenza BLIK di 2 minuti è passato. In attesa che il maker confermi o contrassegni il codice come non valido.';
	@override String get timerExpiredActions => 'Il tempo di scadenza BLIK di 2 minuti è passato ma il maker non ha ricevuto il codice BLIK. Puoi rinviare un nuovo codice BLIK o annullare.';
	@override String get resendBlikButton => 'Rinvia Nuovo Codice BLIK';
	@override String get navigatedHome => 'Tornato alla home.';
	@override String get expiredTitle => 'Codice BLIK Scaduto';
	@override String get expiredWarning => 'Il maker non ha ricevuto il codice BLIK quindi non ha potuto utilizzarlo.';
	@override String get expiredRelistCountdownLabel => 'Nuova pubblicazione automatica tra';
	@override String get expiredSentWarning => 'Il maker non ha ancora confermato il pagamento. Cosa vuoi fare?';
	@override String get expiredInstruction1 => 'Se vuoi riprovare con un nuovo codice BLIK, rinnova la prenotazione.';
	@override String get expiredInstruction2 => 'Se non vuoi più completare questa transazione, annulla la prenotazione.';
	@override String get expiredInstruction3 => 'Se il pagamento BLIK è stato addebitato sul tuo conto bancario, non preoccuparti, i bitcoin sono ancora al sicuro presso il coordinatore.';
	@override late final _Translations$taker$waitConfirmation$takerCharged$it takerCharged = _Translations$taker$waitConfirmation$takerCharged$it._(_root);
	@override late final _Translations$taker$waitConfirmation$expiredActions$it expiredActions = _Translations$taker$waitConfirmation$expiredActions$it._(_root);
	@override late final _Translations$taker$waitConfirmation$feedback$it feedback = _Translations$taker$waitConfirmation$feedback$it._(_root);
	@override late final _Translations$taker$waitConfirmation$errors$it errors = _Translations$taker$waitConfirmation$errors$it._(_root);
}

// Path: taker.paymentProcess
class _Translations$taker$paymentProcess$it extends Translations$taker$paymentProcess$en {
	_Translations$taker$paymentProcess$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Processo di Pagamento';
	@override String get waitingForOfferUpdate => 'In attesa dell\'aggiornamento dello stato dell\'offerta...';
	@override late final _Translations$taker$paymentProcess$states$it states = _Translations$taker$paymentProcess$states$it._(_root);
	@override late final _Translations$taker$paymentProcess$steps$it steps = _Translations$taker$paymentProcess$steps$it._(_root);
	@override late final _Translations$taker$paymentProcess$errors$it errors = _Translations$taker$paymentProcess$errors$it._(_root);
	@override late final _Translations$taker$paymentProcess$loading$it loading = _Translations$taker$paymentProcess$loading$it._(_root);
	@override late final _Translations$taker$paymentProcess$actions$it actions = _Translations$taker$paymentProcess$actions$it._(_root);
}

// Path: taker.paymentFailed
class _Translations$taker$paymentFailed$it extends Translations$taker$paymentFailed$en {
	_Translations$taker$paymentFailed$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento Fallito';
	@override String instructions({required Object netAmount}) => 'Fornisci una nuova fattura Lightning per ${netAmount}';
	@override late final _Translations$taker$paymentFailed$form$it form = _Translations$taker$paymentFailed$form$it._(_root);
	@override late final _Translations$taker$paymentFailed$actions$it actions = _Translations$taker$paymentFailed$actions$it._(_root);
	@override late final _Translations$taker$paymentFailed$errors$it errors = _Translations$taker$paymentFailed$errors$it._(_root);
	@override late final _Translations$taker$paymentFailed$walletSection$it walletSection = _Translations$taker$paymentFailed$walletSection$it._(_root);
	@override late final _Translations$taker$paymentFailed$loading$it loading = _Translations$taker$paymentFailed$loading$it._(_root);
	@override late final _Translations$taker$paymentFailed$success$it success = _Translations$taker$paymentFailed$success$it._(_root);
}

// Path: taker.paymentSuccess
class _Translations$taker$paymentSuccess$it extends Translations$taker$paymentSuccess$en {
	_Translations$taker$paymentSuccess$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento Riuscito';
	@override String get message => 'Il tuo pagamento è stato elaborato con successo.';
	@override late final _Translations$taker$paymentSuccess$actions$it actions = _Translations$taker$paymentSuccess$actions$it._(_root);
}

// Path: taker.invalidBlik
class _Translations$taker$invalidBlik$it extends Translations$taker$invalidBlik$en {
	_Translations$taker$invalidBlik$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Codice BLIK Non Valido';
	@override String get message => 'Il Maker ha Rifiutato il Codice BLIK';
	@override String get explanation => 'Il maker dell\'offerta ha indicato che il codice BLIK fornito non era valido o non ha funzionato.\n\nCosa vuoi fare?';
	@override String get werentCharged => 'Se NON ti è stato addebitato:';
	@override String get wereCharged => 'Se ti è stato addebitato:';
	@override late final _Translations$taker$invalidBlik$actions$it actions = _Translations$taker$invalidBlik$actions$it._(_root);
	@override late final _Translations$taker$invalidBlik$feedback$it feedback = _Translations$taker$invalidBlik$feedback$it._(_root);
	@override late final _Translations$taker$invalidBlik$errors$it errors = _Translations$taker$invalidBlik$errors$it._(_root);
}

// Path: taker.conflict
class _Translations$taker$conflict$it extends Translations$taker$conflict$en {
	_Translations$taker$conflict$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conflitto Offerta';
	@override String get headline => 'Conflitto Offerta Segnalato';
	@override String get body => 'Il Maker ha contrassegnato il codice BLIK come non valido, ma tu hai segnalato un conflitto, indicando che ritieni il pagamento andato a buon fine.';
	@override String get instructions => 'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.';
	@override late final _Translations$taker$conflict$actions$it actions = _Translations$taker$conflict$actions$it._(_root);
	@override late final _Translations$taker$conflict$feedback$it feedback = _Translations$taker$conflict$feedback$it._(_root);
	@override late final _Translations$taker$conflict$errors$it errors = _Translations$taker$conflict$errors$it._(_root);
	@override late final _Translations$taker$conflict$nostrContact$it nostrContact = _Translations$taker$conflict$nostrContact$it._(_root);
}

// Path: blik.instructions
class _Translations$blik$instructions$it extends Translations$blik$instructions$en {
	_Translations$blik$instructions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get taker => 'Una volta che il Maker inserisce il codice BLIK, dovrai confermare il pagamento nella tua app bancaria. Assicurati che l\'importo sia corretto prima di confermare.';
}

// Path: home.notifications
class _Translations$home$notifications$it extends Translations$home$notifications$en {
	_Translations$home$notifications$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ricevi notifiche sulle nuove offerte tramite:';
	@override String get telegram => 'Telegram';
	@override String get simplex => 'SimpleX';
	@override String get element => 'Element';
	@override String get signal => 'Signal';
}

// Path: home.statistics
class _Translations$home$statistics$it extends Translations$home$statistics$en {
	_Translations$home$statistics$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offerte Completate';
	@override String lifetimeCompact({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Totale: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}';
	@override String last7DaysCompact({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ultimi 7g: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}';
	@override String last7DaysSingleLine({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ultimi 7g: ${count} offerte  |  Media BLIK: ${avgBlikTime}  |  Media Pagato: ${avgPaidTime}';
	@override late final _Translations$home$statistics$errors$it errors = _Translations$home$statistics$errors$it._(_root);
}

// Path: generateNewKey.buttons
class _Translations$generateNewKey$buttons$it extends Translations$generateNewKey$buttons$en {
	_Translations$generateNewKey$buttons$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Genera';
}

// Path: generateNewKey.errors
class _Translations$generateNewKey$errors$it extends Translations$generateNewKey$errors$en {
	_Translations$generateNewKey$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get activeOffer => 'Non puoi generare un nuovo Neko mentre hai un\'offerta attiva.';
	@override String get failed => 'Impossibile generare un nuovo Neko';
}

// Path: generateNewKey.feedback
class _Translations$generateNewKey$feedback$it extends Translations$generateNewKey$feedback$en {
	_Translations$generateNewKey$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get success => 'Nuovo Neko generato con successo!';
}

// Path: generateNewKey.tooltips
class _Translations$generateNewKey$tooltips$it extends Translations$generateNewKey$tooltips$en {
	_Translations$generateNewKey$tooltips$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Genera Nuovo Neko';
}

// Path: backup.feedback
class _Translations$backup$feedback$it extends Translations$backup$feedback$en {
	_Translations$backup$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Chiave privata copiata negli appunti!';
}

// Path: backup.tooltips
class _Translations$backup$tooltips$it extends Translations$backup$tooltips$en {
	_Translations$backup$tooltips$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get backup => 'Backup Neko';
}

// Path: restore.labels
class _Translations$restore$labels$it extends Translations$restore$labels$en {
	_Translations$restore$labels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get privateKey => 'Chiave Privata';
}

// Path: restore.buttons
class _Translations$restore$buttons$it extends Translations$restore$buttons$en {
	_Translations$restore$buttons$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Ripristina';
}

// Path: restore.errors
class _Translations$restore$errors$it extends Translations$restore$errors$en {
	_Translations$restore$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get invalidKey => 'Deve essere una stringa esadecimale di 64 caratteri.';
	@override String get failed => 'Ripristino fallito';
}

// Path: restore.feedback
class _Translations$restore$feedback$it extends Translations$restore$feedback$en {
	_Translations$restore$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get success => 'Neko ripristinato con successo! L\'app verrà riavviata.';
}

// Path: restore.tooltips
class _Translations$restore$tooltips$it extends Translations$restore$tooltips$en {
	_Translations$restore$tooltips$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Ripristina Neko';
}

// Path: system.errors
class _Translations$system$errors$it extends Translations$system$errors$en {
	_Translations$system$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get generic => 'Si è verificato un errore imprevisto. Riprova.';
	@override String get loadingTimeoutConfig => 'Errore nel caricamento della configurazione timeout.';
	@override String get loadingCoordinatorConfig => 'Errore nel caricamento della configurazione del coordinatore. Riprova.';
	@override String get noPublicKey => 'La tua chiave pubblica non è disponibile. Impossibile procedere.';
	@override String get internalOfferIncomplete => 'Errore interno: I dettagli dell\'offerta sono incompleti. Riprova.';
	@override String get loadingPublicKey => 'Errore nel caricamento della tua chiave pubblica. Riavvia l\'app.';
}

// Path: system.blik
class _Translations$system$blik$it extends Translations$system$blik$en {
	_Translations$system$blik$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Codice BLIK copiato negli appunti';
}

// Path: myOffers.filter
class _Translations$myOffers$filter$it extends Translations$myOffers$filter$en {
	_Translations$myOffers$filter$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tutte';
	@override String get active => 'Attive';
	@override String get completed => 'Completate';
	@override String get failed => 'Fallite';
}

// Path: myOffers.details
class _Translations$myOffers$details$it extends Translations$myOffers$details$en {
	_Translations$myOffers$details$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dettagli offerta';
	@override String get notFound => 'Offerta non trovata.';
	@override String get amount => 'Importo';
	@override String get fees => 'Commissioni';
	@override String get sats => 'Satoshi';
	@override String get maker => 'Maker';
	@override String get taker => 'Taker';
	@override String get yourFee => 'La tua commissione';
	@override String get makerFee => 'Commissione maker';
	@override String get takerFee => 'Commissione taker';
	@override String get coordinator => 'Coordinatore';
	@override String get createdAt => 'Creata';
	@override String get reservedAt => 'Prenotata';
	@override String get blikReceivedAt => 'BLIK inviato';
	@override String get makerConfirmedAt => 'Confermata';
	@override String get settledAt => 'Liquidata';
	@override String get takerPaidAt => 'Taker pagato';
	@override String get id => 'ID offerta';
	@override String get paymentHash => 'Hash pagamento';
	@override String get holdInvoice => 'Hold Invoice';
	@override String get continueActiveOffer => 'Continua offerta attiva';
	@override String after({required Object duration}) => 'dopo ${duration}';
}

// Path: landing.actions
class _Translations$landing$actions$it extends Translations$landing$actions$en {
	_Translations$landing$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get payBlik => 'Paga BLIK';
	@override String get payBlikSubtitle => 'con bitcoin';
	@override String get sellBlik => 'Compra bitcoin';
	@override String get sellBlikSubtitle => 'con BLIK';
	@override String get howItWorks => 'Come funziona?';
}

// Path: settings.offerCreation
class _Translations$settings$offerCreation$it extends Translations$settings$offerCreation$en {
	_Translations$settings$offerCreation$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Creazione offerte';
	@override String get defaultCategory => 'Categoria predefinita';
	@override String get preferredCoordinator => 'Coordinatore preferito';
	@override String get automaticCoordinator => 'Più affidabile';
	@override String get automaticCoordinatorDescription => 'Sceglie il coordinatore con la migliore reputazione, combinando le tue offerte completate e l\'attività complessiva della rete.';
	@override String get cheapestCoordinator => 'Più economico';
	@override String get cheapestCoordinatorDescription => 'Sceglie il coordinatore disponibile con la commissione del venditore più bassa per ogni offerta.';
	@override String get enablePremium => 'Abilita premio di prezzo';
	@override String get enablePremiumDescription => 'Mostra il cursore del premio durante la creazione delle offerte maker.';
	@override String get defaultPremium => 'Premio predefinito';
	@override String get defaultPremiumDisabled => 'Abilita il premio di prezzo per impostare un premio predefinito.';
	@override String get premiumPerCoordinatorNote => 'Ogni coordinatore imposta il proprio premio massimo, quindi il tuo valore predefinito è limitato dal coordinatore usato per un\'offerta.';
	@override late final _Translations$settings$offerCreation$categoryOptions$it categoryOptions = _Translations$settings$offerCreation$categoryOptions$it._(_root);
	@override late final _Translations$settings$offerCreation$dialogs$it dialogs = _Translations$settings$offerCreation$dialogs$it._(_root);
}

// Path: settings.display
class _Translations$settings$display$it extends Translations$settings$display$en {
	_Translations$settings$display$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aspetto';
	@override String get bitcoinUnit => 'Unità bitcoin';
	@override String get bitcoinUnitDescription => 'Scegli come mostrare gli importi bitcoin in tutta l\'app.';
	@override late final _Translations$settings$display$unitOptions$it unitOptions = _Translations$settings$display$unitOptions$it._(_root);
}

// Path: notificationSettings.newOfferAlerts
class _Translations$notificationSettings$newOfferAlerts$it extends Translations$notificationSettings$newOfferAlerts$en {
	_Translations$notificationSettings$newOfferAlerts$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Avvisi nuove offerte';
	@override String get description => 'Se abilitato, BitBlik ti notificherà delle nuove offerte disponibili da accettare dai tuoi coordinatori abilitati mentre l\'app è in background. Potrebbe essere più veloce dei messenger esterni.';
}

// Path: wallet.missingReceiving
class _Translations$wallet$missingReceiving$it extends Translations$wallet$missingReceiving$en {
	_Translations$wallet$missingReceiving$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portafoglio di ricezione richiesto';
	@override String get message => 'Nessun portafoglio configurato per ricevere. Aggiungine uno nelle impostazioni Portafoglio per accettare offerte.';
	@override String get openSettings => 'Impostazioni portafoglio';
}

// Path: nwc.labels
class _Translations$nwc$labels$it extends Translations$nwc$labels$en {
	_Translations$nwc$labels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get connectionString => 'Stringa di Connessione NWC';
	@override String get hint => 'nostr+walletconnect://...';
	@override String get status => 'Stato Connessione';
	@override String get connected => 'Connesso';
	@override String get disconnected => 'Disconnesso';
	@override String get scanQrCode => 'Scansiona il codice QR con la tua connessione NWC';
	@override String get balance => 'Saldo';
	@override String get budget => 'Budget';
	@override String get usedBudget => 'Usato';
	@override String get totalBudget => 'Totale';
	@override String get renewsIn => 'Si rinnova tra';
	@override String get renewalPeriod => 'Periodo di Rinnovo';
	@override String get relay => 'Relay';
	@override String get relays => 'Relay';
}

// Path: nwc.prompts
class _Translations$nwc$prompts$it extends Translations$nwc$prompts$en {
	_Translations$nwc$prompts$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Inserisci la tua stringa di connessione NWC';
	@override String get connect => 'Connetti Portafoglio';
	@override String get disconnect => 'Disconnetti';
	@override String get confirmDisconnect => 'Sei sicuro di voler disconnettere il tuo portafoglio NWC?';
	@override String get pasteConnection => 'Incolla stringa di connessione';
	@override String get chooseMethod => 'Scegli come connettere il tuo portafoglio Lightning';
	@override String get howToGet => 'Non hai ancora una connessione NWC? Scopri come ottenerla!';
	@override String get learnMore => 'Scopri di più su NWC';
}

// Path: nwc.actions
class _Translations$nwc$actions$it extends Translations$nwc$actions$en {
	_Translations$nwc$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get connectAlbyGo => 'Connetti con Alby Go';
	@override String get connectNwc => 'Scansiona QR Code NWC';
}

// Path: nwc.feedback
class _Translations$nwc$feedback$it extends Translations$nwc$feedback$en {
	_Translations$nwc$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Portafoglio NWC connesso con successo!';
	@override String get disconnected => 'Portafoglio NWC disconnesso';
	@override String get connecting => 'Connessione al portafoglio NWC...';
	@override String get loadingWalletInfo => 'Caricamento informazioni portafoglio...';
}

// Path: nwc.errors
class _Translations$nwc$errors$it extends Translations$nwc$errors$en {
	_Translations$nwc$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String connecting({required Object details}) => 'Errore nella connessione a NWC: ${details}';
	@override String disconnecting({required Object details}) => 'Errore nella disconnessione da NWC: ${details}';
	@override String get invalid => 'Stringa di connessione NWC non valida';
	@override String get required => 'La stringa di connessione NWC è obbligatoria';
	@override String get loadingBalance => 'Impossibile caricare il saldo del portafoglio';
	@override String get loadingBudget => 'Impossibile caricare il budget del portafoglio';
}

// Path: nwc.time
class _Translations$nwc$time$it extends Translations$nwc$time$en {
	_Translations$nwc$time$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String minutes({required Object count}) => '${count}m';
	@override String hours({required Object count}) => '${count}h';
	@override String days({required Object count}) => '${count}g';
	@override String get justNow => 'adesso';
}

// Path: relays.status
class _Translations$relays$status$it extends Translations$relays$status$en {
	_Translations$relays$status$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Connesso';
	@override String get connecting => 'Connessione';
	@override String get reconnecting => 'Riconnessione';
	@override String get disconnected => 'Disconnesso';
}

// Path: relays.popup
class _Translations$relays$popup$it extends Translations$relays$popup$en {
	_Translations$relays$popup$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String title({required Object connected, required Object total}) => 'Relay (${connected}/${total} connessi)';
	@override String get connectingMessage => 'Connessione ai relay...';
}

// Path: offerNotifications.activeService
class _Translations$offerNotifications$activeService$it extends Translations$offerNotifications$activeService$en {
	_Translations$offerNotifications$activeService$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'In attesa di nuove offerte';
	@override String get body => 'Servizio in background che monitora gli eventi Nostr delle offerte BitBlik.';
}

// Path: offerNotifications.funded
class _Translations$offerNotifications$funded$it extends Translations$offerNotifications$funded$en {
	_Translations$offerNotifications$funded$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offerta finanziata';
	@override String get body => 'La tua fattura hold è stata accettata. L\'offerta è ora attiva.';
}

// Path: offerNotifications.reserved
class _Translations$offerNotifications$reserved$it extends Translations$offerNotifications$reserved$en {
	_Translations$offerNotifications$reserved$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offerta prenotata';
	@override String get body => 'Un taker ha prenotato la tua offerta.';
}

// Path: offerNotifications.blikReady
class _Translations$offerNotifications$blikReady$it extends Translations$offerNotifications$blikReady$en {
	_Translations$offerNotifications$blikReady$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Codice BLIK pronto';
	@override String get body => 'Il tuo codice BLIK è pronto per essere visualizzato.';
}

// Path: offerNotifications.newOffer
class _Translations$offerNotifications$newOffer$it extends Translations$offerNotifications$newOffer$en {
	_Translations$offerNotifications$newOffer$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuova offerta disponibile';
	@override String body({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}';
	@override String premiumSuffix({required Object percent}) => '+${percent}% premio';
}

// Path: offerNotifications.categories
class _Translations$offerNotifications$categories$it extends Translations$offerNotifications$categories$en {
	_Translations$offerNotifications$categories$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Negozio';
	@override String get atm => 'ATM';
	@override String get online => 'Online';
}

// Path: offerNotifications.blikPendingReminder
class _Translations$offerNotifications$blikPendingReminder$it extends Translations$offerNotifications$blikPendingReminder$en {
	_Translations$offerNotifications$blikPendingReminder$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'BLIK in attesa di azione';
	@override String get body => 'Conferma il pagamento o segna il codice BLIK come non valido.';
}

// Path: offerNotifications.takerCharged
class _Translations$offerNotifications$takerCharged$it extends Translations$offerNotifications$takerCharged$en {
	_Translations$offerNotifications$takerCharged$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'BLIK addebitato';
	@override String get body => 'Il taker segnala che il BLIK è stato addebitato. Conferma o segna come non valido.';
}

// Path: offerNotifications.invalidBlik
class _Translations$offerNotifications$invalidBlik$it extends Translations$offerNotifications$invalidBlik$en {
	_Translations$offerNotifications$invalidBlik$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'BLIK non valido';
	@override String get body => 'Il maker ha contrassegnato il tuo codice BLIK come non valido.';
}

// Path: offerNotifications.takerPaid
class _Translations$offerNotifications$takerPaid$it extends Translations$offerNotifications$takerPaid$en {
	_Translations$offerNotifications$takerPaid$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento ricevuto';
	@override String get body => 'Il tuo pagamento Lightning è stato inviato.';
}

// Path: offers.details.categories
class _Translations$offers$details$categories$it extends Translations$offers$details$categories$en {
	_Translations$offers$details$categories$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Negozio, caffè o ristorante';
	@override String get atmCashout => 'Prelievo contanti da ATM';
	@override String get onlineService => 'Prodotto o servizio online';
}

// Path: offers.details.consents
class _Translations$offers$details$consents$it extends Translations$offers$details$consents$en {
	_Translations$offers$details$consents$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Alcuni ATM aggiungono una commissione extra oltre all\'importo dell\'offerta. Accettando questa offerta, accetti qualsiasi costo bancario aggiuntivo richiesto dall\'ATM.';
	@override String get ecommerce => 'Per vari motivi — come articolo esaurito, correzione di un sovrapprezzo o altri problemi lato commerciante — il commerciante online potrebbe automaticamente restituire denaro sul conto bancario collegato al BLIK che hai generato. Quei fondi arrivano sul tuo conto e non ti appartengono. Se succede, contatta il coordinatore in buona fede e organizza la restituzione dei fondi al maker. Accettando questa offerta, accetti questi termini e giuri solennemente di agire onestamente in tali situazioni.';
}

// Path: maker.amountForm.progress
class _Translations$maker$amountForm$progress$it extends Translations$maker$amountForm$progress$en {
	_Translations$maker$amountForm$progress$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Crea Offerta';
	@override String get step2 => '2. Attendi Taker';
	@override String get step3 => '3. Usa BLIK';
}

// Path: maker.amountForm.labels
class _Translations$maker$amountForm$labels$it extends Translations$maker$amountForm$labels$en {
	_Translations$maker$amountForm$labels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get coordinator => 'Coordinatore';
	@override String get category => 'Categoria';
	@override String get exchangeRate => 'Tasso di Cambio';
	@override String get fee => 'Commissione';
	@override String get satoshisToPay => 'Importo da Pagare';
	@override String get enterAmount => 'Inserisci importo';
	@override String get tapToSelect => 'Tocca per selezionare';
	@override String get premium => 'Premio';
}

// Path: maker.amountForm.actions
class _Translations$maker$amountForm$actions$it extends Translations$maker$amountForm$actions$en {
	_Translations$maker$amountForm$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get generateInvoice => 'Genera Fattura';
}

// Path: maker.amountForm.tooltips
class _Translations$maker$amountForm$tooltips$it extends Translations$maker$amountForm$tooltips$en {
	_Translations$maker$amountForm$tooltips$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String feeInfo({required Object feePercent}) => 'Il coordinatore applica una commissione maker del ${feePercent}%. Questa commissione viene detratta dal tuo pagamento Lightning.';
	@override String get payInfo => 'Questo calcolo si basa sui tassi di cambio recuperati dal client. Il coordinatore calcolerà l\'importo esatto, e l\'importo della fattura sarà quello finale e definitivo da pagare.';
	@override String get premiumInfo => 'Un premio opzionale ti permette di vendere i tuoi sat sopra il prezzo di mercato. Il premio riduce i sat bloccati nella tua fattura hold per lo stesso importo fiat, così il taker paga sopra il mercato e tu trattieni la differenza. Predefinito disattivato (0%). Il premio massimo è impostato dal coordinatore selezionato.';
}

// Path: maker.amountForm.category
class _Translations$maker$amountForm$category$it extends Translations$maker$amountForm$category$en {
	_Translations$maker$amountForm$category$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Categoria offerta';
	@override late final _Translations$maker$amountForm$category$options$it options = _Translations$maker$amountForm$category$options$it._(_root);
	@override late final _Translations$maker$amountForm$category$shortLabels$it shortLabels = _Translations$maker$amountForm$category$shortLabels$it._(_root);
	@override String get atmHint => 'I taker vedranno che questa offerta serve per un prelievo ATM e potrebbero evitarla se la loro banca applica commissioni aggiuntive.';
	@override String get physicalShopHint => 'Il posto ideale per usare Bitblik è una cassa self-service — poiché aspettare che un taker riservi, generi e confermi il codice BLIK potrebbe richiedere un paio di minuti. Funziona benissimo in negozi, caffè e ristoranti. Se ti senti abbastanza coraggioso da far aspettare un cassiere normale (e le persone in coda dietro di te) quei pochi minuti, complimenti.';
	@override String get ecommerceWarningTitle => 'Rischio rimborso negozio online';
	@override String get ecommerceWarningBody => 'Per vari motivi — come articolo esaurito, correzione di un sovrapprezzo o altri problemi lato commerciante — il negozio online potrebbe emettere automaticamente un rimborso sul conto bancario collegato al BLIK, che è il conto del taker. Il coordinatore non può obbligare il taker a restituire quei fondi a te.';
	@override String get ecommerceConfirmation => 'Capisco il rischio di rimborso e aggiungerò una nota all\'ordine per chiedere al commerciante di rimborsare su un conto diverso se necessario.';
	@override String get whyThisIsNeeded => 'perché è necessario?';
}

// Path: maker.amountForm.onboarding
class _Translations$maker$amountForm$onboarding$it extends Translations$maker$amountForm$onboarding$en {
	_Translations$maker$amountForm$onboarding$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get titlePrefix => 'Novità';
	@override String get title => 'Scegli la categoria dell\'offerta';
	@override String get body => 'Prima di generare la fattura, scegli la categoria che descrive meglio ciò che stai pagando.';
	@override String get showWhy => 'Perché è importante?';
	@override String get hideWhy => 'Nascondi dettagli';
	@override String get whyTitle => 'La categoria giusta aiuta i taker a decidere in modo sicuro';
	@override String get whyBody => 'Situazioni diverse comportano aspettative e rischi diversi. I prelievi ATM possono includere commissioni bancarie extra, mentre gli acquisti online possono avere casi particolari sui rimborsi. Selezionare la categoria corretta dà ai taker il contesto necessario prima di accettare la tua offerta.';
	@override String get cta => 'Ho capito';
}

// Path: maker.amountForm.errors
class _Translations$maker$amountForm$errors$it extends Translations$maker$amountForm$errors$en {
	_Translations$maker$amountForm$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String initiating({required Object details}) => 'Errore nell\'avvio dell\'offerta: ${details}';
	@override String get publicKeyNotLoaded => 'Errore: Chiave pubblica non ancora caricata.';
	@override String get noCoordinatorMatchesAmount => 'Nessun coordinatore supporta questo importo. Prova con un valore diverso.';
	@override String get categoryRequired => 'Seleziona una categoria per l\'offerta.';
	@override String get ecommerceConfirmationRequired => 'Conferma il rischio di rimborso del negozio online prima di continuare.';
}

// Path: maker.payInvoice.actions
class _Translations$maker$payInvoice$actions$it extends Translations$maker$payInvoice$actions$en {
	_Translations$maker$payInvoice$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get copy => 'Copia Fattura';
	@override String get payInWallet => 'Apri nel Wallet Esterno';
	@override String get connectWallet => 'Connetti Wallet';
	@override String get payWithNwc => 'Paga';
	@override String get paying => 'Pagamento in corso...';
}

// Path: maker.payInvoice.feedback
class _Translations$maker$payInvoice$feedback$it extends Translations$maker$payInvoice$feedback$en {
	_Translations$maker$payInvoice$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Fattura copiata negli appunti!';
	@override String get waitingConfirmation => 'In attesa della conferma del pagamento...';
	@override String get nwcConnected => 'Wallet NWC connesso!';
	@override String get nwcPaymentSuccess => 'Pagamento riuscito!';
}

// Path: maker.payInvoice.errors
class _Translations$maker$payInvoice$errors$it extends Translations$maker$payInvoice$errors$en {
	_Translations$maker$payInvoice$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get couldNotOpenApp => 'Impossibile aprire l\'app Lightning per la fattura.';
	@override String openingApp({required Object details}) => 'Errore nell\'apertura dell\'app Lightning: ${details}';
	@override String get publicKeyNotAvailable => 'La chiave pubblica non è disponibile.';
	@override String get couldNotFetchActive => 'Impossibile recuperare i dettagli dell\'offerta attiva. Potrebbe essere scaduta.';
	@override String nwcPaymentFailed({required Object details}) => 'Pagamento fallito: ${details}';
	@override String get nwcNotConnected => 'Wallet NWC non connesso';
	@override String insufficientBalance({required Object required, required Object available}) => 'Saldo insufficiente. Necessari ${required} sats, disponibili ${available} sats';
	@override String get cancelOfferAlreadyFunded => 'Il coordinatore segnala che questa offerta è già finanziata. Non può essere annullata ora.';
	@override String cancelFailed({required Object details}) => 'Impossibile annullare l\'offerta: ${details}';
}

// Path: maker.confirmPayment.actions
class _Translations$maker$confirmPayment$actions$it extends Translations$maker$confirmPayment$actions$en {
	_Translations$maker$confirmPayment$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Conferma pagamento riuscito';
	@override String get markInvalid => 'Codice BLIK Non Valido';
	@override String get copyBlik => 'Copia BLIK';
}

// Path: maker.confirmPayment.confirmDialog
class _Translations$maker$confirmPayment$confirmDialog$it extends Translations$maker$confirmPayment$confirmDialog$en {
	_Translations$maker$confirmPayment$confirmDialog$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confermare il Pagamento?';
	@override String get content => 'Questa azione è irreversibile. Dopo la conferma:\n\n• Il Taker riceverà i fondi immediatamente\n• Il coordinatore non potrà contestare i fondi\n• Non puoi annullare questa azione\n\nConferma solo se il pagamento BLIK è andato a buon fine.';
	@override String get cancel => 'Annulla';
	@override String get confirmButton => 'Sì, Conferma Pagamento';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _Translations$maker$confirmPayment$invalidBlikDisputeDialog$it extends Translations$maker$confirmPayment$invalidBlikDisputeDialog$en {
	_Translations$maker$confirmPayment$invalidBlikDisputeDialog$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aprire una Disputa?';
	@override String get content => 'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto.\n\nContrassegnarlo come non valido aprirà immediatamente una DISPUTA che richiede l\'intervento del coordinatore.\n\n• Potrebbe essere addebitata una commissione per disputa se il verdetto sarà contro di te\n• La fattura hold verrà saldata immediatamente\n• Sarà necessaria una verifica manuale\n\nProcedi solo se sei certo che il pagamento BLIK NON è andato a buon fine.';
	@override String get cancel => 'Annulla';
	@override String get confirmButton => 'Sì, Apri Disputa';
}

// Path: maker.confirmPayment.feedback
class _Translations$maker$confirmPayment$feedback$it extends Translations$maker$confirmPayment$feedback$en {
	_Translations$maker$confirmPayment$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Il Maker ha confermato il pagamento.';
	@override String get confirmedTakerPaid => 'Pagamento confermato! Il Taker riceverà i fondi.';
	@override String progressLabel({required Object seconds}) => 'Conferma in corso: ${seconds} s rimanenti';
}

// Path: maker.confirmPayment.errors
class _Translations$maker$confirmPayment$errors$it extends Translations$maker$confirmPayment$errors$en {
	_Translations$maker$confirmPayment$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get failedToRetrieve => 'Errore: Impossibile recuperare il codice BLIK.';
	@override String retrieving({required Object details}) => 'Errore nel recupero del codice BLIK: ${details}';
	@override String get missingHashOrKey => 'Errore: Hash di pagamento o chiave pubblica mancante.';
	@override String incorrectState({required Object status}) => 'L\'offerta non è nello stato corretto per la conferma (Stato: ${status})';
	@override String confirming({required Object details}) => 'Errore nella conferma del pagamento: ${details}';
	@override String get invalidState => 'Errore: Stato dell\'offerta non valido ricevuto.';
	@override String get internalIncomplete => 'Errore interno: Dettagli dell\'offerta incompleti.';
	@override String notAwaitingConfirmation({required Object status}) => 'L\'offerta non è più in attesa di conferma (Stato: ${status}).';
	@override String get unexpectedStatus => 'Stato dell\'offerta inaspettato ricevuto dal server.';
}

// Path: maker.conflict.actions
class _Translations$maker$conflict$actions$it extends Translations$maker$conflict$actions$en {
	_Translations$maker$conflict$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get back => 'Torna alla Home';
	@override String get confirmPayment => 'Ho sbagliato, conferma che il pagamento BLIK è riuscito';
	@override String get openDispute => 'Il pagamento BLIK NON è riuscito, APRI DISPUTA';
	@override String get submitDispute => 'Invia Disputa';
}

// Path: maker.conflict.disputeDialog
class _Translations$maker$conflict$disputeDialog$it extends Translations$maker$conflict$disputeDialog$en {
	_Translations$maker$conflict$disputeDialog$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aprire una disputa?';
	@override String get content => 'Aprire una disputa richiede una verifica manuale da parte del coordinatore, che richiederà tempo. Una commissione per disputa sarà addebitata se la disputa sarà risolta contro di te. La fattura hold verrà saldata per evitare che scada. Se la disputa sarà risolta a tuo favore, riceverai un rimborso (meno le commissioni) su un portafoglio a tua scelta.';
	@override String get contentDetailed => 'Aprire una disputa richiederà l\'intervento manuale del coordinatore, che richiede tempo e comporta una commissione per disputa.\n\nLa fattura hold verrà saldata immediatamente per evitare che scada prima della risoluzione della disputa.\n\nSe la disputa sarà risolta a tuo favore, l\'importo in satoshi verrà rimborsato su un portafoglio a tua scelta (meno le commissioni). Assicurati di avere un portafoglio pronto per ricevere.';
	@override late final _Translations$maker$conflict$disputeDialog$actions$it actions = _Translations$maker$conflict$disputeDialog$actions$it._(_root);
}

// Path: maker.conflict.feedback
class _Translations$maker$conflict$feedback$it extends Translations$maker$conflict$feedback$en {
	_Translations$maker$conflict$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get disputeOpenedSuccess => 'Disputa aperta con successo. Il coordinatore esaminerà la situazione.';
}

// Path: maker.conflict.errors
class _Translations$maker$conflict$errors$it extends Translations$maker$conflict$errors$en {
	_Translations$maker$conflict$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String openingDispute({required Object error}) => 'Errore nell\'apertura della disputa: ${error}';
}

// Path: maker.conflict.nostrContact
class _Translations$maker$conflict$nostrContact$it extends Translations$maker$conflict$nostrContact$en {
	_Translations$maker$conflict$nostrContact$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contatta il Coordinatore su Nostr';
	@override String get description => 'Puoi inviare un DM al coordinatore direttamente per assistenza con questa disputa.';
	@override String get copyNpub => 'Copia npub';
	@override String get openProfile => 'Visualizza Profilo';
	@override String get npubCopied => 'Npub del coordinatore copiato negli appunti!';
	@override String get yourIdentityDescription => 'Per inviare DM, accedi con la tua chiave privata Neko (nsec) in qualsiasi client Nostr che supporta i messaggi diretti.';
	@override String get manageNekoKeys => 'Gestisci Chiavi Neko';
}

// Path: taker.submitBlik.actions
class _Translations$taker$submitBlik$actions$it extends Translations$taker$submitBlik$actions$en {
	_Translations$taker$submitBlik$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get submit => 'Invia BLIK';
}

// Path: taker.submitBlik.feedback
class _Translations$taker$submitBlik$feedback$it extends Translations$taker$submitBlik$feedback$en {
	_Translations$taker$submitBlik$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get pasted => 'Codice BLIK incollato.';
}

// Path: taker.submitBlik.validation
class _Translations$taker$submitBlik$validation$it extends Translations$taker$submitBlik$validation$en {
	_Translations$taker$submitBlik$validation$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get invalidFormat => 'Inserisci un codice BLIK valido a 6 cifre.';
}

// Path: taker.submitBlik.errors
class _Translations$taker$submitBlik$errors$it extends Translations$taker$submitBlik$errors$en {
	_Translations$taker$submitBlik$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String submitting({required Object details}) => 'Errore nell\'invio del codice BLIK: ${details}';
	@override String get clipboardInvalid => 'Gli appunti non contengono un codice BLIK valido a 6 cifre.';
	@override String get stateChanged => 'Errore: Lo stato dell\'offerta è cambiato.';
	@override String get stateNotValid => 'Errore: Lo stato dell\'offerta non è più valido.';
	@override String fetchedIdMismatch({required Object fetchedId, required Object initialId}) => 'L\'ID dell\'offerta attiva recuperata (${fetchedId}) non corrisponde all\'ID iniziale (${initialId}). Mismatch di stato?';
	@override String get paymentHashMissing => 'Hash di pagamento dell\'offerta mancante dopo il recupero.';
}

// Path: taker.submitBlik.details
class _Translations$taker$submitBlik$details$it extends Translations$taker$submitBlik$details$en {
	_Translations$taker$submitBlik$details$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get requestedAmount => 'Importo BLIK richiesto';
	@override String get exchangeRate => 'Tasso di Cambio';
	@override String get takerFee => 'Commissione taker';
	@override String get status => 'Stato';
	@override String get youllReceive => 'Riceverai';
}

// Path: taker.waitConfirmation.categoryReminder
class _Translations$taker$waitConfirmation$categoryReminder$it extends Translations$taker$waitConfirmation$categoryReminder$en {
	_Translations$taker$waitConfirmation$categoryReminder$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Promemoria offerta ATM: la tua banca potrebbe ancora chiederti di approvare una commissione ATM extra oltre all\'importo principale.';
	@override String get ecommerce => 'Promemoria ordine online: se il commerciante invia un rimborso automatico al tuo conto bancario, contatta il coordinatore e restituiscilo.';
}

// Path: taker.waitConfirmation.takerCharged
class _Translations$taker$waitConfirmation$takerCharged$it extends Translations$taker$waitConfirmation$takerCharged$en {
	_Translations$taker$waitConfirmation$takerCharged$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hai segnalato che il BLIK è stato addebitato';
	@override String get message => 'Il maker ha 60 minuti per confermare il pagamento o contestarlo. Se non fa nulla, il pagamento verrà confermato automaticamente e riceverai i bitcoin.';
}

// Path: taker.waitConfirmation.expiredActions
class _Translations$taker$waitConfirmation$expiredActions$it extends Translations$taker$waitConfirmation$expiredActions$en {
	_Translations$taker$waitConfirmation$expiredActions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get reportConflict => 'Il BLIK è stato addebitato sul mio conto bancario';
	@override String get renewReservation => 'Riprova con un nuovo codice BLIK';
	@override String get cancelReservation => 'Annulla prenotazione';
}

// Path: taker.waitConfirmation.feedback
class _Translations$taker$waitConfirmation$feedback$it extends Translations$taker$waitConfirmation$feedback$en {
	_Translations$taker$waitConfirmation$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmed => 'Il Maker ha confermato il pagamento.';
	@override String get paymentSuccessful => 'Pagamento riuscito! Riceverai i fondi a breve.';
	@override String get conflictReported => 'Conflitto segnalato. Il coordinatore esaminerà la situazione.';
}

// Path: taker.waitConfirmation.errors
class _Translations$taker$waitConfirmation$errors$it extends Translations$taker$waitConfirmation$errors$en {
	_Translations$taker$waitConfirmation$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get invalidOfferStateReceived => 'Ricevuta un\'offerta con stato non valido per questa schermata. Ripristino in corso.';
	@override String reportingConflict({required Object details}) => 'Errore nella segnalazione del conflitto: ${details}';
}

// Path: taker.paymentProcess.states
class _Translations$taker$paymentProcess$states$it extends Translations$taker$paymentProcess$states$en {
	_Translations$taker$paymentProcess$states$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get preparing => 'Preparazione invio pagamento...';
	@override String get sending => 'Invio pagamento...';
	@override String get received => 'Pagamento ricevuto!';
	@override String get failed => 'Pagamento fallito';
	@override String get waitingUpdate => 'In attesa dell\'aggiornamento dell\'offerta...';
}

// Path: taker.paymentProcess.steps
class _Translations$taker$paymentProcess$steps$it extends Translations$taker$paymentProcess$steps$en {
	_Translations$taker$paymentProcess$steps$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmedBlik => 'Il Maker ha confermato il pagamento BLIK';
	@override String get makerInvoiceSettled => 'Fattura hold del Maker saldata';
	@override String get takerInvoicePaid => 'Pagamento della tua fattura Lightning';
	@override String get takerPaymentFailed => 'Pagamento alla tua fattura fallito';
}

// Path: taker.paymentProcess.errors
class _Translations$taker$paymentProcess$errors$it extends Translations$taker$paymentProcess$errors$en {
	_Translations$taker$paymentProcess$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String sending({required Object details}) => 'Errore nell\'invio del pagamento: ${details}';
	@override String get notConfirmed => 'Offerta non confermata dal Maker.';
	@override String get expired => 'Offerta scaduta.';
	@override String get cancelled => 'Offerta annullata.';
	@override String get paymentFailed => 'Pagamento dell\'offerta fallito.';
	@override String get unknown => 'Errore offerta sconosciuto.';
	@override String get takerPaymentFailed => 'Il pagamento alla tua fattura Lightning è fallito.';
	@override String get noPublicKey => 'Errore: Impossibile recuperare la tua chiave pubblica.';
	@override String get loadingPublicKey => 'Errore nel caricamento dei tuoi dati';
	@override String get missingPaymentHash => 'Errore: Dettagli di pagamento mancanti.';
}

// Path: taker.paymentProcess.loading
class _Translations$taker$paymentProcess$loading$it extends Translations$taker$paymentProcess$loading$en {
	_Translations$taker$paymentProcess$loading$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get publicKey => 'Caricamento dei tuoi dati...';
}

// Path: taker.paymentProcess.actions
class _Translations$taker$paymentProcess$actions$it extends Translations$taker$paymentProcess$actions$en {
	_Translations$taker$paymentProcess$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get goToFailureDetails => 'Riprova con nuova fattura';
}

// Path: taker.paymentFailed.form
class _Translations$taker$paymentFailed$form$it extends Translations$taker$paymentFailed$form$en {
	_Translations$taker$paymentFailed$form$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get newInvoiceLabel => 'Nuova fattura Lightning';
	@override String get newInvoiceHint => 'Inserisci la tua fattura BOLT11';
}

// Path: taker.paymentFailed.actions
class _Translations$taker$paymentFailed$actions$it extends Translations$taker$paymentFailed$actions$en {
	_Translations$taker$paymentFailed$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get retryPayment => 'Invia Nuova Fattura';
}

// Path: taker.paymentFailed.errors
class _Translations$taker$paymentFailed$errors$it extends Translations$taker$paymentFailed$errors$en {
	_Translations$taker$paymentFailed$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get enterValidInvoice => 'Inserisci una fattura valida';
	@override String updatingInvoice({required Object details}) => 'Errore nell\'aggiornamento della fattura: ${details}';
	@override String get paymentRetryFailed => 'Nuovo tentativo di pagamento fallito. Controlla la fattura o riprova più tardi.';
	@override String get takerPublicKeyNotFound => 'Chiave pubblica del taker non trovata.';
	@override String generateFailed({required Object details}) => 'Impossibile generare la fattura: ${details}';
}

// Path: taker.paymentFailed.walletSection
class _Translations$taker$paymentFailed$walletSection$it extends Translations$taker$paymentFailed$walletSection$en {
	_Translations$taker$paymentFailed$walletSection$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Genera fattura dal portafoglio';
	@override String get defaultLabel => 'predefinito';
	@override String tapToGenerate({required Object amountSats}) => 'Tocca per generare la fattura per ${amountSats}';
}

// Path: taker.paymentFailed.loading
class _Translations$taker$paymentFailed$loading$it extends Translations$taker$paymentFailed$loading$en {
	_Translations$taker$paymentFailed$loading$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get processingPayment => 'Elaborazione del nuovo tentativo di pagamento...';
}

// Path: taker.paymentFailed.success
class _Translations$taker$paymentFailed$success$it extends Translations$taker$paymentFailed$success$en {
	_Translations$taker$paymentFailed$success$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento Riuscito';
	@override String get message => 'Il tuo pagamento è stato elaborato con successo.';
}

// Path: taker.paymentSuccess.actions
class _Translations$taker$paymentSuccess$actions$it extends Translations$taker$paymentSuccess$actions$en {
	_Translations$taker$paymentSuccess$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get goHome => 'Vai alla home';
}

// Path: taker.invalidBlik.actions
class _Translations$taker$invalidBlik$actions$it extends Translations$taker$invalidBlik$actions$en {
	_Translations$taker$invalidBlik$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get retry => 'Invia nuovo codice BLIK';
	@override String get cancelReservation => 'Annulla Transazione';
	@override String get reportConflict => 'Avvia Disputa';
	@override String get returnHome => 'Torna alla home';
}

// Path: taker.invalidBlik.feedback
class _Translations$taker$invalidBlik$feedback$it extends Translations$taker$invalidBlik$feedback$en {
	_Translations$taker$invalidBlik$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get conflictReportedSuccess => 'Conflitto segnalato. Il coordinatore lo esaminerà.';
}

// Path: taker.invalidBlik.errors
class _Translations$taker$invalidBlik$errors$it extends Translations$taker$invalidBlik$errors$en {
	_Translations$taker$invalidBlik$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get reservationFailed => 'Impossibile riservare nuovamente l\'offerta';
	@override String conflictReport({required Object details}) => 'Errore nella segnalazione del conflitto: ${details}';
}

// Path: taker.conflict.actions
class _Translations$taker$conflict$actions$it extends Translations$taker$conflict$actions$en {
	_Translations$taker$conflict$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get back => 'Torna alla Home';
}

// Path: taker.conflict.feedback
class _Translations$taker$conflict$feedback$it extends Translations$taker$conflict$feedback$en {
	_Translations$taker$conflict$feedback$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get reported => 'Conflitto segnalato. Il coordinatore esaminerà.';
}

// Path: taker.conflict.errors
class _Translations$taker$conflict$errors$it extends Translations$taker$conflict$errors$en {
	_Translations$taker$conflict$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String reporting({required Object details}) => 'Errore nella segnalazione del conflitto: ${details}';
}

// Path: taker.conflict.nostrContact
class _Translations$taker$conflict$nostrContact$it extends Translations$taker$conflict$nostrContact$en {
	_Translations$taker$conflict$nostrContact$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contatta il Coordinatore su Nostr';
	@override String get description => 'Puoi inviare un DM al coordinatore direttamente per assistenza con questa disputa.';
	@override String get copyNpub => 'Copia npub';
	@override String get openProfile => 'Visualizza Profilo';
	@override String get npubCopied => 'Npub del coordinatore copiato negli appunti!';
	@override String get yourIdentityDescription => 'Per inviare DM, accedi con la tua chiave privata Neko (nsec) in qualsiasi client Nostr che supporta i messaggi diretti.';
	@override String get manageNekoKeys => 'Gestisci Chiavi Neko';
}

// Path: home.statistics.errors
class _Translations$home$statistics$errors$it extends Translations$home$statistics$errors$en {
	_Translations$home$statistics$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String loading({required Object error}) => 'Errore nel caricamento delle statistiche: ${error}';
}

// Path: settings.offerCreation.categoryOptions
class _Translations$settings$offerCreation$categoryOptions$it extends Translations$settings$offerCreation$categoryOptions$en {
	_Translations$settings$offerCreation$categoryOptions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Negozio, caffè o ristorante';
	@override String get atm => 'Prelievo ATM';
	@override String get online => 'Servizio/prodotto online';
}

// Path: settings.offerCreation.dialogs
class _Translations$settings$offerCreation$dialogs$it extends Translations$settings$offerCreation$dialogs$en {
	_Translations$settings$offerCreation$dialogs$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get selectCategory => 'Seleziona la categoria predefinita';
	@override String get selectCoordinator => 'Seleziona il coordinatore preferito';
	@override String get premiumHint => 'Inserisci una percentuale come 1.5. I valori vengono arrotondati a passi di 0.5%.';
	@override String get premiumHelper => 'Applicato quando il premio di prezzo è abilitato e limitato al massimo del coordinatore selezionato.';
}

// Path: settings.display.unitOptions
class _Translations$settings$display$unitOptions$it extends Translations$settings$display$unitOptions$en {
	_Translations$settings$display$unitOptions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get sats => 'sat';
	@override String get bitcoin => '₿ (BIP-177)';
}

// Path: maker.amountForm.category.options
class _Translations$maker$amountForm$category$options$it extends Translations$maker$amountForm$category$options$en {
	_Translations$maker$amountForm$category$options$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Negozio, caffè o ristorante';
	@override String get atmCashout => 'Prelievo contanti da ATM';
	@override String get onlineService => 'Prodotto o servizio online';
}

// Path: maker.amountForm.category.shortLabels
class _Translations$maker$amountForm$category$shortLabels$it extends Translations$maker$amountForm$category$shortLabels$en {
	_Translations$maker$amountForm$category$shortLabels$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Negozio';
	@override String get atm => 'ATM';
	@override String get online => 'Online';
}

// Path: maker.conflict.disputeDialog.actions
class _Translations$maker$conflict$disputeDialog$actions$it extends Translations$maker$conflict$disputeDialog$actions$en {
	_Translations$maker$conflict$disputeDialog$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Apri Disputa';
	@override String get cancel => 'Annulla';
}

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'BitBlik',
			'app.greeting' => 'Ciao!',
			'app.changelog' => 'Registro modifiche',
			'common.buttons.cancel' => 'Annulla',
			'common.buttons.save' => 'Salva',
			'common.buttons.done' => 'Fatto',
			'common.buttons.retry' => 'Riprova',
			'common.buttons.goHome' => 'Vai alla Home',
			'common.buttons.saveAndContinue' => 'Salva e Continua',
			'common.buttons.reveal' => 'Mostra',
			'common.buttons.hide' => 'Nascondi',
			'common.buttons.copy' => 'Copia',
			'common.buttons.close' => 'Chiudi',
			'common.buttons.restore' => 'Ripristina',
			'common.buttons.faq' => 'FAQ',
			'common.labels.amount' => 'Importo (PLN)',
			'common.labels.status' => ({required Object status}) => 'Stato: ${status}',
			'common.labels.role' => ({required Object role}) => 'Ruolo: ${role}',
			'common.notifications.success' => 'Successo',
			'common.notifications.error' => 'Errore',
			'common.notifications.loading' => 'Caricamento...',
			'common.clipboard.copyToClipboard' => 'Copia negli appunti',
			'common.clipboard.pasteFromClipboard' => 'Incolla dagli appunti',
			'common.clipboard.copied' => 'Copiato negli appunti!',
			'common.actions.cancelAndReturnToOffers' => 'Annulla e torna alle offerte',
			'common.actions.cancelAndReturnHome' => 'Annulla e torna alla Home',
			'lightningAddress.labels.address' => 'Indirizzo Lightning (LNURL)',
			'lightningAddress.labels.hint' => 'utente@dominio.com',
			'lightningAddress.labels.short' => ({required Object address}) => 'Indirizzo Lightning: ${address}',
			'lightningAddress.labels.receivingAddress' => 'Il tuo indirizzo di ricezione:',
			'lightningAddress.prompts.enter' => 'Inserisci il tuo indirizzo Lightning per continuare',
			'lightningAddress.prompts.edit' => 'Modifica',
			'lightningAddress.prompts.invalid' => 'Inserisci un indirizzo Lightning valido',
			'lightningAddress.prompts.required' => 'L\'indirizzo Lightning è obbligatorio.',
			'lightningAddress.prompts.enterToTakeOffer' => 'Devi impostare un indirizzo Lightning per accettare un\'offerta.',
			'lightningAddress.prompts.missing' => 'Indirizzo Lightning mancante. Aggiungine uno per poter accettare offerte.',
			'lightningAddress.prompts.add' => 'Aggiungi',
			'lightningAddress.prompts.delete' => 'Elimina',
			'lightningAddress.prompts.confirmDelete' => 'Sei sicuro di voler eliminare il tuo indirizzo Lightning?',
			'lightningAddress.prompts.howToGet' => 'Non hai ancora un indirizzo Lightning? Scopri come ottenerne uno!',
			'lightningAddress.prompts.learnMore' => 'Scopri di più sull\'indirizzo Lightning',
			'lightningAddress.feedback.saved' => 'Indirizzo Lightning salvato!',
			'lightningAddress.feedback.updated' => 'Indirizzo Lightning aggiornato!',
			'lightningAddress.feedback.valid' => 'Indirizzo Lightning valido',
			'lightningAddress.errors.saving' => ({required Object details}) => 'Errore nel salvataggio dell\'indirizzo: ${details}',
			'lightningAddress.errors.loading' => ({required Object details}) => 'Errore nel caricamento dell\'indirizzo Lightning: ${details}',
			'offers.details.yourOffer' => 'La tua offerta:',
			'offers.details.selectedOffer' => 'Offerta:',
			'offers.details.activeOffer' => 'Hai un\'offerta attiva:',
			'offers.details.finishedOffers' => 'Offerte completate',
			'offers.details.noAvailable' => 'Nessuna offerta disponibile.',
			'offers.details.noAvailableTip' => 'Suggerimento: condividi Bitblik nella tua community e tra i tuoi amici per aumentare gli ordini su Bitblik.',
			'offers.details.noSuccessfulTrades' => 'Nessuna transazione completata.',
			'offers.details.loadingDetails' => 'Caricamento dettagli offerta...',
			'offers.details.amount' => ({required Object amount}) => 'Importo: ${amount} satoshi',
			'offers.details.amountWithCurrency' => ({required Object amount, required Object currency}) => '${amount} ${currency}',
			'offers.details.makerFee' => ({required Object fee}) => 'Commissione: ${fee} sats',
			'offers.details.takerFee' => ({required Object fee}) => 'Commissione: ${fee} sats',
			'offers.details.subtitle' => ({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (commissione) satoshi\nStato: ${status}',
			'offers.details.subtitleWithDate' => ({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (commissione) satoshi\nStato: ${status}\nPagato: ${date}',
			'offers.details.activeSubtitle' => ({required Object status, required Object amount}) => 'Stato: ${status}\nImporto: ${amount} satoshi',
			'offers.details.id' => ({required Object id}) => 'ID Offerta: ${id}...',
			'offers.details.created' => ({required Object dateTime}) => 'Creata: ${dateTime}',
			'offers.details.takenAfter' => ({required Object duration}) => 'Accettata dopo: ${duration}',
			'offers.details.paidAfter' => ({required Object duration}) => 'Pagata dopo: ${duration}',
			'offers.details.exchangeRate' => 'Tasso di Cambio',
			'offers.details.amountLabel' => 'Importo',
			'offers.details.makerFeeLabel' => 'Commissione maker',
			'offers.details.takerFeeLabel' => 'Commissione taker',
			'offers.details.feeLabel' => 'Commissione',
			'offers.details.statusLabel' => 'Stato',
			'offers.details.youllReceive' => 'Riceverai',
			'offers.details.coordinator' => 'Coordinatore',
			'offers.details.categoryLabel' => 'Categoria',
			'offers.details.categories.physicalShop' => 'Negozio, caffè o ristorante',
			'offers.details.categories.atmCashout' => 'Prelievo contanti da ATM',
			'offers.details.categories.onlineService' => 'Prodotto o servizio online',
			'offers.details.consents.atm' => 'Alcuni ATM aggiungono una commissione extra oltre all\'importo dell\'offerta. Accettando questa offerta, accetti qualsiasi costo bancario aggiuntivo richiesto dall\'ATM.',
			'offers.details.consents.ecommerce' => 'Per vari motivi — come articolo esaurito, correzione di un sovrapprezzo o altri problemi lato commerciante — il commerciante online potrebbe automaticamente restituire denaro sul conto bancario collegato al BLIK che hai generato. Quei fondi arrivano sul tuo conto e non ti appartengono. Se succede, contatta il coordinatore in buona fede e organizza la restituzione dei fondi al maker. Accettando questa offerta, accetti questi termini e giuri solennemente di agire onestamente in tali situazioni.',
			'offers.labels.premium' => 'Premio',
			'offers.labels.premiumBadge' => ({required Object percent}) => '+${percent}% premio',
			'offers.tooltips.takerFeeInfo' => ({required Object feePercent}) => 'Il coordinatore applica una commissione taker del ${feePercent}%. Questo include le commissioni di routing Lightning ed è detratto dall\'importo che ricevi',
			'offers.tooltips.premiumInfoTaker' => 'Un premio significa che questa offerta è prezzata sopra il mercato. Per lo stesso importo fiat, il maker blocca meno sat nella fattura hold, quindi paghi sopra il mercato e ricevi meno sat rispetto al tasso di mercato. Il premio massimo è impostato dal coordinatore.',
			'offers.tooltips.ratesFetchedAt' => 'Recuperato alle',
			'offers.tooltips.ratesSources' => 'Fonti tasso medio',
			'offers.actions.take' => 'ACCETTA',
			'offers.actions.takeOffer' => 'Accetta Offerta',
			'offers.actions.resume' => 'INSERISCI BLIK',
			'offers.actions.cancel' => 'Annulla offerta',
			'offers.actions.view' => 'Visualizza dettagli',
			'offers.status.created' => 'Creata',
			'offers.status.funded' => 'Finanziata',
			'offers.status.expired' => 'Scaduta',
			'offers.status.cancelled' => 'Annullata',
			'offers.status.reserved' => 'Riservata',
			'offers.status.blikReceived' => 'BLIK Inviato',
			'offers.status.blikSentToMaker' => 'BLIK Ricevuto',
			'offers.status.expiredBlik' => 'BLIK Scaduto',
			'offers.status.expiredSentBlik' => 'BLIK Scaduto',
			'offers.status.takerCharged' => 'Taker Addebitato',
			'offers.status.invalidBlik' => 'BLIK Non Valido',
			'offers.status.conflict' => 'Conflitto',
			'offers.status.dispute' => 'Disputa',
			'offers.status.makerConfirmed' => 'Confermata',
			'offers.status.settled' => 'Conclusa',
			'offers.status.payingTaker' => 'Pagamento wTaker',
			'offers.status.takerPaymentFailed' => 'Taker s1Pagamento Fallito',
			'offers.status.takerPaid' => 'Taker Pagato',
			'offers.status.unknownStatus' => 'Sconosciuto',
			'offers.statusMessages.reserved' => 'Offerta riservata dal Taker!',
			'offers.statusMessages.cancelled' => 'Offerta annullata con successo.',
			'offers.statusMessages.cancelledOrExpired' => 'L\'offerta è stata annullata o è scaduta.',
			'offers.statusMessages.noLongerAvailable' => ({required Object status}) => 'L\'offerta non è più disponibile (Stato: ${status}).',
			'offers.progress.waitingForTaker' => ({required Object time}) => 'In attesa del taker: ${time}',
			'offers.progress.reserved' => ({required Object seconds}) => 'Riservata: ${seconds} s rimanenti',
			'offers.progress.confirming' => ({required Object seconds}) => 'Conferma in corso: ${seconds} s rimanenti',
			'offers.errors.loading' => ({required Object details}) => 'Errore nel caricamento delle offerte: ${details}',
			'offers.errors.loadingDetails' => ({required Object details}) => 'Errore nel caricamento dei dettagli dell\'offerta: ${details}',
			'offers.errors.detailsMissing' => 'Errore: Dettagli dell\'offerta mancanti o non validi.',
			'offers.errors.detailsNotLoaded' => 'Impossibile caricare i dettagli dell\'offerta.',
			'offers.errors.notFound' => 'Errore: Offerta non trovata.',
			'offers.errors.unexpectedState' => 'Errore: L\'offerta è in uno stato imprevisto.',
			'offers.errors.unexpectedStateWithStatus' => ({required Object status}) => 'L\'offerta è in uno stato imprevisto (${status}). Riprova o contatta l\'assistenza.',
			'offers.errors.invalidStatus' => 'L\'offerta ha uno stato non valido.',
			'offers.errors.couldNotIdentify' => 'Errore: Impossibile identificare l\'offerta da annullare.',
			'offers.errors.cannotBeCancelled' => ({required Object status}) => 'L\'offerta non può essere annullata nello stato attuale (${status}).',
			'offers.errors.failedToCancel' => ({required Object details}) => 'Impossibile annullare l\'offerta: ${details}',
			'offers.errors.activeDetailsLost' => 'Errore: Dettagli dell\'offerta attiva persi.',
			'offers.errors.checkingActive' => ({required Object details}) => 'Errore nel controllo delle offerte attive: ${details}',
			'offers.errors.cannotResume' => ({required Object status}) => 'Impossibile riprendere l\'offerta nello stato: ${status}',
			'offers.errors.cannotResumeTaker' => ({required Object status}) => 'Impossibile riprendere l\'offerta taker nello stato: ${status}',
			'offers.errors.resuming' => ({required Object details}) => 'Errore nel riprendere l\'offerta: ${details}',
			'offers.errors.makerPublicKeyNotFound' => 'Chiave pubblica del maker non trovata',
			'offers.errors.takerPublicKeyNotFound' => 'Chiave pubblica del taker non trovata.',
			'offers.errors.atmConsentRequired' => 'Accetta la condizione sulla commissione ATM prima di prendere questa offerta.',
			'offers.errors.ecommerceConsentRequired' => 'Accetta la condizione di restituzione del rimborso ecommerce prima di prendere questa offerta.',
			'offers.errors.cannotTakeOwnOffer' => 'Non puoi prendere la tua stessa offerta.',
			'offers.success.title' => 'Offerta completata',
			'offers.success.headline' => 'Pagamento confermato!',
			'offers.success.subtitle' => 'Il taker verrà pagato ora.',
			'offers.success.detailsTitle' => 'Dettagli offerta:',
			'offers.success.duration' => ({required Object time}) => 'L\'offerta è stata completata in ${time}.',
			'reservations.actions.cancel' => 'Annulla prenotazione',
			'reservations.feedback.cancelled' => 'Prenotazione annullata.',
			'reservations.errors.cancelling' => ({required Object error}) => 'Impossibile annullare la prenotazione: ${error}',
			'reservations.errors.failedToReserve' => ({required Object details}) => 'Impossibile riservare l\'offerta: ${details}',
			'reservations.errors.failedNoTimestamp' => 'Impossibile riservare l\'offerta (timestamp mancante).',
			'reservations.errors.timestampMissing' => 'Timestamp della prenotazione offerta mancante.',
			'reservations.errors.notReserved' => ({required Object status}) => 'L\'offerta non è più nello stato riservato (${status}).',
			'exchange.labels.enterAmount' => 'Inserisci l\'importo (PLN) da pagare:',
			'exchange.labels.equivalent' => ({required Object sats}) => '≈ ${sats} satoshi',
			'exchange.labels.rate' => ({required Object rate}) => 'Tasso di cambio ≈ ${rate} PLN/BTC',
			'exchange.feedback.fetching' => 'Recupero tasso di cambio...',
			'exchange.errors.fetchingRate' => 'Impossibile recuperare il tasso di cambio.',
			'exchange.errors.invalidFormat' => 'Formato numero non valido',
			'exchange.errors.mustBePositive' => 'L\'importo deve essere positivo',
			'exchange.errors.invalidFeePercentage' => 'Percentuale commissione non valida',
			'exchange.errors.tooLowFiat' => ({required Object minAmount, required Object currency}) => 'L\'importo è troppo basso. Il minimo è ${minAmount} ${currency}.',
			'exchange.errors.tooHighFiat' => ({required Object maxAmount, required Object currency}) => 'L\'importo è troppo alto. Il massimo è ${maxAmount} ${currency}.',
			'coordinator.title' => 'Coordinatori',
			'coordinator.info.fee' => 'commissione',
			'coordinator.info.rangeDisplay' => ({required Object minAmount, required Object maxAmount, required Object currency}) => 'Importo: ${minAmount}-${maxAmount} ${currency}',
			'coordinator.info.feeDisplay' => ({required Object fee}) => '${fee}% commissione',
			'coordinator.selector.loading' => 'Caricamento Coordinatori...',
			'coordinator.selector.errorLoading' => 'Errore nel Caricamento Coordinatori',
			'coordinator.selector.choose' => 'Scegli Coordinatore',
			'coordinator.selector.viewNostrProfile' => 'Visualizza profilo Nostr',
			'coordinator.selector.unresponsive' => 'Questo coordinatore non risponde',
			'coordinator.selector.waitingResponse' => 'In attesa della risposta del coordinatore',
			'coordinator.selector.termsAccept' => 'Accetto i ',
			'coordinator.selector.termsOfUsage' => 'Termini di utilizzo',
			'coordinator.dialog.makerFee' => 'Commissione Maker',
			'coordinator.dialog.takerFee' => 'Commissione Taker',
			'coordinator.dialog.amountRange' => 'Range Importo',
			'coordinator.dialog.reservationTime' => 'Tempo di Prenotazione',
			'coordinator.dialog.currencies' => 'Valute',
			'coordinator.dialog.viewTerms' => 'Visualizza Termini',
			'coordinator.details.title' => 'Coordinatore',
			'coordinator.details.relaysInUse' => 'Relay in uso',
			'coordinator.details.relaysInUseHint' => 'Tutta la comunicazione con questo coordinatore passa per questi relay (dalla sua lista NIP-65).',
			'coordinator.details.noRelays' => 'Nessun relay ancora noto',
			'coordinator.details.makerFee' => 'Commissione maker',
			'coordinator.details.takerFee' => 'Commissione taker',
			'coordinator.details.amountRange' => 'Intervallo importo',
			'coordinator.details.maxPremium' => 'Premio max',
			'coordinator.details.maxPremiumInfoTitle' => 'Premio',
			'coordinator.details.maxPremiumInfoBody' => 'Il premio è un sovrapprezzo opzionale rispetto al tasso di mercato che un maker può impostare su un\'offerta. Con un premio, il maker blocca meno satoshi per lo stesso importo in fiat, quindi il taker paga sopra il mercato e il maker trattiene la differenza. Questo valore è il premio massimo che questo coordinatore consente sulle sue offerte.',
			'coordinator.details.reservationTime' => 'Tempo di prenotazione',
			'coordinator.details.currencies' => 'Valute',
			'coordinator.details.version' => 'Versione',
			'coordinator.details.yourOffers' => 'Le tue offerte',
			'coordinator.details.successfulOffers' => 'Offerte riuscite (30g)',
			'coordinator.details.statusOnline' => 'Online',
			'coordinator.details.statusOffline' => 'Offline',
			'coordinator.details.statusUnknown' => 'Sconosciuto',
			'coordinator.details.openNostrProfile' => 'Apri profilo Nostr',
			'coordinator.details.termsOfUsage' => 'Termini di utilizzo',
			'coordinator.management.title' => 'Gestione Coordinatori',
			'coordinator.management.availableCoordinators' => 'Coordinatori',
			'coordinator.management.noCoordinators' => 'Nessun coordinatore trovato.',
			'coordinator.management.online' => 'Online',
			'coordinator.management.unknownOffline' => 'Sconosciuto/Offline',
			'coordinator.management.openNostrProfile' => 'Apri Profilo Nostr',
			'coordinator.management.enable' => 'Abilita',
			'coordinator.management.remove' => 'Rimuovi',
			'coordinator.management.addCustomWhitelist' => 'Aggiungi coordinatore personalizzato',
			'coordinator.management.addCustomWhitelistHint' => 'npub1...',
			'coordinator.management.add' => 'Aggiungi',
			'coordinator.management.coordinatorDisabled' => 'Coordinatore disabilitato',
			'coordinator.management.coordinatorEnabled' => 'Coordinatore abilitato',
			'coordinator.management.coordinatorAdded' => 'Coordinatore aggiunto alla whitelist personalizzata',
			'coordinator.management.coordinatorRemoved' => 'Coordinatore rimosso dalla whitelist personalizzata',
			'coordinator.management.coordinatorAddInfoUnavailable' => 'Nessuna informazione sul coordinatore trovata sui relay. Coordinatore non aggiunto.',
			'coordinator.management.pleaseEnterNpub' => 'Inserisci un npub',
			'coordinator.management.error' => 'Errore',
			'coordinator.management.metricYourOffers' => 'Le tue offerte',
			'coordinator.management.metricYourOffersTooltip' => 'Numero di offerte che hai completato con successo con questo coordinatore.',
			'coordinator.management.metricNetworkOffers' => 'Offerte (30g)',
			'coordinator.management.metricNetworkOffersTooltip' => 'Offerte risolte con successo da questo coordinatore tra tutti gli utenti negli ultimi 30 giorni.',
			'maker.roleSelection.button' => 'PAGA con Lightning',
			'maker.amountForm.progress.step1' => '1. Crea Offerta',
			'maker.amountForm.progress.step2' => '2. Attendi Taker',
			'maker.amountForm.progress.step3' => '3. Usa BLIK',
			'maker.amountForm.labels.coordinator' => 'Coordinatore',
			'maker.amountForm.labels.category' => 'Categoria',
			'maker.amountForm.labels.exchangeRate' => 'Tasso di Cambio',
			'maker.amountForm.labels.fee' => 'Commissione',
			'maker.amountForm.labels.satoshisToPay' => 'Importo da Pagare',
			'maker.amountForm.labels.enterAmount' => 'Inserisci importo',
			'maker.amountForm.labels.tapToSelect' => 'Tocca per selezionare',
			'maker.amountForm.labels.premium' => 'Premio',
			'maker.amountForm.actions.generateInvoice' => 'Genera Fattura',
			'maker.amountForm.tooltips.feeInfo' => ({required Object feePercent}) => 'Il coordinatore applica una commissione maker del ${feePercent}%. Questa commissione viene detratta dal tuo pagamento Lightning.',
			'maker.amountForm.tooltips.payInfo' => 'Questo calcolo si basa sui tassi di cambio recuperati dal client. Il coordinatore calcolerà l\'importo esatto, e l\'importo della fattura sarà quello finale e definitivo da pagare.',
			'maker.amountForm.tooltips.premiumInfo' => 'Un premio opzionale ti permette di vendere i tuoi sat sopra il prezzo di mercato. Il premio riduce i sat bloccati nella tua fattura hold per lo stesso importo fiat, così il taker paga sopra il mercato e tu trattieni la differenza. Predefinito disattivato (0%). Il premio massimo è impostato dal coordinatore selezionato.',
			'maker.amountForm.category.label' => 'Categoria offerta',
			'maker.amountForm.category.options.physicalShop' => 'Negozio, caffè o ristorante',
			'maker.amountForm.category.options.atmCashout' => 'Prelievo contanti da ATM',
			'maker.amountForm.category.options.onlineService' => 'Prodotto o servizio online',
			'maker.amountForm.category.shortLabels.shop' => 'Negozio',
			'maker.amountForm.category.shortLabels.atm' => 'ATM',
			'maker.amountForm.category.shortLabels.online' => 'Online',
			'maker.amountForm.category.atmHint' => 'I taker vedranno che questa offerta serve per un prelievo ATM e potrebbero evitarla se la loro banca applica commissioni aggiuntive.',
			'maker.amountForm.category.physicalShopHint' => 'Il posto ideale per usare Bitblik è una cassa self-service — poiché aspettare che un taker riservi, generi e confermi il codice BLIK potrebbe richiedere un paio di minuti. Funziona benissimo in negozi, caffè e ristoranti. Se ti senti abbastanza coraggioso da far aspettare un cassiere normale (e le persone in coda dietro di te) quei pochi minuti, complimenti.',
			'maker.amountForm.category.ecommerceWarningTitle' => 'Rischio rimborso negozio online',
			'maker.amountForm.category.ecommerceWarningBody' => 'Per vari motivi — come articolo esaurito, correzione di un sovrapprezzo o altri problemi lato commerciante — il negozio online potrebbe emettere automaticamente un rimborso sul conto bancario collegato al BLIK, che è il conto del taker. Il coordinatore non può obbligare il taker a restituire quei fondi a te.',
			'maker.amountForm.category.ecommerceConfirmation' => 'Capisco il rischio di rimborso e aggiungerò una nota all\'ordine per chiedere al commerciante di rimborsare su un conto diverso se necessario.',
			'maker.amountForm.category.whyThisIsNeeded' => 'perché è necessario?',
			'maker.amountForm.onboarding.titlePrefix' => 'Novità',
			'maker.amountForm.onboarding.title' => 'Scegli la categoria dell\'offerta',
			'maker.amountForm.onboarding.body' => 'Prima di generare la fattura, scegli la categoria che descrive meglio ciò che stai pagando.',
			'maker.amountForm.onboarding.showWhy' => 'Perché è importante?',
			'maker.amountForm.onboarding.hideWhy' => 'Nascondi dettagli',
			'maker.amountForm.onboarding.whyTitle' => 'La categoria giusta aiuta i taker a decidere in modo sicuro',
			'maker.amountForm.onboarding.whyBody' => 'Situazioni diverse comportano aspettative e rischi diversi. I prelievi ATM possono includere commissioni bancarie extra, mentre gli acquisti online possono avere casi particolari sui rimborsi. Selezionare la categoria corretta dà ai taker il contesto necessario prima di accettare la tua offerta.',
			'maker.amountForm.onboarding.cta' => 'Ho capito',
			'maker.amountForm.errors.initiating' => ({required Object details}) => 'Errore nell\'avvio dell\'offerta: ${details}',
			'maker.amountForm.errors.publicKeyNotLoaded' => 'Errore: Chiave pubblica non ancora caricata.',
			'maker.amountForm.errors.noCoordinatorMatchesAmount' => 'Nessun coordinatore supporta questo importo. Prova con un valore diverso.',
			'maker.amountForm.errors.categoryRequired' => 'Seleziona una categoria per l\'offerta.',
			'maker.amountForm.errors.ecommerceConfirmationRequired' => 'Conferma il rischio di rimborso del negozio online prima di continuare.',
			'maker.payInvoice.title' => 'Paga questa fattura Hold:',
			'maker.payInvoice.actions.copy' => 'Copia Fattura',
			'maker.payInvoice.actions.payInWallet' => 'Apri nel Wallet Esterno',
			'maker.payInvoice.actions.connectWallet' => 'Connetti Wallet',
			'maker.payInvoice.actions.payWithNwc' => 'Paga',
			'maker.payInvoice.actions.paying' => 'Pagamento in corso...',
			'maker.payInvoice.feedback.copied' => 'Fattura copiata negli appunti!',
			'maker.payInvoice.feedback.waitingConfirmation' => 'In attesa della conferma del pagamento...',
			'maker.payInvoice.feedback.nwcConnected' => 'Wallet NWC connesso!',
			'maker.payInvoice.feedback.nwcPaymentSuccess' => 'Pagamento riuscito!',
			'maker.payInvoice.errors.couldNotOpenApp' => 'Impossibile aprire l\'app Lightning per la fattura.',
			'maker.payInvoice.errors.openingApp' => ({required Object details}) => 'Errore nell\'apertura dell\'app Lightning: ${details}',
			'maker.payInvoice.errors.publicKeyNotAvailable' => 'La chiave pubblica non è disponibile.',
			'maker.payInvoice.errors.couldNotFetchActive' => 'Impossibile recuperare i dettagli dell\'offerta attiva. Potrebbe essere scaduta.',
			'maker.payInvoice.errors.nwcPaymentFailed' => ({required Object details}) => 'Pagamento fallito: ${details}',
			'maker.payInvoice.errors.nwcNotConnected' => 'Wallet NWC non connesso',
			'maker.payInvoice.errors.insufficientBalance' => ({required Object required, required Object available}) => 'Saldo insufficiente. Necessari ${required} sats, disponibili ${available} sats',
			'maker.payInvoice.errors.cancelOfferAlreadyFunded' => 'Il coordinatore segnala che questa offerta è già finanziata. Non può essere annullata ora.',
			'maker.payInvoice.errors.cancelFailed' => ({required Object details}) => 'Impossibile annullare l\'offerta: ${details}',
			'maker.waitTaker.message' => 'In attesa che un Taker riservi la tua offerta...',
			'maker.waitTaker.progressLabel' => ({required Object time}) => 'In attesa del taker: ${time}',
			'maker.waitTaker.errorActiveOfferDetailsLost' => 'Errore: Dettagli dell\'offerta attiva persi.',
			'maker.waitTaker.errorFailedToRetrieveBlik' => 'Errore: Impossibile recuperare il codice BLIK.',
			'maker.waitTaker.errorRetrievingBlik' => ({required Object details}) => 'Errore nel recupero del codice BLIK: ${details}',
			'maker.waitTaker.offerNoLongerAvailable' => ({required Object status}) => 'L\'offerta non è più disponibile (Stato: ${status}).',
			'maker.waitTaker.errorCouldNotIdentifyOffer' => 'Errore: Impossibile identificare l\'offerta da annullare.',
			'maker.waitTaker.offerCannotBeCancelled' => ({required Object status}) => 'L\'offerta non può essere annullata nello stato attuale (${status}).',
			'maker.waitTaker.offerCancelledSuccessfully' => 'Offerta annullata con successo.',
			'maker.waitTaker.failedToCancelOffer' => ({required Object details}) => 'Impossibile annullare l\'offerta: ${details}',
			'maker.waitTaker.offerExpiredTitle' => 'Offerta scaduta',
			'maker.waitTaker.offerExpiredMessage' => 'Nessun taker ha riservato la tua offerta in tempo.',
			'maker.waitTaker.recreateOffer' => 'Nuova offerta — stesso importo',
			'maker.waitForBlik.title' => 'In attesa di BLIK',
			'maker.waitForBlik.messageInfo' => 'Il Taker ha riservato l\'offerta!',
			'maker.waitForBlik.messageWaiting' => 'In attesa del codice BLIK...',
			'maker.waitForBlik.progressLabel' => ({required Object seconds}) => 'Riservata: ${seconds} s rimanenti',
			'maker.confirmPayment.title' => 'Codice BLIK ricevuto!',
			'maker.confirmPayment.retrieving' => 'Recupero codice BLIK...',
			'maker.confirmPayment.instructions' => 'Inserisci questo codice nel terminale di pagamento. Quando il Taker conferma nella sua app bancaria e il pagamento va a buon fine, premi Conferma qui sotto.',
			'maker.confirmPayment.instruction1' => 'Inserisci il codice nella richiesta di pagamento BLIK.',
			'maker.confirmPayment.instruction2' => 'Attendi che il Taker confermi il pagamento nella sua app.',
			'maker.confirmPayment.instruction3' => 'Quando il pagamento va a buon fine, premi Conferma qui sotto:',
			'maker.confirmPayment.takerChargedWarning' => 'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto bancario. Se lo contrassegni come non valido, si creerà un conflitto.',
			'maker.confirmPayment.expiredTitle' => 'Codice BLIK Scaduto',
			'maker.confirmPayment.expiredWarning' => 'Il codice BLIK è scaduto. Devi confermare manualmente lo stato del pagamento:',
			'maker.confirmPayment.expiredInstruction1' => 'Se il pagamento BLIK è andato a buon fine e hai completato l\'acquisto, clicca "Conferma pagamento riuscito" qui sotto.',
			'maker.confirmPayment.expiredInstruction2' => 'Se il pagamento BLIK è fallito o non è stato completato, clicca "Codice BLIK Non Valido" qui sotto.',
			'maker.confirmPayment.actions.confirm' => 'Conferma pagamento riuscito',
			'maker.confirmPayment.actions.markInvalid' => 'Codice BLIK Non Valido',
			'maker.confirmPayment.actions.copyBlik' => 'Copia BLIK',
			'maker.confirmPayment.confirmDialog.title' => 'Confermare il Pagamento?',
			'maker.confirmPayment.confirmDialog.content' => 'Questa azione è irreversibile. Dopo la conferma:\n\n• Il Taker riceverà i fondi immediatamente\n• Il coordinatore non potrà contestare i fondi\n• Non puoi annullare questa azione\n\nConferma solo se il pagamento BLIK è andato a buon fine.',
			'maker.confirmPayment.confirmDialog.cancel' => 'Annulla',
			'maker.confirmPayment.confirmDialog.confirmButton' => 'Sì, Conferma Pagamento',
			'maker.confirmPayment.invalidBlikDisputeDialog.title' => 'Aprire una Disputa?',
			'maker.confirmPayment.invalidBlikDisputeDialog.content' => 'Il taker ha segnalato che il pagamento BLIK è stato addebitato sul suo conto.\n\nContrassegnarlo come non valido aprirà immediatamente una DISPUTA che richiede l\'intervento del coordinatore.\n\n• Potrebbe essere addebitata una commissione per disputa se il verdetto sarà contro di te\n• La fattura hold verrà saldata immediatamente\n• Sarà necessaria una verifica manuale\n\nProcedi solo se sei certo che il pagamento BLIK NON è andato a buon fine.',
			'maker.confirmPayment.invalidBlikDisputeDialog.cancel' => 'Annulla',
			'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton' => 'Sì, Apri Disputa',
			'maker.confirmPayment.feedback.confirmed' => 'Il Maker ha confermato il pagamento.',
			'maker.confirmPayment.feedback.confirmedTakerPaid' => 'Pagamento confermato! Il Taker riceverà i fondi.',
			'maker.confirmPayment.feedback.progressLabel' => ({required Object seconds}) => 'Conferma in corso: ${seconds} s rimanenti',
			'maker.confirmPayment.errors.failedToRetrieve' => 'Errore: Impossibile recuperare il codice BLIK.',
			'maker.confirmPayment.errors.retrieving' => ({required Object details}) => 'Errore nel recupero del codice BLIK: ${details}',
			'maker.confirmPayment.errors.missingHashOrKey' => 'Errore: Hash di pagamento o chiave pubblica mancante.',
			'maker.confirmPayment.errors.incorrectState' => ({required Object status}) => 'L\'offerta non è nello stato corretto per la conferma (Stato: ${status})',
			'maker.confirmPayment.errors.confirming' => ({required Object details}) => 'Errore nella conferma del pagamento: ${details}',
			'maker.confirmPayment.errors.invalidState' => 'Errore: Stato dell\'offerta non valido ricevuto.',
			'maker.confirmPayment.errors.internalIncomplete' => 'Errore interno: Dettagli dell\'offerta incompleti.',
			'maker.confirmPayment.errors.notAwaitingConfirmation' => ({required Object status}) => 'L\'offerta non è più in attesa di conferma (Stato: ${status}).',
			'maker.confirmPayment.errors.unexpectedStatus' => 'Stato dell\'offerta inaspettato ricevuto dal server.',
			'maker.invalidBlik.title' => 'Codice BLIK Non Valido',
			'maker.invalidBlik.info' => 'Hai contrassegnato il codice BLIK come non valido. In attesa che il taker fornisca un nuovo codice o avvii una disputa.',
			'maker.conflict.title' => 'Conflitto Offerta',
			'maker.conflict.headline' => 'Conflitto Offerta Segnalato',
			'maker.conflict.body' => 'Hai contrassegnato il codice BLIK come non valido, ma il Taker ha segnalato un conflitto, indicando che ritiene il pagamento andato a buon fine.',
			'maker.conflict.instructions' => 'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.',
			'maker.conflict.actions.back' => 'Torna alla Home',
			'maker.conflict.actions.confirmPayment' => 'Ho sbagliato, conferma che il pagamento BLIK è riuscito',
			'maker.conflict.actions.openDispute' => 'Il pagamento BLIK NON è riuscito, APRI DISPUTA',
			'maker.conflict.actions.submitDispute' => 'Invia Disputa',
			'maker.conflict.disputeDialog.title' => 'Aprire una disputa?',
			'maker.conflict.disputeDialog.content' => 'Aprire una disputa richiede una verifica manuale da parte del coordinatore, che richiederà tempo. Una commissione per disputa sarà addebitata se la disputa sarà risolta contro di te. La fattura hold verrà saldata per evitare che scada. Se la disputa sarà risolta a tuo favore, riceverai un rimborso (meno le commissioni) su un portafoglio a tua scelta.',
			'maker.conflict.disputeDialog.contentDetailed' => 'Aprire una disputa richiederà l\'intervento manuale del coordinatore, che richiede tempo e comporta una commissione per disputa.\n\nLa fattura hold verrà saldata immediatamente per evitare che scada prima della risoluzione della disputa.\n\nSe la disputa sarà risolta a tuo favore, l\'importo in satoshi verrà rimborsato su un portafoglio a tua scelta (meno le commissioni). Assicurati di avere un portafoglio pronto per ricevere.',
			'maker.conflict.disputeDialog.actions.confirm' => 'Apri Disputa',
			'maker.conflict.disputeDialog.actions.cancel' => 'Annulla',
			'maker.conflict.feedback.disputeOpenedSuccess' => 'Disputa aperta con successo. Il coordinatore esaminerà la situazione.',
			'maker.conflict.errors.openingDispute' => ({required Object error}) => 'Errore nell\'apertura della disputa: ${error}',
			'maker.conflict.nostrContact.title' => 'Contatta il Coordinatore su Nostr',
			'maker.conflict.nostrContact.description' => 'Puoi inviare un DM al coordinatore direttamente per assistenza con questa disputa.',
			'maker.conflict.nostrContact.copyNpub' => 'Copia npub',
			'maker.conflict.nostrContact.openProfile' => 'Visualizza Profilo',
			'maker.conflict.nostrContact.npubCopied' => 'Npub del coordinatore copiato negli appunti!',
			'maker.conflict.nostrContact.yourIdentityDescription' => 'Per inviare DM, accedi con la tua chiave privata Neko (nsec) in qualsiasi client Nostr che supporta i messaggi diretti.',
			'maker.conflict.nostrContact.manageNekoKeys' => 'Gestisci Chiavi Neko',
			'maker.success.title' => 'Offerta completata',
			'maker.success.headline' => 'Pagamento confermato!',
			'maker.success.subtitle' => 'Il Taker verrà ora pagato.',
			'maker.success.detailsTitle' => 'Dettagli offerta:',
			'maker.success.duration' => ({required Object time}) => 'L\'offerta ha richiesto ${time}!',
			'taker.roleSelection.button' => 'VENDI codice BLIK per satoshi',
			'taker.progress.step1' => 'Invia BLIK',
			'taker.progress.step2' => 'Conferma BLIK',
			'taker.progress.step3' => 'Ricevi Pagamento',
			'taker.submitBlik.title' => 'Inserisci BLIK a 6 cifre',
			'taker.submitBlik.label' => 'Codice BLIK',
			'taker.submitBlik.instruction' => 'Inserisci BLIK prima che scada il tempo...',
			'taker.submitBlik.timeLimit' => ({required Object seconds}) => 'Inserisci BLIK entro: ${seconds} s',
			'taker.submitBlik.timeExpired' => 'Il tempo per inserire il codice BLIK è scaduto.',
			'taker.submitBlik.actions.submit' => 'Invia BLIK',
			'taker.submitBlik.feedback.pasted' => 'Codice BLIK incollato.',
			'taker.submitBlik.validation.invalidFormat' => 'Inserisci un codice BLIK valido a 6 cifre.',
			'taker.submitBlik.errors.submitting' => ({required Object details}) => 'Errore nell\'invio del codice BLIK: ${details}',
			'taker.submitBlik.errors.clipboardInvalid' => 'Gli appunti non contengono un codice BLIK valido a 6 cifre.',
			'taker.submitBlik.errors.stateChanged' => 'Errore: Lo stato dell\'offerta è cambiato.',
			'taker.submitBlik.errors.stateNotValid' => 'Errore: Lo stato dell\'offerta non è più valido.',
			'taker.submitBlik.errors.fetchedIdMismatch' => ({required Object fetchedId, required Object initialId}) => 'L\'ID dell\'offerta attiva recuperata (${fetchedId}) non corrisponde all\'ID iniziale (${initialId}). Mismatch di stato?',
			'taker.submitBlik.errors.paymentHashMissing' => 'Hash di pagamento dell\'offerta mancante dopo il recupero.',
			'taker.submitBlik.details.requestedAmount' => 'Importo BLIK richiesto',
			'taker.submitBlik.details.exchangeRate' => 'Tasso di Cambio',
			'taker.submitBlik.details.takerFee' => 'Commissione taker',
			'taker.submitBlik.details.status' => 'Stato',
			'taker.submitBlik.details.youllReceive' => 'Riceverai',
			'taker.waitConfirmation.title' => 'In attesa del Maker',
			'taker.waitConfirmation.statusLabel' => ({required Object status}) => 'Stato offerta: ${status}',
			'taker.waitConfirmation.waitingMaker' => ({required Object seconds}) => 'In attesa della conferma del Maker: ${seconds} s',
			'taker.waitConfirmation.waitingMakerConfirmation' => ({required Object seconds}) => 'In attesa che il Maker confermi che il BLIK è corretto. Tempo rimanente: ${seconds}s',
			'taker.waitConfirmation.importantNotice' => ({required Object amount, required Object currency}) => 'MOLTO IMPORTANTE: Assicurati di accettare solo la conferma BLIK per ${amount} ${currency}',
			'taker.waitConfirmation.importantBlikAmountConfirmation' => ({required Object amount, required Object currency}) => 'MOLTO IMPORTANTE: Nella tua app bancaria, assicurati di confermare un pagamento BLIK per esattamente ${amount} ${currency}.',
			'taker.waitConfirmation.instructions' => 'Il maker deve ora inserirlo nel terminale di pagamento entro 2 minuti. Dovrai poi accettare il codice BLIK nella tua app bancaria.',
			'taker.waitConfirmation.categoryReminder.atm' => 'Promemoria offerta ATM: la tua banca potrebbe ancora chiederti di approvare una commissione ATM extra oltre all\'importo principale.',
			'taker.waitConfirmation.categoryReminder.ecommerce' => 'Promemoria ordine online: se il commerciante invia un rimborso automatico al tuo conto bancario, contatta il coordinatore e restituiscilo.',
			'taker.waitConfirmation.waitingForMakerToReceive' => 'In attesa che il maker riceva il tuo codice BLIK...',
			'taker.waitConfirmation.makerReceivedBlik' => 'Il maker ha ricevuto il tuo codice BLIK.',
			'taker.waitConfirmation.timerExpiredMessage' => 'Il tempo di scadenza BLIK di 2 minuti è passato. In attesa che il maker confermi o contrassegni il codice come non valido.',
			'taker.waitConfirmation.timerExpiredActions' => 'Il tempo di scadenza BLIK di 2 minuti è passato ma il maker non ha ricevuto il codice BLIK. Puoi rinviare un nuovo codice BLIK o annullare.',
			'taker.waitConfirmation.resendBlikButton' => 'Rinvia Nuovo Codice BLIK',
			'taker.waitConfirmation.navigatedHome' => 'Tornato alla home.',
			'taker.waitConfirmation.expiredTitle' => 'Codice BLIK Scaduto',
			'taker.waitConfirmation.expiredWarning' => 'Il maker non ha ricevuto il codice BLIK quindi non ha potuto utilizzarlo.',
			'taker.waitConfirmation.expiredRelistCountdownLabel' => 'Nuova pubblicazione automatica tra',
			'taker.waitConfirmation.expiredSentWarning' => 'Il maker non ha ancora confermato il pagamento. Cosa vuoi fare?',
			'taker.waitConfirmation.expiredInstruction1' => 'Se vuoi riprovare con un nuovo codice BLIK, rinnova la prenotazione.',
			'taker.waitConfirmation.expiredInstruction2' => 'Se non vuoi più completare questa transazione, annulla la prenotazione.',
			'taker.waitConfirmation.expiredInstruction3' => 'Se il pagamento BLIK è stato addebitato sul tuo conto bancario, non preoccuparti, i bitcoin sono ancora al sicuro presso il coordinatore.',
			'taker.waitConfirmation.takerCharged.title' => 'Hai segnalato che il BLIK è stato addebitato',
			'taker.waitConfirmation.takerCharged.message' => 'Il maker ha 60 minuti per confermare il pagamento o contestarlo. Se non fa nulla, il pagamento verrà confermato automaticamente e riceverai i bitcoin.',
			'taker.waitConfirmation.expiredActions.reportConflict' => 'Il BLIK è stato addebitato sul mio conto bancario',
			'taker.waitConfirmation.expiredActions.renewReservation' => 'Riprova con un nuovo codice BLIK',
			'taker.waitConfirmation.expiredActions.cancelReservation' => 'Annulla prenotazione',
			'taker.waitConfirmation.feedback.makerConfirmed' => 'Il Maker ha confermato il pagamento.',
			'taker.waitConfirmation.feedback.paymentSuccessful' => 'Pagamento riuscito! Riceverai i fondi a breve.',
			'taker.waitConfirmation.feedback.conflictReported' => 'Conflitto segnalato. Il coordinatore esaminerà la situazione.',
			'taker.waitConfirmation.errors.invalidOfferStateReceived' => 'Ricevuta un\'offerta con stato non valido per questa schermata. Ripristino in corso.',
			'taker.waitConfirmation.errors.reportingConflict' => ({required Object details}) => 'Errore nella segnalazione del conflitto: ${details}',
			'taker.paymentProcess.title' => 'Processo di Pagamento',
			'taker.paymentProcess.waitingForOfferUpdate' => 'In attesa dell\'aggiornamento dello stato dell\'offerta...',
			'taker.paymentProcess.states.preparing' => 'Preparazione invio pagamento...',
			'taker.paymentProcess.states.sending' => 'Invio pagamento...',
			'taker.paymentProcess.states.received' => 'Pagamento ricevuto!',
			'taker.paymentProcess.states.failed' => 'Pagamento fallito',
			'taker.paymentProcess.states.waitingUpdate' => 'In attesa dell\'aggiornamento dell\'offerta...',
			'taker.paymentProcess.steps.makerConfirmedBlik' => 'Il Maker ha confermato il pagamento BLIK',
			'taker.paymentProcess.steps.makerInvoiceSettled' => 'Fattura hold del Maker saldata',
			'taker.paymentProcess.steps.takerInvoicePaid' => 'Pagamento della tua fattura Lightning',
			'taker.paymentProcess.steps.takerPaymentFailed' => 'Pagamento alla tua fattura fallito',
			'taker.paymentProcess.errors.sending' => ({required Object details}) => 'Errore nell\'invio del pagamento: ${details}',
			'taker.paymentProcess.errors.notConfirmed' => 'Offerta non confermata dal Maker.',
			'taker.paymentProcess.errors.expired' => 'Offerta scaduta.',
			'taker.paymentProcess.errors.cancelled' => 'Offerta annullata.',
			'taker.paymentProcess.errors.paymentFailed' => 'Pagamento dell\'offerta fallito.',
			'taker.paymentProcess.errors.unknown' => 'Errore offerta sconosciuto.',
			'taker.paymentProcess.errors.takerPaymentFailed' => 'Il pagamento alla tua fattura Lightning è fallito.',
			'taker.paymentProcess.errors.noPublicKey' => 'Errore: Impossibile recuperare la tua chiave pubblica.',
			'taker.paymentProcess.errors.loadingPublicKey' => 'Errore nel caricamento dei tuoi dati',
			'taker.paymentProcess.errors.missingPaymentHash' => 'Errore: Dettagli di pagamento mancanti.',
			'taker.paymentProcess.loading.publicKey' => 'Caricamento dei tuoi dati...',
			'taker.paymentProcess.actions.goToFailureDetails' => 'Riprova con nuova fattura',
			'taker.paymentFailed.title' => 'Pagamento Fallito',
			'taker.paymentFailed.instructions' => ({required Object netAmount}) => 'Fornisci una nuova fattura Lightning per ${netAmount}',
			'taker.paymentFailed.form.newInvoiceLabel' => 'Nuova fattura Lightning',
			'taker.paymentFailed.form.newInvoiceHint' => 'Inserisci la tua fattura BOLT11',
			'taker.paymentFailed.actions.retryPayment' => 'Invia Nuova Fattura',
			'taker.paymentFailed.errors.enterValidInvoice' => 'Inserisci una fattura valida',
			'taker.paymentFailed.errors.updatingInvoice' => ({required Object details}) => 'Errore nell\'aggiornamento della fattura: ${details}',
			'taker.paymentFailed.errors.paymentRetryFailed' => 'Nuovo tentativo di pagamento fallito. Controlla la fattura o riprova più tardi.',
			'taker.paymentFailed.errors.takerPublicKeyNotFound' => 'Chiave pubblica del taker non trovata.',
			'taker.paymentFailed.errors.generateFailed' => ({required Object details}) => 'Impossibile generare la fattura: ${details}',
			'taker.paymentFailed.walletSection.title' => 'Genera fattura dal portafoglio',
			'taker.paymentFailed.walletSection.defaultLabel' => 'predefinito',
			'taker.paymentFailed.walletSection.tapToGenerate' => ({required Object amountSats}) => 'Tocca per generare la fattura per ${amountSats}',
			'taker.paymentFailed.loading.processingPayment' => 'Elaborazione del nuovo tentativo di pagamento...',
			'taker.paymentFailed.success.title' => 'Pagamento Riuscito',
			'taker.paymentFailed.success.message' => 'Il tuo pagamento è stato elaborato con successo.',
			'taker.paymentSuccess.title' => 'Pagamento Riuscito',
			'taker.paymentSuccess.message' => 'Il tuo pagamento è stato elaborato con successo.',
			'taker.paymentSuccess.actions.goHome' => 'Vai alla home',
			'taker.invalidBlik.title' => 'Codice BLIK Non Valido',
			'taker.invalidBlik.message' => 'Il Maker ha Rifiutato il Codice BLIK',
			'taker.invalidBlik.explanation' => 'Il maker dell\'offerta ha indicato che il codice BLIK fornito non era valido o non ha funzionato.\n\nCosa vuoi fare?',
			'taker.invalidBlik.werentCharged' => 'Se NON ti è stato addebitato:',
			'taker.invalidBlik.wereCharged' => 'Se ti è stato addebitato:',
			'taker.invalidBlik.actions.retry' => 'Invia nuovo codice BLIK',
			'taker.invalidBlik.actions.cancelReservation' => 'Annulla Transazione',
			'taker.invalidBlik.actions.reportConflict' => 'Avvia Disputa',
			'taker.invalidBlik.actions.returnHome' => 'Torna alla home',
			'taker.invalidBlik.feedback.conflictReportedSuccess' => 'Conflitto segnalato. Il coordinatore lo esaminerà.',
			'taker.invalidBlik.errors.reservationFailed' => 'Impossibile riservare nuovamente l\'offerta',
			'taker.invalidBlik.errors.conflictReport' => ({required Object details}) => 'Errore nella segnalazione del conflitto: ${details}',
			'taker.conflict.title' => 'Conflitto Offerta',
			'taker.conflict.headline' => 'Conflitto Offerta Segnalato',
			'taker.conflict.body' => 'Il Maker ha contrassegnato il codice BLIK come non valido, ma tu hai segnalato un conflitto, indicando che ritieni il pagamento andato a buon fine.',
			'taker.conflict.instructions' => 'Attendi che il coordinatore esamini la situazione. Potrebbero esserti richiesti ulteriori dettagli. Controlla più tardi o contatta l\'assistenza se necessario.',
			'taker.conflict.actions.back' => 'Torna alla Home',
			'taker.conflict.feedback.reported' => 'Conflitto segnalato. Il coordinatore esaminerà.',
			'taker.conflict.errors.reporting' => ({required Object details}) => 'Errore nella segnalazione del conflitto: ${details}',
			'taker.conflict.nostrContact.title' => 'Contatta il Coordinatore su Nostr',
			'taker.conflict.nostrContact.description' => 'Puoi inviare un DM al coordinatore direttamente per assistenza con questa disputa.',
			'taker.conflict.nostrContact.copyNpub' => 'Copia npub',
			'taker.conflict.nostrContact.openProfile' => 'Visualizza Profilo',
			'taker.conflict.nostrContact.npubCopied' => 'Npub del coordinatore copiato negli appunti!',
			'taker.conflict.nostrContact.yourIdentityDescription' => 'Per inviare DM, accedi con la tua chiave privata Neko (nsec) in qualsiasi client Nostr che supporta i messaggi diretti.',
			'taker.conflict.nostrContact.manageNekoKeys' => 'Gestisci Chiavi Neko',
			'blik.instructions.taker' => 'Una volta che il Maker inserisce il codice BLIK, dovrai confermare il pagamento nella tua app bancaria. Assicurati che l\'importo sia corretto prima di confermare.',
			'home.notifications.title' => 'Ricevi notifiche sulle nuove offerte tramite:',
			'home.notifications.telegram' => 'Telegram',
			'home.notifications.simplex' => 'SimpleX',
			'home.notifications.element' => 'Element',
			'home.notifications.signal' => 'Signal',
			'home.statistics.title' => 'Offerte Completate',
			'home.statistics.lifetimeCompact' => ({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Totale: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}',
			'home.statistics.last7DaysCompact' => ({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ultimi 7g: ${count} transazioni\nAttesa media per BLIK: ${avgBlikTime}\nTempo medio completamento: ${avgPaidTime}',
			'home.statistics.last7DaysSingleLine' => ({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ultimi 7g: ${count} offerte  |  Media BLIK: ${avgBlikTime}  |  Media Pagato: ${avgPaidTime}',
			'home.statistics.errors.loading' => ({required Object error}) => 'Errore nel caricamento delle statistiche: ${error}',
			'nekoInfo.title' => 'Cos\'è un Neko?',
			'nekoInfo.description' => 'Il tuo Neko è la tua identità per usare BitBlik. È composto da una chiave privata e pubblica per garantire una comunicazione crittograficamente sicura con il coordinatore.\n\nPer garantire maggiore anonimato, si consiglia di usare un nuovo Neko per ogni offerta.\n\n⚠️ IMPORTANTE: La tua chiave privata è memorizzata solo sul tuo dispositivo (lato client). È fondamentale fare il backup della tua chiave privata, poiché perderla potrebbe impedirti di risolvere dispute e recuperare i tuoi fondi.',
			'nekoInfo.backupWarning' => 'Ricorda di fare il backup del tuo Neko',
			'generateNewKey.title' => 'Nuovo',
			'generateNewKey.description' => 'Sei sicuro di voler generare un nuovo Neko? Quello attuale andrà perso per sempre se non ne hai fatto il backup.',
			'generateNewKey.buttons.generate' => 'Genera',
			'generateNewKey.errors.activeOffer' => 'Non puoi generare un nuovo Neko mentre hai un\'offerta attiva.',
			'generateNewKey.errors.failed' => 'Impossibile generare un nuovo Neko',
			'generateNewKey.feedback.success' => 'Nuovo Neko generato con successo!',
			'generateNewKey.tooltips.generate' => 'Genera Nuovo Neko',
			'backup.title' => 'Backup',
			'backup.description' => 'Questa è la tua chiave privata. Protegge la comunicazione con il coordinatore. Non rivelarla mai a nessuno. Fai il backup in un luogo sicuro per prevenire problemi durante le dispute.',
			'backup.feedback.copied' => 'Chiave privata copiata negli appunti!',
			'backup.tooltips.backup' => 'Backup Neko',
			'restore.title' => 'Ripristina',
			'restore.labels.privateKey' => 'Chiave Privata',
			'restore.buttons.restore' => 'Ripristina',
			'restore.errors.invalidKey' => 'Deve essere una stringa esadecimale di 64 caratteri.',
			_ => null,
		} ?? switch (path) {
			'restore.errors.failed' => 'Ripristino fallito',
			'restore.feedback.success' => 'Neko ripristinato con successo! L\'app verrà riavviata.',
			'restore.tooltips.restore' => 'Ripristina Neko',
			'system.loadingPublicKey' => 'Caricamento della tua chiave pubblica...',
			'system.errors.generic' => 'Si è verificato un errore imprevisto. Riprova.',
			'system.errors.loadingTimeoutConfig' => 'Errore nel caricamento della configurazione timeout.',
			'system.errors.loadingCoordinatorConfig' => 'Errore nel caricamento della configurazione del coordinatore. Riprova.',
			'system.errors.noPublicKey' => 'La tua chiave pubblica non è disponibile. Impossibile procedere.',
			'system.errors.internalOfferIncomplete' => 'Errore interno: I dettagli dell\'offerta sono incompleti. Riprova.',
			'system.errors.loadingPublicKey' => 'Errore nel caricamento della tua chiave pubblica. Riavvia l\'app.',
			'system.blik.copied' => 'Codice BLIK copiato negli appunti',
			'myOffers.title' => 'Le mie offerte',
			'myOffers.empty' => 'Nessuna offerta.',
			'myOffers.unknownCoordinator' => 'Coordinatore sconosciuto',
			'myOffers.menuLabel' => 'Le mie offerte',
			'myOffers.filter.all' => 'Tutte',
			'myOffers.filter.active' => 'Attive',
			'myOffers.filter.completed' => 'Completate',
			'myOffers.filter.failed' => 'Fallite',
			'myOffers.details.title' => 'Dettagli offerta',
			'myOffers.details.notFound' => 'Offerta non trovata.',
			'myOffers.details.amount' => 'Importo',
			'myOffers.details.fees' => 'Commissioni',
			'myOffers.details.sats' => 'Satoshi',
			'myOffers.details.maker' => 'Maker',
			'myOffers.details.taker' => 'Taker',
			'myOffers.details.yourFee' => 'La tua commissione',
			'myOffers.details.makerFee' => 'Commissione maker',
			'myOffers.details.takerFee' => 'Commissione taker',
			'myOffers.details.coordinator' => 'Coordinatore',
			'myOffers.details.createdAt' => 'Creata',
			'myOffers.details.reservedAt' => 'Prenotata',
			'myOffers.details.blikReceivedAt' => 'BLIK inviato',
			'myOffers.details.makerConfirmedAt' => 'Confermata',
			'myOffers.details.settledAt' => 'Liquidata',
			'myOffers.details.takerPaidAt' => 'Taker pagato',
			'myOffers.details.id' => 'ID offerta',
			'myOffers.details.paymentHash' => 'Hash pagamento',
			'myOffers.details.holdInvoice' => 'Hold Invoice',
			'myOffers.details.continueActiveOffer' => 'Continua offerta attiva',
			'myOffers.details.after' => ({required Object duration}) => 'dopo ${duration}',
			'landing.mainTitle' => 'Il tuo ponte BLIK ⇄ bitcoin',
			'landing.subtitle' => 'Paga o vendi il tuo codice BLIK con bitcoin',
			'landing.partnership' => 'partnership',
			'landing.actions.payBlik' => 'Paga BLIK',
			'landing.actions.payBlikSubtitle' => 'con bitcoin',
			'landing.actions.sellBlik' => 'Compra bitcoin',
			'landing.actions.sellBlikSubtitle' => 'con BLIK',
			'landing.actions.howItWorks' => 'Come funziona?',
			'faq.screenTitle' => 'FAQ',
			'faq.tooltip' => 'FAQ',
			'settings.title' => 'Impostazioni',
			'settings.offerCreation.title' => 'Creazione offerte',
			'settings.offerCreation.defaultCategory' => 'Categoria predefinita',
			'settings.offerCreation.preferredCoordinator' => 'Coordinatore preferito',
			'settings.offerCreation.automaticCoordinator' => 'Più affidabile',
			'settings.offerCreation.automaticCoordinatorDescription' => 'Sceglie il coordinatore con la migliore reputazione, combinando le tue offerte completate e l\'attività complessiva della rete.',
			'settings.offerCreation.cheapestCoordinator' => 'Più economico',
			'settings.offerCreation.cheapestCoordinatorDescription' => 'Sceglie il coordinatore disponibile con la commissione del venditore più bassa per ogni offerta.',
			'settings.offerCreation.enablePremium' => 'Abilita premio di prezzo',
			'settings.offerCreation.enablePremiumDescription' => 'Mostra il cursore del premio durante la creazione delle offerte maker.',
			'settings.offerCreation.defaultPremium' => 'Premio predefinito',
			'settings.offerCreation.defaultPremiumDisabled' => 'Abilita il premio di prezzo per impostare un premio predefinito.',
			'settings.offerCreation.premiumPerCoordinatorNote' => 'Ogni coordinatore imposta il proprio premio massimo, quindi il tuo valore predefinito è limitato dal coordinatore usato per un\'offerta.',
			'settings.offerCreation.categoryOptions.shop' => 'Negozio, caffè o ristorante',
			'settings.offerCreation.categoryOptions.atm' => 'Prelievo ATM',
			'settings.offerCreation.categoryOptions.online' => 'Servizio/prodotto online',
			'settings.offerCreation.dialogs.selectCategory' => 'Seleziona la categoria predefinita',
			'settings.offerCreation.dialogs.selectCoordinator' => 'Seleziona il coordinatore preferito',
			'settings.offerCreation.dialogs.premiumHint' => 'Inserisci una percentuale come 1.5. I valori vengono arrotondati a passi di 0.5%.',
			'settings.offerCreation.dialogs.premiumHelper' => 'Applicato quando il premio di prezzo è abilitato e limitato al massimo del coordinatore selezionato.',
			'settings.display.title' => 'Aspetto',
			'settings.display.bitcoinUnit' => 'Unità bitcoin',
			'settings.display.bitcoinUnitDescription' => 'Scegli come mostrare gli importi bitcoin in tutta l\'app.',
			'settings.display.unitOptions.sats' => 'sat',
			'settings.display.unitOptions.bitcoin' => '₿ (BIP-177)',
			'notificationSettings.title' => 'Notifiche',
			'notificationSettings.androidOnly' => 'Le notifiche in background sono attualmente supportate solo su Android.',
			'notificationSettings.newOfferAlerts.label' => 'Avvisi nuove offerte',
			'notificationSettings.newOfferAlerts.description' => 'Se abilitato, BitBlik ti notificherà delle nuove offerte disponibili da accettare dai tuoi coordinatori abilitati mentre l\'app è in background. Potrebbe essere più veloce dei messenger esterni.',
			'wallet.title' => 'Portafoglio',
			'wallet.description' => 'Gestisci le impostazioni del tuo portafoglio Lightning',
			'wallet.missingReceiving.title' => 'Portafoglio di ricezione richiesto',
			'wallet.missingReceiving.message' => 'Nessun portafoglio configurato per ricevere. Aggiungine uno nelle impostazioni Portafoglio per accettare offerte.',
			'wallet.missingReceiving.openSettings' => 'Impostazioni portafoglio',
			'nwc.title' => 'Nostr Wallet Connect (NWC)',
			'nwc.description' => 'Connetti il tuo portafoglio Lightning tramite NWC',
			'nwc.labels.connectionString' => 'Stringa di Connessione NWC',
			'nwc.labels.hint' => 'nostr+walletconnect://...',
			'nwc.labels.status' => 'Stato Connessione',
			'nwc.labels.connected' => 'Connesso',
			'nwc.labels.disconnected' => 'Disconnesso',
			'nwc.labels.scanQrCode' => 'Scansiona il codice QR con la tua connessione NWC',
			'nwc.labels.balance' => 'Saldo',
			'nwc.labels.budget' => 'Budget',
			'nwc.labels.usedBudget' => 'Usato',
			'nwc.labels.totalBudget' => 'Totale',
			'nwc.labels.renewsIn' => 'Si rinnova tra',
			'nwc.labels.renewalPeriod' => 'Periodo di Rinnovo',
			'nwc.labels.relay' => 'Relay',
			'nwc.labels.relays' => 'Relay',
			'nwc.prompts.enter' => 'Inserisci la tua stringa di connessione NWC',
			'nwc.prompts.connect' => 'Connetti Portafoglio',
			'nwc.prompts.disconnect' => 'Disconnetti',
			'nwc.prompts.confirmDisconnect' => 'Sei sicuro di voler disconnettere il tuo portafoglio NWC?',
			'nwc.prompts.pasteConnection' => 'Incolla stringa di connessione',
			'nwc.prompts.chooseMethod' => 'Scegli come connettere il tuo portafoglio Lightning',
			'nwc.prompts.howToGet' => 'Non hai ancora una connessione NWC? Scopri come ottenerla!',
			'nwc.prompts.learnMore' => 'Scopri di più su NWC',
			'nwc.actions.connectAlbyGo' => 'Connetti con Alby Go',
			'nwc.actions.connectNwc' => 'Scansiona QR Code NWC',
			'nwc.feedback.connected' => 'Portafoglio NWC connesso con successo!',
			'nwc.feedback.disconnected' => 'Portafoglio NWC disconnesso',
			'nwc.feedback.connecting' => 'Connessione al portafoglio NWC...',
			'nwc.feedback.loadingWalletInfo' => 'Caricamento informazioni portafoglio...',
			'nwc.errors.connecting' => ({required Object details}) => 'Errore nella connessione a NWC: ${details}',
			'nwc.errors.disconnecting' => ({required Object details}) => 'Errore nella disconnessione da NWC: ${details}',
			'nwc.errors.invalid' => 'Stringa di connessione NWC non valida',
			'nwc.errors.required' => 'La stringa di connessione NWC è obbligatoria',
			'nwc.errors.loadingBalance' => 'Impossibile caricare il saldo del portafoglio',
			'nwc.errors.loadingBudget' => 'Impossibile caricare il budget del portafoglio',
			'nwc.time.minutes' => ({required Object count}) => '${count}m',
			'nwc.time.hours' => ({required Object count}) => '${count}h',
			'nwc.time.days' => ({required Object count}) => '${count}g',
			'nwc.time.justNow' => 'adesso',
			'nekoManagement.title' => 'Neko',
			'relays.title' => 'Relay',
			'relays.coordinatorRelays' => 'Relay del coordinatore',
			'relays.discoveryRelays' => 'Relay di scoperta',
			'relays.status.connected' => 'Connesso',
			'relays.status.connecting' => 'Connessione',
			'relays.status.reconnecting' => 'Riconnessione',
			'relays.status.disconnected' => 'Disconnesso',
			'relays.popup.title' => ({required Object connected, required Object total}) => 'Relay (${connected}/${total} connessi)',
			'relays.popup.connectingMessage' => 'Connessione ai relay...',
			'offerNotifications.activeService.title' => 'In attesa di nuove offerte',
			'offerNotifications.activeService.body' => 'Servizio in background che monitora gli eventi Nostr delle offerte BitBlik.',
			'offerNotifications.funded.title' => 'Offerta finanziata',
			'offerNotifications.funded.body' => 'La tua fattura hold è stata accettata. L\'offerta è ora attiva.',
			'offerNotifications.reserved.title' => 'Offerta prenotata',
			'offerNotifications.reserved.body' => 'Un taker ha prenotato la tua offerta.',
			'offerNotifications.blikReady.title' => 'Codice BLIK pronto',
			'offerNotifications.blikReady.body' => 'Il tuo codice BLIK è pronto per essere visualizzato.',
			'offerNotifications.newOffer.title' => 'Nuova offerta disponibile',
			'offerNotifications.newOffer.body' => ({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}',
			'offerNotifications.newOffer.premiumSuffix' => ({required Object percent}) => '+${percent}% premio',
			'offerNotifications.categories.shop' => 'Negozio',
			'offerNotifications.categories.atm' => 'ATM',
			'offerNotifications.categories.online' => 'Online',
			'offerNotifications.blikPendingReminder.title' => 'BLIK in attesa di azione',
			'offerNotifications.blikPendingReminder.body' => 'Conferma il pagamento o segna il codice BLIK come non valido.',
			'offerNotifications.takerCharged.title' => 'BLIK addebitato',
			'offerNotifications.takerCharged.body' => 'Il taker segnala che il BLIK è stato addebitato. Conferma o segna come non valido.',
			'offerNotifications.invalidBlik.title' => 'BLIK non valido',
			'offerNotifications.invalidBlik.body' => 'Il maker ha contrassegnato il tuo codice BLIK come non valido.',
			'offerNotifications.takerPaid.title' => 'Pagamento ricevuto',
			'offerNotifications.takerPaid.body' => 'Il tuo pagamento Lightning è stato inviato.',
			'altstore.dialogTitle' => 'AltStore Non Installato',
			'altstore.step1Title' => 'Scarica e installa AltStore PAL',
			'altstore.step1Button' => 'altstore.io/download',
			'altstore.step1Warning' => 'Hai bisogno di Safari per installare AltStore PAL!',
			'altstore.step2Title' => 'Installa BitBlik',
			'altstore.step2Button' => 'Installa BitBlik',
			'altstore.step2Fallback' => 'Non funziona? Incolla la sorgente in AltStore',
			_ => null,
		};
	}
}
