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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$fr app = _Translations$app$fr._(_root);
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$lightningAddress$fr lightningAddress = _Translations$lightningAddress$fr._(_root);
	@override late final _Translations$nfc$fr nfc = _Translations$nfc$fr._(_root);
	@override late final _Translations$offers$fr offers = _Translations$offers$fr._(_root);
	@override late final _Translations$reservations$fr reservations = _Translations$reservations$fr._(_root);
	@override late final _Translations$exchange$fr exchange = _Translations$exchange$fr._(_root);
	@override late final _Translations$coordinator$fr coordinator = _Translations$coordinator$fr._(_root);
	@override late final _Translations$disputeChat$fr disputeChat = _Translations$disputeChat$fr._(_root);
	@override late final _Translations$receivingInvoice$fr receivingInvoice = _Translations$receivingInvoice$fr._(_root);
	@override late final _Translations$maker$fr maker = _Translations$maker$fr._(_root);
	@override late final _Translations$taker$fr taker = _Translations$taker$fr._(_root);
	@override late final _Translations$twint$fr twint = _Translations$twint$fr._(_root);
	@override late final _Translations$blik$fr blik = _Translations$blik$fr._(_root);
	@override late final _Translations$home$fr home = _Translations$home$fr._(_root);
	@override late final _Translations$nekoInfo$fr nekoInfo = _Translations$nekoInfo$fr._(_root);
	@override late final _Translations$generateNewKey$fr generateNewKey = _Translations$generateNewKey$fr._(_root);
	@override late final _Translations$backup$fr backup = _Translations$backup$fr._(_root);
	@override late final _Translations$restore$fr restore = _Translations$restore$fr._(_root);
	@override late final _Translations$system$fr system = _Translations$system$fr._(_root);
	@override late final _Translations$myOffers$fr myOffers = _Translations$myOffers$fr._(_root);
	@override late final _Translations$landing$fr landing = _Translations$landing$fr._(_root);
	@override late final _Translations$faq$fr faq = _Translations$faq$fr._(_root);
	@override late final _Translations$settings$fr settings = _Translations$settings$fr._(_root);
	@override late final _Translations$notificationSettings$fr notificationSettings = _Translations$notificationSettings$fr._(_root);
	@override late final _Translations$onboarding$fr onboarding = _Translations$onboarding$fr._(_root);
	@override late final _Translations$wallet$fr wallet = _Translations$wallet$fr._(_root);
	@override late final _Translations$nwc$fr nwc = _Translations$nwc$fr._(_root);
	@override late final _Translations$nekoManagement$fr nekoManagement = _Translations$nekoManagement$fr._(_root);
	@override late final _Translations$relays$fr relays = _Translations$relays$fr._(_root);
	@override late final _Translations$offerNotifications$fr offerNotifications = _Translations$offerNotifications$fr._(_root);
	@override late final _Translations$altstore$fr altstore = _Translations$altstore$fr._(_root);
}

// Path: app
class _Translations$app$fr extends Translations$app$en {
	_Translations$app$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object app}) => '${app}';
	@override String get greeting => 'Bonjour !';
	@override String get changelog => 'Journal des modifications';
}

// Path: common
class _Translations$common$fr extends Translations$common$en {
	_Translations$common$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$buttons$fr buttons = _Translations$common$buttons$fr._(_root);
	@override late final _Translations$common$labels$fr labels = _Translations$common$labels$fr._(_root);
	@override late final _Translations$common$notifications$fr notifications = _Translations$common$notifications$fr._(_root);
	@override late final _Translations$common$clipboard$fr clipboard = _Translations$common$clipboard$fr._(_root);
	@override late final _Translations$common$actions$fr actions = _Translations$common$actions$fr._(_root);
}

// Path: lightningAddress
class _Translations$lightningAddress$fr extends Translations$lightningAddress$en {
	_Translations$lightningAddress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$lightningAddress$labels$fr labels = _Translations$lightningAddress$labels$fr._(_root);
	@override late final _Translations$lightningAddress$prompts$fr prompts = _Translations$lightningAddress$prompts$fr._(_root);
	@override late final _Translations$lightningAddress$feedback$fr feedback = _Translations$lightningAddress$feedback$fr._(_root);
	@override late final _Translations$lightningAddress$errors$fr errors = _Translations$lightningAddress$errors$fr._(_root);
}

// Path: nfc
class _Translations$nfc$fr extends Translations$nfc$en {
	_Translations$nfc$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$nfc$actions$fr actions = _Translations$nfc$actions$fr._(_root);
	@override late final _Translations$nfc$prompts$fr prompts = _Translations$nfc$prompts$fr._(_root);
	@override late final _Translations$nfc$feedback$fr feedback = _Translations$nfc$feedback$fr._(_root);
	@override late final _Translations$nfc$errors$fr errors = _Translations$nfc$errors$fr._(_root);
}

// Path: offers
class _Translations$offers$fr extends Translations$offers$en {
	_Translations$offers$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offers$details$fr details = _Translations$offers$details$fr._(_root);
	@override late final _Translations$offers$labels$fr labels = _Translations$offers$labels$fr._(_root);
	@override late final _Translations$offers$tooltips$fr tooltips = _Translations$offers$tooltips$fr._(_root);
	@override late final _Translations$offers$actions$fr actions = _Translations$offers$actions$fr._(_root);
	@override late final _Translations$offers$status$fr status = _Translations$offers$status$fr._(_root);
	@override late final _Translations$offers$statusMessages$fr statusMessages = _Translations$offers$statusMessages$fr._(_root);
	@override late final _Translations$offers$progress$fr progress = _Translations$offers$progress$fr._(_root);
	@override late final _Translations$offers$errors$fr errors = _Translations$offers$errors$fr._(_root);
	@override late final _Translations$offers$success$fr success = _Translations$offers$success$fr._(_root);
}

// Path: reservations
class _Translations$reservations$fr extends Translations$reservations$en {
	_Translations$reservations$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reservations$actions$fr actions = _Translations$reservations$actions$fr._(_root);
	@override late final _Translations$reservations$feedback$fr feedback = _Translations$reservations$feedback$fr._(_root);
	@override late final _Translations$reservations$errors$fr errors = _Translations$reservations$errors$fr._(_root);
}

// Path: exchange
class _Translations$exchange$fr extends Translations$exchange$en {
	_Translations$exchange$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$exchange$labels$fr labels = _Translations$exchange$labels$fr._(_root);
	@override late final _Translations$exchange$feedback$fr feedback = _Translations$exchange$feedback$fr._(_root);
	@override late final _Translations$exchange$errors$fr errors = _Translations$exchange$errors$fr._(_root);
}

// Path: coordinator
class _Translations$coordinator$fr extends Translations$coordinator$en {
	_Translations$coordinator$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Coordinateurs';
	@override late final _Translations$coordinator$info$fr info = _Translations$coordinator$info$fr._(_root);
	@override late final _Translations$coordinator$selector$fr selector = _Translations$coordinator$selector$fr._(_root);
	@override late final _Translations$coordinator$dialog$fr dialog = _Translations$coordinator$dialog$fr._(_root);
	@override late final _Translations$coordinator$details$fr details = _Translations$coordinator$details$fr._(_root);
	@override late final _Translations$coordinator$coldStart$fr coldStart = _Translations$coordinator$coldStart$fr._(_root);
	@override late final _Translations$coordinator$management$fr management = _Translations$coordinator$management$fr._(_root);
}

// Path: disputeChat
class _Translations$disputeChat$fr extends Translations$disputeChat$en {
	_Translations$disputeChat$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get viewHistory => 'Voir l’historique du litige';
	@override String get historyTitle => 'Historique du litige';
	@override String get ruledForMaker => 'Décision en faveur du maker';
	@override String get ruledForTaker => 'Décision en faveur du taker';
	@override String get legacyChannel => 'Canal de compatibilité NIP-04 hérité';
	@override String get privateConversation => 'Conversation privée avec le coordinateur';
	@override String get noMessages => 'Aucun message pour le moment.';
	@override String get replyHint => 'Répondre ici';
	@override String get readOnly => 'L’historique de ce litige résolu est en lecture seule.';
	@override late final _Translations$disputeChat$tooltips$fr tooltips = _Translations$disputeChat$tooltips$fr._(_root);
	@override late final _Translations$disputeChat$errors$fr errors = _Translations$disputeChat$errors$fr._(_root);
}

// Path: receivingInvoice
class _Translations$receivingInvoice$fr extends Translations$receivingInvoice$en {
	_Translations$receivingInvoice$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$receivingInvoice$errors$fr errors = _Translations$receivingInvoice$errors$fr._(_root);
}

// Path: maker
class _Translations$maker$fr extends Translations$maker$en {
	_Translations$maker$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$refundInvoice$fr refundInvoice = _Translations$maker$refundInvoice$fr._(_root);
	@override late final _Translations$maker$roleSelection$fr roleSelection = _Translations$maker$roleSelection$fr._(_root);
	@override late final _Translations$maker$amountForm$fr amountForm = _Translations$maker$amountForm$fr._(_root);
	@override late final _Translations$maker$payInvoice$fr payInvoice = _Translations$maker$payInvoice$fr._(_root);
	@override late final _Translations$maker$waitTaker$fr waitTaker = _Translations$maker$waitTaker$fr._(_root);
	@override late final _Translations$maker$waitForBlik$fr waitForBlik = _Translations$maker$waitForBlik$fr._(_root);
	@override late final _Translations$maker$confirmPayment$fr confirmPayment = _Translations$maker$confirmPayment$fr._(_root);
	@override late final _Translations$maker$invalidBlik$fr invalidBlik = _Translations$maker$invalidBlik$fr._(_root);
	@override late final _Translations$maker$conflict$fr conflict = _Translations$maker$conflict$fr._(_root);
	@override late final _Translations$maker$success$fr success = _Translations$maker$success$fr._(_root);
}

// Path: taker
class _Translations$taker$fr extends Translations$taker$en {
	_Translations$taker$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$taker$roleSelection$fr roleSelection = _Translations$taker$roleSelection$fr._(_root);
	@override late final _Translations$taker$progress$fr progress = _Translations$taker$progress$fr._(_root);
	@override late final _Translations$taker$submitBlik$fr submitBlik = _Translations$taker$submitBlik$fr._(_root);
	@override late final _Translations$taker$criticalCodeDecision$fr criticalCodeDecision = _Translations$taker$criticalCodeDecision$fr._(_root);
	@override late final _Translations$taker$conflict$fr conflict = _Translations$taker$conflict$fr._(_root);
	@override late final _Translations$taker$dispute$fr dispute = _Translations$taker$dispute$fr._(_root);
}

// Path: twint
class _Translations$twint$fr extends Translations$twint$en {
	_Translations$twint$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$twint$scanner$fr scanner = _Translations$twint$scanner$fr._(_root);
	@override late final _Translations$twint$flow$fr flow = _Translations$twint$flow$fr._(_root);
	@override late final _Translations$twint$waitConfirmation$fr waitConfirmation = _Translations$twint$waitConfirmation$fr._(_root);
	@override late final _Translations$twint$paymentProcess$fr paymentProcess = _Translations$twint$paymentProcess$fr._(_root);
	@override late final _Translations$twint$paymentFailed$fr paymentFailed = _Translations$twint$paymentFailed$fr._(_root);
	@override late final _Translations$twint$paymentSuccess$fr paymentSuccess = _Translations$twint$paymentSuccess$fr._(_root);
	@override late final _Translations$twint$invalidBlik$fr invalidBlik = _Translations$twint$invalidBlik$fr._(_root);
	@override late final _Translations$twint$conflict$fr conflict = _Translations$twint$conflict$fr._(_root);
}

// Path: blik
class _Translations$blik$fr extends Translations$blik$en {
	_Translations$blik$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$blik$instructions$fr instructions = _Translations$blik$instructions$fr._(_root);
}

// Path: home
class _Translations$home$fr extends Translations$home$en {
	_Translations$home$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$home$notifications$fr notifications = _Translations$home$notifications$fr._(_root);
	@override late final _Translations$home$statistics$fr statistics = _Translations$home$statistics$fr._(_root);
}

// Path: nekoInfo
class _Translations$nekoInfo$fr extends Translations$nekoInfo$en {
	_Translations$nekoInfo$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qu\'est-ce qu\'un Neko ?';
	@override String description({required Object app}) => 'Votre Neko est votre identité pour utiliser ${app}. Il est composé d\'une clé privée et d\'une clé publique pour garantir une communication cryptographiquement sécurisée avec le coordinateur.\n\nPour plus d\'anonymat, il est recommandé d\'utiliser un nouveau Neko pour chaque offre.\n\n⚠️ IMPORTANT : votre clé privée n\'est stockée que sur votre appareil (côté client). Il est essentiel de sauvegarder votre clé privée, car en perdre l\'accès peut vous empêcher de résoudre des litiges et de récupérer vos fonds.';
	@override String get backupWarning => 'Pensez à sauvegarder votre Neko';
}

// Path: generateNewKey
class _Translations$generateNewKey$fr extends Translations$generateNewKey$en {
	_Translations$generateNewKey$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nouveau';
	@override String get description => 'Voulez-vous vraiment générer un nouveau Neko ? Votre Neko actuel sera perdu pour toujours si vous ne l\'avez pas sauvegardé.';
	@override late final _Translations$generateNewKey$buttons$fr buttons = _Translations$generateNewKey$buttons$fr._(_root);
	@override late final _Translations$generateNewKey$errors$fr errors = _Translations$generateNewKey$errors$fr._(_root);
	@override late final _Translations$generateNewKey$feedback$fr feedback = _Translations$generateNewKey$feedback$fr._(_root);
	@override late final _Translations$generateNewKey$tooltips$fr tooltips = _Translations$generateNewKey$tooltips$fr._(_root);
}

// Path: backup
class _Translations$backup$fr extends Translations$backup$en {
	_Translations$backup$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sauvegarde';
	@override String get description => 'Ceci est votre clé privée. Elle sécurise la communication avec le coordinateur. Ne la révélez jamais à personne. Sauvegardez-la en lieu sûr pour éviter tout problème en cas de litige.';
	@override late final _Translations$backup$feedback$fr feedback = _Translations$backup$feedback$fr._(_root);
	@override late final _Translations$backup$tooltips$fr tooltips = _Translations$backup$tooltips$fr._(_root);
}

// Path: restore
class _Translations$restore$fr extends Translations$restore$en {
	_Translations$restore$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Restaurer';
	@override late final _Translations$restore$labels$fr labels = _Translations$restore$labels$fr._(_root);
	@override late final _Translations$restore$buttons$fr buttons = _Translations$restore$buttons$fr._(_root);
	@override late final _Translations$restore$errors$fr errors = _Translations$restore$errors$fr._(_root);
	@override late final _Translations$restore$feedback$fr feedback = _Translations$restore$feedback$fr._(_root);
	@override late final _Translations$restore$tooltips$fr tooltips = _Translations$restore$tooltips$fr._(_root);
}

// Path: system
class _Translations$system$fr extends Translations$system$en {
	_Translations$system$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get loadingPublicKey => 'Chargement de votre clé publique...';
	@override late final _Translations$system$errors$fr errors = _Translations$system$errors$fr._(_root);
	@override late final _Translations$system$blik$fr blik = _Translations$system$blik$fr._(_root);
}

// Path: myOffers
class _Translations$myOffers$fr extends Translations$myOffers$en {
	_Translations$myOffers$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mes offres';
	@override String get empty => 'Aucune offre pour l\'instant.';
	@override String get unknownCoordinator => 'Coordinateur inconnu';
	@override String get menuLabel => 'Mes offres';
	@override late final _Translations$myOffers$filter$fr filter = _Translations$myOffers$filter$fr._(_root);
	@override late final _Translations$myOffers$details$fr details = _Translations$myOffers$details$fr._(_root);
}

// Path: landing
class _Translations$landing$fr extends Translations$landing$en {
	_Translations$landing$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String mainTitle({required Object code}) => 'Votre passerelle ${code} ⇄ bitcoin';
	@override String subtitle({required Object code}) => 'Payez ou vendez votre code ${code} avec du bitcoin';
	@override String get partnership => 'partenariat';
	@override late final _Translations$landing$actions$fr actions = _Translations$landing$actions$fr._(_root);
}

// Path: faq
class _Translations$faq$fr extends Translations$faq$en {
	_Translations$faq$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'FAQ';
	@override String get tooltip => 'FAQ';
}

// Path: settings
class _Translations$settings$fr extends Translations$settings$en {
	_Translations$settings$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réglages';
	@override late final _Translations$settings$offerCreation$fr offerCreation = _Translations$settings$offerCreation$fr._(_root);
	@override late final _Translations$settings$display$fr display = _Translations$settings$display$fr._(_root);
	@override late final _Translations$settings$paymentSystem$fr paymentSystem = _Translations$settings$paymentSystem$fr._(_root);
}

// Path: notificationSettings
class _Translations$notificationSettings$fr extends Translations$notificationSettings$en {
	_Translations$notificationSettings$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications';
	@override String get androidOnly => 'Les notifications en arrière-plan ne sont actuellement prises en charge que sur Android.';
	@override late final _Translations$notificationSettings$newOfferAlerts$fr newOfferAlerts = _Translations$notificationSettings$newOfferAlerts$fr._(_root);
}

// Path: onboarding
class _Translations$onboarding$fr extends Translations$onboarding$en {
	_Translations$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Choisissez votre marché';
	@override String get subtitle => 'Choisissez le pays et le système de paiement que vous utiliserez. Vous pouvez le changer à tout moment dans les Paramètres.';
}

// Path: wallet
class _Translations$wallet$fr extends Translations$wallet$en {
	_Translations$wallet$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portefeuille';
	@override String get description => 'Gérez les réglages de votre portefeuille Lightning';
	@override late final _Translations$wallet$missingReceiving$fr missingReceiving = _Translations$wallet$missingReceiving$fr._(_root);
	@override late final _Translations$wallet$details$fr details = _Translations$wallet$details$fr._(_root);
}

// Path: nwc
class _Translations$nwc$fr extends Translations$nwc$en {
	_Translations$nwc$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nostr Wallet Connect (NWC)';
	@override String get description => 'Connectez votre portefeuille Lightning via NWC';
	@override late final _Translations$nwc$labels$fr labels = _Translations$nwc$labels$fr._(_root);
	@override late final _Translations$nwc$prompts$fr prompts = _Translations$nwc$prompts$fr._(_root);
	@override late final _Translations$nwc$actions$fr actions = _Translations$nwc$actions$fr._(_root);
	@override late final _Translations$nwc$feedback$fr feedback = _Translations$nwc$feedback$fr._(_root);
	@override late final _Translations$nwc$errors$fr errors = _Translations$nwc$errors$fr._(_root);
	@override late final _Translations$nwc$time$fr time = _Translations$nwc$time$fr._(_root);
}

// Path: nekoManagement
class _Translations$nekoManagement$fr extends Translations$nekoManagement$en {
	_Translations$nekoManagement$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neko';
}

// Path: relays
class _Translations$relays$fr extends Translations$relays$en {
	_Translations$relays$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Relais';
	@override String get coordinatorRelays => 'Relais du coordinateur';
	@override String get discoveryRelays => 'Relais de découverte';
	@override late final _Translations$relays$status$fr status = _Translations$relays$status$fr._(_root);
	@override late final _Translations$relays$popup$fr popup = _Translations$relays$popup$fr._(_root);
}

// Path: offerNotifications
class _Translations$offerNotifications$fr extends Translations$offerNotifications$en {
	_Translations$offerNotifications$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offerNotifications$activeService$fr activeService = _Translations$offerNotifications$activeService$fr._(_root);
	@override late final _Translations$offerNotifications$funded$fr funded = _Translations$offerNotifications$funded$fr._(_root);
	@override late final _Translations$offerNotifications$reserved$fr reserved = _Translations$offerNotifications$reserved$fr._(_root);
	@override late final _Translations$offerNotifications$blikReady$fr blikReady = _Translations$offerNotifications$blikReady$fr._(_root);
	@override late final _Translations$offerNotifications$newOffer$fr newOffer = _Translations$offerNotifications$newOffer$fr._(_root);
	@override late final _Translations$offerNotifications$categories$fr categories = _Translations$offerNotifications$categories$fr._(_root);
	@override late final _Translations$offerNotifications$blikPendingReminder$fr blikPendingReminder = _Translations$offerNotifications$blikPendingReminder$fr._(_root);
	@override late final _Translations$offerNotifications$takerCharged$fr takerCharged = _Translations$offerNotifications$takerCharged$fr._(_root);
	@override late final _Translations$offerNotifications$invalidBlik$fr invalidBlik = _Translations$offerNotifications$invalidBlik$fr._(_root);
	@override late final _Translations$offerNotifications$takerPaid$fr takerPaid = _Translations$offerNotifications$takerPaid$fr._(_root);
}

// Path: altstore
class _Translations$altstore$fr extends Translations$altstore$en {
	_Translations$altstore$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'AltStore non installé';
	@override String get step1Title => 'Téléchargez et installez AltStore PAL';
	@override String get step1Button => 'altstore.io/download';
	@override String get step1Warning => 'Vous avez besoin de Safari pour installer AltStore PAL !';
	@override String step2Title({required Object app}) => 'Installer ${app}';
	@override String step2Button({required Object app}) => 'Installer ${app}';
	@override String get step2Fallback => 'Toujours pas de succès ? Collez la source dans AltStore';
}

// Path: common.buttons
class _Translations$common$buttons$fr extends Translations$common$buttons$en {
	_Translations$common$buttons$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuler';
	@override String get save => 'Enregistrer';
	@override String get done => 'Terminé';
	@override String get retry => 'Réessayer';
	@override String get goHome => 'Accueil';
	@override String get saveAndContinue => 'Enregistrer et continuer';
	@override String get reveal => 'Afficher';
	@override String get hide => 'Masquer';
	@override String get copy => 'Copier';
	@override String get close => 'Fermer';
	@override String get restore => 'Restaurer';
	@override String get faq => 'FAQ';
}

// Path: common.labels
class _Translations$common$labels$fr extends Translations$common$labels$en {
	_Translations$common$labels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String amount({required Object currency}) => 'Montant (${currency})';
	@override String status({required Object status}) => 'Statut : ${status}';
	@override String role({required Object role}) => 'Rôle : ${role}';
}

// Path: common.notifications
class _Translations$common$notifications$fr extends Translations$common$notifications$en {
	_Translations$common$notifications$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get success => 'Succès';
	@override String get error => 'Erreur';
	@override String get loading => 'Chargement...';
}

// Path: common.clipboard
class _Translations$common$clipboard$fr extends Translations$common$clipboard$en {
	_Translations$common$clipboard$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get copyToClipboard => 'Copier dans le presse-papiers';
	@override String get pasteFromClipboard => 'Coller depuis le presse-papiers';
	@override String get copied => 'Copié dans le presse-papiers !';
}

// Path: common.actions
class _Translations$common$actions$fr extends Translations$common$actions$en {
	_Translations$common$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancelAndReturnToOffers => 'Annuler et revenir aux offres';
	@override String get cancelAndReturnHome => 'Annuler et revenir à l\'accueil';
}

// Path: lightningAddress.labels
class _Translations$lightningAddress$labels$fr extends Translations$lightningAddress$labels$en {
	_Translations$lightningAddress$labels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get address => 'Adresse Lightning (LNURL)';
	@override String get hint => 'utilisateur@domaine.com';
	@override String short({required Object address}) => 'Adresse Lightning : ${address}';
	@override String get receivingAddress => 'Votre adresse de réception :';
}

// Path: lightningAddress.prompts
class _Translations$lightningAddress$prompts$fr extends Translations$lightningAddress$prompts$en {
	_Translations$lightningAddress$prompts$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Saisissez votre adresse Lightning pour continuer';
	@override String get edit => 'Modifier';
	@override String get invalid => 'Saisissez une adresse Lightning valide';
	@override String get required => 'L\'adresse Lightning est requise.';
	@override String get enterToTakeOffer => 'Vous devez définir une adresse Lightning pour accepter une offre.';
	@override String get missing => 'Adresse Lightning manquante. Veuillez en ajouter une pour pouvoir accepter des offres.';
	@override String get add => 'Ajouter';
	@override String get delete => 'Supprimer';
	@override String get confirmDelete => 'Voulez-vous vraiment supprimer votre adresse Lightning ?';
	@override String get howToGet => 'Vous n\'avez pas encore d\'adresse Lightning ? Découvrez comment en obtenir une !';
	@override String get learnMore => 'En savoir plus sur les adresses Lightning';
}

// Path: lightningAddress.feedback
class _Translations$lightningAddress$feedback$fr extends Translations$lightningAddress$feedback$en {
	_Translations$lightningAddress$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Adresse Lightning enregistrée !';
	@override String get updated => 'Adresse Lightning mise à jour !';
	@override String get valid => 'Adresse Lightning valide';
}

// Path: lightningAddress.errors
class _Translations$lightningAddress$errors$fr extends Translations$lightningAddress$errors$en {
	_Translations$lightningAddress$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String saving({required Object details}) => 'Erreur lors de l\'enregistrement de l\'adresse : ${details}';
	@override String loading({required Object details}) => 'Erreur lors du chargement de l\'adresse Lightning : ${details}';
}

// Path: nfc.actions
class _Translations$nfc$actions$fr extends Translations$nfc$actions$en {
	_Translations$nfc$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get scan => 'Scanner NFC';
	@override String get addWallet => 'Ajouter le wallet';
}

// Path: nfc.prompts
class _Translations$nfc$prompts$fr extends Translations$nfc$prompts$en {
	_Translations$nfc$prompts$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Ajouter le wallet Lightning ?';
	@override String addMessage({required Object address}) => 'Cette adresse Lightning a été trouvée sur un tag NFC : ${address}\n\nL\'ajouter comme wallet LNURL ?';
}

// Path: nfc.feedback
class _Translations$nfc$feedback$fr extends Translations$nfc$feedback$en {
	_Translations$nfc$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get readyToScan => 'Approchez votre téléphone du tag NFC';
	@override String get alreadyScanning => 'Un scan NFC est déjà en cours';
	@override String get alreadyAdded => 'Cette adresse Lightning est déjà configurée';
	@override String get walletAdded => 'Wallet Lightning ajouté depuis le tag NFC';
}

// Path: nfc.errors
class _Translations$nfc$errors$fr extends Translations$nfc$errors$en {
	_Translations$nfc$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get disabled => 'Le NFC est désactivé sur cet appareil';
	@override String get unsupported => 'Le NFC n\'est pas disponible sur cet appareil';
	@override String reading({required Object details}) => 'Échec du scan NFC : ${details}';
}

// Path: offers.details
class _Translations$offers$details$fr extends Translations$offers$details$en {
	_Translations$offers$details$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get yourOffer => 'Votre offre :';
	@override String get selectedOffer => 'Offre :';
	@override String get activeOffer => 'Vous avez une offre active :';
	@override String get finishedOffers => 'Offres terminées';
	@override String get noAvailable => 'Aucune offre disponible.';
	@override String noAvailableTip({required Object app}) => 'Astuce : partagez ${app} dans votre communauté et parmi vos amis pour augmenter le nombre de commandes ${app}.';
	@override String get noSuccessfulTrades => 'Aucun échange réussi.';
	@override String get loadingDetails => 'Chargement des détails de l\'offre...';
	@override String amount({required Object amount}) => 'Montant : ${amount} satoshi';
	@override String amountWithCurrency({required Object amount, required Object currency}) => '${amount} ${currency}';
	@override String makerFee({required Object fee}) => 'Frais : ${fee} sats';
	@override String takerFee({required Object fee}) => 'Frais : ${fee} sats';
	@override String subtitle({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (frais) satoshi\nStatut : ${status}';
	@override String subtitleWithDate({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (frais) satoshi\nStatut : ${status}\nPayé : ${date}';
	@override String activeSubtitle({required Object status, required Object amount}) => 'Statut : ${status}\nMontant : ${amount} satoshi';
	@override String id({required Object id}) => 'ID de l\'offre : ${id}...';
	@override String created({required Object dateTime}) => 'Créée : ${dateTime}';
	@override String takenAfter({required Object duration}) => 'Acceptée après : ${duration}';
	@override String paidAfter({required Object duration}) => 'Payée après : ${duration}';
	@override String get exchangeRate => 'Taux de change';
	@override String get amountLabel => 'Montant';
	@override String get makerFeeLabel => 'Frais maker';
	@override String get takerFeeLabel => 'Frais taker';
	@override String get feeLabel => 'Frais';
	@override String get statusLabel => 'Statut';
	@override String get youllReceive => 'Vous recevrez';
	@override String get coordinator => 'Coordinateur';
	@override String get categoryLabel => 'Catégorie';
	@override late final _Translations$offers$details$categories$fr categories = _Translations$offers$details$categories$fr._(_root);
	@override late final _Translations$offers$details$consents$fr consents = _Translations$offers$details$consents$fr._(_root);
}

// Path: offers.labels
class _Translations$offers$labels$fr extends Translations$offers$labels$en {
	_Translations$offers$labels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get premium => 'Prime';
	@override String premiumBadge({required Object percent}) => '+${percent}% de prime';
}

// Path: offers.tooltips
class _Translations$offers$tooltips$fr extends Translations$offers$tooltips$en {
	_Translations$offers$tooltips$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String takerFeeInfo({required Object feePercent}) => 'Le coordinateur facture des frais taker de ${feePercent}%. Ils incluent les frais de routage Lightning et sont déduits du montant que vous recevez.';
	@override String get premiumInfoTaker => 'Une prime signifie que cette offre est au-dessus du prix du marché. Pour le même montant fiat, le maker verrouille moins de sats dans la facture hold : vous payez donc au-dessus du marché et recevez moins de sats qu\'au taux du marché. La prime maximale est fixée par le coordinateur.';
	@override String get ratesFetchedAt => 'Récupéré à';
	@override String get ratesSources => 'Sources du taux moyen';
}

// Path: offers.actions
class _Translations$offers$actions$fr extends Translations$offers$actions$en {
	_Translations$offers$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get take => 'ACCEPTER';
	@override String get takeOffer => 'Accepter l\'offre';
	@override String resume({required Object code}) => 'SAISIR ${code}';
	@override String get cancel => 'Annuler l\'offre';
	@override String get view => 'Voir les détails';
}

// Path: offers.status
class _Translations$offers$status$fr extends Translations$offers$status$en {
	_Translations$offers$status$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get created => 'Créée';
	@override String get funded => 'Financée';
	@override String get expired => 'Expirée';
	@override String get cancelled => 'Annulée';
	@override String get reserved => 'Réservée';
	@override String blikReceived({required Object code}) => '${code} envoyé';
	@override String blikSentToMaker({required Object code}) => '${code} reçu';
	@override String expiredBlik({required Object code}) => '${code} expiré';
	@override String expiredSentBlik({required Object code}) => '${code} expiré';
	@override String get takerCharged => 'Taker débité';
	@override String invalidBlik({required Object code}) => '${code} invalide';
	@override String get conflict => 'Conflit';
	@override String get dispute => 'Litige';
	@override String get refundingMaker => 'Remboursement du maker';
	@override String get makerConfirmed => 'Confirmée';
	@override String get settled => 'Réglée';
	@override String get payingTaker => 'Paiement du taker';
	@override String get takerPaymentFailed => 'Échec du paiement au taker';
	@override String get takerPaid => 'Taker payé';
	@override String get unknownStatus => 'Inconnu';
}

// Path: offers.statusMessages
class _Translations$offers$statusMessages$fr extends Translations$offers$statusMessages$en {
	_Translations$offers$statusMessages$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get reserved => 'Offre réservée par un taker !';
	@override String get cancelled => 'Offre annulée avec succès.';
	@override String get cancelledOrExpired => 'L\'offre a été annulée ou a expiré.';
	@override String noLongerAvailable({required Object status}) => 'L\'offre n\'est plus disponible (Statut : ${status}).';
}

// Path: offers.progress
class _Translations$offers$progress$fr extends Translations$offers$progress$en {
	_Translations$offers$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String waitingForTaker({required Object time}) => 'En attente d\'un taker : ${time}';
	@override String reserved({required Object seconds}) => 'Réservée : ${seconds} s restantes';
	@override String confirming({required Object seconds}) => 'Confirmation : ${seconds} s restantes';
}

// Path: offers.errors
class _Translations$offers$errors$fr extends Translations$offers$errors$en {
	_Translations$offers$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String loading({required Object details}) => 'Erreur lors du chargement des offres : ${details}';
	@override String loadingDetails({required Object details}) => 'Erreur lors du chargement des détails de l\'offre : ${details}';
	@override String get detailsMissing => 'Erreur : détails de l\'offre manquants ou invalides.';
	@override String get detailsNotLoaded => 'Impossible de charger les détails de l\'offre.';
	@override String get notFound => 'Erreur : offre introuvable.';
	@override String get unexpectedState => 'Erreur : l\'offre est dans un état inattendu.';
	@override String unexpectedStateWithStatus({required Object status}) => 'L\'offre est dans un état inattendu (${status}). Veuillez réessayer ou contacter le support.';
	@override String get invalidStatus => 'L\'offre a un statut invalide.';
	@override String get couldNotIdentify => 'Erreur : impossible d\'identifier l\'offre à annuler.';
	@override String cannotBeCancelled({required Object status}) => 'L\'offre ne peut pas être annulée dans son état actuel (${status}).';
	@override String failedToCancel({required Object details}) => 'Échec de l\'annulation de l\'offre : ${details}';
	@override String get activeDetailsLost => 'Erreur : détails de l\'offre active perdus.';
	@override String checkingActive({required Object details}) => 'Erreur lors de la vérification des offres actives : ${details}';
	@override String cannotResume({required Object status}) => 'Impossible de reprendre l\'offre dans cet état : ${status}';
	@override String cannotResumeTaker({required Object status}) => 'Impossible de reprendre l\'offre taker dans cet état : ${status}';
	@override String resuming({required Object details}) => 'Erreur lors de la reprise de l\'offre : ${details}';
	@override String get makerPublicKeyNotFound => 'Clé publique du maker introuvable';
	@override String get takerPublicKeyNotFound => 'Clé publique du taker introuvable.';
	@override String get atmConsentRequired => 'Acceptez la condition relative aux frais de distributeur avant d\'accepter cette offre.';
	@override String get ecommerceConsentRequired => 'Acceptez la condition de restitution des remboursements e-commerce avant d\'accepter cette offre.';
	@override String get cannotTakeOwnOffer => 'Vous ne pouvez pas accepter votre propre offre.';
}

// Path: offers.success
class _Translations$offers$success$fr extends Translations$offers$success$en {
	_Translations$offers$success$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offre terminée';
	@override String get headline => 'Paiement confirmé !';
	@override String get subtitle => 'Le taker va maintenant être payé.';
	@override String get detailsTitle => 'Détails de l\'offre :';
	@override String duration({required Object time}) => 'L\'offre a pris ${time} pour se terminer.';
}

// Path: reservations.actions
class _Translations$reservations$actions$fr extends Translations$reservations$actions$en {
	_Translations$reservations$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuler la réservation';
}

// Path: reservations.feedback
class _Translations$reservations$feedback$fr extends Translations$reservations$feedback$en {
	_Translations$reservations$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancelled => 'Réservation annulée.';
}

// Path: reservations.errors
class _Translations$reservations$errors$fr extends Translations$reservations$errors$en {
	_Translations$reservations$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String cancelling({required Object error}) => 'Échec de l\'annulation de la réservation : ${error}';
	@override String failedToReserve({required Object details}) => 'Échec de la réservation de l\'offre : ${details}';
	@override String get failedNoTimestamp => 'Échec de la réservation de l\'offre (pas d\'horodatage).';
	@override String get timestampMissing => 'Horodatage de la réservation de l\'offre manquant.';
	@override String notReserved({required Object status}) => 'L\'offre n\'est plus à l\'état réservé (${status}).';
}

// Path: exchange.labels
class _Translations$exchange$labels$fr extends Translations$exchange$labels$en {
	_Translations$exchange$labels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String enterAmount({required Object currency}) => 'Saisissez le montant (${currency}) à payer :';
	@override String equivalent({required Object sats}) => '≈ ${sats} satoshi';
	@override String rate({required Object rate, required Object currency}) => 'Taux de change ≈ ${rate} ${currency}/BTC';
}

// Path: exchange.feedback
class _Translations$exchange$feedback$fr extends Translations$exchange$feedback$en {
	_Translations$exchange$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get fetching => 'Récupération du taux de change...';
}

// Path: exchange.errors
class _Translations$exchange$errors$fr extends Translations$exchange$errors$en {
	_Translations$exchange$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get fetchingRate => 'Impossible de récupérer le taux de change.';
	@override String get invalidFormat => 'Format de nombre invalide';
	@override String get mustBePositive => 'Le montant doit être positif';
	@override String get invalidFeePercentage => 'Pourcentage de frais invalide';
	@override String tooLowFiat({required Object minAmount, required Object currency}) => 'Le montant est trop faible. Le minimum est ${minAmount} ${currency}.';
	@override String tooHighFiat({required Object maxAmount, required Object currency}) => 'Le montant est trop élevé. Le maximum est ${maxAmount} ${currency}.';
	@override String atmNotDispensable({required Object notes}) => 'Le distributeur ne peut pas délivrer ce montant. Utilisez une combinaison de billets : ${notes}.';
	@override String atmOverBankLimit({required Object bank, required Object limit, required Object currency}) => '${bank} délivre au maximum ${limit} ${currency} par retrait.';
}

// Path: coordinator.info
class _Translations$coordinator$info$fr extends Translations$coordinator$info$en {
	_Translations$coordinator$info$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get fee => 'frais';
	@override String rangeDisplay({required Object minAmount, required Object maxAmount, required Object currency}) => 'Montant : ${minAmount}-${maxAmount} ${currency}';
	@override String feeDisplay({required Object fee}) => '${fee}% de frais';
}

// Path: coordinator.selector
class _Translations$coordinator$selector$fr extends Translations$coordinator$selector$en {
	_Translations$coordinator$selector$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Chargement des coordinateurs...';
	@override String get errorLoading => 'Erreur lors du chargement des coordinateurs';
	@override String get choose => 'Choisir un coordinateur';
	@override String get viewNostrProfile => 'Voir le profil Nostr';
	@override String get unresponsive => 'Ce coordinateur ne répond pas';
	@override String get waitingResponse => 'En attente de la réponse du coordinateur';
	@override String get termsAccept => 'J\'accepte les ';
	@override String get termsOfUsage => 'conditions d\'utilisation du coordinateur';
}

// Path: coordinator.dialog
class _Translations$coordinator$dialog$fr extends Translations$coordinator$dialog$en {
	_Translations$coordinator$dialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get makerFee => 'Frais maker';
	@override String get takerFee => 'Frais taker';
	@override String get amountRange => 'Plage de montants';
	@override String get reservationTime => 'Durée de réservation';
	@override String get currencies => 'Devises';
	@override String get viewTerms => 'Voir les conditions';
}

// Path: coordinator.details
class _Translations$coordinator$details$fr extends Translations$coordinator$details$en {
	_Translations$coordinator$details$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Coordinateur';
	@override String get relaysInUse => 'Relais utilisés';
	@override String get relaysInUseHint => 'Toute la communication avec ce coordinateur passe par ces relais (issus de sa liste NIP-65).';
	@override String get noRelays => 'Aucun relais connu pour l\'instant';
	@override String get makerFee => 'Frais maker';
	@override String get takerFee => 'Frais taker';
	@override String get amountRange => 'Plage de montants';
	@override String get maxPremium => 'Prime max';
	@override String get maxPremiumInfoTitle => 'Prime';
	@override String get maxPremiumInfoBody => 'Une prime est une majoration facultative du prix au-dessus du taux du marché qu\'un maker peut appliquer à une offre. Avec une prime, le maker verrouille moins de sats pour le même montant fiat : le taker paie donc au-dessus du marché et le maker garde la différence. Cette valeur est la prime la plus élevée que ce coordinateur autorise sur ses offres.';
	@override String get reservationTime => 'Durée de réservation';
	@override String get currencies => 'Devises';
	@override String get paymentSystem => 'Système de paiement';
	@override String get version => 'Version';
	@override String get yourOffers => 'Vos offres';
	@override String get successfulOffers => 'Offres réussies (30 j)';
	@override String get statusOnline => 'En ligne';
	@override String get statusOffline => 'Hors ligne';
	@override String get statusUnknown => 'Inconnu';
	@override String get openNostrProfile => 'Ouvrir le profil Nostr';
	@override String get termsOfUsage => 'Conditions d\'utilisation';
}

// Path: coordinator.coldStart
class _Translations$coordinator$coldStart$fr extends Translations$coordinator$coldStart$en {
	_Translations$coordinator$coldStart$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Découverte des coordinateurs';
	@override String body({required Object app}) => '${app} recherche des coordinateurs publics, vérifie lesquels sont joignables et active pour vous une petite sélection par défaut.';
	@override String get settingsHint => 'Vous pourrez modifier les coordinateurs activés plus tard dans les Réglages.';
	@override String get ok => 'OK';
	@override String get discovered => 'Découverts';
	@override String get candidates => 'Candidats';
	@override String get enabled => 'Activés';
	@override String get recordsTitle => 'Coordinateurs actuels';
	@override String get recordEnabled => 'Activé';
	@override String get recordHealthyCandidate => 'Candidat opérationnel';
	@override String get recordOfflineCandidate => 'Candidat hors ligne';
	@override String get recordChecking => 'Vérification';
	@override String get recordDiscovered => 'Découvert';
	@override late final _Translations$coordinator$coldStart$phases$fr phases = _Translations$coordinator$coldStart$phases$fr._(_root);
}

// Path: coordinator.management
class _Translations$coordinator$management$fr extends Translations$coordinator$management$en {
	_Translations$coordinator$management$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gestion des coordinateurs';
	@override String get availableCoordinators => 'Coordinateurs';
	@override String get noCoordinators => 'Aucun coordinateur découvert pour l\'instant.';
	@override String get online => 'En ligne';
	@override String get unknownOffline => 'Inconnu/Hors ligne';
	@override String get openNostrProfile => 'Ouvrir le profil Nostr';
	@override String get enable => 'Activer';
	@override String get remove => 'Retirer';
	@override String get addCustomWhitelist => 'Ajouter un coordinateur personnalisé';
	@override String get addCustomWhitelistHint => 'npub1...';
	@override String get add => 'Ajouter';
	@override String get coordinatorDisabled => 'Coordinateur désactivé';
	@override String get coordinatorEnabled => 'Coordinateur activé';
	@override String get coordinatorAdded => 'Coordinateur ajouté à la liste blanche personnalisée';
	@override String get coordinatorRemoved => 'Coordinateur retiré de la liste blanche personnalisée';
	@override String get coordinatorAddInfoUnavailable => 'Aucune information sur ce coordinateur trouvée sur les relais. Coordinateur non ajouté.';
	@override String get pleaseEnterNpub => 'Veuillez saisir un npub';
	@override String get error => 'Erreur';
	@override String get metricYourOffers => 'Vos offres';
	@override String get metricYourOffersTooltip => 'Nombre d\'offres que vous avez menées à bien avec ce coordinateur.';
	@override String get metricNetworkOffers => 'Offres (30 j)';
	@override String get metricNetworkOffersTooltip => 'Offres réussies réglées par ce coordinateur pour l\'ensemble des utilisateurs au cours des 30 derniers jours.';
}

// Path: disputeChat.tooltips
class _Translations$disputeChat$tooltips$fr extends Translations$disputeChat$tooltips$en {
	_Translations$disputeChat$tooltips$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get refresh => 'Actualiser les messages';
	@override String get attachEvidence => 'Joindre une preuve de paiement';
	@override String get send => 'Envoyer le message';
}

// Path: disputeChat.errors
class _Translations$disputeChat$errors$fr extends Translations$disputeChat$errors$en {
	_Translations$disputeChat$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get accountNotReady => 'La messagerie privée sera disponible lorsque votre compte Nostr sera prêt.';
	@override String get subscriptionFailed => 'La connexion aux messages privés a échoué. Actualisez la conversation.';
	@override String get decryptFailed => 'Un message privé n’a pas pu être déchiffré.';
	@override String get operationFailed => 'L’opération de messagerie privée a échoué. Veuillez réessayer.';
	@override String get nostrNotInitialized => 'Nostr n’est pas initialisé.';
	@override String get attachmentsRequireNip17 => 'Les pièces jointes sont disponibles uniquement dans le canal NIP-17.';
}

// Path: receivingInvoice.errors
class _Translations$receivingInvoice$errors$fr extends Translations$receivingInvoice$errors$en {
	_Translations$receivingInvoice$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get walletUnavailable => 'Le service de portefeuille est indisponible.';
	@override String get noBolt11 => 'Le portefeuille n’a pas renvoyé de facture BOLT11.';
}

// Path: maker.refundInvoice
class _Translations$maker$refundInvoice$fr extends Translations$maker$refundInvoice$en {
	_Translations$maker$refundInvoice$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Le coordinateur a statué en votre faveur';
	@override String instructions({required Object amount}) => 'Choisissez un portefeuille de réception ou collez une facture Lightning de exactement ${amount} pour votre remboursement.';
	@override String get invoiceLabel => 'Facture de remboursement au montant exact';
	@override String get submit => 'Envoyer la facture de remboursement';
	@override String get addWallet => 'Ajouter un portefeuille';
	@override String get noReceivingWallet => 'Aucun portefeuille de réception n’est configuré. Ajoutez-en un ou collez une facture provenant d’un autre portefeuille.';
	@override String get paymentFailed => 'La tentative de remboursement précédente a échoué. Choisissez un autre portefeuille ou envoyez une nouvelle facture.';
	@override String submitFailed({required Object details}) => 'Impossible d’envoyer la facture de remboursement : ${details}';
	@override late final _Translations$maker$refundInvoice$errors$fr errors = _Translations$maker$refundInvoice$errors$fr._(_root);
}

// Path: maker.roleSelection
class _Translations$maker$roleSelection$fr extends Translations$maker$roleSelection$en {
	_Translations$maker$roleSelection$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get button => 'PAYER avec Lightning';
}

// Path: maker.amountForm
class _Translations$maker$amountForm$fr extends Translations$maker$amountForm$en {
	_Translations$maker$amountForm$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$amountForm$progress$fr progress = _Translations$maker$amountForm$progress$fr._(_root);
	@override late final _Translations$maker$amountForm$labels$fr labels = _Translations$maker$amountForm$labels$fr._(_root);
	@override late final _Translations$maker$amountForm$actions$fr actions = _Translations$maker$amountForm$actions$fr._(_root);
	@override late final _Translations$maker$amountForm$bank$fr bank = _Translations$maker$amountForm$bank$fr._(_root);
	@override late final _Translations$maker$amountForm$twintScan$fr twintScan = _Translations$maker$amountForm$twintScan$fr._(_root);
	@override late final _Translations$maker$amountForm$tooltips$fr tooltips = _Translations$maker$amountForm$tooltips$fr._(_root);
	@override late final _Translations$maker$amountForm$category$fr category = _Translations$maker$amountForm$category$fr._(_root);
	@override late final _Translations$maker$amountForm$onboarding$fr onboarding = _Translations$maker$amountForm$onboarding$fr._(_root);
	@override late final _Translations$maker$amountForm$errors$fr errors = _Translations$maker$amountForm$errors$fr._(_root);
}

// Path: maker.payInvoice
class _Translations$maker$payInvoice$fr extends Translations$maker$payInvoice$en {
	_Translations$maker$payInvoice$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Payez cette facture hold :';
	@override late final _Translations$maker$payInvoice$actions$fr actions = _Translations$maker$payInvoice$actions$fr._(_root);
	@override late final _Translations$maker$payInvoice$feedback$fr feedback = _Translations$maker$payInvoice$feedback$fr._(_root);
	@override late final _Translations$maker$payInvoice$errors$fr errors = _Translations$maker$payInvoice$errors$fr._(_root);
	@override late final _Translations$maker$payInvoice$budgetWarning$fr budgetWarning = _Translations$maker$payInvoice$budgetWarning$fr._(_root);
}

// Path: maker.waitTaker
class _Translations$maker$waitTaker$fr extends Translations$maker$waitTaker$en {
	_Translations$maker$waitTaker$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'En attente d\'un taker pour réserver votre offre...';
	@override String progressLabel({required Object time}) => 'En attente d\'un taker : ${time}';
	@override String get errorActiveOfferDetailsLost => 'Erreur : détails de l\'offre active perdus.';
	@override String errorFailedToRetrieveBlik({required Object code}) => 'Erreur : impossible de récupérer le code ${code}.';
	@override String errorRetrievingBlik({required Object code, required Object details}) => 'Erreur lors de la récupération du code ${code} : ${details}';
	@override String offerNoLongerAvailable({required Object status}) => 'L\'offre n\'est plus disponible (Statut : ${status}).';
	@override String get errorCouldNotIdentifyOffer => 'Erreur : impossible d\'identifier l\'offre à annuler.';
	@override String offerCannotBeCancelled({required Object status}) => 'L\'offre ne peut pas être annulée dans son état actuel (${status}).';
	@override String get offerCancelledSuccessfully => 'Offre annulée avec succès.';
	@override String failedToCancelOffer({required Object details}) => 'Échec de l\'annulation de l\'offre : ${details}';
	@override String get offerExpiredTitle => 'Offre expirée';
	@override String get offerExpiredMessage => 'Aucun taker n\'a réservé votre offre à temps.';
	@override String get recreateOffer => 'Nouvelle offre — même montant';
}

// Path: maker.waitForBlik
class _Translations$maker$waitForBlik$fr extends Translations$maker$waitForBlik$en {
	_Translations$maker$waitForBlik$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'En attente du ${code}';
	@override String get messageInfo => 'Un taker a réservé l\'offre !';
	@override String messageWaiting({required Object code}) => 'En attente de la fourniture du code ${code}...';
	@override String progressLabel({required Object seconds}) => 'Réservée : ${seconds} s restantes';
}

// Path: maker.confirmPayment
class _Translations$maker$confirmPayment$fr extends Translations$maker$confirmPayment$en {
	_Translations$maker$confirmPayment$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Code ${code} reçu !';
	@override String retrieving({required Object code}) => 'Récupération du code ${code}...';
	@override String get instructions => 'Saisissez ce code dans le terminal de paiement. Lorsque le taker confirme dans son application bancaire et que le paiement est réussi, appuyez sur Confirmer ci-dessous.';
	@override String instruction1({required Object code}) => 'Saisissez le code dans la demande de paiement ${code}.';
	@override String get instruction2 => 'Attendez que le taker confirme le paiement dans son application.';
	@override String get instruction3 => 'Lorsque le paiement est réussi, appuyez sur Confirmer ci-dessous :';
	@override String mbwayAtmInstructions({required Object amount, required Object minutes}) => 'Pour retirer ${amount} €, rendez-vous au distributeur MULTIBANCO le plus proche, appuyez sur la touche verte et choisissez l\'option "Retirer de l\'argent" ("Levantar Dinheiro"). Saisissez le code. Ce code est valable ${minutes} minutes.';
	@override String takerChargedWarning({required Object code}) => 'Le taker a signalé que le paiement ${code} a été débité de son compte bancaire. Si vous le marquez comme invalide, cela créera un conflit.';
	@override String autoConfirmInfo({required Object code}) => 'Sauf si vous marquez le ${code} comme invalide, le paiement sera confirmé automatiquement et le taker payé à la fin de ce compte à rebours.';
	@override String autoConfirmCountdown({required Object time}) => 'Confirmation automatique dans ${time}';
	@override String expiredTitle({required Object code}) => 'Code ${code} expiré';
	@override String expiredWarning({required Object code}) => 'Le code ${code} a expiré. Vous devez confirmer manuellement le statut du paiement :';
	@override String expiredInstruction1({required Object code}) => 'Si le paiement ${code} a réussi et que vous avez terminé votre achat, cliquez sur "Confirmer le paiement réussi" ci-dessous.';
	@override String expiredInstruction2({required Object code}) => 'Si le paiement ${code} a échoué ou n\'a pas été effectué, cliquez sur "Code ${code} invalide" ci-dessous.';
	@override late final _Translations$maker$confirmPayment$actions$fr actions = _Translations$maker$confirmPayment$actions$fr._(_root);
	@override late final _Translations$maker$confirmPayment$confirmDialog$fr confirmDialog = _Translations$maker$confirmPayment$confirmDialog$fr._(_root);
	@override late final _Translations$maker$confirmPayment$invalidBlikDisputeDialog$fr invalidBlikDisputeDialog = _Translations$maker$confirmPayment$invalidBlikDisputeDialog$fr._(_root);
	@override late final _Translations$maker$confirmPayment$feedback$fr feedback = _Translations$maker$confirmPayment$feedback$fr._(_root);
	@override late final _Translations$maker$confirmPayment$errors$fr errors = _Translations$maker$confirmPayment$errors$fr._(_root);
}

// Path: maker.invalidBlik
class _Translations$maker$invalidBlik$fr extends Translations$maker$invalidBlik$en {
	_Translations$maker$invalidBlik$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Code ${code} invalide';
	@override String info({required Object code}) => 'Vous avez marqué le code ${code} comme invalide. En attente que le taker fournisse un nouveau code ou ouvre un litige.';
}

// Path: maker.conflict
class _Translations$maker$conflict$fr extends Translations$maker$conflict$en {
	_Translations$maker$conflict$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conflit sur l\'offre';
	@override String get headline => 'Conflit sur l\'offre signalé';
	@override String body({required Object code}) => 'Vous avez marqué le code ${code} comme invalide, mais le taker a signalé un conflit, indiquant qu\'il estime que le paiement a réussi.';
	@override String get instructions => 'Confirmez le résultat avant la fin du délai. Si le paiement a réussi, confirmez-le afin que le taker soit payé. S\'il a échoué, ouvrez un litige. Sans action de votre part, un litige formel sera ouvert automatiquement.';
	@override String timeoutLabel({required Object time}) => 'Ouverture automatique du litige formel dans ${time}';
	@override late final _Translations$maker$conflict$actions$fr actions = _Translations$maker$conflict$actions$fr._(_root);
	@override late final _Translations$maker$conflict$disputeDialog$fr disputeDialog = _Translations$maker$conflict$disputeDialog$fr._(_root);
	@override late final _Translations$maker$conflict$feedback$fr feedback = _Translations$maker$conflict$feedback$fr._(_root);
	@override late final _Translations$maker$conflict$errors$fr errors = _Translations$maker$conflict$errors$fr._(_root);
	@override late final _Translations$maker$conflict$nostrContact$fr nostrContact = _Translations$maker$conflict$nostrContact$fr._(_root);
}

// Path: maker.success
class _Translations$maker$success$fr extends Translations$maker$success$en {
	_Translations$maker$success$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offre terminée';
	@override String get headline => 'Paiement confirmé !';
	@override String get subtitle => 'Le taker va maintenant être payé.';
	@override String get detailsTitle => 'Détails de l\'offre :';
	@override String duration({required Object time}) => 'L\'offre a pris ${time} !';
}

// Path: taker.roleSelection
class _Translations$taker$roleSelection$fr extends Translations$taker$roleSelection$en {
	_Translations$taker$roleSelection$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String button({required Object code}) => 'VENDRE un code ${code} contre des satoshi';
}

// Path: taker.progress
class _Translations$taker$progress$fr extends Translations$taker$progress$en {
	_Translations$taker$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String step1({required Object code}) => 'Envoyer le ${code}';
	@override String step2({required Object code}) => 'Confirmer le ${code}';
	@override String get step3 => 'Être payé';
}

// Path: taker.submitBlik
class _Translations$taker$submitBlik$fr extends Translations$taker$submitBlik$en {
	_Translations$taker$submitBlik$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String generateInBank({required Object bank}) => 'Générez le code de retrait dans votre application ${bank}.';
	@override String title({required Object code, required Object digits}) => 'Saisissez le ${code} à ${digits} chiffres';
	@override String label({required Object code}) => 'Code ${code}';
	@override String instruction({required Object code}) => 'Saisissez le ${code} avant la fin du délai...';
	@override String timeLimit({required Object code, required Object seconds}) => 'Saisissez le ${code} dans les : ${seconds} s';
	@override String timeExpired({required Object code}) => 'Le délai pour saisir le code ${code} a expiré.';
	@override late final _Translations$taker$submitBlik$actions$fr actions = _Translations$taker$submitBlik$actions$fr._(_root);
	@override late final _Translations$taker$submitBlik$feedback$fr feedback = _Translations$taker$submitBlik$feedback$fr._(_root);
	@override late final _Translations$taker$submitBlik$validation$fr validation = _Translations$taker$submitBlik$validation$fr._(_root);
	@override late final _Translations$taker$submitBlik$errors$fr errors = _Translations$taker$submitBlik$errors$fr._(_root);
	@override late final _Translations$taker$submitBlik$details$fr details = _Translations$taker$submitBlik$details$fr._(_root);
}

// Path: taker.criticalCodeDecision
class _Translations$taker$criticalCodeDecision$fr extends Translations$taker$criticalCodeDecision$en {
	_Translations$taker$criticalCodeDecision$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Décision critique';
	@override String explanation({required Object code}) => 'Vous avez déjà communiqué un code ${code} au maker. Continuer peut remplacer ce code, mettre fin à votre réservation et rouvrir l’offre à d’autres takers.';
	@override String get warningTitle => 'VOUS RISQUEZ DE PERDRE VOS FONDS';
	@override String warningBody({required Object code}) => 'Si votre banque a débité le paiement ${code}, NE continuez PAS. Le maker a peut-être utilisé votre code et, après cette action, le coordinateur pourrait ne plus pouvoir garantir le versement de vos bitcoins.';
	@override late final _Translations$taker$criticalCodeDecision$actions$fr actions = _Translations$taker$criticalCodeDecision$actions$fr._(_root);
}

// Path: taker.conflict
class _Translations$taker$conflict$fr extends Translations$taker$conflict$en {
	_Translations$taker$conflict$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmation du paiement en attente';
	@override String get headline => 'En attente de la confirmation du maker';
	@override String body({required Object code}) => 'Vous avez signalé que le paiement ${code} a été débité, mais le maker a indiqué qu\'il avait échoué. Ces déclarations sont contradictoires.';
	@override String get instructions => 'Le maker doit maintenant confirmer le résultat. S\'il confirme que le paiement a réussi, votre versement continuera. S\'il confirme l\'échec, ou si le délai expire, l\'offre passera en litige formel et le chat du litige deviendra disponible.';
	@override String timeoutLabel({required Object time}) => 'Ouverture automatique du litige formel dans ${time}';
	@override late final _Translations$taker$conflict$actions$fr actions = _Translations$taker$conflict$actions$fr._(_root);
	@override late final _Translations$taker$conflict$feedback$fr feedback = _Translations$taker$conflict$feedback$fr._(_root);
	@override late final _Translations$taker$conflict$errors$fr errors = _Translations$taker$conflict$errors$fr._(_root);
}

// Path: taker.dispute
class _Translations$taker$dispute$fr extends Translations$taker$dispute$en {
	_Translations$taker$dispute$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get headline => 'Litige formel ouvert';
	@override String get body => 'L\'offre est maintenant examinée par le coordinateur. Utilisez le chat du litige ci-dessous pour communiquer avec le coordinateur et fournir les justificatifs demandés.';
}

// Path: twint.scanner
class _Translations$twint$scanner$fr extends Translations$twint$scanner$en {
	_Translations$twint$scanner$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Scanner le code ${code}';
	@override late final _Translations$twint$scanner$status$fr status = _Translations$twint$scanner$status$fr._(_root);
}

// Path: twint.flow
class _Translations$twint$flow$fr extends Translations$twint$flow$en {
	_Translations$twint$flow$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$twint$flow$progress$fr progress = _Translations$twint$flow$progress$fr._(_root);
	@override late final _Translations$twint$flow$takerProgress$fr takerProgress = _Translations$twint$flow$takerProgress$fr._(_root);
	@override late final _Translations$twint$flow$makerWait$fr makerWait = _Translations$twint$flow$makerWait$fr._(_root);
	@override late final _Translations$twint$flow$makerExpired$fr makerExpired = _Translations$twint$flow$makerExpired$fr._(_root);
	@override late final _Translations$twint$flow$makerVerify$fr makerVerify = _Translations$twint$flow$makerVerify$fr._(_root);
	@override late final _Translations$twint$flow$makerRecode$fr makerRecode = _Translations$twint$flow$makerRecode$fr._(_root);
	@override late final _Translations$twint$flow$takerPay$fr takerPay = _Translations$twint$flow$takerPay$fr._(_root);
	@override late final _Translations$twint$flow$takerWait$fr takerWait = _Translations$twint$flow$takerWait$fr._(_root);
	@override late final _Translations$twint$flow$takerExpired$fr takerExpired = _Translations$twint$flow$takerExpired$fr._(_root);
}

// Path: twint.waitConfirmation
class _Translations$twint$waitConfirmation$fr extends Translations$twint$waitConfirmation$en {
	_Translations$twint$waitConfirmation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'En attente du maker';
	@override String statusLabel({required Object status}) => 'Statut de l\'offre : ${status}';
	@override String waitingMaker({required Object seconds}) => 'En attente de la confirmation du maker : ${seconds} s';
	@override String waitingMakerConfirmation({required Object code, required Object seconds}) => 'En attente que le maker confirme que le ${code} est correct. Temps restant : ${seconds}s';
	@override String importantNotice({required Object code, required Object amount, required Object currency}) => 'TRÈS IMPORTANT : assurez-vous de n\'accepter qu\'une confirmation ${code} de ${amount} ${currency}';
	@override String importantBlikAmountConfirmation({required Object code, required Object amount, required Object currency}) => 'TRÈS IMPORTANT : dans votre application bancaire, assurez-vous de confirmer un paiement ${code} d\'exactement ${amount} ${currency}.';
	@override String instructions({required Object minutes, required Object code}) => 'Le maker doit maintenant le saisir dans le terminal de paiement dans les ${minutes} minutes. Vous devrez ensuite accepter le code ${code} dans votre application bancaire.';
	@override String instructionsNoConfirm({required Object code, required Object minutes}) => 'Le maker doit maintenant saisir votre code ${code} au distributeur dans les ${minutes} minutes.';
	@override late final _Translations$twint$waitConfirmation$categoryReminder$fr categoryReminder = _Translations$twint$waitConfirmation$categoryReminder$fr._(_root);
	@override String waitingForMakerToReceive({required Object code}) => 'En attente que le maker reçoive votre code ${code}...';
	@override String makerReceivedBlik({required Object code}) => 'Le maker a reçu votre code ${code}.';
	@override String timerExpiredMessage({required Object minutes, required Object code}) => 'Le délai d\'expiration de ${minutes} min du ${code} est passé. En attente que le maker confirme ou marque le code comme invalide.';
	@override String timerExpiredActions({required Object minutes, required Object code}) => 'Le délai d\'expiration de ${minutes} min du ${code} est passé mais le maker n\'a pas reçu le code ${code}. Vous pouvez renvoyer un nouveau code ${code} ou annuler.';
	@override String resendBlikButton({required Object code}) => 'Renvoyer un nouveau code ${code}';
	@override String get navigatedHome => 'Retour à l\'accueil.';
	@override String expiredTitle({required Object code}) => 'Code ${code} expiré';
	@override String expiredWarning({required Object code}) => 'Le maker n\'a pas reçu le code ${code}, il n\'a donc pas pu l\'utiliser.';
	@override String get expiredRelistCountdownLabel => 'La réservation se termine dans';
	@override String get expiredSentWarning => 'Le maker n\'a pas encore confirmé le paiement. Que souhaitez-vous faire ?';
	@override String expiredInstruction1({required Object code}) => 'Si vous voulez réessayer avec un nouveau code ${code}, renouvelez la réservation.';
	@override String get expiredInstruction2 => 'Si vous ne souhaitez plus effectuer cette transaction, annulez la réservation.';
	@override String expiredInstruction3({required Object code}) => 'Si le paiement ${code} a été débité de votre compte bancaire, pas d\'inquiétude : les bitcoins sont toujours verrouillés en sécurité chez le coordinateur.';
	@override late final _Translations$twint$waitConfirmation$takerCharged$fr takerCharged = _Translations$twint$waitConfirmation$takerCharged$fr._(_root);
	@override late final _Translations$twint$waitConfirmation$expiredActions$fr expiredActions = _Translations$twint$waitConfirmation$expiredActions$fr._(_root);
	@override late final _Translations$twint$waitConfirmation$feedback$fr feedback = _Translations$twint$waitConfirmation$feedback$fr._(_root);
	@override late final _Translations$twint$waitConfirmation$errors$fr errors = _Translations$twint$waitConfirmation$errors$fr._(_root);
}

// Path: twint.paymentProcess
class _Translations$twint$paymentProcess$fr extends Translations$twint$paymentProcess$en {
	_Translations$twint$paymentProcess$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Processus de paiement';
	@override String get waitingForOfferUpdate => 'En attente de la mise à jour du statut de l\'offre...';
	@override late final _Translations$twint$paymentProcess$states$fr states = _Translations$twint$paymentProcess$states$fr._(_root);
	@override late final _Translations$twint$paymentProcess$steps$fr steps = _Translations$twint$paymentProcess$steps$fr._(_root);
	@override late final _Translations$twint$paymentProcess$errors$fr errors = _Translations$twint$paymentProcess$errors$fr._(_root);
	@override late final _Translations$twint$paymentProcess$loading$fr loading = _Translations$twint$paymentProcess$loading$fr._(_root);
	@override late final _Translations$twint$paymentProcess$actions$fr actions = _Translations$twint$paymentProcess$actions$fr._(_root);
}

// Path: twint.paymentFailed
class _Translations$twint$paymentFailed$fr extends Translations$twint$paymentFailed$en {
	_Translations$twint$paymentFailed$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paiement échoué';
	@override String instructions({required Object netAmount}) => 'Veuillez fournir une nouvelle facture Lightning de ${netAmount}';
	@override late final _Translations$twint$paymentFailed$form$fr form = _Translations$twint$paymentFailed$form$fr._(_root);
	@override late final _Translations$twint$paymentFailed$actions$fr actions = _Translations$twint$paymentFailed$actions$fr._(_root);
	@override late final _Translations$twint$paymentFailed$errors$fr errors = _Translations$twint$paymentFailed$errors$fr._(_root);
	@override late final _Translations$twint$paymentFailed$walletSection$fr walletSection = _Translations$twint$paymentFailed$walletSection$fr._(_root);
	@override late final _Translations$twint$paymentFailed$loading$fr loading = _Translations$twint$paymentFailed$loading$fr._(_root);
	@override late final _Translations$twint$paymentFailed$success$fr success = _Translations$twint$paymentFailed$success$fr._(_root);
}

// Path: twint.paymentSuccess
class _Translations$twint$paymentSuccess$fr extends Translations$twint$paymentSuccess$en {
	_Translations$twint$paymentSuccess$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paiement réussi';
	@override String get message => 'Votre paiement a été traité avec succès.';
	@override late final _Translations$twint$paymentSuccess$actions$fr actions = _Translations$twint$paymentSuccess$actions$fr._(_root);
}

// Path: twint.invalidBlik
class _Translations$twint$invalidBlik$fr extends Translations$twint$invalidBlik$en {
	_Translations$twint$invalidBlik$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Code ${code} invalide';
	@override String message({required Object code}) => 'Le maker a rejeté le code ${code}';
	@override String explanation({required Object code}) => 'Le créateur de l\'offre a indiqué que le code ${code} que vous avez fourni était invalide ou n\'a pas fonctionné.\n\nQue souhaitez-vous faire ?';
	@override String get werentCharged => 'Si vous n\'avez PAS été débité :';
	@override String get wereCharged => 'Si vous avez été débité :';
	@override late final _Translations$twint$invalidBlik$actions$fr actions = _Translations$twint$invalidBlik$actions$fr._(_root);
	@override late final _Translations$twint$invalidBlik$confirmDialog$fr confirmDialog = _Translations$twint$invalidBlik$confirmDialog$fr._(_root);
	@override late final _Translations$twint$invalidBlik$disputeConfirmDialog$fr disputeConfirmDialog = _Translations$twint$invalidBlik$disputeConfirmDialog$fr._(_root);
	@override late final _Translations$twint$invalidBlik$feedback$fr feedback = _Translations$twint$invalidBlik$feedback$fr._(_root);
	@override late final _Translations$twint$invalidBlik$errors$fr errors = _Translations$twint$invalidBlik$errors$fr._(_root);
}

// Path: twint.conflict
class _Translations$twint$conflict$fr extends Translations$twint$conflict$en {
	_Translations$twint$conflict$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conflit sur l\'offre';
	@override String get headline => 'Conflit sur l\'offre signalé';
	@override String body({required Object code}) => 'Le maker a marqué le code ${code} comme invalide, mais vous avez signalé un conflit, indiquant que vous estimez que le paiement a réussi.';
	@override String get instructions => 'Attendez que le coordinateur examine la situation. Des détails supplémentaires pourront vous être demandés. Revenez plus tard ou contactez le support si nécessaire.';
	@override late final _Translations$twint$conflict$actions$fr actions = _Translations$twint$conflict$actions$fr._(_root);
	@override late final _Translations$twint$conflict$feedback$fr feedback = _Translations$twint$conflict$feedback$fr._(_root);
	@override late final _Translations$twint$conflict$errors$fr errors = _Translations$twint$conflict$errors$fr._(_root);
	@override late final _Translations$twint$conflict$nostrContact$fr nostrContact = _Translations$twint$conflict$nostrContact$fr._(_root);
}

// Path: blik.instructions
class _Translations$blik$instructions$fr extends Translations$blik$instructions$en {
	_Translations$blik$instructions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String taker({required Object code}) => 'Dès que le maker saisit le code ${code}, vous devrez confirmer le paiement dans votre application bancaire. Vérifiez que le montant est correct avant de confirmer.';
}

// Path: home.notifications
class _Translations$home$notifications$fr extends Translations$home$notifications$en {
	_Translations$home$notifications$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Soyez notifié des nouvelles offres via :';
	@override String get telegram => 'Telegram';
	@override String get simplex => 'SimpleX';
	@override String get matrix => 'Matrix';
	@override String get signal => 'Signal';
	@override String get channelAllBanks => '(toutes les banques)';
	@override String get channelForBankPrefix => '(uniquement les offres pour ';
	@override String get channelForBankSuffix => ')';
	@override String get scopeAllBanks => 'Toutes les banques';
	@override String scopeBankOnly({required Object bank}) => '${bank} uniquement';
}

// Path: home.statistics
class _Translations$home$statistics$fr extends Translations$home$statistics$en {
	_Translations$home$statistics$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offres terminées';
	@override String lifetimeCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Total : ${count} transactions\nAttente moyenne du ${code} : ${avgBlikTime}\nDurée moyenne de finalisation : ${avgPaidTime}';
	@override String last7DaysCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => '7 derniers jours : ${count} transactions\nAttente moyenne du ${code} : ${avgBlikTime}\nDurée moyenne de finalisation : ${avgPaidTime}';
	@override String last7DaysSingleLine({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => '7 derniers jours : ${count} offres  |  Réservation moy. : ${avgReservationTime}  |  Paiement moy. : ${avgPaidTime}';
	@override late final _Translations$home$statistics$errors$fr errors = _Translations$home$statistics$errors$fr._(_root);
}

// Path: generateNewKey.buttons
class _Translations$generateNewKey$buttons$fr extends Translations$generateNewKey$buttons$en {
	_Translations$generateNewKey$buttons$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Générer';
}

// Path: generateNewKey.errors
class _Translations$generateNewKey$errors$fr extends Translations$generateNewKey$errors$en {
	_Translations$generateNewKey$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get activeOffer => 'Vous ne pouvez pas générer un nouveau Neko tant que vous avez une offre active.';
	@override String get failed => 'Impossible de générer un nouveau Neko';
}

// Path: generateNewKey.feedback
class _Translations$generateNewKey$feedback$fr extends Translations$generateNewKey$feedback$en {
	_Translations$generateNewKey$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get success => 'Nouveau Neko généré avec succès !';
}

// Path: generateNewKey.tooltips
class _Translations$generateNewKey$tooltips$fr extends Translations$generateNewKey$tooltips$en {
	_Translations$generateNewKey$tooltips$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Générer un nouveau Neko';
}

// Path: backup.feedback
class _Translations$backup$feedback$fr extends Translations$backup$feedback$en {
	_Translations$backup$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Clé privée copiée dans le presse-papiers !';
}

// Path: backup.tooltips
class _Translations$backup$tooltips$fr extends Translations$backup$tooltips$en {
	_Translations$backup$tooltips$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get backup => 'Sauvegarder le Neko';
}

// Path: restore.labels
class _Translations$restore$labels$fr extends Translations$restore$labels$en {
	_Translations$restore$labels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get privateKey => 'Clé privée';
}

// Path: restore.buttons
class _Translations$restore$buttons$fr extends Translations$restore$buttons$en {
	_Translations$restore$buttons$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Restaurer';
}

// Path: restore.errors
class _Translations$restore$errors$fr extends Translations$restore$errors$en {
	_Translations$restore$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get invalidKey => 'Doit être une chaîne hexadécimale de 64 caractères.';
	@override String get failed => 'Échec de la restauration';
}

// Path: restore.feedback
class _Translations$restore$feedback$fr extends Translations$restore$feedback$en {
	_Translations$restore$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get success => 'Neko restauré avec succès ! L\'application va redémarrer.';
}

// Path: restore.tooltips
class _Translations$restore$tooltips$fr extends Translations$restore$tooltips$en {
	_Translations$restore$tooltips$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Restaurer le Neko';
}

// Path: system.errors
class _Translations$system$errors$fr extends Translations$system$errors$en {
	_Translations$system$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get generic => 'Une erreur inattendue s\'est produite. Veuillez réessayer.';
	@override String get loadingTimeoutConfig => 'Erreur lors du chargement de la configuration des délais.';
	@override String get loadingCoordinatorConfig => 'Erreur lors du chargement de la configuration du coordinateur. Veuillez réessayer.';
	@override String get noPublicKey => 'Votre clé publique n\'est pas disponible. Impossible de continuer.';
	@override String get internalOfferIncomplete => 'Erreur interne : les détails de l\'offre sont incomplets. Veuillez réessayer.';
	@override String get loadingPublicKey => 'Erreur lors du chargement de votre clé publique. Veuillez redémarrer l\'application.';
}

// Path: system.blik
class _Translations$system$blik$fr extends Translations$system$blik$en {
	_Translations$system$blik$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String copied({required Object code}) => 'Code ${code} copié dans le presse-papiers';
}

// Path: myOffers.filter
class _Translations$myOffers$filter$fr extends Translations$myOffers$filter$en {
	_Translations$myOffers$filter$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get all => 'Toutes';
	@override String get active => 'Actives';
	@override String get completed => 'Terminées';
	@override String get failed => 'Échouées';
}

// Path: myOffers.details
class _Translations$myOffers$details$fr extends Translations$myOffers$details$en {
	_Translations$myOffers$details$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails de l\'offre';
	@override String get notFound => 'Offre introuvable.';
	@override String get amount => 'Montant';
	@override String get fees => 'Frais';
	@override String get sats => 'Satoshis';
	@override String get maker => 'Maker';
	@override String get taker => 'Taker';
	@override String get yourFee => 'Vos frais';
	@override String get makerFee => 'Frais maker';
	@override String get takerFee => 'Frais taker';
	@override String get coordinator => 'Coordinateur';
	@override String get createdAt => 'Créée';
	@override String get reservedAt => 'Réservée';
	@override String blikReceivedAt({required Object code}) => '${code} envoyé';
	@override String get makerConfirmedAt => 'Confirmée';
	@override String get settledAt => 'Réglée';
	@override String get takerPaidAt => 'Taker payé';
	@override String get id => 'ID de l\'offre';
	@override String get paymentHash => 'Hash de paiement';
	@override String get holdInvoice => 'Facture hold';
	@override String get continueActiveOffer => 'Reprendre l\'offre active';
	@override String after({required Object duration}) => 'après ${duration}';
}

// Path: landing.actions
class _Translations$landing$actions$fr extends Translations$landing$actions$en {
	_Translations$landing$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String payBlik({required Object code}) => 'Payer en ${code}';
	@override String get payBlikSubtitle => 'avec du bitcoin';
	@override String get sellBlik => 'Acheter du bitcoin';
	@override String sellBlikSubtitle({required Object code}) => 'avec ${code}';
	@override String get howItWorks => 'Comment ça marche ?';
}

// Path: settings.offerCreation
class _Translations$settings$offerCreation$fr extends Translations$settings$offerCreation$en {
	_Translations$settings$offerCreation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Création d\'offres';
	@override String get defaultCategory => 'Catégorie par défaut';
	@override String get defaultBank => 'Banque par défaut';
	@override String get defaultBankNone => 'Aucune (choisir par offre)';
	@override String get preferredCoordinator => 'Coordinateur préféré';
	@override String get automaticCoordinator => 'Le plus fiable';
	@override String get automaticCoordinatorDescription => 'Choisit le coordinateur avec le meilleur historique, en combinant vos propres offres terminées et l\'activité globale du réseau.';
	@override String get cheapestCoordinator => 'Le moins cher';
	@override String get cheapestCoordinatorDescription => 'Choisit pour chaque offre le coordinateur disponible avec les frais maker les plus bas.';
	@override String get enablePremium => 'Activer la tarification avec prime';
	@override String get enablePremiumDescription => 'Affiche le curseur de prime lors de la création d\'offres maker.';
	@override String get defaultPremium => 'Prime par défaut';
	@override String get defaultPremiumDisabled => 'Activez la tarification avec prime pour définir une prime par défaut.';
	@override String get premiumPerCoordinatorNote => 'Chaque coordinateur fixe sa propre prime maximale, votre valeur par défaut est donc plafonnée par le coordinateur utilisé pour une offre.';
	@override late final _Translations$settings$offerCreation$categoryOptions$fr categoryOptions = _Translations$settings$offerCreation$categoryOptions$fr._(_root);
	@override late final _Translations$settings$offerCreation$dialogs$fr dialogs = _Translations$settings$offerCreation$dialogs$fr._(_root);
}

// Path: settings.display
class _Translations$settings$display$fr extends Translations$settings$display$en {
	_Translations$settings$display$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Affichage';
	@override String get bitcoinUnit => 'Unité bitcoin';
	@override String get bitcoinUnitDescription => 'Choisissez comment les montants en bitcoin sont affichés dans l\'application.';
	@override late final _Translations$settings$display$unitOptions$fr unitOptions = _Translations$settings$display$unitOptions$fr._(_root);
}

// Path: settings.paymentSystem
class _Translations$settings$paymentSystem$fr extends Translations$settings$paymentSystem$en {
	_Translations$settings$paymentSystem$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pays / Système de paiement';
	@override String get subtitle => 'Choisissez le système de paiement de votre pays.';
	@override String get dialogTitle => 'Sélectionner le système de paiement';
	@override late final _Translations$settings$paymentSystem$countries$fr countries = _Translations$settings$paymentSystem$countries$fr._(_root);
}

// Path: notificationSettings.newOfferAlerts
class _Translations$notificationSettings$newOfferAlerts$fr extends Translations$notificationSettings$newOfferAlerts$en {
	_Translations$notificationSettings$newOfferAlerts$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Alertes de nouvelles offres';
	@override String description({required Object app}) => 'Lorsque cette option est activée, ${app} vous notifie des nouvelles offres disponibles auprès de vos coordinateurs activés pendant que l\'application est en arrière-plan. Cela peut être plus rapide que les messageries externes.';
}

// Path: wallet.missingReceiving
class _Translations$wallet$missingReceiving$fr extends Translations$wallet$missingReceiving$en {
	_Translations$wallet$missingReceiving$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portefeuille de réception requis';
	@override String get message => 'Aucun portefeuille configuré pour la réception. Ajoutez-en un dans les réglages du portefeuille pour accepter des offres.';
	@override String get openSettings => 'Réglages du portefeuille';
}

// Path: wallet.details
class _Translations$wallet$details$fr extends Translations$wallet$details$en {
	_Translations$wallet$details$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails du portefeuille';
	@override String get pendingTitle => 'Transactions en attente';
	@override String get finishedTitle => 'Transactions terminées';
}

// Path: nwc.labels
class _Translations$nwc$labels$fr extends Translations$nwc$labels$en {
	_Translations$nwc$labels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get connectionString => 'Chaîne de connexion NWC';
	@override String get hint => 'nostr+walletconnect://...';
	@override String get status => 'État de la connexion';
	@override String get connected => 'Connecté';
	@override String get disconnected => 'Déconnecté';
	@override String get scanQrCode => 'Scannez le QR code avec votre connexion NWC';
	@override String get balance => 'Solde';
	@override String get budget => 'Budget';
	@override String get usedBudget => 'Utilisé';
	@override String get totalBudget => 'Total';
	@override String get renewsIn => 'Renouvellement dans';
	@override String get renewalPeriod => 'Période de renouvellement';
	@override String get relay => 'Relais';
	@override String get relays => 'Relais';
}

// Path: nwc.prompts
class _Translations$nwc$prompts$fr extends Translations$nwc$prompts$en {
	_Translations$nwc$prompts$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Saisissez votre chaîne de connexion NWC';
	@override String get connect => 'Connecter le portefeuille';
	@override String get disconnect => 'Déconnecter';
	@override String get confirmDisconnect => 'Voulez-vous vraiment déconnecter votre portefeuille NWC ?';
	@override String get pasteConnection => 'Coller la chaîne de connexion';
	@override String get chooseMethod => 'Choisissez comment connecter votre portefeuille Lightning';
	@override String get howToGet => 'Vous n\'avez pas encore de connexion NWC ? Découvrez comment en obtenir une !';
	@override String get learnMore => 'En savoir plus sur NWC';
}

// Path: nwc.actions
class _Translations$nwc$actions$fr extends Translations$nwc$actions$en {
	_Translations$nwc$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get connectAlbyGo => 'Connecter avec Alby Go';
	@override String get connectNwc => 'Scanner le QR code NWC';
}

// Path: nwc.feedback
class _Translations$nwc$feedback$fr extends Translations$nwc$feedback$en {
	_Translations$nwc$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Portefeuille NWC connecté avec succès !';
	@override String get disconnected => 'Portefeuille NWC déconnecté';
	@override String get connecting => 'Connexion au portefeuille NWC...';
	@override String get loadingWalletInfo => 'Chargement des informations du portefeuille...';
}

// Path: nwc.errors
class _Translations$nwc$errors$fr extends Translations$nwc$errors$en {
	_Translations$nwc$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String connecting({required Object details}) => 'Erreur de connexion à NWC : ${details}';
	@override String disconnecting({required Object details}) => 'Erreur de déconnexion de NWC : ${details}';
	@override String get invalid => 'Chaîne de connexion NWC invalide';
	@override String get required => 'La chaîne de connexion NWC est requise';
	@override String get loadingBalance => 'Impossible de charger le solde du portefeuille';
	@override String get loadingBudget => 'Impossible de charger le budget du portefeuille';
}

// Path: nwc.time
class _Translations$nwc$time$fr extends Translations$nwc$time$en {
	_Translations$nwc$time$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String minutes({required Object count}) => '${count} min';
	@override String hours({required Object count}) => '${count} h';
	@override String days({required Object count}) => '${count} j';
	@override String get justNow => 'à l\'instant';
}

// Path: relays.status
class _Translations$relays$status$fr extends Translations$relays$status$en {
	_Translations$relays$status$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Connecté';
	@override String get connecting => 'Connexion';
	@override String get reconnecting => 'Reconnexion';
	@override String get disconnected => 'Déconnecté';
}

// Path: relays.popup
class _Translations$relays$popup$fr extends Translations$relays$popup$en {
	_Translations$relays$popup$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object connected, required Object total}) => 'Relais (${connected}/${total} connectés)';
	@override String get connectingMessage => 'Connexion aux relais...';
}

// Path: offerNotifications.activeService
class _Translations$offerNotifications$activeService$fr extends Translations$offerNotifications$activeService$en {
	_Translations$offerNotifications$activeService$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'En attente de nouvelles offres';
	@override String body({required Object app}) => 'Service Nostr surveillant les événements des offres ${app}.';
}

// Path: offerNotifications.funded
class _Translations$offerNotifications$funded$fr extends Translations$offerNotifications$funded$en {
	_Translations$offerNotifications$funded$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offre financée';
	@override String get body => 'Votre facture hold a été acceptée. L\'offre est maintenant en ligne.';
}

// Path: offerNotifications.reserved
class _Translations$offerNotifications$reserved$fr extends Translations$offerNotifications$reserved$en {
	_Translations$offerNotifications$reserved$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offre réservée';
	@override String get body => 'Un taker a réservé votre offre.';
}

// Path: offerNotifications.blikReady
class _Translations$offerNotifications$blikReady$fr extends Translations$offerNotifications$blikReady$en {
	_Translations$offerNotifications$blikReady$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Code ${code} prêt';
	@override String body({required Object code}) => 'Votre code ${code} est prêt à être consulté.';
}

// Path: offerNotifications.newOffer
class _Translations$offerNotifications$newOffer$fr extends Translations$offerNotifications$newOffer$en {
	_Translations$offerNotifications$newOffer$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nouvelle offre disponible';
	@override String body({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}';
	@override String premiumSuffix({required Object percent}) => '+${percent}% de prime';
}

// Path: offerNotifications.categories
class _Translations$offerNotifications$categories$fr extends Translations$offerNotifications$categories$en {
	_Translations$offerNotifications$categories$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Magasin';
	@override String get atm => 'Distributeur';
	@override String get online => 'En ligne';
}

// Path: offerNotifications.blikPendingReminder
class _Translations$offerNotifications$blikPendingReminder$fr extends Translations$offerNotifications$blikPendingReminder$en {
	_Translations$offerNotifications$blikPendingReminder$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Le ${code} attend votre action';
	@override String body({required Object code}) => 'Confirmez le paiement ou marquez le code ${code} comme invalide.';
}

// Path: offerNotifications.takerCharged
class _Translations$offerNotifications$takerCharged$fr extends Translations$offerNotifications$takerCharged$en {
	_Translations$offerNotifications$takerCharged$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} débité';
	@override String body({required Object code}) => 'Le taker signale que le ${code} a été débité. Confirmez ou marquez comme invalide.';
}

// Path: offerNotifications.invalidBlik
class _Translations$offerNotifications$invalidBlik$fr extends Translations$offerNotifications$invalidBlik$en {
	_Translations$offerNotifications$invalidBlik$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} marqué invalide';
	@override String body({required Object code}) => 'Le maker a marqué votre code ${code} comme invalide.';
}

// Path: offerNotifications.takerPaid
class _Translations$offerNotifications$takerPaid$fr extends Translations$offerNotifications$takerPaid$en {
	_Translations$offerNotifications$takerPaid$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paiement reçu';
	@override String get body => 'Votre paiement Lightning a été envoyé.';
}

// Path: offers.details.categories
class _Translations$offers$details$categories$fr extends Translations$offers$details$categories$en {
	_Translations$offers$details$categories$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Magasin, café ou restaurant';
	@override String get atmCashout => 'Retrait au distributeur';
	@override String get onlineService => 'Service/produit en ligne';
}

// Path: offers.details.consents
class _Translations$offers$details$consents$fr extends Translations$offers$details$consents$en {
	_Translations$offers$details$consents$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Certains distributeurs ajoutent des frais supplémentaires au montant de l\'offre. En acceptant cette offre, vous acceptez tous les frais bancaires supplémentaires exigés par le distributeur.';
	@override String ecommerce({required Object code}) => 'Pour diverses raisons — article en rupture de stock, correction d\'un trop-perçu ou autres problèmes côté commerçant — le commerçant en ligne peut automatiquement renvoyer de l\'argent vers le compte bancaire lié au ${code} que vous avez généré. Ces fonds arrivent sur votre compte mais ne vous appartiennent pas. Si cela se produit, contactez le coordinateur de bonne foi et organisez la restitution des fonds au maker. En acceptant cette offre, vous acceptez ces conditions et vous engagez sur l\'honneur à agir honnêtement dans de telles situations.';
}

// Path: coordinator.coldStart.phases
class _Translations$coordinator$coldStart$phases$fr extends Translations$coordinator$coldStart$phases$en {
	_Translations$coordinator$coldStart$phases$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get loadingMuteList => 'Chargement des filtres de coordinateurs';
	@override String get discovering => 'Découverte des coordinateurs sur Nostr';
	@override String get loadingProfiles => 'Chargement des profils des coordinateurs';
	@override String get loadingStats => 'Lecture de l\'historique des coordinateurs';
	@override String get checkingHealth => 'Vérification de la disponibilité des coordinateurs';
	@override String get finalizing => 'Activation des coordinateurs par défaut';
	@override String get completed => 'Terminé';
}

// Path: maker.refundInvoice.errors
class _Translations$maker$refundInvoice$errors$fr extends Translations$maker$refundInvoice$errors$en {
	_Translations$maker$refundInvoice$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get backendUnavailable => 'Le service de paiement Lightning est indisponible.';
	@override String get missing => 'Saisissez une facture de remboursement.';
	@override String get invalid => 'Saisissez une facture de remboursement BOLT11 valide.';
	@override String get wrongNetwork => 'La facture de remboursement appartient au mauvais réseau Lightning.';
	@override String get wrongAmount => 'La facture de remboursement doit contenir le montant exact du remboursement.';
	@override String get invalidExpiry => 'La facture de remboursement a une expiration invalide.';
	@override String get futureTimestamp => 'L’horodatage de la facture de remboursement est dans le futur.';
	@override String get expired => 'La facture de remboursement a expiré. Générez-en une nouvelle.';
	@override String get invalidPaymentHash => 'La facture de remboursement ne contient pas de hash de paiement valide.';
	@override String get reusedInvoice => 'Utilisez une nouvelle facture ; la facture de l’offre ne peut pas recevoir le remboursement.';
	@override String get unsupportedNetwork => 'Ce réseau Lightning n’est pas pris en charge.';
	@override String get unknown => 'Vérifiez la facture et réessayez.';
}

// Path: maker.amountForm.progress
class _Translations$maker$amountForm$progress$fr extends Translations$maker$amountForm$progress$en {
	_Translations$maker$amountForm$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Créer l\'offre';
	@override String get step2 => '2. Attendre un taker';
	@override String step3({required Object code}) => '3. Utiliser le ${code}';
}

// Path: maker.amountForm.labels
class _Translations$maker$amountForm$labels$fr extends Translations$maker$amountForm$labels$en {
	_Translations$maker$amountForm$labels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get coordinator => 'Coordinateur';
	@override String get category => 'Catégorie';
	@override String get exchangeRate => 'Taux de change';
	@override String get fee => 'Frais';
	@override String get satoshisToPay => 'Montant à payer';
	@override String get enterAmount => 'Saisir le montant';
	@override String get customAmount => 'Personnalisé';
	@override String get tapToSelect => 'Touchez pour sélectionner';
	@override String get premium => 'Prime';
}

// Path: maker.amountForm.actions
class _Translations$maker$amountForm$actions$fr extends Translations$maker$amountForm$actions$en {
	_Translations$maker$amountForm$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get generateInvoice => 'Générer la facture';
}

// Path: maker.amountForm.bank
class _Translations$maker$amountForm$bank$fr extends Translations$maker$amountForm$bank$en {
	_Translations$maker$amountForm$bank$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Banque';
	@override String get required => 'Veuillez choisir une banque';
	@override String shortValidityWarning({required Object minutes}) => 'Le code de cette banque n\'est valable que ${minutes} min — soyez au distributeur avant de réserver.';
}

// Path: maker.amountForm.twintScan
class _Translations$maker$amountForm$twintScan$fr extends Translations$maker$amountForm$twintScan$en {
	_Translations$maker$amountForm$twintScan$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String cardTitle({required Object code}) => 'Scanner le QR ${code} et le montant';
	@override String get cardBody => 'Pointez la caméra vers l\'écran de paiement. L\'application préremplira le code et, s\'il est visible, le montant.';
	@override String get scanButton => 'Scanner avec la caméra';
	@override String get manualButton => 'Saisir manuellement à la place';
	@override String codeLabel({required Object code}) => 'Code ${code}';
	@override String get rescan => 'Scanner à nouveau';
	@override String helperFilled({required Object code}) => 'Le taker verra ce code et le saisira dans ${code}.';
	@override String helperEmpty({required Object digits}) => 'Scannez pour remplir ceci automatiquement, ou saisissez manuellement le code à ${digits} chiffres.';
}

// Path: maker.amountForm.tooltips
class _Translations$maker$amountForm$tooltips$fr extends Translations$maker$amountForm$tooltips$en {
	_Translations$maker$amountForm$tooltips$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String feeInfo({required Object feePercent}) => 'Le coordinateur facture des frais maker de ${feePercent}%. Ces frais sont déduits de votre paiement Lightning.';
	@override String get payInfo => 'Ce calcul est basé sur des taux de change récupérés côté client. Le coordinateur calculera le montant exact, et le montant de la facture sera le montant final et exact à payer.';
	@override String get premiumInfo => 'Une prime facultative vous permet de vendre vos sats au-dessus du prix du marché. La prime réduit les sats verrouillés dans votre facture hold pour le même montant fiat : le taker paie donc au-dessus du marché et vous gardez la différence. Désactivée par défaut (0%). La prime maximale est fixée par le coordinateur sélectionné.';
}

// Path: maker.amountForm.category
class _Translations$maker$amountForm$category$fr extends Translations$maker$amountForm$category$en {
	_Translations$maker$amountForm$category$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Catégorie de l\'offre';
	@override String unsupportedForSystem({required Object system}) => '${system} ne prend pas en charge cette catégorie.';
	@override late final _Translations$maker$amountForm$category$options$fr options = _Translations$maker$amountForm$category$options$fr._(_root);
	@override late final _Translations$maker$amountForm$category$shortLabels$fr shortLabels = _Translations$maker$amountForm$category$shortLabels$fr._(_root);
	@override String get atmHint => 'Les takers verront que cette offre concerne un retrait au distributeur et pourront l\'éviter si leur banque facture des frais de distributeur supplémentaires.';
	@override String physicalShopHint({required Object app, required Object code}) => 'L\'endroit idéal pour utiliser ${app} est une caisse en libre-service — car attendre qu\'un taker réserve, génère et confirme un code ${code} peut prendre quelques minutes. Fonctionne très bien dans les magasins, cafés et restaurants. Si vous êtes assez courageux pour faire patienter un caissier ordinaire (et les personnes dans la file derrière vous) pendant ces quelques minutes, tant mieux pour vous.';
	@override String get ecommerceWarningTitle => 'Risque de remboursement par le commerçant en ligne';
	@override String ecommerceWarningBody({required Object code}) => 'Pour diverses raisons — article en rupture de stock, correction d\'un trop-perçu ou autres problèmes côté commerçant — le commerçant en ligne peut automatiquement émettre un remboursement vers le compte bancaire lié au ${code}, c\'est-à-dire le compte du taker. Le coordinateur ne peut pas forcer le taker à vous restituer ces fonds.';
	@override String get ecommerceConfirmation => 'Je comprends le risque de remboursement et j\'ajouterai une note à la commande demandant au commerçant de rembourser un autre compte si un remboursement devient nécessaire.';
	@override String get whyThisIsNeeded => 'pourquoi est-ce nécessaire ?';
}

// Path: maker.amountForm.onboarding
class _Translations$maker$amountForm$onboarding$fr extends Translations$maker$amountForm$onboarding$en {
	_Translations$maker$amountForm$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get titlePrefix => 'Nouveau';
	@override String get title => 'Choisissez la catégorie de l\'offre';
	@override String get body => 'Choisissez la catégorie qui correspond le mieux à ce que vous payez avant de générer la facture.';
	@override String get showWhy => 'Pourquoi est-ce important ?';
	@override String get hideWhy => 'Masquer les détails';
	@override String get whyTitle => 'Choisir la bonne catégorie aide les takers à décider en toute sécurité';
	@override String get whyBody => 'Des situations différentes impliquent des attentes et des risques différents. Les retraits au distributeur peuvent inclure des frais bancaires supplémentaires, et les achats en ligne peuvent comporter des cas particuliers de remboursement. Indiquer la bonne catégorie donne aux takers le contexte dont ils ont besoin avant d\'accepter votre offre.';
	@override String get cta => 'Compris';
}

// Path: maker.amountForm.errors
class _Translations$maker$amountForm$errors$fr extends Translations$maker$amountForm$errors$en {
	_Translations$maker$amountForm$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String initiating({required Object details}) => 'Erreur lors de la création de l\'offre : ${details}';
	@override String get publicKeyNotLoaded => 'Erreur : clé publique pas encore chargée.';
	@override String get noCoordinatorMatchesAmount => 'Aucun coordinateur ne prend en charge ce montant. Essayez une autre valeur.';
	@override String get categoryRequired => 'Sélectionnez une catégorie d\'offre.';
	@override String get ecommerceConfirmationRequired => 'Confirmez le risque de remboursement du commerçant en ligne avant de continuer.';
}

// Path: maker.payInvoice.actions
class _Translations$maker$payInvoice$actions$fr extends Translations$maker$payInvoice$actions$en {
	_Translations$maker$payInvoice$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get copy => 'Copier la facture';
	@override String get payInWallet => 'Ouvrir dans un portefeuille externe';
	@override String get connectWallet => 'Connecter un portefeuille';
	@override String get payWithNwc => 'Payer';
	@override String get paying => 'Paiement en cours...';
}

// Path: maker.payInvoice.feedback
class _Translations$maker$payInvoice$feedback$fr extends Translations$maker$payInvoice$feedback$en {
	_Translations$maker$payInvoice$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Facture copiée dans le presse-papiers !';
	@override String get waitingConfirmation => 'En attente de la confirmation du paiement...';
	@override String get nwcConnected => 'Portefeuille NWC connecté !';
	@override String get nwcPaymentSuccess => 'Paiement réussi !';
}

// Path: maker.payInvoice.errors
class _Translations$maker$payInvoice$errors$fr extends Translations$maker$payInvoice$errors$en {
	_Translations$maker$payInvoice$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get couldNotOpenApp => 'Impossible d\'ouvrir l\'application Lightning pour la facture.';
	@override String openingApp({required Object details}) => 'Erreur lors de l\'ouverture de l\'application Lightning : ${details}';
	@override String get publicKeyNotAvailable => 'La clé publique n\'est pas disponible.';
	@override String get couldNotFetchActive => 'Impossible de récupérer les détails de l\'offre active. Elle a peut-être expiré.';
	@override String nwcPaymentFailed({required Object details}) => 'Paiement échoué : ${details}';
	@override String get nwcNotConnected => 'Portefeuille NWC non connecté';
	@override String insufficientBalance({required Object required, required Object available}) => 'Solde insuffisant. ${required} sats nécessaires, ${available} sats disponibles';
	@override String get cancelOfferAlreadyFunded => 'Le coordinateur indique que cette offre est déjà financée. Elle ne peut plus être annulée.';
	@override String cancelFailed({required Object details}) => 'Impossible d\'annuler l\'offre : ${details}';
}

// Path: maker.payInvoice.budgetWarning
class _Translations$maker$payInvoice$budgetWarning$fr extends Translations$maker$payInvoice$budgetWarning$en {
	_Translations$maker$payInvoice$budgetWarning$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Le paiement peut échouer';
	@override String balanceTooLow({required Object name}) => 'Votre portefeuille de dépense par défaut ${name} n\'a pas un solde suffisant pour ce paiement.';
	@override String budgetTooLow({required Object name}) => 'Votre portefeuille de dépense par défaut ${name} n\'a pas un budget de dépense suffisant pour ce paiement.';
	@override String balanceLine({required Object available}) => 'Solde : ${available}';
	@override String budgetLine({required Object remaining}) => 'Budget NWC restant : ${remaining}';
	@override String requiredLine({required Object required}) => 'Nécessaire : ${required}';
	@override String addFundsHint({required Object name}) => 'Ajoutez des fonds à ${name} pour couvrir ce montant.';
	@override String get increaseBudgetHint => 'Augmentez le budget de dépense NWC de cette connexion dans votre application de portefeuille.';
	@override String get switchWalletLabel => 'Ou utilisez un autre portefeuille :';
	@override String get walletLowFundsTag => 'Peut échouer';
	@override String get payAnyway => 'Essayer quand même';
	@override String get cancel => 'Annuler';
	@override String get readyTitle => 'Payer la facture';
}

// Path: maker.confirmPayment.actions
class _Translations$maker$confirmPayment$actions$fr extends Translations$maker$confirmPayment$actions$en {
	_Translations$maker$confirmPayment$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Confirmer le paiement réussi';
	@override String markInvalid({required Object code}) => 'Code ${code} invalide';
	@override String copyBlik({required Object code}) => 'Copier le ${code}';
}

// Path: maker.confirmPayment.confirmDialog
class _Translations$maker$confirmPayment$confirmDialog$fr extends Translations$maker$confirmPayment$confirmDialog$en {
	_Translations$maker$confirmPayment$confirmDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmer le paiement ?';
	@override String content({required Object code}) => 'Cette action est irréversible. Après confirmation :\n\n• Le taker recevra les fonds immédiatement\n• Le coordinateur ne pourra pas contester les fonds\n• Vous ne pourrez pas annuler cette action\n\nNe confirmez que si le paiement ${code} a réussi.';
	@override String get cancel => 'Annuler';
	@override String get confirmButton => 'Oui, confirmer le paiement';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _Translations$maker$confirmPayment$invalidBlikDisputeDialog$fr extends Translations$maker$confirmPayment$invalidBlikDisputeDialog$en {
	_Translations$maker$confirmPayment$invalidBlikDisputeDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ouvrir un litige ?';
	@override String content({required Object code}) => 'Le taker a signalé que le paiement ${code} a été débité de son compte.\n\nLe marquer comme invalide ouvrira immédiatement un LITIGE nécessitant l\'intervention du coordinateur.\n\n• Des frais de litige peuvent être facturés si la décision est en votre défaveur\n• La facture hold sera réglée immédiatement\n• Une vérification manuelle sera nécessaire\n\nNe continuez que si vous êtes certain que le paiement ${code} n\'a PAS réussi.';
	@override String get cancel => 'Annuler';
	@override String get confirmButton => 'Oui, ouvrir un litige';
}

// Path: maker.confirmPayment.feedback
class _Translations$maker$confirmPayment$feedback$fr extends Translations$maker$confirmPayment$feedback$en {
	_Translations$maker$confirmPayment$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Le maker a confirmé le paiement.';
	@override String get confirmedTakerPaid => 'Paiement confirmé ! Le taker recevra les fonds.';
	@override String progressLabel({required Object seconds}) => 'Confirmation : ${seconds} s restantes';
}

// Path: maker.confirmPayment.errors
class _Translations$maker$confirmPayment$errors$fr extends Translations$maker$confirmPayment$errors$en {
	_Translations$maker$confirmPayment$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String failedToRetrieve({required Object code}) => 'Erreur : impossible de récupérer le code ${code}.';
	@override String retrieving({required Object code, required Object details}) => 'Erreur lors de la récupération du code ${code} : ${details}';
	@override String get missingHashOrKey => 'Erreur : hash de paiement ou clé publique manquant.';
	@override String incorrectState({required Object status}) => 'L\'offre n\'est pas dans le bon état pour une confirmation (Statut : ${status})';
	@override String confirming({required Object details}) => 'Erreur lors de la confirmation du paiement : ${details}';
	@override String get invalidState => 'Erreur : état d\'offre invalide reçu.';
	@override String get internalIncomplete => 'Erreur interne : détails de l\'offre incomplets.';
	@override String notAwaitingConfirmation({required Object status}) => 'L\'offre n\'attend plus de confirmation (Statut : ${status}).';
	@override String get unexpectedStatus => 'Statut d\'offre inattendu reçu du serveur.';
}

// Path: maker.conflict.actions
class _Translations$maker$conflict$actions$fr extends Translations$maker$conflict$actions$en {
	_Translations$maker$conflict$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get back => 'Retour à l\'accueil';
	@override String confirmPayment({required Object code}) => 'Mon erreur, confirmer le succès du paiement ${code}';
	@override String openDispute({required Object code}) => 'Le paiement ${code} n\'a PAS réussi, OUVRIR UN LITIGE';
	@override String get submitDispute => 'Soumettre le litige';
}

// Path: maker.conflict.disputeDialog
class _Translations$maker$conflict$disputeDialog$fr extends Translations$maker$conflict$disputeDialog$en {
	_Translations$maker$conflict$disputeDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ouvrir un litige ?';
	@override String get content => 'L\'ouverture d\'un litige nécessite une vérification manuelle par le coordinateur, ce qui prend du temps. Des frais de litige seront déduits si la décision est en votre défaveur. La facture hold sera réglée pour éviter qu\'elle n\'expire. Si le litige est tranché en votre faveur, vous recevrez un remboursement (moins les frais) sur le portefeuille de votre choix.';
	@override String get contentDetailed => 'L\'ouverture d\'un litige nécessitera une intervention manuelle du coordinateur, ce qui prend du temps et entraîne des frais de litige.\n\nLa facture hold sera immédiatement réglée pour éviter qu\'elle n\'expire avant la résolution du litige.\n\nSi le litige est tranché en votre faveur, le montant en satoshi sera remboursé sur le portefeuille de votre choix (moins les frais). Assurez-vous d\'avoir un portefeuille prêt à recevoir.';
	@override late final _Translations$maker$conflict$disputeDialog$actions$fr actions = _Translations$maker$conflict$disputeDialog$actions$fr._(_root);
}

// Path: maker.conflict.feedback
class _Translations$maker$conflict$feedback$fr extends Translations$maker$conflict$feedback$en {
	_Translations$maker$conflict$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get disputeOpenedSuccess => 'Litige ouvert avec succès. Le coordinateur l\'examinera.';
}

// Path: maker.conflict.errors
class _Translations$maker$conflict$errors$fr extends Translations$maker$conflict$errors$en {
	_Translations$maker$conflict$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String openingDispute({required Object error}) => 'Erreur lors de l\'ouverture du litige : ${error}';
}

// Path: maker.conflict.nostrContact
class _Translations$maker$conflict$nostrContact$fr extends Translations$maker$conflict$nostrContact$en {
	_Translations$maker$conflict$nostrContact$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contacter le coordinateur sur Nostr';
	@override String get description => 'Vous pouvez envoyer un message privé au coordinateur pour obtenir de l\'aide sur ce litige.';
	@override String get copyNpub => 'Copier le npub';
	@override String get openProfile => 'Voir le profil';
	@override String get npubCopied => 'npub du coordinateur copié dans le presse-papiers !';
	@override String get yourIdentityDescription => 'Pour envoyer des messages privés, connectez-vous avec votre clé privée Neko (nsec) dans n\'importe quel client Nostr prenant en charge les messages directs.';
	@override String get manageNekoKeys => 'Gérer les clés Neko';
}

// Path: taker.submitBlik.actions
class _Translations$taker$submitBlik$actions$fr extends Translations$taker$submitBlik$actions$en {
	_Translations$taker$submitBlik$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String submit({required Object code}) => 'Envoyer le ${code}';
}

// Path: taker.submitBlik.feedback
class _Translations$taker$submitBlik$feedback$fr extends Translations$taker$submitBlik$feedback$en {
	_Translations$taker$submitBlik$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String pasted({required Object code}) => 'Code ${code} collé.';
}

// Path: taker.submitBlik.validation
class _Translations$taker$submitBlik$validation$fr extends Translations$taker$submitBlik$validation$en {
	_Translations$taker$submitBlik$validation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String invalidFormat({required Object code, required Object digits}) => 'Saisissez un code ${code} valide à ${digits} chiffres.';
}

// Path: taker.submitBlik.errors
class _Translations$taker$submitBlik$errors$fr extends Translations$taker$submitBlik$errors$en {
	_Translations$taker$submitBlik$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String submitting({required Object code, required Object details}) => 'Erreur lors de l\'envoi du code ${code} : ${details}';
	@override String clipboardInvalid({required Object code, required Object digits}) => 'Le presse-papiers ne contient pas de code ${code} valide à ${digits} chiffres.';
	@override String get stateChanged => 'Erreur : l\'état de l\'offre a changé.';
	@override String get stateNotValid => 'Erreur : l\'état de l\'offre n\'est plus valide.';
	@override String fetchedIdMismatch({required Object fetchedId, required Object initialId}) => 'L\'ID de l\'offre active récupérée (${fetchedId}) ne correspond pas à l\'ID initial (${initialId}). Incohérence d\'état ?';
	@override String get paymentHashMissing => 'Hash de paiement de l\'offre manquant après récupération.';
}

// Path: taker.submitBlik.details
class _Translations$taker$submitBlik$details$fr extends Translations$taker$submitBlik$details$en {
	_Translations$taker$submitBlik$details$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String requestedAmount({required Object code}) => 'Montant ${code} demandé';
	@override String get exchangeRate => 'Taux de change';
	@override String get takerFee => 'Frais taker';
	@override String get status => 'Statut';
	@override String get youllReceive => 'Vous recevrez';
}

// Path: taker.criticalCodeDecision.actions
class _Translations$taker$criticalCodeDecision$actions$fr extends Translations$taker$criticalCodeDecision$actions$en {
	_Translations$taker$criticalCodeDecision$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Retourner vérifier ma banque';
	@override String get proceed => 'Je n’ai PAS été débité — continuer';
}

// Path: taker.conflict.actions
class _Translations$taker$conflict$actions$fr extends Translations$taker$conflict$actions$en {
	_Translations$taker$conflict$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get back => 'Retour à l\'accueil';
}

// Path: taker.conflict.feedback
class _Translations$taker$conflict$feedback$fr extends Translations$taker$conflict$feedback$en {
	_Translations$taker$conflict$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get reported => 'Conflit de paiement signalé. En attente de la confirmation du maker.';
}

// Path: taker.conflict.errors
class _Translations$taker$conflict$errors$fr extends Translations$taker$conflict$errors$en {
	_Translations$taker$conflict$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String reporting({required Object details}) => 'Erreur lors du signalement du conflit : ${details}';
}

// Path: twint.scanner.status
class _Translations$twint$scanner$status$fr extends Translations$twint$scanner$status$en {
	_Translations$twint$scanner$status$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String align({required Object code}) => 'Alignez le QR ${code} et le texte du montant dans le cadre de la caméra.';
	@override String notRecognized({required Object code}) => 'Le code ${code} n\'est pas encore reconnu. Gardez le QR et le montant visibles, ou remplissez le formulaire manuellement.';
	@override String get amountFailed => 'Le scan caméra n\'a pas pu extraire le montant. Vous pouvez quand même utiliser le résultat du QR et corriger les champs manuellement.';
}

// Path: twint.flow.progress
class _Translations$twint$flow$progress$fr extends Translations$twint$flow$progress$en {
	_Translations$twint$flow$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Créer l\'offre';
	@override String get step2 => '2. Attendre un taker';
	@override String get step3 => '3. Confirmer';
}

// Path: twint.flow.takerProgress
class _Translations$twint$flow$takerProgress$fr extends Translations$twint$flow$takerProgress$en {
	_Translations$twint$flow$takerProgress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String step1({required Object code}) => '1. Payer ${code}';
	@override String get step2 => '2. Recevoir des sats';
}

// Path: twint.flow.makerWait
class _Translations$twint$flow$makerWait$fr extends Translations$twint$flow$makerWait$en {
	_Translations$twint$flow$makerWait$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get takerPaying => 'Le taker est en train de payer';
	@override String yourCode({required Object code}) => 'Votre code ${code}';
	@override String offerExpires({required Object code}) => 'Le ${code} expire';
	@override String get autoExpires => 'Expire automatiquement';
	@override String codeExpiresIn({required Object code}) => '${code} expirera dans...';
	@override String get cancelOffer => 'Annuler l\'offre';
	@override String reservedInfo({required Object code}) => 'Un taker a réservé votre offre et paie maintenant votre code ${code} dans son application bancaire. Dès que le paiement arrive chez votre commerçant, confirmez-le ci-dessous.';
	@override String get confirmReceived => 'Confirmer le paiement reçu';
	@override late final _Translations$twint$flow$makerWait$confirmDialog$fr confirmDialog = _Translations$twint$flow$makerWait$confirmDialog$fr._(_root);
}

// Path: twint.flow.makerExpired
class _Translations$twint$flow$makerExpired$fr extends Translations$twint$flow$makerExpired$en {
	_Translations$twint$flow$makerExpired$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} probablement expiré';
	@override String warning({required Object code}) => 'Le code ${code} a probablement expiré — mais le taker a peut-être quand même réussi à le payer. Vérifiez chez votre commerçant : vous disposez du temps ci-dessous pour confirmer le paiement.';
	@override String get timerCaption => 'Temps pour confirmer';
	@override String get disputeHint => 'Vous pouvez aussi laisser le minuteur expirer. Si le taker déclare avoir payé, cela devient un conflit/litige où les deux parties devront fournir des preuves au coordinateur pour résoudre le problème.';
}

// Path: twint.flow.makerVerify
class _Translations$twint$flow$makerVerify$fr extends Translations$twint$flow$makerVerify$en {
	_Translations$twint$flow$makerVerify$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Avez-vous reçu le paiement ?';
	@override String body({required Object amount, required Object code}) => 'Le taker indique avoir payé ${amount} sur votre code ${code}.';
	@override String get hint => 'Vérifiez le statut du paiement auprès de votre commerçant (terminal de magasin ou transaction en ligne). En cas de doute, attendez et revérifiez plus tard avant de décider.';
	@override String get autoConfirms => 'Confirme automatiquement';
	@override String get confirmReceived => 'Confirmer la réception';
	@override String get openDispute => 'Ouvrir un litige';
}

// Path: twint.flow.makerRecode
class _Translations$twint$flow$makerRecode$fr extends Translations$twint$flow$makerRecode$en {
	_Translations$twint$flow$makerRecode$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Offre expirée';
	@override String body({required Object code}) => 'Aucun taker n\'a terminé l\'échange. Saisissez un nouveau code ${code} pour republier cette offre, ou annulez-la.';
	@override String scanCardTitle({required Object code}) => 'Scanner le nouveau QR ${code}';
	@override String get scanCardBody => 'Pointez la caméra vers l\'écran de paiement. L\'app préremplira le nouveau code — le montant reste le même.';
	@override String fieldLabel({required Object code}) => 'Nouveau code ${code}';
	@override String get autoCancels => 'Annule automatiquement';
	@override String get relist => 'Republier avec un nouveau code';
	@override String get cancelOffer => 'Annuler l\'offre';
}

// Path: twint.flow.takerPay
class _Translations$twint$flow$takerPay$fr extends Translations$twint$flow$takerPay$en {
	_Translations$twint$flow$takerPay$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Payer avec ${code}';
	@override String body({required Object code, required Object amount}) => 'Ouvrez votre application ${code} et payez ${amount} avec :';
	@override String get codeExpires => 'Le code expire';
	@override String get paid => 'J\'ai payé';
	@override String get cancel => 'Annuler';
}

// Path: twint.flow.takerWait
class _Translations$twint$flow$takerWait$fr extends Translations$twint$flow$takerWait$en {
	_Translations$twint$flow$takerWait$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'En attente du maker';
	@override String body({required Object code}) => 'Le maker vérifie si votre paiement ${code} est arrivé chez son commerçant. Il doit confirmer la réception ou ouvrir un litige.';
	@override String get info => 'Si le maker n\'agit pas avant l\'expiration du minuteur, le paiement se confirme automatiquement et vous recevrez vos sats.';
	@override String get autoConfirms => 'Confirme automatiquement';
}

// Path: twint.flow.takerExpired
class _Translations$twint$flow$takerExpired$fr extends Translations$twint$flow$takerExpired$en {
	_Translations$twint$flow$takerExpired$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} probablement expiré';
	@override String warning({required Object code}) => 'Le code ${code} a probablement expiré. Vous devez maintenant prendre une décision importante — choisissez avec soin.';
	@override String optionPaid({required Object code}) => 'Si vous AVEZ payé le code ${code} dans votre application bancaire, marquez-le comme payé. Cela vous engage : le maker devra confirmer pour débloquer le bitcoin, ou ouvrir un litige où les deux parties fourniront des preuves au coordinateur.';
	@override String get optionCancel => 'Si vous n\'avez PAS payé, annulez la réservation. C\'est irréversible — si le paiement est en fait passé, le coordinateur ne pourra plus garantir vos sats.';
	@override String noDecision({required Object code}) => 'Si vous ne prenez aucune décision avant la fin du minuteur, le coordinateur supposera que vous n\'avez PAS payé le code ${code}. Le maker pourra alors annuler l\'offre — annulant la facture bloquée — après quoi le coordinateur ne pourra plus vous régler les sats, même si vous avez payé.';
	@override String get timerCaption => 'Temps pour décider';
	@override String markPaid({required Object code}) => 'J\'ai payé le code ${code}';
	@override String get cancel => 'Annuler la réservation';
	@override late final _Translations$twint$flow$takerExpired$markPaidDialog$fr markPaidDialog = _Translations$twint$flow$takerExpired$markPaidDialog$fr._(_root);
	@override late final _Translations$twint$flow$takerExpired$cancelDialog$fr cancelDialog = _Translations$twint$flow$takerExpired$cancelDialog$fr._(_root);
}

// Path: twint.waitConfirmation.categoryReminder
class _Translations$twint$waitConfirmation$categoryReminder$fr extends Translations$twint$waitConfirmation$categoryReminder$en {
	_Translations$twint$waitConfirmation$categoryReminder$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Rappel offre distributeur : votre banque peut encore vous demander d\'approuver des frais de distributeur supplémentaires en plus du montant principal.';
	@override String get ecommerce => 'Rappel commande en ligne : si le commerçant envoie un remboursement automatique sur votre compte bancaire, contactez le coordinateur et restituez-le.';
}

// Path: twint.waitConfirmation.takerCharged
class _Translations$twint$waitConfirmation$takerCharged$fr extends Translations$twint$waitConfirmation$takerCharged$en {
	_Translations$twint$waitConfirmation$takerCharged$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Vous avez marqué le ${code} comme débité';
	@override String message({required Object minutes}) => 'Le maker a ${minutes} min pour confirmer ou contester le paiement. S\'il ne fait rien, le paiement sera confirmé automatiquement et vous recevrez les bitcoins.';
}

// Path: twint.waitConfirmation.expiredActions
class _Translations$twint$waitConfirmation$expiredActions$fr extends Translations$twint$waitConfirmation$expiredActions$en {
	_Translations$twint$waitConfirmation$expiredActions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String reportConflict({required Object code}) => 'Le ${code} a été débité de mon compte bancaire';
	@override String renewReservation({required Object code}) => 'Réessayer avec un nouveau code ${code}';
	@override String get cancelReservation => 'Annuler la réservation';
}

// Path: twint.waitConfirmation.feedback
class _Translations$twint$waitConfirmation$feedback$fr extends Translations$twint$waitConfirmation$feedback$en {
	_Translations$twint$waitConfirmation$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmed => 'Le maker a confirmé le paiement.';
	@override String get paymentSuccessful => 'Paiement réussi ! Vous recevrez les fonds sous peu.';
	@override String get conflictReported => 'Conflit signalé. Le coordinateur examinera la situation.';
}

// Path: twint.waitConfirmation.errors
class _Translations$twint$waitConfirmation$errors$fr extends Translations$twint$waitConfirmation$errors$en {
	_Translations$twint$waitConfirmation$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get invalidOfferStateReceived => 'Offre reçue avec un état invalide pour cet écran. Réinitialisation.';
	@override String reportingConflict({required Object details}) => 'Erreur lors du signalement du conflit : ${details}';
}

// Path: twint.paymentProcess.states
class _Translations$twint$paymentProcess$states$fr extends Translations$twint$paymentProcess$states$en {
	_Translations$twint$paymentProcess$states$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get preparing => 'Préparation de l\'envoi du paiement...';
	@override String get sending => 'Envoi du paiement...';
	@override String get received => 'Paiement reçu !';
	@override String get failed => 'Paiement échoué';
	@override String get waitingUpdate => 'En attente de la mise à jour de l\'offre...';
}

// Path: twint.paymentProcess.steps
class _Translations$twint$paymentProcess$steps$fr extends Translations$twint$paymentProcess$steps$en {
	_Translations$twint$paymentProcess$steps$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String makerConfirmedBlik({required Object code}) => 'Le maker a confirmé le paiement ${code}';
	@override String get makerInvoiceSettled => 'Facture hold du maker réglée';
	@override String get takerInvoicePaid => 'Paiement de votre facture Lightning';
	@override String get takerPaymentFailed => 'Le paiement vers votre facture a échoué';
}

// Path: twint.paymentProcess.errors
class _Translations$twint$paymentProcess$errors$fr extends Translations$twint$paymentProcess$errors$en {
	_Translations$twint$paymentProcess$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String sending({required Object details}) => 'Erreur lors de l\'envoi du paiement : ${details}';
	@override String get notConfirmed => 'Offre non confirmée par le maker.';
	@override String get expired => 'Offre expirée.';
	@override String get cancelled => 'Offre annulée.';
	@override String get paymentFailed => 'Le paiement de l\'offre a échoué.';
	@override String get unknown => 'Erreur d\'offre inconnue.';
	@override String get takerPaymentFailed => 'Le paiement vers votre facture Lightning a échoué.';
	@override String get noPublicKey => 'Erreur : impossible de récupérer votre clé publique.';
	@override String get loadingPublicKey => 'Erreur lors du chargement de vos données';
	@override String get missingPaymentHash => 'Erreur : détails de paiement manquants.';
}

// Path: twint.paymentProcess.loading
class _Translations$twint$paymentProcess$loading$fr extends Translations$twint$paymentProcess$loading$en {
	_Translations$twint$paymentProcess$loading$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get publicKey => 'Chargement de vos données...';
}

// Path: twint.paymentProcess.actions
class _Translations$twint$paymentProcess$actions$fr extends Translations$twint$paymentProcess$actions$en {
	_Translations$twint$paymentProcess$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get goToFailureDetails => 'Réessayer avec une nouvelle facture';
}

// Path: twint.paymentFailed.form
class _Translations$twint$paymentFailed$form$fr extends Translations$twint$paymentFailed$form$en {
	_Translations$twint$paymentFailed$form$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get newInvoiceLabel => 'Nouvelle facture Lightning';
	@override String get newInvoiceHint => 'Saisissez votre facture BOLT11';
}

// Path: twint.paymentFailed.actions
class _Translations$twint$paymentFailed$actions$fr extends Translations$twint$paymentFailed$actions$en {
	_Translations$twint$paymentFailed$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get retryPayment => 'Soumettre la nouvelle facture';
}

// Path: twint.paymentFailed.errors
class _Translations$twint$paymentFailed$errors$fr extends Translations$twint$paymentFailed$errors$en {
	_Translations$twint$paymentFailed$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get enterValidInvoice => 'Veuillez saisir une facture valide';
	@override String updatingInvoice({required Object details}) => 'Erreur lors de la mise à jour de la facture : ${details}';
	@override String get paymentRetryFailed => 'Nouvelle tentative de paiement échouée. Veuillez vérifier la facture ou réessayer plus tard.';
	@override String get takerPublicKeyNotFound => 'Clé publique du taker introuvable.';
	@override String generateFailed({required Object details}) => 'Impossible de générer la facture : ${details}';
}

// Path: twint.paymentFailed.walletSection
class _Translations$twint$paymentFailed$walletSection$fr extends Translations$twint$paymentFailed$walletSection$en {
	_Translations$twint$paymentFailed$walletSection$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Générer une facture depuis le portefeuille';
	@override String get defaultLabel => 'par défaut';
	@override String tapToGenerate({required Object amountSats}) => 'Touchez pour générer une facture de ${amountSats}';
}

// Path: twint.paymentFailed.loading
class _Translations$twint$paymentFailed$loading$fr extends Translations$twint$paymentFailed$loading$en {
	_Translations$twint$paymentFailed$loading$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get processingPayment => 'Traitement de votre nouvelle tentative de paiement...';
}

// Path: twint.paymentFailed.success
class _Translations$twint$paymentFailed$success$fr extends Translations$twint$paymentFailed$success$en {
	_Translations$twint$paymentFailed$success$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paiement réussi';
	@override String get message => 'Votre paiement a été traité avec succès.';
}

// Path: twint.paymentSuccess.actions
class _Translations$twint$paymentSuccess$actions$fr extends Translations$twint$paymentSuccess$actions$en {
	_Translations$twint$paymentSuccess$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get goHome => 'Aller à l\'accueil';
}

// Path: twint.invalidBlik.actions
class _Translations$twint$invalidBlik$actions$fr extends Translations$twint$invalidBlik$actions$en {
	_Translations$twint$invalidBlik$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String retry({required Object code}) => 'Envoyer un nouveau code ${code}';
	@override String get cancelReservation => 'Annuler la transaction';
	@override String get reportConflict => 'Ouvrir un litige';
	@override String get returnHome => 'Retour à l\'accueil';
}

// Path: twint.invalidBlik.confirmDialog
class _Translations$twint$invalidBlik$confirmDialog$fr extends Translations$twint$invalidBlik$confirmDialog$en {
	_Translations$twint$invalidBlik$confirmDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Êtes-vous sûr ?';
	@override String get content => 'Une fois que vous aurez appuyé, il n\'y aura pas de retour en arrière.\n\nSi le montant a BEL ET BIEN été débité de votre compte bancaire, le coordinateur ne pourra PAS garantir que vous recevrez les bitcoins, et vous pourriez perdre vos fonds.\n\nEn cas de doute, mieux vaut attendre un peu et vérifier que vous n\'avez PAS été débité avant de continuer.';
	@override late final _Translations$twint$invalidBlik$confirmDialog$actions$fr actions = _Translations$twint$invalidBlik$confirmDialog$actions$fr._(_root);
}

// Path: twint.invalidBlik.disputeConfirmDialog
class _Translations$twint$invalidBlik$disputeConfirmDialog$fr extends Translations$twint$invalidBlik$disputeConfirmDialog$en {
	_Translations$twint$invalidBlik$disputeConfirmDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ouvrir un litige ?';
	@override String get content => 'N\'ouvrez un litige que si le montant a BEL ET BIEN été débité de votre compte bancaire.\n\nLe coordinateur examinera votre cas manuellement, ce qui prend du temps. Vous devrez fournir une preuve de paiement.';
	@override late final _Translations$twint$invalidBlik$disputeConfirmDialog$actions$fr actions = _Translations$twint$invalidBlik$disputeConfirmDialog$actions$fr._(_root);
}

// Path: twint.invalidBlik.feedback
class _Translations$twint$invalidBlik$feedback$fr extends Translations$twint$invalidBlik$feedback$en {
	_Translations$twint$invalidBlik$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get conflictReportedSuccess => 'Conflit signalé. Le coordinateur l\'examinera.';
}

// Path: twint.invalidBlik.errors
class _Translations$twint$invalidBlik$errors$fr extends Translations$twint$invalidBlik$errors$en {
	_Translations$twint$invalidBlik$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get reservationFailed => 'Échec de la nouvelle réservation de l\'offre';
	@override String conflictReport({required Object details}) => 'Erreur lors du signalement du conflit : ${details}';
}

// Path: twint.conflict.actions
class _Translations$twint$conflict$actions$fr extends Translations$twint$conflict$actions$en {
	_Translations$twint$conflict$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get back => 'Retour à l\'accueil';
}

// Path: twint.conflict.feedback
class _Translations$twint$conflict$feedback$fr extends Translations$twint$conflict$feedback$en {
	_Translations$twint$conflict$feedback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get reported => 'Conflit signalé. Le coordinateur l\'examinera.';
}

// Path: twint.conflict.errors
class _Translations$twint$conflict$errors$fr extends Translations$twint$conflict$errors$en {
	_Translations$twint$conflict$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String reporting({required Object details}) => 'Erreur lors du signalement du conflit : ${details}';
}

// Path: twint.conflict.nostrContact
class _Translations$twint$conflict$nostrContact$fr extends Translations$twint$conflict$nostrContact$en {
	_Translations$twint$conflict$nostrContact$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contacter le coordinateur sur Nostr';
	@override String get description => 'Vous pouvez envoyer un message privé au coordinateur pour obtenir de l\'aide sur ce litige.';
	@override String get copyNpub => 'Copier le npub';
	@override String get openProfile => 'Voir le profil';
	@override String get npubCopied => 'npub du coordinateur copié dans le presse-papiers !';
	@override String get yourIdentityDescription => 'Pour envoyer des messages privés, connectez-vous avec votre clé privée Neko (nsec) dans n\'importe quel client Nostr prenant en charge les messages directs.';
	@override String get manageNekoKeys => 'Gérer les clés Neko';
}

// Path: home.statistics.errors
class _Translations$home$statistics$errors$fr extends Translations$home$statistics$errors$en {
	_Translations$home$statistics$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String loading({required Object error}) => 'Erreur lors du chargement des statistiques : ${error}';
}

// Path: settings.offerCreation.categoryOptions
class _Translations$settings$offerCreation$categoryOptions$fr extends Translations$settings$offerCreation$categoryOptions$en {
	_Translations$settings$offerCreation$categoryOptions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Magasin, café ou restaurant';
	@override String get atm => 'Retrait au distributeur';
	@override String get online => 'Service/produit en ligne';
}

// Path: settings.offerCreation.dialogs
class _Translations$settings$offerCreation$dialogs$fr extends Translations$settings$offerCreation$dialogs$en {
	_Translations$settings$offerCreation$dialogs$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get selectCategory => 'Sélectionner la catégorie par défaut';
	@override String get selectBank => 'Sélectionner la banque par défaut';
	@override String get selectCoordinator => 'Sélectionner le coordinateur préféré';
	@override String get premiumHint => 'Saisissez un pourcentage comme 1.5. Les valeurs sont arrondies par pas de 0.5%.';
	@override String get premiumHelper => 'Appliquée lorsque la tarification avec prime est activée et plafonnée par le maximum du coordinateur sélectionné.';
}

// Path: settings.display.unitOptions
class _Translations$settings$display$unitOptions$fr extends Translations$settings$display$unitOptions$en {
	_Translations$settings$display$unitOptions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sats => 'sats';
	@override String get bitcoin => '₿ (BIP-177)';
}

// Path: settings.paymentSystem.countries
class _Translations$settings$paymentSystem$countries$fr extends Translations$settings$paymentSystem$countries$en {
	_Translations$settings$paymentSystem$countries$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get PL => 'Pologne';
	@override String get PT => 'Portugal';
	@override String get CH => 'Suisse';
	@override String get SK => 'Slovaquie';
}

// Path: maker.amountForm.category.options
class _Translations$maker$amountForm$category$options$fr extends Translations$maker$amountForm$category$options$en {
	_Translations$maker$amountForm$category$options$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Magasin, café ou restaurant';
	@override String get atmCashout => 'Retrait au distributeur';
	@override String get onlineService => 'Service/produit en ligne';
}

// Path: maker.amountForm.category.shortLabels
class _Translations$maker$amountForm$category$shortLabels$fr extends Translations$maker$amountForm$category$shortLabels$en {
	_Translations$maker$amountForm$category$shortLabels$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Magasin';
	@override String get atm => 'Distributeur';
	@override String get online => 'En ligne';
}

// Path: maker.conflict.disputeDialog.actions
class _Translations$maker$conflict$disputeDialog$actions$fr extends Translations$maker$conflict$disputeDialog$actions$en {
	_Translations$maker$conflict$disputeDialog$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Ouvrir un litige';
	@override String get cancel => 'Annuler';
}

// Path: twint.flow.makerWait.confirmDialog
class _Translations$twint$flow$makerWait$confirmDialog$fr extends Translations$twint$flow$makerWait$confirmDialog$en {
	_Translations$twint$flow$makerWait$confirmDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmer le paiement reçu ?';
	@override String content({required Object code}) => 'Ne confirmez que si vous êtes ABSOLUMENT sûr que le paiement ${code} a bien été reçu chez votre commerçant.\n\nLa confirmation règle la facture Lightning et envoie immédiatement les sats au taker — c\'est irréversible.';
	@override String get cancel => 'Annuler';
	@override String get confirmButton => 'Oui, paiement reçu';
}

// Path: twint.flow.takerExpired.markPaidDialog
class _Translations$twint$flow$takerExpired$markPaidDialog$fr extends Translations$twint$flow$takerExpired$markPaidDialog$en {
	_Translations$twint$flow$takerExpired$markPaidDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmer le paiement ?';
	@override String content({required Object code}) => 'Ne continuez que si vous êtes sûr que le paiement ${code} a été débité dans votre application bancaire.\n\nLe maker devra confirmer la réception pour débloquer le bitcoin. S\'il la conteste, un litige est ouvert et les deux parties devront fournir des preuves au coordinateur.';
	@override String get cancel => 'Retour';
	@override String get confirmButton => 'Oui, j\'ai payé';
}

// Path: twint.flow.takerExpired.cancelDialog
class _Translations$twint$flow$takerExpired$cancelDialog$fr extends Translations$twint$flow$takerExpired$cancelDialog$en {
	_Translations$twint$flow$takerExpired$cancelDialog$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Annuler la réservation ?';
	@override String content({required Object code}) => 'N\'annulez que si vous n\'avez PAS payé le code ${code}.\n\nC\'est définitif : si le paiement est en fait passé, le coordinateur ne pourra PAS garantir que vous recevrez les sats.';
	@override String get cancel => 'Retour';
	@override String get confirmButton => 'Oui, annuler';
}

// Path: twint.invalidBlik.confirmDialog.actions
class _Translations$twint$invalidBlik$confirmDialog$actions$fr extends Translations$twint$invalidBlik$confirmDialog$actions$en {
	_Translations$twint$invalidBlik$confirmDialog$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Je suis sûr, continuer';
	@override String get cancel => 'Annuler';
}

// Path: twint.invalidBlik.disputeConfirmDialog.actions
class _Translations$twint$invalidBlik$disputeConfirmDialog$actions$fr extends Translations$twint$invalidBlik$disputeConfirmDialog$actions$en {
	_Translations$twint$invalidBlik$disputeConfirmDialog$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Oui, j\'ai été débité';
	@override String get cancel => 'Annuler';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => ({required Object app}) => '${app}',
			'app.greeting' => 'Bonjour !',
			'app.changelog' => 'Journal des modifications',
			'common.buttons.cancel' => 'Annuler',
			'common.buttons.save' => 'Enregistrer',
			'common.buttons.done' => 'Terminé',
			'common.buttons.retry' => 'Réessayer',
			'common.buttons.goHome' => 'Accueil',
			'common.buttons.saveAndContinue' => 'Enregistrer et continuer',
			'common.buttons.reveal' => 'Afficher',
			'common.buttons.hide' => 'Masquer',
			'common.buttons.copy' => 'Copier',
			'common.buttons.close' => 'Fermer',
			'common.buttons.restore' => 'Restaurer',
			'common.buttons.faq' => 'FAQ',
			'common.labels.amount' => ({required Object currency}) => 'Montant (${currency})',
			'common.labels.status' => ({required Object status}) => 'Statut : ${status}',
			'common.labels.role' => ({required Object role}) => 'Rôle : ${role}',
			'common.notifications.success' => 'Succès',
			'common.notifications.error' => 'Erreur',
			'common.notifications.loading' => 'Chargement...',
			'common.clipboard.copyToClipboard' => 'Copier dans le presse-papiers',
			'common.clipboard.pasteFromClipboard' => 'Coller depuis le presse-papiers',
			'common.clipboard.copied' => 'Copié dans le presse-papiers !',
			'common.actions.cancelAndReturnToOffers' => 'Annuler et revenir aux offres',
			'common.actions.cancelAndReturnHome' => 'Annuler et revenir à l\'accueil',
			'lightningAddress.labels.address' => 'Adresse Lightning (LNURL)',
			'lightningAddress.labels.hint' => 'utilisateur@domaine.com',
			'lightningAddress.labels.short' => ({required Object address}) => 'Adresse Lightning : ${address}',
			'lightningAddress.labels.receivingAddress' => 'Votre adresse de réception :',
			'lightningAddress.prompts.enter' => 'Saisissez votre adresse Lightning pour continuer',
			'lightningAddress.prompts.edit' => 'Modifier',
			'lightningAddress.prompts.invalid' => 'Saisissez une adresse Lightning valide',
			'lightningAddress.prompts.required' => 'L\'adresse Lightning est requise.',
			'lightningAddress.prompts.enterToTakeOffer' => 'Vous devez définir une adresse Lightning pour accepter une offre.',
			'lightningAddress.prompts.missing' => 'Adresse Lightning manquante. Veuillez en ajouter une pour pouvoir accepter des offres.',
			'lightningAddress.prompts.add' => 'Ajouter',
			'lightningAddress.prompts.delete' => 'Supprimer',
			'lightningAddress.prompts.confirmDelete' => 'Voulez-vous vraiment supprimer votre adresse Lightning ?',
			'lightningAddress.prompts.howToGet' => 'Vous n\'avez pas encore d\'adresse Lightning ? Découvrez comment en obtenir une !',
			'lightningAddress.prompts.learnMore' => 'En savoir plus sur les adresses Lightning',
			'lightningAddress.feedback.saved' => 'Adresse Lightning enregistrée !',
			'lightningAddress.feedback.updated' => 'Adresse Lightning mise à jour !',
			'lightningAddress.feedback.valid' => 'Adresse Lightning valide',
			'lightningAddress.errors.saving' => ({required Object details}) => 'Erreur lors de l\'enregistrement de l\'adresse : ${details}',
			'lightningAddress.errors.loading' => ({required Object details}) => 'Erreur lors du chargement de l\'adresse Lightning : ${details}',
			'nfc.actions.scan' => 'Scanner NFC',
			'nfc.actions.addWallet' => 'Ajouter le wallet',
			'nfc.prompts.addTitle' => 'Ajouter le wallet Lightning ?',
			'nfc.prompts.addMessage' => ({required Object address}) => 'Cette adresse Lightning a été trouvée sur un tag NFC : ${address}\n\nL\'ajouter comme wallet LNURL ?',
			'nfc.feedback.readyToScan' => 'Approchez votre téléphone du tag NFC',
			'nfc.feedback.alreadyScanning' => 'Un scan NFC est déjà en cours',
			'nfc.feedback.alreadyAdded' => 'Cette adresse Lightning est déjà configurée',
			'nfc.feedback.walletAdded' => 'Wallet Lightning ajouté depuis le tag NFC',
			'nfc.errors.disabled' => 'Le NFC est désactivé sur cet appareil',
			'nfc.errors.unsupported' => 'Le NFC n\'est pas disponible sur cet appareil',
			'nfc.errors.reading' => ({required Object details}) => 'Échec du scan NFC : ${details}',
			'offers.details.yourOffer' => 'Votre offre :',
			'offers.details.selectedOffer' => 'Offre :',
			'offers.details.activeOffer' => 'Vous avez une offre active :',
			'offers.details.finishedOffers' => 'Offres terminées',
			'offers.details.noAvailable' => 'Aucune offre disponible.',
			'offers.details.noAvailableTip' => ({required Object app}) => 'Astuce : partagez ${app} dans votre communauté et parmi vos amis pour augmenter le nombre de commandes ${app}.',
			'offers.details.noSuccessfulTrades' => 'Aucun échange réussi.',
			'offers.details.loadingDetails' => 'Chargement des détails de l\'offre...',
			'offers.details.amount' => ({required Object amount}) => 'Montant : ${amount} satoshi',
			'offers.details.amountWithCurrency' => ({required Object amount, required Object currency}) => '${amount} ${currency}',
			'offers.details.makerFee' => ({required Object fee}) => 'Frais : ${fee} sats',
			'offers.details.takerFee' => ({required Object fee}) => 'Frais : ${fee} sats',
			'offers.details.subtitle' => ({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (frais) satoshi\nStatut : ${status}',
			'offers.details.subtitleWithDate' => ({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (frais) satoshi\nStatut : ${status}\nPayé : ${date}',
			'offers.details.activeSubtitle' => ({required Object status, required Object amount}) => 'Statut : ${status}\nMontant : ${amount} satoshi',
			'offers.details.id' => ({required Object id}) => 'ID de l\'offre : ${id}...',
			'offers.details.created' => ({required Object dateTime}) => 'Créée : ${dateTime}',
			'offers.details.takenAfter' => ({required Object duration}) => 'Acceptée après : ${duration}',
			'offers.details.paidAfter' => ({required Object duration}) => 'Payée après : ${duration}',
			'offers.details.exchangeRate' => 'Taux de change',
			'offers.details.amountLabel' => 'Montant',
			'offers.details.makerFeeLabel' => 'Frais maker',
			'offers.details.takerFeeLabel' => 'Frais taker',
			'offers.details.feeLabel' => 'Frais',
			'offers.details.statusLabel' => 'Statut',
			'offers.details.youllReceive' => 'Vous recevrez',
			'offers.details.coordinator' => 'Coordinateur',
			'offers.details.categoryLabel' => 'Catégorie',
			'offers.details.categories.physicalShop' => 'Magasin, café ou restaurant',
			'offers.details.categories.atmCashout' => 'Retrait au distributeur',
			'offers.details.categories.onlineService' => 'Service/produit en ligne',
			'offers.details.consents.atm' => 'Certains distributeurs ajoutent des frais supplémentaires au montant de l\'offre. En acceptant cette offre, vous acceptez tous les frais bancaires supplémentaires exigés par le distributeur.',
			'offers.details.consents.ecommerce' => ({required Object code}) => 'Pour diverses raisons — article en rupture de stock, correction d\'un trop-perçu ou autres problèmes côté commerçant — le commerçant en ligne peut automatiquement renvoyer de l\'argent vers le compte bancaire lié au ${code} que vous avez généré. Ces fonds arrivent sur votre compte mais ne vous appartiennent pas. Si cela se produit, contactez le coordinateur de bonne foi et organisez la restitution des fonds au maker. En acceptant cette offre, vous acceptez ces conditions et vous engagez sur l\'honneur à agir honnêtement dans de telles situations.',
			'offers.labels.premium' => 'Prime',
			'offers.labels.premiumBadge' => ({required Object percent}) => '+${percent}% de prime',
			'offers.tooltips.takerFeeInfo' => ({required Object feePercent}) => 'Le coordinateur facture des frais taker de ${feePercent}%. Ils incluent les frais de routage Lightning et sont déduits du montant que vous recevez.',
			'offers.tooltips.premiumInfoTaker' => 'Une prime signifie que cette offre est au-dessus du prix du marché. Pour le même montant fiat, le maker verrouille moins de sats dans la facture hold : vous payez donc au-dessus du marché et recevez moins de sats qu\'au taux du marché. La prime maximale est fixée par le coordinateur.',
			'offers.tooltips.ratesFetchedAt' => 'Récupéré à',
			'offers.tooltips.ratesSources' => 'Sources du taux moyen',
			'offers.actions.take' => 'ACCEPTER',
			'offers.actions.takeOffer' => 'Accepter l\'offre',
			'offers.actions.resume' => ({required Object code}) => 'SAISIR ${code}',
			'offers.actions.cancel' => 'Annuler l\'offre',
			'offers.actions.view' => 'Voir les détails',
			'offers.status.created' => 'Créée',
			'offers.status.funded' => 'Financée',
			'offers.status.expired' => 'Expirée',
			'offers.status.cancelled' => 'Annulée',
			'offers.status.reserved' => 'Réservée',
			'offers.status.blikReceived' => ({required Object code}) => '${code} envoyé',
			'offers.status.blikSentToMaker' => ({required Object code}) => '${code} reçu',
			'offers.status.expiredBlik' => ({required Object code}) => '${code} expiré',
			'offers.status.expiredSentBlik' => ({required Object code}) => '${code} expiré',
			'offers.status.takerCharged' => 'Taker débité',
			'offers.status.invalidBlik' => ({required Object code}) => '${code} invalide',
			'offers.status.conflict' => 'Conflit',
			'offers.status.dispute' => 'Litige',
			'offers.status.refundingMaker' => 'Remboursement du maker',
			'offers.status.makerConfirmed' => 'Confirmée',
			'offers.status.settled' => 'Réglée',
			'offers.status.payingTaker' => 'Paiement du taker',
			'offers.status.takerPaymentFailed' => 'Échec du paiement au taker',
			'offers.status.takerPaid' => 'Taker payé',
			'offers.status.unknownStatus' => 'Inconnu',
			'offers.statusMessages.reserved' => 'Offre réservée par un taker !',
			'offers.statusMessages.cancelled' => 'Offre annulée avec succès.',
			'offers.statusMessages.cancelledOrExpired' => 'L\'offre a été annulée ou a expiré.',
			'offers.statusMessages.noLongerAvailable' => ({required Object status}) => 'L\'offre n\'est plus disponible (Statut : ${status}).',
			'offers.progress.waitingForTaker' => ({required Object time}) => 'En attente d\'un taker : ${time}',
			'offers.progress.reserved' => ({required Object seconds}) => 'Réservée : ${seconds} s restantes',
			'offers.progress.confirming' => ({required Object seconds}) => 'Confirmation : ${seconds} s restantes',
			'offers.errors.loading' => ({required Object details}) => 'Erreur lors du chargement des offres : ${details}',
			'offers.errors.loadingDetails' => ({required Object details}) => 'Erreur lors du chargement des détails de l\'offre : ${details}',
			'offers.errors.detailsMissing' => 'Erreur : détails de l\'offre manquants ou invalides.',
			'offers.errors.detailsNotLoaded' => 'Impossible de charger les détails de l\'offre.',
			'offers.errors.notFound' => 'Erreur : offre introuvable.',
			'offers.errors.unexpectedState' => 'Erreur : l\'offre est dans un état inattendu.',
			'offers.errors.unexpectedStateWithStatus' => ({required Object status}) => 'L\'offre est dans un état inattendu (${status}). Veuillez réessayer ou contacter le support.',
			'offers.errors.invalidStatus' => 'L\'offre a un statut invalide.',
			'offers.errors.couldNotIdentify' => 'Erreur : impossible d\'identifier l\'offre à annuler.',
			'offers.errors.cannotBeCancelled' => ({required Object status}) => 'L\'offre ne peut pas être annulée dans son état actuel (${status}).',
			'offers.errors.failedToCancel' => ({required Object details}) => 'Échec de l\'annulation de l\'offre : ${details}',
			'offers.errors.activeDetailsLost' => 'Erreur : détails de l\'offre active perdus.',
			'offers.errors.checkingActive' => ({required Object details}) => 'Erreur lors de la vérification des offres actives : ${details}',
			'offers.errors.cannotResume' => ({required Object status}) => 'Impossible de reprendre l\'offre dans cet état : ${status}',
			'offers.errors.cannotResumeTaker' => ({required Object status}) => 'Impossible de reprendre l\'offre taker dans cet état : ${status}',
			'offers.errors.resuming' => ({required Object details}) => 'Erreur lors de la reprise de l\'offre : ${details}',
			'offers.errors.makerPublicKeyNotFound' => 'Clé publique du maker introuvable',
			'offers.errors.takerPublicKeyNotFound' => 'Clé publique du taker introuvable.',
			'offers.errors.atmConsentRequired' => 'Acceptez la condition relative aux frais de distributeur avant d\'accepter cette offre.',
			'offers.errors.ecommerceConsentRequired' => 'Acceptez la condition de restitution des remboursements e-commerce avant d\'accepter cette offre.',
			'offers.errors.cannotTakeOwnOffer' => 'Vous ne pouvez pas accepter votre propre offre.',
			'offers.success.title' => 'Offre terminée',
			'offers.success.headline' => 'Paiement confirmé !',
			'offers.success.subtitle' => 'Le taker va maintenant être payé.',
			'offers.success.detailsTitle' => 'Détails de l\'offre :',
			'offers.success.duration' => ({required Object time}) => 'L\'offre a pris ${time} pour se terminer.',
			'reservations.actions.cancel' => 'Annuler la réservation',
			'reservations.feedback.cancelled' => 'Réservation annulée.',
			'reservations.errors.cancelling' => ({required Object error}) => 'Échec de l\'annulation de la réservation : ${error}',
			'reservations.errors.failedToReserve' => ({required Object details}) => 'Échec de la réservation de l\'offre : ${details}',
			'reservations.errors.failedNoTimestamp' => 'Échec de la réservation de l\'offre (pas d\'horodatage).',
			'reservations.errors.timestampMissing' => 'Horodatage de la réservation de l\'offre manquant.',
			'reservations.errors.notReserved' => ({required Object status}) => 'L\'offre n\'est plus à l\'état réservé (${status}).',
			'exchange.labels.enterAmount' => ({required Object currency}) => 'Saisissez le montant (${currency}) à payer :',
			'exchange.labels.equivalent' => ({required Object sats}) => '≈ ${sats} satoshi',
			'exchange.labels.rate' => ({required Object rate, required Object currency}) => 'Taux de change ≈ ${rate} ${currency}/BTC',
			'exchange.feedback.fetching' => 'Récupération du taux de change...',
			'exchange.errors.fetchingRate' => 'Impossible de récupérer le taux de change.',
			'exchange.errors.invalidFormat' => 'Format de nombre invalide',
			'exchange.errors.mustBePositive' => 'Le montant doit être positif',
			'exchange.errors.invalidFeePercentage' => 'Pourcentage de frais invalide',
			'exchange.errors.tooLowFiat' => ({required Object minAmount, required Object currency}) => 'Le montant est trop faible. Le minimum est ${minAmount} ${currency}.',
			'exchange.errors.tooHighFiat' => ({required Object maxAmount, required Object currency}) => 'Le montant est trop élevé. Le maximum est ${maxAmount} ${currency}.',
			'exchange.errors.atmNotDispensable' => ({required Object notes}) => 'Le distributeur ne peut pas délivrer ce montant. Utilisez une combinaison de billets : ${notes}.',
			'exchange.errors.atmOverBankLimit' => ({required Object bank, required Object limit, required Object currency}) => '${bank} délivre au maximum ${limit} ${currency} par retrait.',
			'coordinator.title' => 'Coordinateurs',
			'coordinator.info.fee' => 'frais',
			'coordinator.info.rangeDisplay' => ({required Object minAmount, required Object maxAmount, required Object currency}) => 'Montant : ${minAmount}-${maxAmount} ${currency}',
			'coordinator.info.feeDisplay' => ({required Object fee}) => '${fee}% de frais',
			'coordinator.selector.loading' => 'Chargement des coordinateurs...',
			'coordinator.selector.errorLoading' => 'Erreur lors du chargement des coordinateurs',
			'coordinator.selector.choose' => 'Choisir un coordinateur',
			'coordinator.selector.viewNostrProfile' => 'Voir le profil Nostr',
			'coordinator.selector.unresponsive' => 'Ce coordinateur ne répond pas',
			'coordinator.selector.waitingResponse' => 'En attente de la réponse du coordinateur',
			'coordinator.selector.termsAccept' => 'J\'accepte les ',
			'coordinator.selector.termsOfUsage' => 'conditions d\'utilisation du coordinateur',
			'coordinator.dialog.makerFee' => 'Frais maker',
			'coordinator.dialog.takerFee' => 'Frais taker',
			'coordinator.dialog.amountRange' => 'Plage de montants',
			'coordinator.dialog.reservationTime' => 'Durée de réservation',
			'coordinator.dialog.currencies' => 'Devises',
			'coordinator.dialog.viewTerms' => 'Voir les conditions',
			'coordinator.details.title' => 'Coordinateur',
			'coordinator.details.relaysInUse' => 'Relais utilisés',
			'coordinator.details.relaysInUseHint' => 'Toute la communication avec ce coordinateur passe par ces relais (issus de sa liste NIP-65).',
			'coordinator.details.noRelays' => 'Aucun relais connu pour l\'instant',
			'coordinator.details.makerFee' => 'Frais maker',
			'coordinator.details.takerFee' => 'Frais taker',
			'coordinator.details.amountRange' => 'Plage de montants',
			'coordinator.details.maxPremium' => 'Prime max',
			'coordinator.details.maxPremiumInfoTitle' => 'Prime',
			'coordinator.details.maxPremiumInfoBody' => 'Une prime est une majoration facultative du prix au-dessus du taux du marché qu\'un maker peut appliquer à une offre. Avec une prime, le maker verrouille moins de sats pour le même montant fiat : le taker paie donc au-dessus du marché et le maker garde la différence. Cette valeur est la prime la plus élevée que ce coordinateur autorise sur ses offres.',
			'coordinator.details.reservationTime' => 'Durée de réservation',
			'coordinator.details.currencies' => 'Devises',
			'coordinator.details.paymentSystem' => 'Système de paiement',
			'coordinator.details.version' => 'Version',
			'coordinator.details.yourOffers' => 'Vos offres',
			'coordinator.details.successfulOffers' => 'Offres réussies (30 j)',
			'coordinator.details.statusOnline' => 'En ligne',
			'coordinator.details.statusOffline' => 'Hors ligne',
			'coordinator.details.statusUnknown' => 'Inconnu',
			'coordinator.details.openNostrProfile' => 'Ouvrir le profil Nostr',
			'coordinator.details.termsOfUsage' => 'Conditions d\'utilisation',
			'coordinator.coldStart.title' => 'Découverte des coordinateurs',
			'coordinator.coldStart.body' => ({required Object app}) => '${app} recherche des coordinateurs publics, vérifie lesquels sont joignables et active pour vous une petite sélection par défaut.',
			'coordinator.coldStart.settingsHint' => 'Vous pourrez modifier les coordinateurs activés plus tard dans les Réglages.',
			'coordinator.coldStart.ok' => 'OK',
			'coordinator.coldStart.discovered' => 'Découverts',
			'coordinator.coldStart.candidates' => 'Candidats',
			'coordinator.coldStart.enabled' => 'Activés',
			'coordinator.coldStart.recordsTitle' => 'Coordinateurs actuels',
			'coordinator.coldStart.recordEnabled' => 'Activé',
			'coordinator.coldStart.recordHealthyCandidate' => 'Candidat opérationnel',
			'coordinator.coldStart.recordOfflineCandidate' => 'Candidat hors ligne',
			'coordinator.coldStart.recordChecking' => 'Vérification',
			'coordinator.coldStart.recordDiscovered' => 'Découvert',
			'coordinator.coldStart.phases.loadingMuteList' => 'Chargement des filtres de coordinateurs',
			'coordinator.coldStart.phases.discovering' => 'Découverte des coordinateurs sur Nostr',
			'coordinator.coldStart.phases.loadingProfiles' => 'Chargement des profils des coordinateurs',
			'coordinator.coldStart.phases.loadingStats' => 'Lecture de l\'historique des coordinateurs',
			'coordinator.coldStart.phases.checkingHealth' => 'Vérification de la disponibilité des coordinateurs',
			'coordinator.coldStart.phases.finalizing' => 'Activation des coordinateurs par défaut',
			'coordinator.coldStart.phases.completed' => 'Terminé',
			'coordinator.management.title' => 'Gestion des coordinateurs',
			'coordinator.management.availableCoordinators' => 'Coordinateurs',
			'coordinator.management.noCoordinators' => 'Aucun coordinateur découvert pour l\'instant.',
			'coordinator.management.online' => 'En ligne',
			'coordinator.management.unknownOffline' => 'Inconnu/Hors ligne',
			'coordinator.management.openNostrProfile' => 'Ouvrir le profil Nostr',
			'coordinator.management.enable' => 'Activer',
			'coordinator.management.remove' => 'Retirer',
			'coordinator.management.addCustomWhitelist' => 'Ajouter un coordinateur personnalisé',
			'coordinator.management.addCustomWhitelistHint' => 'npub1...',
			'coordinator.management.add' => 'Ajouter',
			'coordinator.management.coordinatorDisabled' => 'Coordinateur désactivé',
			'coordinator.management.coordinatorEnabled' => 'Coordinateur activé',
			'coordinator.management.coordinatorAdded' => 'Coordinateur ajouté à la liste blanche personnalisée',
			'coordinator.management.coordinatorRemoved' => 'Coordinateur retiré de la liste blanche personnalisée',
			'coordinator.management.coordinatorAddInfoUnavailable' => 'Aucune information sur ce coordinateur trouvée sur les relais. Coordinateur non ajouté.',
			'coordinator.management.pleaseEnterNpub' => 'Veuillez saisir un npub',
			'coordinator.management.error' => 'Erreur',
			'coordinator.management.metricYourOffers' => 'Vos offres',
			'coordinator.management.metricYourOffersTooltip' => 'Nombre d\'offres que vous avez menées à bien avec ce coordinateur.',
			'coordinator.management.metricNetworkOffers' => 'Offres (30 j)',
			'coordinator.management.metricNetworkOffersTooltip' => 'Offres réussies réglées par ce coordinateur pour l\'ensemble des utilisateurs au cours des 30 derniers jours.',
			'disputeChat.viewHistory' => 'Voir l’historique du litige',
			'disputeChat.historyTitle' => 'Historique du litige',
			'disputeChat.ruledForMaker' => 'Décision en faveur du maker',
			'disputeChat.ruledForTaker' => 'Décision en faveur du taker',
			'disputeChat.legacyChannel' => 'Canal de compatibilité NIP-04 hérité',
			'disputeChat.privateConversation' => 'Conversation privée avec le coordinateur',
			'disputeChat.noMessages' => 'Aucun message pour le moment.',
			'disputeChat.replyHint' => 'Répondre ici',
			'disputeChat.readOnly' => 'L’historique de ce litige résolu est en lecture seule.',
			'disputeChat.tooltips.refresh' => 'Actualiser les messages',
			'disputeChat.tooltips.attachEvidence' => 'Joindre une preuve de paiement',
			'disputeChat.tooltips.send' => 'Envoyer le message',
			'disputeChat.errors.accountNotReady' => 'La messagerie privée sera disponible lorsque votre compte Nostr sera prêt.',
			'disputeChat.errors.subscriptionFailed' => 'La connexion aux messages privés a échoué. Actualisez la conversation.',
			'disputeChat.errors.decryptFailed' => 'Un message privé n’a pas pu être déchiffré.',
			'disputeChat.errors.operationFailed' => 'L’opération de messagerie privée a échoué. Veuillez réessayer.',
			'disputeChat.errors.nostrNotInitialized' => 'Nostr n’est pas initialisé.',
			'disputeChat.errors.attachmentsRequireNip17' => 'Les pièces jointes sont disponibles uniquement dans le canal NIP-17.',
			'receivingInvoice.errors.walletUnavailable' => 'Le service de portefeuille est indisponible.',
			'receivingInvoice.errors.noBolt11' => 'Le portefeuille n’a pas renvoyé de facture BOLT11.',
			'maker.refundInvoice.title' => 'Le coordinateur a statué en votre faveur',
			'maker.refundInvoice.instructions' => ({required Object amount}) => 'Choisissez un portefeuille de réception ou collez une facture Lightning de exactement ${amount} pour votre remboursement.',
			'maker.refundInvoice.invoiceLabel' => 'Facture de remboursement au montant exact',
			'maker.refundInvoice.submit' => 'Envoyer la facture de remboursement',
			'maker.refundInvoice.addWallet' => 'Ajouter un portefeuille',
			'maker.refundInvoice.noReceivingWallet' => 'Aucun portefeuille de réception n’est configuré. Ajoutez-en un ou collez une facture provenant d’un autre portefeuille.',
			'maker.refundInvoice.paymentFailed' => 'La tentative de remboursement précédente a échoué. Choisissez un autre portefeuille ou envoyez une nouvelle facture.',
			'maker.refundInvoice.submitFailed' => ({required Object details}) => 'Impossible d’envoyer la facture de remboursement : ${details}',
			'maker.refundInvoice.errors.backendUnavailable' => 'Le service de paiement Lightning est indisponible.',
			'maker.refundInvoice.errors.missing' => 'Saisissez une facture de remboursement.',
			'maker.refundInvoice.errors.invalid' => 'Saisissez une facture de remboursement BOLT11 valide.',
			'maker.refundInvoice.errors.wrongNetwork' => 'La facture de remboursement appartient au mauvais réseau Lightning.',
			'maker.refundInvoice.errors.wrongAmount' => 'La facture de remboursement doit contenir le montant exact du remboursement.',
			'maker.refundInvoice.errors.invalidExpiry' => 'La facture de remboursement a une expiration invalide.',
			'maker.refundInvoice.errors.futureTimestamp' => 'L’horodatage de la facture de remboursement est dans le futur.',
			'maker.refundInvoice.errors.expired' => 'La facture de remboursement a expiré. Générez-en une nouvelle.',
			'maker.refundInvoice.errors.invalidPaymentHash' => 'La facture de remboursement ne contient pas de hash de paiement valide.',
			'maker.refundInvoice.errors.reusedInvoice' => 'Utilisez une nouvelle facture ; la facture de l’offre ne peut pas recevoir le remboursement.',
			'maker.refundInvoice.errors.unsupportedNetwork' => 'Ce réseau Lightning n’est pas pris en charge.',
			'maker.refundInvoice.errors.unknown' => 'Vérifiez la facture et réessayez.',
			'maker.roleSelection.button' => 'PAYER avec Lightning',
			'maker.amountForm.progress.step1' => '1. Créer l\'offre',
			'maker.amountForm.progress.step2' => '2. Attendre un taker',
			'maker.amountForm.progress.step3' => ({required Object code}) => '3. Utiliser le ${code}',
			'maker.amountForm.labels.coordinator' => 'Coordinateur',
			'maker.amountForm.labels.category' => 'Catégorie',
			'maker.amountForm.labels.exchangeRate' => 'Taux de change',
			'maker.amountForm.labels.fee' => 'Frais',
			'maker.amountForm.labels.satoshisToPay' => 'Montant à payer',
			'maker.amountForm.labels.enterAmount' => 'Saisir le montant',
			'maker.amountForm.labels.customAmount' => 'Personnalisé',
			'maker.amountForm.labels.tapToSelect' => 'Touchez pour sélectionner',
			'maker.amountForm.labels.premium' => 'Prime',
			'maker.amountForm.actions.generateInvoice' => 'Générer la facture',
			'maker.amountForm.bank.label' => 'Banque',
			'maker.amountForm.bank.required' => 'Veuillez choisir une banque',
			'maker.amountForm.bank.shortValidityWarning' => ({required Object minutes}) => 'Le code de cette banque n\'est valable que ${minutes} min — soyez au distributeur avant de réserver.',
			'maker.amountForm.twintScan.cardTitle' => ({required Object code}) => 'Scanner le QR ${code} et le montant',
			'maker.amountForm.twintScan.cardBody' => 'Pointez la caméra vers l\'écran de paiement. L\'application préremplira le code et, s\'il est visible, le montant.',
			'maker.amountForm.twintScan.scanButton' => 'Scanner avec la caméra',
			'maker.amountForm.twintScan.manualButton' => 'Saisir manuellement à la place',
			'maker.amountForm.twintScan.codeLabel' => ({required Object code}) => 'Code ${code}',
			'maker.amountForm.twintScan.rescan' => 'Scanner à nouveau',
			'maker.amountForm.twintScan.helperFilled' => ({required Object code}) => 'Le taker verra ce code et le saisira dans ${code}.',
			'maker.amountForm.twintScan.helperEmpty' => ({required Object digits}) => 'Scannez pour remplir ceci automatiquement, ou saisissez manuellement le code à ${digits} chiffres.',
			'maker.amountForm.tooltips.feeInfo' => ({required Object feePercent}) => 'Le coordinateur facture des frais maker de ${feePercent}%. Ces frais sont déduits de votre paiement Lightning.',
			'maker.amountForm.tooltips.payInfo' => 'Ce calcul est basé sur des taux de change récupérés côté client. Le coordinateur calculera le montant exact, et le montant de la facture sera le montant final et exact à payer.',
			'maker.amountForm.tooltips.premiumInfo' => 'Une prime facultative vous permet de vendre vos sats au-dessus du prix du marché. La prime réduit les sats verrouillés dans votre facture hold pour le même montant fiat : le taker paie donc au-dessus du marché et vous gardez la différence. Désactivée par défaut (0%). La prime maximale est fixée par le coordinateur sélectionné.',
			'maker.amountForm.category.label' => 'Catégorie de l\'offre',
			'maker.amountForm.category.unsupportedForSystem' => ({required Object system}) => '${system} ne prend pas en charge cette catégorie.',
			'maker.amountForm.category.options.physicalShop' => 'Magasin, café ou restaurant',
			'maker.amountForm.category.options.atmCashout' => 'Retrait au distributeur',
			'maker.amountForm.category.options.onlineService' => 'Service/produit en ligne',
			'maker.amountForm.category.shortLabels.shop' => 'Magasin',
			'maker.amountForm.category.shortLabels.atm' => 'Distributeur',
			'maker.amountForm.category.shortLabels.online' => 'En ligne',
			'maker.amountForm.category.atmHint' => 'Les takers verront que cette offre concerne un retrait au distributeur et pourront l\'éviter si leur banque facture des frais de distributeur supplémentaires.',
			'maker.amountForm.category.physicalShopHint' => ({required Object app, required Object code}) => 'L\'endroit idéal pour utiliser ${app} est une caisse en libre-service — car attendre qu\'un taker réserve, génère et confirme un code ${code} peut prendre quelques minutes. Fonctionne très bien dans les magasins, cafés et restaurants. Si vous êtes assez courageux pour faire patienter un caissier ordinaire (et les personnes dans la file derrière vous) pendant ces quelques minutes, tant mieux pour vous.',
			'maker.amountForm.category.ecommerceWarningTitle' => 'Risque de remboursement par le commerçant en ligne',
			'maker.amountForm.category.ecommerceWarningBody' => ({required Object code}) => 'Pour diverses raisons — article en rupture de stock, correction d\'un trop-perçu ou autres problèmes côté commerçant — le commerçant en ligne peut automatiquement émettre un remboursement vers le compte bancaire lié au ${code}, c\'est-à-dire le compte du taker. Le coordinateur ne peut pas forcer le taker à vous restituer ces fonds.',
			'maker.amountForm.category.ecommerceConfirmation' => 'Je comprends le risque de remboursement et j\'ajouterai une note à la commande demandant au commerçant de rembourser un autre compte si un remboursement devient nécessaire.',
			'maker.amountForm.category.whyThisIsNeeded' => 'pourquoi est-ce nécessaire ?',
			'maker.amountForm.onboarding.titlePrefix' => 'Nouveau',
			'maker.amountForm.onboarding.title' => 'Choisissez la catégorie de l\'offre',
			'maker.amountForm.onboarding.body' => 'Choisissez la catégorie qui correspond le mieux à ce que vous payez avant de générer la facture.',
			'maker.amountForm.onboarding.showWhy' => 'Pourquoi est-ce important ?',
			'maker.amountForm.onboarding.hideWhy' => 'Masquer les détails',
			'maker.amountForm.onboarding.whyTitle' => 'Choisir la bonne catégorie aide les takers à décider en toute sécurité',
			'maker.amountForm.onboarding.whyBody' => 'Des situations différentes impliquent des attentes et des risques différents. Les retraits au distributeur peuvent inclure des frais bancaires supplémentaires, et les achats en ligne peuvent comporter des cas particuliers de remboursement. Indiquer la bonne catégorie donne aux takers le contexte dont ils ont besoin avant d\'accepter votre offre.',
			'maker.amountForm.onboarding.cta' => 'Compris',
			'maker.amountForm.errors.initiating' => ({required Object details}) => 'Erreur lors de la création de l\'offre : ${details}',
			'maker.amountForm.errors.publicKeyNotLoaded' => 'Erreur : clé publique pas encore chargée.',
			'maker.amountForm.errors.noCoordinatorMatchesAmount' => 'Aucun coordinateur ne prend en charge ce montant. Essayez une autre valeur.',
			'maker.amountForm.errors.categoryRequired' => 'Sélectionnez une catégorie d\'offre.',
			'maker.amountForm.errors.ecommerceConfirmationRequired' => 'Confirmez le risque de remboursement du commerçant en ligne avant de continuer.',
			'maker.payInvoice.title' => 'Payez cette facture hold :',
			'maker.payInvoice.actions.copy' => 'Copier la facture',
			'maker.payInvoice.actions.payInWallet' => 'Ouvrir dans un portefeuille externe',
			'maker.payInvoice.actions.connectWallet' => 'Connecter un portefeuille',
			'maker.payInvoice.actions.payWithNwc' => 'Payer',
			'maker.payInvoice.actions.paying' => 'Paiement en cours...',
			'maker.payInvoice.feedback.copied' => 'Facture copiée dans le presse-papiers !',
			'maker.payInvoice.feedback.waitingConfirmation' => 'En attente de la confirmation du paiement...',
			'maker.payInvoice.feedback.nwcConnected' => 'Portefeuille NWC connecté !',
			'maker.payInvoice.feedback.nwcPaymentSuccess' => 'Paiement réussi !',
			'maker.payInvoice.errors.couldNotOpenApp' => 'Impossible d\'ouvrir l\'application Lightning pour la facture.',
			'maker.payInvoice.errors.openingApp' => ({required Object details}) => 'Erreur lors de l\'ouverture de l\'application Lightning : ${details}',
			'maker.payInvoice.errors.publicKeyNotAvailable' => 'La clé publique n\'est pas disponible.',
			'maker.payInvoice.errors.couldNotFetchActive' => 'Impossible de récupérer les détails de l\'offre active. Elle a peut-être expiré.',
			'maker.payInvoice.errors.nwcPaymentFailed' => ({required Object details}) => 'Paiement échoué : ${details}',
			'maker.payInvoice.errors.nwcNotConnected' => 'Portefeuille NWC non connecté',
			'maker.payInvoice.errors.insufficientBalance' => ({required Object required, required Object available}) => 'Solde insuffisant. ${required} sats nécessaires, ${available} sats disponibles',
			'maker.payInvoice.errors.cancelOfferAlreadyFunded' => 'Le coordinateur indique que cette offre est déjà financée. Elle ne peut plus être annulée.',
			'maker.payInvoice.errors.cancelFailed' => ({required Object details}) => 'Impossible d\'annuler l\'offre : ${details}',
			'maker.payInvoice.budgetWarning.title' => 'Le paiement peut échouer',
			'maker.payInvoice.budgetWarning.balanceTooLow' => ({required Object name}) => 'Votre portefeuille de dépense par défaut ${name} n\'a pas un solde suffisant pour ce paiement.',
			'maker.payInvoice.budgetWarning.budgetTooLow' => ({required Object name}) => 'Votre portefeuille de dépense par défaut ${name} n\'a pas un budget de dépense suffisant pour ce paiement.',
			'maker.payInvoice.budgetWarning.balanceLine' => ({required Object available}) => 'Solde : ${available}',
			'maker.payInvoice.budgetWarning.budgetLine' => ({required Object remaining}) => 'Budget NWC restant : ${remaining}',
			'maker.payInvoice.budgetWarning.requiredLine' => ({required Object required}) => 'Nécessaire : ${required}',
			'maker.payInvoice.budgetWarning.addFundsHint' => ({required Object name}) => 'Ajoutez des fonds à ${name} pour couvrir ce montant.',
			'maker.payInvoice.budgetWarning.increaseBudgetHint' => 'Augmentez le budget de dépense NWC de cette connexion dans votre application de portefeuille.',
			'maker.payInvoice.budgetWarning.switchWalletLabel' => 'Ou utilisez un autre portefeuille :',
			'maker.payInvoice.budgetWarning.walletLowFundsTag' => 'Peut échouer',
			'maker.payInvoice.budgetWarning.payAnyway' => 'Essayer quand même',
			'maker.payInvoice.budgetWarning.cancel' => 'Annuler',
			'maker.payInvoice.budgetWarning.readyTitle' => 'Payer la facture',
			'maker.waitTaker.message' => 'En attente d\'un taker pour réserver votre offre...',
			'maker.waitTaker.progressLabel' => ({required Object time}) => 'En attente d\'un taker : ${time}',
			'maker.waitTaker.errorActiveOfferDetailsLost' => 'Erreur : détails de l\'offre active perdus.',
			'maker.waitTaker.errorFailedToRetrieveBlik' => ({required Object code}) => 'Erreur : impossible de récupérer le code ${code}.',
			'maker.waitTaker.errorRetrievingBlik' => ({required Object code, required Object details}) => 'Erreur lors de la récupération du code ${code} : ${details}',
			'maker.waitTaker.offerNoLongerAvailable' => ({required Object status}) => 'L\'offre n\'est plus disponible (Statut : ${status}).',
			'maker.waitTaker.errorCouldNotIdentifyOffer' => 'Erreur : impossible d\'identifier l\'offre à annuler.',
			'maker.waitTaker.offerCannotBeCancelled' => ({required Object status}) => 'L\'offre ne peut pas être annulée dans son état actuel (${status}).',
			'maker.waitTaker.offerCancelledSuccessfully' => 'Offre annulée avec succès.',
			'maker.waitTaker.failedToCancelOffer' => ({required Object details}) => 'Échec de l\'annulation de l\'offre : ${details}',
			'maker.waitTaker.offerExpiredTitle' => 'Offre expirée',
			'maker.waitTaker.offerExpiredMessage' => 'Aucun taker n\'a réservé votre offre à temps.',
			'maker.waitTaker.recreateOffer' => 'Nouvelle offre — même montant',
			'maker.waitForBlik.title' => ({required Object code}) => 'En attente du ${code}',
			'maker.waitForBlik.messageInfo' => 'Un taker a réservé l\'offre !',
			'maker.waitForBlik.messageWaiting' => ({required Object code}) => 'En attente de la fourniture du code ${code}...',
			'maker.waitForBlik.progressLabel' => ({required Object seconds}) => 'Réservée : ${seconds} s restantes',
			'maker.confirmPayment.title' => ({required Object code}) => 'Code ${code} reçu !',
			'maker.confirmPayment.retrieving' => ({required Object code}) => 'Récupération du code ${code}...',
			'maker.confirmPayment.instructions' => 'Saisissez ce code dans le terminal de paiement. Lorsque le taker confirme dans son application bancaire et que le paiement est réussi, appuyez sur Confirmer ci-dessous.',
			'maker.confirmPayment.instruction1' => ({required Object code}) => 'Saisissez le code dans la demande de paiement ${code}.',
			'maker.confirmPayment.instruction2' => 'Attendez que le taker confirme le paiement dans son application.',
			'maker.confirmPayment.instruction3' => 'Lorsque le paiement est réussi, appuyez sur Confirmer ci-dessous :',
			'maker.confirmPayment.mbwayAtmInstructions' => ({required Object amount, required Object minutes}) => 'Pour retirer ${amount} €, rendez-vous au distributeur MULTIBANCO le plus proche, appuyez sur la touche verte et choisissez l\'option "Retirer de l\'argent" ("Levantar Dinheiro"). Saisissez le code. Ce code est valable ${minutes} minutes.',
			'maker.confirmPayment.takerChargedWarning' => ({required Object code}) => 'Le taker a signalé que le paiement ${code} a été débité de son compte bancaire. Si vous le marquez comme invalide, cela créera un conflit.',
			'maker.confirmPayment.autoConfirmInfo' => ({required Object code}) => 'Sauf si vous marquez le ${code} comme invalide, le paiement sera confirmé automatiquement et le taker payé à la fin de ce compte à rebours.',
			'maker.confirmPayment.autoConfirmCountdown' => ({required Object time}) => 'Confirmation automatique dans ${time}',
			'maker.confirmPayment.expiredTitle' => ({required Object code}) => 'Code ${code} expiré',
			'maker.confirmPayment.expiredWarning' => ({required Object code}) => 'Le code ${code} a expiré. Vous devez confirmer manuellement le statut du paiement :',
			'maker.confirmPayment.expiredInstruction1' => ({required Object code}) => 'Si le paiement ${code} a réussi et que vous avez terminé votre achat, cliquez sur "Confirmer le paiement réussi" ci-dessous.',
			'maker.confirmPayment.expiredInstruction2' => ({required Object code}) => 'Si le paiement ${code} a échoué ou n\'a pas été effectué, cliquez sur "Code ${code} invalide" ci-dessous.',
			'maker.confirmPayment.actions.confirm' => 'Confirmer le paiement réussi',
			'maker.confirmPayment.actions.markInvalid' => ({required Object code}) => 'Code ${code} invalide',
			'maker.confirmPayment.actions.copyBlik' => ({required Object code}) => 'Copier le ${code}',
			'maker.confirmPayment.confirmDialog.title' => 'Confirmer le paiement ?',
			'maker.confirmPayment.confirmDialog.content' => ({required Object code}) => 'Cette action est irréversible. Après confirmation :\n\n• Le taker recevra les fonds immédiatement\n• Le coordinateur ne pourra pas contester les fonds\n• Vous ne pourrez pas annuler cette action\n\nNe confirmez que si le paiement ${code} a réussi.',
			'maker.confirmPayment.confirmDialog.cancel' => 'Annuler',
			'maker.confirmPayment.confirmDialog.confirmButton' => 'Oui, confirmer le paiement',
			'maker.confirmPayment.invalidBlikDisputeDialog.title' => 'Ouvrir un litige ?',
			'maker.confirmPayment.invalidBlikDisputeDialog.content' => ({required Object code}) => 'Le taker a signalé que le paiement ${code} a été débité de son compte.\n\nLe marquer comme invalide ouvrira immédiatement un LITIGE nécessitant l\'intervention du coordinateur.\n\n• Des frais de litige peuvent être facturés si la décision est en votre défaveur\n• La facture hold sera réglée immédiatement\n• Une vérification manuelle sera nécessaire\n\nNe continuez que si vous êtes certain que le paiement ${code} n\'a PAS réussi.',
			'maker.confirmPayment.invalidBlikDisputeDialog.cancel' => 'Annuler',
			'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton' => 'Oui, ouvrir un litige',
			'maker.confirmPayment.feedback.confirmed' => 'Le maker a confirmé le paiement.',
			'maker.confirmPayment.feedback.confirmedTakerPaid' => 'Paiement confirmé ! Le taker recevra les fonds.',
			'maker.confirmPayment.feedback.progressLabel' => ({required Object seconds}) => 'Confirmation : ${seconds} s restantes',
			'maker.confirmPayment.errors.failedToRetrieve' => ({required Object code}) => 'Erreur : impossible de récupérer le code ${code}.',
			'maker.confirmPayment.errors.retrieving' => ({required Object code, required Object details}) => 'Erreur lors de la récupération du code ${code} : ${details}',
			'maker.confirmPayment.errors.missingHashOrKey' => 'Erreur : hash de paiement ou clé publique manquant.',
			'maker.confirmPayment.errors.incorrectState' => ({required Object status}) => 'L\'offre n\'est pas dans le bon état pour une confirmation (Statut : ${status})',
			'maker.confirmPayment.errors.confirming' => ({required Object details}) => 'Erreur lors de la confirmation du paiement : ${details}',
			'maker.confirmPayment.errors.invalidState' => 'Erreur : état d\'offre invalide reçu.',
			'maker.confirmPayment.errors.internalIncomplete' => 'Erreur interne : détails de l\'offre incomplets.',
			'maker.confirmPayment.errors.notAwaitingConfirmation' => ({required Object status}) => 'L\'offre n\'attend plus de confirmation (Statut : ${status}).',
			'maker.confirmPayment.errors.unexpectedStatus' => 'Statut d\'offre inattendu reçu du serveur.',
			'maker.invalidBlik.title' => ({required Object code}) => 'Code ${code} invalide',
			'maker.invalidBlik.info' => ({required Object code}) => 'Vous avez marqué le code ${code} comme invalide. En attente que le taker fournisse un nouveau code ou ouvre un litige.',
			'maker.conflict.title' => 'Conflit sur l\'offre',
			'maker.conflict.headline' => 'Conflit sur l\'offre signalé',
			'maker.conflict.body' => ({required Object code}) => 'Vous avez marqué le code ${code} comme invalide, mais le taker a signalé un conflit, indiquant qu\'il estime que le paiement a réussi.',
			'maker.conflict.instructions' => 'Confirmez le résultat avant la fin du délai. Si le paiement a réussi, confirmez-le afin que le taker soit payé. S\'il a échoué, ouvrez un litige. Sans action de votre part, un litige formel sera ouvert automatiquement.',
			'maker.conflict.timeoutLabel' => ({required Object time}) => 'Ouverture automatique du litige formel dans ${time}',
			'maker.conflict.actions.back' => 'Retour à l\'accueil',
			'maker.conflict.actions.confirmPayment' => ({required Object code}) => 'Mon erreur, confirmer le succès du paiement ${code}',
			'maker.conflict.actions.openDispute' => ({required Object code}) => 'Le paiement ${code} n\'a PAS réussi, OUVRIR UN LITIGE',
			'maker.conflict.actions.submitDispute' => 'Soumettre le litige',
			'maker.conflict.disputeDialog.title' => 'Ouvrir un litige ?',
			'maker.conflict.disputeDialog.content' => 'L\'ouverture d\'un litige nécessite une vérification manuelle par le coordinateur, ce qui prend du temps. Des frais de litige seront déduits si la décision est en votre défaveur. La facture hold sera réglée pour éviter qu\'elle n\'expire. Si le litige est tranché en votre faveur, vous recevrez un remboursement (moins les frais) sur le portefeuille de votre choix.',
			'maker.conflict.disputeDialog.contentDetailed' => 'L\'ouverture d\'un litige nécessitera une intervention manuelle du coordinateur, ce qui prend du temps et entraîne des frais de litige.\n\nLa facture hold sera immédiatement réglée pour éviter qu\'elle n\'expire avant la résolution du litige.\n\nSi le litige est tranché en votre faveur, le montant en satoshi sera remboursé sur le portefeuille de votre choix (moins les frais). Assurez-vous d\'avoir un portefeuille prêt à recevoir.',
			'maker.conflict.disputeDialog.actions.confirm' => 'Ouvrir un litige',
			'maker.conflict.disputeDialog.actions.cancel' => 'Annuler',
			'maker.conflict.feedback.disputeOpenedSuccess' => 'Litige ouvert avec succès. Le coordinateur l\'examinera.',
			'maker.conflict.errors.openingDispute' => ({required Object error}) => 'Erreur lors de l\'ouverture du litige : ${error}',
			'maker.conflict.nostrContact.title' => 'Contacter le coordinateur sur Nostr',
			'maker.conflict.nostrContact.description' => 'Vous pouvez envoyer un message privé au coordinateur pour obtenir de l\'aide sur ce litige.',
			'maker.conflict.nostrContact.copyNpub' => 'Copier le npub',
			'maker.conflict.nostrContact.openProfile' => 'Voir le profil',
			'maker.conflict.nostrContact.npubCopied' => 'npub du coordinateur copié dans le presse-papiers !',
			'maker.conflict.nostrContact.yourIdentityDescription' => 'Pour envoyer des messages privés, connectez-vous avec votre clé privée Neko (nsec) dans n\'importe quel client Nostr prenant en charge les messages directs.',
			'maker.conflict.nostrContact.manageNekoKeys' => 'Gérer les clés Neko',
			'maker.success.title' => 'Offre terminée',
			'maker.success.headline' => 'Paiement confirmé !',
			'maker.success.subtitle' => 'Le taker va maintenant être payé.',
			'maker.success.detailsTitle' => 'Détails de l\'offre :',
			'maker.success.duration' => ({required Object time}) => 'L\'offre a pris ${time} !',
			'taker.roleSelection.button' => ({required Object code}) => 'VENDRE un code ${code} contre des satoshi',
			'taker.progress.step1' => ({required Object code}) => 'Envoyer le ${code}',
			'taker.progress.step2' => ({required Object code}) => 'Confirmer le ${code}',
			'taker.progress.step3' => 'Être payé',
			'taker.submitBlik.generateInBank' => ({required Object bank}) => 'Générez le code de retrait dans votre application ${bank}.',
			'taker.submitBlik.title' => ({required Object code, required Object digits}) => 'Saisissez le ${code} à ${digits} chiffres',
			'taker.submitBlik.label' => ({required Object code}) => 'Code ${code}',
			'taker.submitBlik.instruction' => ({required Object code}) => 'Saisissez le ${code} avant la fin du délai...',
			'taker.submitBlik.timeLimit' => ({required Object code, required Object seconds}) => 'Saisissez le ${code} dans les : ${seconds} s',
			'taker.submitBlik.timeExpired' => ({required Object code}) => 'Le délai pour saisir le code ${code} a expiré.',
			'taker.submitBlik.actions.submit' => ({required Object code}) => 'Envoyer le ${code}',
			'taker.submitBlik.feedback.pasted' => ({required Object code}) => 'Code ${code} collé.',
			'taker.submitBlik.validation.invalidFormat' => ({required Object code, required Object digits}) => 'Saisissez un code ${code} valide à ${digits} chiffres.',
			'taker.submitBlik.errors.submitting' => ({required Object code, required Object details}) => 'Erreur lors de l\'envoi du code ${code} : ${details}',
			'taker.submitBlik.errors.clipboardInvalid' => ({required Object code, required Object digits}) => 'Le presse-papiers ne contient pas de code ${code} valide à ${digits} chiffres.',
			'taker.submitBlik.errors.stateChanged' => 'Erreur : l\'état de l\'offre a changé.',
			'taker.submitBlik.errors.stateNotValid' => 'Erreur : l\'état de l\'offre n\'est plus valide.',
			'taker.submitBlik.errors.fetchedIdMismatch' => ({required Object fetchedId, required Object initialId}) => 'L\'ID de l\'offre active récupérée (${fetchedId}) ne correspond pas à l\'ID initial (${initialId}). Incohérence d\'état ?',
			'taker.submitBlik.errors.paymentHashMissing' => 'Hash de paiement de l\'offre manquant après récupération.',
			'taker.submitBlik.details.requestedAmount' => ({required Object code}) => 'Montant ${code} demandé',
			'taker.submitBlik.details.exchangeRate' => 'Taux de change',
			'taker.submitBlik.details.takerFee' => 'Frais taker',
			'taker.submitBlik.details.status' => 'Statut',
			'taker.submitBlik.details.youllReceive' => 'Vous recevrez',
			'taker.criticalCodeDecision.title' => 'Décision critique',
			'taker.criticalCodeDecision.explanation' => ({required Object code}) => 'Vous avez déjà communiqué un code ${code} au maker. Continuer peut remplacer ce code, mettre fin à votre réservation et rouvrir l’offre à d’autres takers.',
			'taker.criticalCodeDecision.warningTitle' => 'VOUS RISQUEZ DE PERDRE VOS FONDS',
			'taker.criticalCodeDecision.warningBody' => ({required Object code}) => 'Si votre banque a débité le paiement ${code}, NE continuez PAS. Le maker a peut-être utilisé votre code et, après cette action, le coordinateur pourrait ne plus pouvoir garantir le versement de vos bitcoins.',
			'taker.criticalCodeDecision.actions.cancel' => 'Retourner vérifier ma banque',
			'taker.criticalCodeDecision.actions.proceed' => 'Je n’ai PAS été débité — continuer',
			'taker.conflict.title' => 'Confirmation du paiement en attente',
			'taker.conflict.headline' => 'En attente de la confirmation du maker',
			'taker.conflict.body' => ({required Object code}) => 'Vous avez signalé que le paiement ${code} a été débité, mais le maker a indiqué qu\'il avait échoué. Ces déclarations sont contradictoires.',
			'taker.conflict.instructions' => 'Le maker doit maintenant confirmer le résultat. S\'il confirme que le paiement a réussi, votre versement continuera. S\'il confirme l\'échec, ou si le délai expire, l\'offre passera en litige formel et le chat du litige deviendra disponible.',
			'taker.conflict.timeoutLabel' => ({required Object time}) => 'Ouverture automatique du litige formel dans ${time}',
			'taker.conflict.actions.back' => 'Retour à l\'accueil',
			'taker.conflict.feedback.reported' => 'Conflit de paiement signalé. En attente de la confirmation du maker.',
			'taker.conflict.errors.reporting' => ({required Object details}) => 'Erreur lors du signalement du conflit : ${details}',
			'taker.dispute.headline' => 'Litige formel ouvert',
			'taker.dispute.body' => 'L\'offre est maintenant examinée par le coordinateur. Utilisez le chat du litige ci-dessous pour communiquer avec le coordinateur et fournir les justificatifs demandés.',
			'twint.scanner.title' => ({required Object code}) => 'Scanner le code ${code}',
			'twint.scanner.status.align' => ({required Object code}) => 'Alignez le QR ${code} et le texte du montant dans le cadre de la caméra.',
			'twint.scanner.status.notRecognized' => ({required Object code}) => 'Le code ${code} n\'est pas encore reconnu. Gardez le QR et le montant visibles, ou remplissez le formulaire manuellement.',
			'twint.scanner.status.amountFailed' => 'Le scan caméra n\'a pas pu extraire le montant. Vous pouvez quand même utiliser le résultat du QR et corriger les champs manuellement.',
			'twint.flow.progress.step1' => '1. Créer l\'offre',
			'twint.flow.progress.step2' => '2. Attendre un taker',
			'twint.flow.progress.step3' => '3. Confirmer',
			_ => null,
		} ?? switch (path) {
			'twint.flow.takerProgress.step1' => ({required Object code}) => '1. Payer ${code}',
			'twint.flow.takerProgress.step2' => '2. Recevoir des sats',
			'twint.flow.makerWait.takerPaying' => 'Le taker est en train de payer',
			'twint.flow.makerWait.yourCode' => ({required Object code}) => 'Votre code ${code}',
			'twint.flow.makerWait.offerExpires' => ({required Object code}) => 'Le ${code} expire',
			'twint.flow.makerWait.autoExpires' => 'Expire automatiquement',
			'twint.flow.makerWait.codeExpiresIn' => ({required Object code}) => '${code} expirera dans...',
			'twint.flow.makerWait.cancelOffer' => 'Annuler l\'offre',
			'twint.flow.makerWait.reservedInfo' => ({required Object code}) => 'Un taker a réservé votre offre et paie maintenant votre code ${code} dans son application bancaire. Dès que le paiement arrive chez votre commerçant, confirmez-le ci-dessous.',
			'twint.flow.makerWait.confirmReceived' => 'Confirmer le paiement reçu',
			'twint.flow.makerWait.confirmDialog.title' => 'Confirmer le paiement reçu ?',
			'twint.flow.makerWait.confirmDialog.content' => ({required Object code}) => 'Ne confirmez que si vous êtes ABSOLUMENT sûr que le paiement ${code} a bien été reçu chez votre commerçant.\n\nLa confirmation règle la facture Lightning et envoie immédiatement les sats au taker — c\'est irréversible.',
			'twint.flow.makerWait.confirmDialog.cancel' => 'Annuler',
			'twint.flow.makerWait.confirmDialog.confirmButton' => 'Oui, paiement reçu',
			'twint.flow.makerExpired.title' => ({required Object code}) => '${code} probablement expiré',
			'twint.flow.makerExpired.warning' => ({required Object code}) => 'Le code ${code} a probablement expiré — mais le taker a peut-être quand même réussi à le payer. Vérifiez chez votre commerçant : vous disposez du temps ci-dessous pour confirmer le paiement.',
			'twint.flow.makerExpired.timerCaption' => 'Temps pour confirmer',
			'twint.flow.makerExpired.disputeHint' => 'Vous pouvez aussi laisser le minuteur expirer. Si le taker déclare avoir payé, cela devient un conflit/litige où les deux parties devront fournir des preuves au coordinateur pour résoudre le problème.',
			'twint.flow.makerVerify.title' => 'Avez-vous reçu le paiement ?',
			'twint.flow.makerVerify.body' => ({required Object amount, required Object code}) => 'Le taker indique avoir payé ${amount} sur votre code ${code}.',
			'twint.flow.makerVerify.hint' => 'Vérifiez le statut du paiement auprès de votre commerçant (terminal de magasin ou transaction en ligne). En cas de doute, attendez et revérifiez plus tard avant de décider.',
			'twint.flow.makerVerify.autoConfirms' => 'Confirme automatiquement',
			'twint.flow.makerVerify.confirmReceived' => 'Confirmer la réception',
			'twint.flow.makerVerify.openDispute' => 'Ouvrir un litige',
			'twint.flow.makerRecode.title' => 'Offre expirée',
			'twint.flow.makerRecode.body' => ({required Object code}) => 'Aucun taker n\'a terminé l\'échange. Saisissez un nouveau code ${code} pour republier cette offre, ou annulez-la.',
			'twint.flow.makerRecode.scanCardTitle' => ({required Object code}) => 'Scanner le nouveau QR ${code}',
			'twint.flow.makerRecode.scanCardBody' => 'Pointez la caméra vers l\'écran de paiement. L\'app préremplira le nouveau code — le montant reste le même.',
			'twint.flow.makerRecode.fieldLabel' => ({required Object code}) => 'Nouveau code ${code}',
			'twint.flow.makerRecode.autoCancels' => 'Annule automatiquement',
			'twint.flow.makerRecode.relist' => 'Republier avec un nouveau code',
			'twint.flow.makerRecode.cancelOffer' => 'Annuler l\'offre',
			'twint.flow.takerPay.title' => ({required Object code}) => 'Payer avec ${code}',
			'twint.flow.takerPay.body' => ({required Object code, required Object amount}) => 'Ouvrez votre application ${code} et payez ${amount} avec :',
			'twint.flow.takerPay.codeExpires' => 'Le code expire',
			'twint.flow.takerPay.paid' => 'J\'ai payé',
			'twint.flow.takerPay.cancel' => 'Annuler',
			'twint.flow.takerWait.title' => 'En attente du maker',
			'twint.flow.takerWait.body' => ({required Object code}) => 'Le maker vérifie si votre paiement ${code} est arrivé chez son commerçant. Il doit confirmer la réception ou ouvrir un litige.',
			'twint.flow.takerWait.info' => 'Si le maker n\'agit pas avant l\'expiration du minuteur, le paiement se confirme automatiquement et vous recevrez vos sats.',
			'twint.flow.takerWait.autoConfirms' => 'Confirme automatiquement',
			'twint.flow.takerExpired.title' => ({required Object code}) => '${code} probablement expiré',
			'twint.flow.takerExpired.warning' => ({required Object code}) => 'Le code ${code} a probablement expiré. Vous devez maintenant prendre une décision importante — choisissez avec soin.',
			'twint.flow.takerExpired.optionPaid' => ({required Object code}) => 'Si vous AVEZ payé le code ${code} dans votre application bancaire, marquez-le comme payé. Cela vous engage : le maker devra confirmer pour débloquer le bitcoin, ou ouvrir un litige où les deux parties fourniront des preuves au coordinateur.',
			'twint.flow.takerExpired.optionCancel' => 'Si vous n\'avez PAS payé, annulez la réservation. C\'est irréversible — si le paiement est en fait passé, le coordinateur ne pourra plus garantir vos sats.',
			'twint.flow.takerExpired.noDecision' => ({required Object code}) => 'Si vous ne prenez aucune décision avant la fin du minuteur, le coordinateur supposera que vous n\'avez PAS payé le code ${code}. Le maker pourra alors annuler l\'offre — annulant la facture bloquée — après quoi le coordinateur ne pourra plus vous régler les sats, même si vous avez payé.',
			'twint.flow.takerExpired.timerCaption' => 'Temps pour décider',
			'twint.flow.takerExpired.markPaid' => ({required Object code}) => 'J\'ai payé le code ${code}',
			'twint.flow.takerExpired.cancel' => 'Annuler la réservation',
			'twint.flow.takerExpired.markPaidDialog.title' => 'Confirmer le paiement ?',
			'twint.flow.takerExpired.markPaidDialog.content' => ({required Object code}) => 'Ne continuez que si vous êtes sûr que le paiement ${code} a été débité dans votre application bancaire.\n\nLe maker devra confirmer la réception pour débloquer le bitcoin. S\'il la conteste, un litige est ouvert et les deux parties devront fournir des preuves au coordinateur.',
			'twint.flow.takerExpired.markPaidDialog.cancel' => 'Retour',
			'twint.flow.takerExpired.markPaidDialog.confirmButton' => 'Oui, j\'ai payé',
			'twint.flow.takerExpired.cancelDialog.title' => 'Annuler la réservation ?',
			'twint.flow.takerExpired.cancelDialog.content' => ({required Object code}) => 'N\'annulez que si vous n\'avez PAS payé le code ${code}.\n\nC\'est définitif : si le paiement est en fait passé, le coordinateur ne pourra PAS garantir que vous recevrez les sats.',
			'twint.flow.takerExpired.cancelDialog.cancel' => 'Retour',
			'twint.flow.takerExpired.cancelDialog.confirmButton' => 'Oui, annuler',
			'twint.waitConfirmation.title' => 'En attente du maker',
			'twint.waitConfirmation.statusLabel' => ({required Object status}) => 'Statut de l\'offre : ${status}',
			'twint.waitConfirmation.waitingMaker' => ({required Object seconds}) => 'En attente de la confirmation du maker : ${seconds} s',
			'twint.waitConfirmation.waitingMakerConfirmation' => ({required Object code, required Object seconds}) => 'En attente que le maker confirme que le ${code} est correct. Temps restant : ${seconds}s',
			'twint.waitConfirmation.importantNotice' => ({required Object code, required Object amount, required Object currency}) => 'TRÈS IMPORTANT : assurez-vous de n\'accepter qu\'une confirmation ${code} de ${amount} ${currency}',
			'twint.waitConfirmation.importantBlikAmountConfirmation' => ({required Object code, required Object amount, required Object currency}) => 'TRÈS IMPORTANT : dans votre application bancaire, assurez-vous de confirmer un paiement ${code} d\'exactement ${amount} ${currency}.',
			'twint.waitConfirmation.instructions' => ({required Object minutes, required Object code}) => 'Le maker doit maintenant le saisir dans le terminal de paiement dans les ${minutes} minutes. Vous devrez ensuite accepter le code ${code} dans votre application bancaire.',
			'twint.waitConfirmation.instructionsNoConfirm' => ({required Object code, required Object minutes}) => 'Le maker doit maintenant saisir votre code ${code} au distributeur dans les ${minutes} minutes.',
			'twint.waitConfirmation.categoryReminder.atm' => 'Rappel offre distributeur : votre banque peut encore vous demander d\'approuver des frais de distributeur supplémentaires en plus du montant principal.',
			'twint.waitConfirmation.categoryReminder.ecommerce' => 'Rappel commande en ligne : si le commerçant envoie un remboursement automatique sur votre compte bancaire, contactez le coordinateur et restituez-le.',
			'twint.waitConfirmation.waitingForMakerToReceive' => ({required Object code}) => 'En attente que le maker reçoive votre code ${code}...',
			'twint.waitConfirmation.makerReceivedBlik' => ({required Object code}) => 'Le maker a reçu votre code ${code}.',
			'twint.waitConfirmation.timerExpiredMessage' => ({required Object minutes, required Object code}) => 'Le délai d\'expiration de ${minutes} min du ${code} est passé. En attente que le maker confirme ou marque le code comme invalide.',
			'twint.waitConfirmation.timerExpiredActions' => ({required Object minutes, required Object code}) => 'Le délai d\'expiration de ${minutes} min du ${code} est passé mais le maker n\'a pas reçu le code ${code}. Vous pouvez renvoyer un nouveau code ${code} ou annuler.',
			'twint.waitConfirmation.resendBlikButton' => ({required Object code}) => 'Renvoyer un nouveau code ${code}',
			'twint.waitConfirmation.navigatedHome' => 'Retour à l\'accueil.',
			'twint.waitConfirmation.expiredTitle' => ({required Object code}) => 'Code ${code} expiré',
			'twint.waitConfirmation.expiredWarning' => ({required Object code}) => 'Le maker n\'a pas reçu le code ${code}, il n\'a donc pas pu l\'utiliser.',
			'twint.waitConfirmation.expiredRelistCountdownLabel' => 'La réservation se termine dans',
			'twint.waitConfirmation.expiredSentWarning' => 'Le maker n\'a pas encore confirmé le paiement. Que souhaitez-vous faire ?',
			'twint.waitConfirmation.expiredInstruction1' => ({required Object code}) => 'Si vous voulez réessayer avec un nouveau code ${code}, renouvelez la réservation.',
			'twint.waitConfirmation.expiredInstruction2' => 'Si vous ne souhaitez plus effectuer cette transaction, annulez la réservation.',
			'twint.waitConfirmation.expiredInstruction3' => ({required Object code}) => 'Si le paiement ${code} a été débité de votre compte bancaire, pas d\'inquiétude : les bitcoins sont toujours verrouillés en sécurité chez le coordinateur.',
			'twint.waitConfirmation.takerCharged.title' => ({required Object code}) => 'Vous avez marqué le ${code} comme débité',
			'twint.waitConfirmation.takerCharged.message' => ({required Object minutes}) => 'Le maker a ${minutes} min pour confirmer ou contester le paiement. S\'il ne fait rien, le paiement sera confirmé automatiquement et vous recevrez les bitcoins.',
			'twint.waitConfirmation.expiredActions.reportConflict' => ({required Object code}) => 'Le ${code} a été débité de mon compte bancaire',
			'twint.waitConfirmation.expiredActions.renewReservation' => ({required Object code}) => 'Réessayer avec un nouveau code ${code}',
			'twint.waitConfirmation.expiredActions.cancelReservation' => 'Annuler la réservation',
			'twint.waitConfirmation.feedback.makerConfirmed' => 'Le maker a confirmé le paiement.',
			'twint.waitConfirmation.feedback.paymentSuccessful' => 'Paiement réussi ! Vous recevrez les fonds sous peu.',
			'twint.waitConfirmation.feedback.conflictReported' => 'Conflit signalé. Le coordinateur examinera la situation.',
			'twint.waitConfirmation.errors.invalidOfferStateReceived' => 'Offre reçue avec un état invalide pour cet écran. Réinitialisation.',
			'twint.waitConfirmation.errors.reportingConflict' => ({required Object details}) => 'Erreur lors du signalement du conflit : ${details}',
			'twint.paymentProcess.title' => 'Processus de paiement',
			'twint.paymentProcess.waitingForOfferUpdate' => 'En attente de la mise à jour du statut de l\'offre...',
			'twint.paymentProcess.states.preparing' => 'Préparation de l\'envoi du paiement...',
			'twint.paymentProcess.states.sending' => 'Envoi du paiement...',
			'twint.paymentProcess.states.received' => 'Paiement reçu !',
			'twint.paymentProcess.states.failed' => 'Paiement échoué',
			'twint.paymentProcess.states.waitingUpdate' => 'En attente de la mise à jour de l\'offre...',
			'twint.paymentProcess.steps.makerConfirmedBlik' => ({required Object code}) => 'Le maker a confirmé le paiement ${code}',
			'twint.paymentProcess.steps.makerInvoiceSettled' => 'Facture hold du maker réglée',
			'twint.paymentProcess.steps.takerInvoicePaid' => 'Paiement de votre facture Lightning',
			'twint.paymentProcess.steps.takerPaymentFailed' => 'Le paiement vers votre facture a échoué',
			'twint.paymentProcess.errors.sending' => ({required Object details}) => 'Erreur lors de l\'envoi du paiement : ${details}',
			'twint.paymentProcess.errors.notConfirmed' => 'Offre non confirmée par le maker.',
			'twint.paymentProcess.errors.expired' => 'Offre expirée.',
			'twint.paymentProcess.errors.cancelled' => 'Offre annulée.',
			'twint.paymentProcess.errors.paymentFailed' => 'Le paiement de l\'offre a échoué.',
			'twint.paymentProcess.errors.unknown' => 'Erreur d\'offre inconnue.',
			'twint.paymentProcess.errors.takerPaymentFailed' => 'Le paiement vers votre facture Lightning a échoué.',
			'twint.paymentProcess.errors.noPublicKey' => 'Erreur : impossible de récupérer votre clé publique.',
			'twint.paymentProcess.errors.loadingPublicKey' => 'Erreur lors du chargement de vos données',
			'twint.paymentProcess.errors.missingPaymentHash' => 'Erreur : détails de paiement manquants.',
			'twint.paymentProcess.loading.publicKey' => 'Chargement de vos données...',
			'twint.paymentProcess.actions.goToFailureDetails' => 'Réessayer avec une nouvelle facture',
			'twint.paymentFailed.title' => 'Paiement échoué',
			'twint.paymentFailed.instructions' => ({required Object netAmount}) => 'Veuillez fournir une nouvelle facture Lightning de ${netAmount}',
			'twint.paymentFailed.form.newInvoiceLabel' => 'Nouvelle facture Lightning',
			'twint.paymentFailed.form.newInvoiceHint' => 'Saisissez votre facture BOLT11',
			'twint.paymentFailed.actions.retryPayment' => 'Soumettre la nouvelle facture',
			'twint.paymentFailed.errors.enterValidInvoice' => 'Veuillez saisir une facture valide',
			'twint.paymentFailed.errors.updatingInvoice' => ({required Object details}) => 'Erreur lors de la mise à jour de la facture : ${details}',
			'twint.paymentFailed.errors.paymentRetryFailed' => 'Nouvelle tentative de paiement échouée. Veuillez vérifier la facture ou réessayer plus tard.',
			'twint.paymentFailed.errors.takerPublicKeyNotFound' => 'Clé publique du taker introuvable.',
			'twint.paymentFailed.errors.generateFailed' => ({required Object details}) => 'Impossible de générer la facture : ${details}',
			'twint.paymentFailed.walletSection.title' => 'Générer une facture depuis le portefeuille',
			'twint.paymentFailed.walletSection.defaultLabel' => 'par défaut',
			'twint.paymentFailed.walletSection.tapToGenerate' => ({required Object amountSats}) => 'Touchez pour générer une facture de ${amountSats}',
			'twint.paymentFailed.loading.processingPayment' => 'Traitement de votre nouvelle tentative de paiement...',
			'twint.paymentFailed.success.title' => 'Paiement réussi',
			'twint.paymentFailed.success.message' => 'Votre paiement a été traité avec succès.',
			'twint.paymentSuccess.title' => 'Paiement réussi',
			'twint.paymentSuccess.message' => 'Votre paiement a été traité avec succès.',
			'twint.paymentSuccess.actions.goHome' => 'Aller à l\'accueil',
			'twint.invalidBlik.title' => ({required Object code}) => 'Code ${code} invalide',
			'twint.invalidBlik.message' => ({required Object code}) => 'Le maker a rejeté le code ${code}',
			'twint.invalidBlik.explanation' => ({required Object code}) => 'Le créateur de l\'offre a indiqué que le code ${code} que vous avez fourni était invalide ou n\'a pas fonctionné.\n\nQue souhaitez-vous faire ?',
			'twint.invalidBlik.werentCharged' => 'Si vous n\'avez PAS été débité :',
			'twint.invalidBlik.wereCharged' => 'Si vous avez été débité :',
			'twint.invalidBlik.actions.retry' => ({required Object code}) => 'Envoyer un nouveau code ${code}',
			'twint.invalidBlik.actions.cancelReservation' => 'Annuler la transaction',
			'twint.invalidBlik.actions.reportConflict' => 'Ouvrir un litige',
			'twint.invalidBlik.actions.returnHome' => 'Retour à l\'accueil',
			'twint.invalidBlik.confirmDialog.title' => 'Êtes-vous sûr ?',
			'twint.invalidBlik.confirmDialog.content' => 'Une fois que vous aurez appuyé, il n\'y aura pas de retour en arrière.\n\nSi le montant a BEL ET BIEN été débité de votre compte bancaire, le coordinateur ne pourra PAS garantir que vous recevrez les bitcoins, et vous pourriez perdre vos fonds.\n\nEn cas de doute, mieux vaut attendre un peu et vérifier que vous n\'avez PAS été débité avant de continuer.',
			'twint.invalidBlik.confirmDialog.actions.proceed' => 'Je suis sûr, continuer',
			'twint.invalidBlik.confirmDialog.actions.cancel' => 'Annuler',
			'twint.invalidBlik.disputeConfirmDialog.title' => 'Ouvrir un litige ?',
			'twint.invalidBlik.disputeConfirmDialog.content' => 'N\'ouvrez un litige que si le montant a BEL ET BIEN été débité de votre compte bancaire.\n\nLe coordinateur examinera votre cas manuellement, ce qui prend du temps. Vous devrez fournir une preuve de paiement.',
			'twint.invalidBlik.disputeConfirmDialog.actions.proceed' => 'Oui, j\'ai été débité',
			'twint.invalidBlik.disputeConfirmDialog.actions.cancel' => 'Annuler',
			'twint.invalidBlik.feedback.conflictReportedSuccess' => 'Conflit signalé. Le coordinateur l\'examinera.',
			'twint.invalidBlik.errors.reservationFailed' => 'Échec de la nouvelle réservation de l\'offre',
			'twint.invalidBlik.errors.conflictReport' => ({required Object details}) => 'Erreur lors du signalement du conflit : ${details}',
			'twint.conflict.title' => 'Conflit sur l\'offre',
			'twint.conflict.headline' => 'Conflit sur l\'offre signalé',
			'twint.conflict.body' => ({required Object code}) => 'Le maker a marqué le code ${code} comme invalide, mais vous avez signalé un conflit, indiquant que vous estimez que le paiement a réussi.',
			'twint.conflict.instructions' => 'Attendez que le coordinateur examine la situation. Des détails supplémentaires pourront vous être demandés. Revenez plus tard ou contactez le support si nécessaire.',
			'twint.conflict.actions.back' => 'Retour à l\'accueil',
			'twint.conflict.feedback.reported' => 'Conflit signalé. Le coordinateur l\'examinera.',
			'twint.conflict.errors.reporting' => ({required Object details}) => 'Erreur lors du signalement du conflit : ${details}',
			'twint.conflict.nostrContact.title' => 'Contacter le coordinateur sur Nostr',
			'twint.conflict.nostrContact.description' => 'Vous pouvez envoyer un message privé au coordinateur pour obtenir de l\'aide sur ce litige.',
			'twint.conflict.nostrContact.copyNpub' => 'Copier le npub',
			'twint.conflict.nostrContact.openProfile' => 'Voir le profil',
			'twint.conflict.nostrContact.npubCopied' => 'npub du coordinateur copié dans le presse-papiers !',
			'twint.conflict.nostrContact.yourIdentityDescription' => 'Pour envoyer des messages privés, connectez-vous avec votre clé privée Neko (nsec) dans n\'importe quel client Nostr prenant en charge les messages directs.',
			'twint.conflict.nostrContact.manageNekoKeys' => 'Gérer les clés Neko',
			'blik.instructions.taker' => ({required Object code}) => 'Dès que le maker saisit le code ${code}, vous devrez confirmer le paiement dans votre application bancaire. Vérifiez que le montant est correct avant de confirmer.',
			'home.notifications.title' => 'Soyez notifié des nouvelles offres via :',
			'home.notifications.telegram' => 'Telegram',
			'home.notifications.simplex' => 'SimpleX',
			'home.notifications.matrix' => 'Matrix',
			'home.notifications.signal' => 'Signal',
			'home.notifications.channelAllBanks' => '(toutes les banques)',
			'home.notifications.channelForBankPrefix' => '(uniquement les offres pour ',
			'home.notifications.channelForBankSuffix' => ')',
			'home.notifications.scopeAllBanks' => 'Toutes les banques',
			'home.notifications.scopeBankOnly' => ({required Object bank}) => '${bank} uniquement',
			'home.statistics.title' => 'Offres terminées',
			'home.statistics.lifetimeCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Total : ${count} transactions\nAttente moyenne du ${code} : ${avgBlikTime}\nDurée moyenne de finalisation : ${avgPaidTime}',
			'home.statistics.last7DaysCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => '7 derniers jours : ${count} transactions\nAttente moyenne du ${code} : ${avgBlikTime}\nDurée moyenne de finalisation : ${avgPaidTime}',
			'home.statistics.last7DaysSingleLine' => ({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => '7 derniers jours : ${count} offres  |  Réservation moy. : ${avgReservationTime}  |  Paiement moy. : ${avgPaidTime}',
			'home.statistics.errors.loading' => ({required Object error}) => 'Erreur lors du chargement des statistiques : ${error}',
			'nekoInfo.title' => 'Qu\'est-ce qu\'un Neko ?',
			'nekoInfo.description' => ({required Object app}) => 'Votre Neko est votre identité pour utiliser ${app}. Il est composé d\'une clé privée et d\'une clé publique pour garantir une communication cryptographiquement sécurisée avec le coordinateur.\n\nPour plus d\'anonymat, il est recommandé d\'utiliser un nouveau Neko pour chaque offre.\n\n⚠️ IMPORTANT : votre clé privée n\'est stockée que sur votre appareil (côté client). Il est essentiel de sauvegarder votre clé privée, car en perdre l\'accès peut vous empêcher de résoudre des litiges et de récupérer vos fonds.',
			'nekoInfo.backupWarning' => 'Pensez à sauvegarder votre Neko',
			'generateNewKey.title' => 'Nouveau',
			'generateNewKey.description' => 'Voulez-vous vraiment générer un nouveau Neko ? Votre Neko actuel sera perdu pour toujours si vous ne l\'avez pas sauvegardé.',
			'generateNewKey.buttons.generate' => 'Générer',
			'generateNewKey.errors.activeOffer' => 'Vous ne pouvez pas générer un nouveau Neko tant que vous avez une offre active.',
			'generateNewKey.errors.failed' => 'Impossible de générer un nouveau Neko',
			'generateNewKey.feedback.success' => 'Nouveau Neko généré avec succès !',
			'generateNewKey.tooltips.generate' => 'Générer un nouveau Neko',
			'backup.title' => 'Sauvegarde',
			'backup.description' => 'Ceci est votre clé privée. Elle sécurise la communication avec le coordinateur. Ne la révélez jamais à personne. Sauvegardez-la en lieu sûr pour éviter tout problème en cas de litige.',
			'backup.feedback.copied' => 'Clé privée copiée dans le presse-papiers !',
			'backup.tooltips.backup' => 'Sauvegarder le Neko',
			'restore.title' => 'Restaurer',
			'restore.labels.privateKey' => 'Clé privée',
			'restore.buttons.restore' => 'Restaurer',
			'restore.errors.invalidKey' => 'Doit être une chaîne hexadécimale de 64 caractères.',
			'restore.errors.failed' => 'Échec de la restauration',
			'restore.feedback.success' => 'Neko restauré avec succès ! L\'application va redémarrer.',
			'restore.tooltips.restore' => 'Restaurer le Neko',
			'system.loadingPublicKey' => 'Chargement de votre clé publique...',
			'system.errors.generic' => 'Une erreur inattendue s\'est produite. Veuillez réessayer.',
			'system.errors.loadingTimeoutConfig' => 'Erreur lors du chargement de la configuration des délais.',
			'system.errors.loadingCoordinatorConfig' => 'Erreur lors du chargement de la configuration du coordinateur. Veuillez réessayer.',
			'system.errors.noPublicKey' => 'Votre clé publique n\'est pas disponible. Impossible de continuer.',
			'system.errors.internalOfferIncomplete' => 'Erreur interne : les détails de l\'offre sont incomplets. Veuillez réessayer.',
			'system.errors.loadingPublicKey' => 'Erreur lors du chargement de votre clé publique. Veuillez redémarrer l\'application.',
			'system.blik.copied' => ({required Object code}) => 'Code ${code} copié dans le presse-papiers',
			'myOffers.title' => 'Mes offres',
			'myOffers.empty' => 'Aucune offre pour l\'instant.',
			'myOffers.unknownCoordinator' => 'Coordinateur inconnu',
			'myOffers.menuLabel' => 'Mes offres',
			'myOffers.filter.all' => 'Toutes',
			'myOffers.filter.active' => 'Actives',
			'myOffers.filter.completed' => 'Terminées',
			'myOffers.filter.failed' => 'Échouées',
			'myOffers.details.title' => 'Détails de l\'offre',
			'myOffers.details.notFound' => 'Offre introuvable.',
			'myOffers.details.amount' => 'Montant',
			'myOffers.details.fees' => 'Frais',
			'myOffers.details.sats' => 'Satoshis',
			'myOffers.details.maker' => 'Maker',
			'myOffers.details.taker' => 'Taker',
			'myOffers.details.yourFee' => 'Vos frais',
			'myOffers.details.makerFee' => 'Frais maker',
			'myOffers.details.takerFee' => 'Frais taker',
			'myOffers.details.coordinator' => 'Coordinateur',
			'myOffers.details.createdAt' => 'Créée',
			'myOffers.details.reservedAt' => 'Réservée',
			'myOffers.details.blikReceivedAt' => ({required Object code}) => '${code} envoyé',
			'myOffers.details.makerConfirmedAt' => 'Confirmée',
			'myOffers.details.settledAt' => 'Réglée',
			'myOffers.details.takerPaidAt' => 'Taker payé',
			'myOffers.details.id' => 'ID de l\'offre',
			'myOffers.details.paymentHash' => 'Hash de paiement',
			'myOffers.details.holdInvoice' => 'Facture hold',
			'myOffers.details.continueActiveOffer' => 'Reprendre l\'offre active',
			'myOffers.details.after' => ({required Object duration}) => 'après ${duration}',
			'landing.mainTitle' => ({required Object code}) => 'Votre passerelle ${code} ⇄ bitcoin',
			'landing.subtitle' => ({required Object code}) => 'Payez ou vendez votre code ${code} avec du bitcoin',
			'landing.partnership' => 'partenariat',
			'landing.actions.payBlik' => ({required Object code}) => 'Payer en ${code}',
			'landing.actions.payBlikSubtitle' => 'avec du bitcoin',
			'landing.actions.sellBlik' => 'Acheter du bitcoin',
			'landing.actions.sellBlikSubtitle' => ({required Object code}) => 'avec ${code}',
			'landing.actions.howItWorks' => 'Comment ça marche ?',
			'faq.screenTitle' => 'FAQ',
			'faq.tooltip' => 'FAQ',
			'settings.title' => 'Réglages',
			'settings.offerCreation.title' => 'Création d\'offres',
			'settings.offerCreation.defaultCategory' => 'Catégorie par défaut',
			'settings.offerCreation.defaultBank' => 'Banque par défaut',
			'settings.offerCreation.defaultBankNone' => 'Aucune (choisir par offre)',
			'settings.offerCreation.preferredCoordinator' => 'Coordinateur préféré',
			'settings.offerCreation.automaticCoordinator' => 'Le plus fiable',
			'settings.offerCreation.automaticCoordinatorDescription' => 'Choisit le coordinateur avec le meilleur historique, en combinant vos propres offres terminées et l\'activité globale du réseau.',
			'settings.offerCreation.cheapestCoordinator' => 'Le moins cher',
			'settings.offerCreation.cheapestCoordinatorDescription' => 'Choisit pour chaque offre le coordinateur disponible avec les frais maker les plus bas.',
			'settings.offerCreation.enablePremium' => 'Activer la tarification avec prime',
			'settings.offerCreation.enablePremiumDescription' => 'Affiche le curseur de prime lors de la création d\'offres maker.',
			'settings.offerCreation.defaultPremium' => 'Prime par défaut',
			'settings.offerCreation.defaultPremiumDisabled' => 'Activez la tarification avec prime pour définir une prime par défaut.',
			'settings.offerCreation.premiumPerCoordinatorNote' => 'Chaque coordinateur fixe sa propre prime maximale, votre valeur par défaut est donc plafonnée par le coordinateur utilisé pour une offre.',
			'settings.offerCreation.categoryOptions.shop' => 'Magasin, café ou restaurant',
			'settings.offerCreation.categoryOptions.atm' => 'Retrait au distributeur',
			'settings.offerCreation.categoryOptions.online' => 'Service/produit en ligne',
			'settings.offerCreation.dialogs.selectCategory' => 'Sélectionner la catégorie par défaut',
			'settings.offerCreation.dialogs.selectBank' => 'Sélectionner la banque par défaut',
			'settings.offerCreation.dialogs.selectCoordinator' => 'Sélectionner le coordinateur préféré',
			'settings.offerCreation.dialogs.premiumHint' => 'Saisissez un pourcentage comme 1.5. Les valeurs sont arrondies par pas de 0.5%.',
			'settings.offerCreation.dialogs.premiumHelper' => 'Appliquée lorsque la tarification avec prime est activée et plafonnée par le maximum du coordinateur sélectionné.',
			'settings.display.title' => 'Affichage',
			'settings.display.bitcoinUnit' => 'Unité bitcoin',
			'settings.display.bitcoinUnitDescription' => 'Choisissez comment les montants en bitcoin sont affichés dans l\'application.',
			'settings.display.unitOptions.sats' => 'sats',
			'settings.display.unitOptions.bitcoin' => '₿ (BIP-177)',
			'settings.paymentSystem.title' => 'Pays / Système de paiement',
			'settings.paymentSystem.subtitle' => 'Choisissez le système de paiement de votre pays.',
			'settings.paymentSystem.dialogTitle' => 'Sélectionner le système de paiement',
			'settings.paymentSystem.countries.PL' => 'Pologne',
			'settings.paymentSystem.countries.PT' => 'Portugal',
			'settings.paymentSystem.countries.CH' => 'Suisse',
			'settings.paymentSystem.countries.SK' => 'Slovaquie',
			'notificationSettings.title' => 'Notifications',
			'notificationSettings.androidOnly' => 'Les notifications en arrière-plan ne sont actuellement prises en charge que sur Android.',
			'notificationSettings.newOfferAlerts.label' => 'Alertes de nouvelles offres',
			'notificationSettings.newOfferAlerts.description' => ({required Object app}) => 'Lorsque cette option est activée, ${app} vous notifie des nouvelles offres disponibles auprès de vos coordinateurs activés pendant que l\'application est en arrière-plan. Cela peut être plus rapide que les messageries externes.',
			'onboarding.title' => 'Choisissez votre marché',
			'onboarding.subtitle' => 'Choisissez le pays et le système de paiement que vous utiliserez. Vous pouvez le changer à tout moment dans les Paramètres.',
			'wallet.title' => 'Portefeuille',
			'wallet.description' => 'Gérez les réglages de votre portefeuille Lightning',
			'wallet.missingReceiving.title' => 'Portefeuille de réception requis',
			'wallet.missingReceiving.message' => 'Aucun portefeuille configuré pour la réception. Ajoutez-en un dans les réglages du portefeuille pour accepter des offres.',
			'wallet.missingReceiving.openSettings' => 'Réglages du portefeuille',
			'wallet.details.title' => 'Détails du portefeuille',
			'wallet.details.pendingTitle' => 'Transactions en attente',
			'wallet.details.finishedTitle' => 'Transactions terminées',
			'nwc.title' => 'Nostr Wallet Connect (NWC)',
			'nwc.description' => 'Connectez votre portefeuille Lightning via NWC',
			'nwc.labels.connectionString' => 'Chaîne de connexion NWC',
			'nwc.labels.hint' => 'nostr+walletconnect://...',
			'nwc.labels.status' => 'État de la connexion',
			'nwc.labels.connected' => 'Connecté',
			'nwc.labels.disconnected' => 'Déconnecté',
			'nwc.labels.scanQrCode' => 'Scannez le QR code avec votre connexion NWC',
			'nwc.labels.balance' => 'Solde',
			'nwc.labels.budget' => 'Budget',
			'nwc.labels.usedBudget' => 'Utilisé',
			'nwc.labels.totalBudget' => 'Total',
			'nwc.labels.renewsIn' => 'Renouvellement dans',
			'nwc.labels.renewalPeriod' => 'Période de renouvellement',
			'nwc.labels.relay' => 'Relais',
			'nwc.labels.relays' => 'Relais',
			'nwc.prompts.enter' => 'Saisissez votre chaîne de connexion NWC',
			'nwc.prompts.connect' => 'Connecter le portefeuille',
			'nwc.prompts.disconnect' => 'Déconnecter',
			'nwc.prompts.confirmDisconnect' => 'Voulez-vous vraiment déconnecter votre portefeuille NWC ?',
			'nwc.prompts.pasteConnection' => 'Coller la chaîne de connexion',
			'nwc.prompts.chooseMethod' => 'Choisissez comment connecter votre portefeuille Lightning',
			'nwc.prompts.howToGet' => 'Vous n\'avez pas encore de connexion NWC ? Découvrez comment en obtenir une !',
			'nwc.prompts.learnMore' => 'En savoir plus sur NWC',
			'nwc.actions.connectAlbyGo' => 'Connecter avec Alby Go',
			'nwc.actions.connectNwc' => 'Scanner le QR code NWC',
			'nwc.feedback.connected' => 'Portefeuille NWC connecté avec succès !',
			'nwc.feedback.disconnected' => 'Portefeuille NWC déconnecté',
			'nwc.feedback.connecting' => 'Connexion au portefeuille NWC...',
			'nwc.feedback.loadingWalletInfo' => 'Chargement des informations du portefeuille...',
			'nwc.errors.connecting' => ({required Object details}) => 'Erreur de connexion à NWC : ${details}',
			'nwc.errors.disconnecting' => ({required Object details}) => 'Erreur de déconnexion de NWC : ${details}',
			'nwc.errors.invalid' => 'Chaîne de connexion NWC invalide',
			'nwc.errors.required' => 'La chaîne de connexion NWC est requise',
			'nwc.errors.loadingBalance' => 'Impossible de charger le solde du portefeuille',
			'nwc.errors.loadingBudget' => 'Impossible de charger le budget du portefeuille',
			'nwc.time.minutes' => ({required Object count}) => '${count} min',
			'nwc.time.hours' => ({required Object count}) => '${count} h',
			'nwc.time.days' => ({required Object count}) => '${count} j',
			'nwc.time.justNow' => 'à l\'instant',
			'nekoManagement.title' => 'Neko',
			'relays.title' => 'Relais',
			'relays.coordinatorRelays' => 'Relais du coordinateur',
			'relays.discoveryRelays' => 'Relais de découverte',
			'relays.status.connected' => 'Connecté',
			'relays.status.connecting' => 'Connexion',
			'relays.status.reconnecting' => 'Reconnexion',
			'relays.status.disconnected' => 'Déconnecté',
			'relays.popup.title' => ({required Object connected, required Object total}) => 'Relais (${connected}/${total} connectés)',
			'relays.popup.connectingMessage' => 'Connexion aux relais...',
			'offerNotifications.activeService.title' => 'En attente de nouvelles offres',
			'offerNotifications.activeService.body' => ({required Object app}) => 'Service Nostr surveillant les événements des offres ${app}.',
			'offerNotifications.funded.title' => 'Offre financée',
			'offerNotifications.funded.body' => 'Votre facture hold a été acceptée. L\'offre est maintenant en ligne.',
			'offerNotifications.reserved.title' => 'Offre réservée',
			'offerNotifications.reserved.body' => 'Un taker a réservé votre offre.',
			'offerNotifications.blikReady.title' => ({required Object code}) => 'Code ${code} prêt',
			'offerNotifications.blikReady.body' => ({required Object code}) => 'Votre code ${code} est prêt à être consulté.',
			'offerNotifications.newOffer.title' => 'Nouvelle offre disponible',
			'offerNotifications.newOffer.body' => ({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}',
			'offerNotifications.newOffer.premiumSuffix' => ({required Object percent}) => '+${percent}% de prime',
			'offerNotifications.categories.shop' => 'Magasin',
			'offerNotifications.categories.atm' => 'Distributeur',
			'offerNotifications.categories.online' => 'En ligne',
			'offerNotifications.blikPendingReminder.title' => ({required Object code}) => 'Le ${code} attend votre action',
			'offerNotifications.blikPendingReminder.body' => ({required Object code}) => 'Confirmez le paiement ou marquez le code ${code} comme invalide.',
			'offerNotifications.takerCharged.title' => ({required Object code}) => '${code} débité',
			'offerNotifications.takerCharged.body' => ({required Object code}) => 'Le taker signale que le ${code} a été débité. Confirmez ou marquez comme invalide.',
			'offerNotifications.invalidBlik.title' => ({required Object code}) => '${code} marqué invalide',
			'offerNotifications.invalidBlik.body' => ({required Object code}) => 'Le maker a marqué votre code ${code} comme invalide.',
			'offerNotifications.takerPaid.title' => 'Paiement reçu',
			'offerNotifications.takerPaid.body' => 'Votre paiement Lightning a été envoyé.',
			'altstore.dialogTitle' => 'AltStore non installé',
			'altstore.step1Title' => 'Téléchargez et installez AltStore PAL',
			'altstore.step1Button' => 'altstore.io/download',
			'altstore.step1Warning' => 'Vous avez besoin de Safari pour installer AltStore PAL !',
			'altstore.step2Title' => ({required Object app}) => 'Installer ${app}',
			'altstore.step2Button' => ({required Object app}) => 'Installer ${app}',
			'altstore.step2Fallback' => 'Toujours pas de succès ? Collez la source dans AltStore',
			_ => null,
		};
	}
}
