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
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$de app = _Translations$app$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$lightningAddress$de lightningAddress = _Translations$lightningAddress$de._(_root);
	@override late final _Translations$nfc$de nfc = _Translations$nfc$de._(_root);
	@override late final _Translations$offers$de offers = _Translations$offers$de._(_root);
	@override late final _Translations$reservations$de reservations = _Translations$reservations$de._(_root);
	@override late final _Translations$exchange$de exchange = _Translations$exchange$de._(_root);
	@override late final _Translations$coordinator$de coordinator = _Translations$coordinator$de._(_root);
	@override late final _Translations$maker$de maker = _Translations$maker$de._(_root);
	@override late final _Translations$taker$de taker = _Translations$taker$de._(_root);
	@override late final _Translations$twint$de twint = _Translations$twint$de._(_root);
	@override late final _Translations$blik$de blik = _Translations$blik$de._(_root);
	@override late final _Translations$home$de home = _Translations$home$de._(_root);
	@override late final _Translations$nekoInfo$de nekoInfo = _Translations$nekoInfo$de._(_root);
	@override late final _Translations$generateNewKey$de generateNewKey = _Translations$generateNewKey$de._(_root);
	@override late final _Translations$backup$de backup = _Translations$backup$de._(_root);
	@override late final _Translations$restore$de restore = _Translations$restore$de._(_root);
	@override late final _Translations$system$de system = _Translations$system$de._(_root);
	@override late final _Translations$myOffers$de myOffers = _Translations$myOffers$de._(_root);
	@override late final _Translations$landing$de landing = _Translations$landing$de._(_root);
	@override late final _Translations$faq$de faq = _Translations$faq$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
	@override late final _Translations$notificationSettings$de notificationSettings = _Translations$notificationSettings$de._(_root);
	@override late final _Translations$onboarding$de onboarding = _Translations$onboarding$de._(_root);
	@override late final _Translations$wallet$de wallet = _Translations$wallet$de._(_root);
	@override late final _Translations$nwc$de nwc = _Translations$nwc$de._(_root);
	@override late final _Translations$nekoManagement$de nekoManagement = _Translations$nekoManagement$de._(_root);
	@override late final _Translations$relays$de relays = _Translations$relays$de._(_root);
	@override late final _Translations$offerNotifications$de offerNotifications = _Translations$offerNotifications$de._(_root);
	@override late final _Translations$altstore$de altstore = _Translations$altstore$de._(_root);
}

// Path: app
class _Translations$app$de extends Translations$app$en {
	_Translations$app$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object app}) => '${app}';
	@override String get greeting => 'Hallo!';
	@override String get changelog => 'Änderungsprotokoll';
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$buttons$de buttons = _Translations$common$buttons$de._(_root);
	@override late final _Translations$common$labels$de labels = _Translations$common$labels$de._(_root);
	@override late final _Translations$common$notifications$de notifications = _Translations$common$notifications$de._(_root);
	@override late final _Translations$common$clipboard$de clipboard = _Translations$common$clipboard$de._(_root);
	@override late final _Translations$common$actions$de actions = _Translations$common$actions$de._(_root);
}

// Path: lightningAddress
class _Translations$lightningAddress$de extends Translations$lightningAddress$en {
	_Translations$lightningAddress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$lightningAddress$labels$de labels = _Translations$lightningAddress$labels$de._(_root);
	@override late final _Translations$lightningAddress$prompts$de prompts = _Translations$lightningAddress$prompts$de._(_root);
	@override late final _Translations$lightningAddress$feedback$de feedback = _Translations$lightningAddress$feedback$de._(_root);
	@override late final _Translations$lightningAddress$errors$de errors = _Translations$lightningAddress$errors$de._(_root);
}

// Path: nfc
class _Translations$nfc$de extends Translations$nfc$en {
	_Translations$nfc$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$nfc$actions$de actions = _Translations$nfc$actions$de._(_root);
	@override late final _Translations$nfc$prompts$de prompts = _Translations$nfc$prompts$de._(_root);
	@override late final _Translations$nfc$feedback$de feedback = _Translations$nfc$feedback$de._(_root);
	@override late final _Translations$nfc$errors$de errors = _Translations$nfc$errors$de._(_root);
}

// Path: offers
class _Translations$offers$de extends Translations$offers$en {
	_Translations$offers$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offers$details$de details = _Translations$offers$details$de._(_root);
	@override late final _Translations$offers$labels$de labels = _Translations$offers$labels$de._(_root);
	@override late final _Translations$offers$tooltips$de tooltips = _Translations$offers$tooltips$de._(_root);
	@override late final _Translations$offers$actions$de actions = _Translations$offers$actions$de._(_root);
	@override late final _Translations$offers$status$de status = _Translations$offers$status$de._(_root);
	@override late final _Translations$offers$statusMessages$de statusMessages = _Translations$offers$statusMessages$de._(_root);
	@override late final _Translations$offers$progress$de progress = _Translations$offers$progress$de._(_root);
	@override late final _Translations$offers$errors$de errors = _Translations$offers$errors$de._(_root);
	@override late final _Translations$offers$success$de success = _Translations$offers$success$de._(_root);
}

// Path: reservations
class _Translations$reservations$de extends Translations$reservations$en {
	_Translations$reservations$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reservations$actions$de actions = _Translations$reservations$actions$de._(_root);
	@override late final _Translations$reservations$feedback$de feedback = _Translations$reservations$feedback$de._(_root);
	@override late final _Translations$reservations$errors$de errors = _Translations$reservations$errors$de._(_root);
}

// Path: exchange
class _Translations$exchange$de extends Translations$exchange$en {
	_Translations$exchange$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$exchange$labels$de labels = _Translations$exchange$labels$de._(_root);
	@override late final _Translations$exchange$feedback$de feedback = _Translations$exchange$feedback$de._(_root);
	@override late final _Translations$exchange$errors$de errors = _Translations$exchange$errors$de._(_root);
}

// Path: coordinator
class _Translations$coordinator$de extends Translations$coordinator$en {
	_Translations$coordinator$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinatoren';
	@override late final _Translations$coordinator$info$de info = _Translations$coordinator$info$de._(_root);
	@override late final _Translations$coordinator$selector$de selector = _Translations$coordinator$selector$de._(_root);
	@override late final _Translations$coordinator$dialog$de dialog = _Translations$coordinator$dialog$de._(_root);
	@override late final _Translations$coordinator$details$de details = _Translations$coordinator$details$de._(_root);
	@override late final _Translations$coordinator$coldStart$de coldStart = _Translations$coordinator$coldStart$de._(_root);
	@override late final _Translations$coordinator$management$de management = _Translations$coordinator$management$de._(_root);
}

// Path: maker
class _Translations$maker$de extends Translations$maker$en {
	_Translations$maker$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$roleSelection$de roleSelection = _Translations$maker$roleSelection$de._(_root);
	@override late final _Translations$maker$amountForm$de amountForm = _Translations$maker$amountForm$de._(_root);
	@override late final _Translations$maker$payInvoice$de payInvoice = _Translations$maker$payInvoice$de._(_root);
	@override late final _Translations$maker$waitTaker$de waitTaker = _Translations$maker$waitTaker$de._(_root);
	@override late final _Translations$maker$waitForBlik$de waitForBlik = _Translations$maker$waitForBlik$de._(_root);
	@override late final _Translations$maker$confirmPayment$de confirmPayment = _Translations$maker$confirmPayment$de._(_root);
	@override late final _Translations$maker$invalidBlik$de invalidBlik = _Translations$maker$invalidBlik$de._(_root);
	@override late final _Translations$maker$conflict$de conflict = _Translations$maker$conflict$de._(_root);
	@override late final _Translations$maker$success$de success = _Translations$maker$success$de._(_root);
}

// Path: taker
class _Translations$taker$de extends Translations$taker$en {
	_Translations$taker$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$taker$roleSelection$de roleSelection = _Translations$taker$roleSelection$de._(_root);
	@override late final _Translations$taker$progress$de progress = _Translations$taker$progress$de._(_root);
	@override late final _Translations$taker$submitBlik$de submitBlik = _Translations$taker$submitBlik$de._(_root);
	@override late final _Translations$taker$criticalCodeDecision$de criticalCodeDecision = _Translations$taker$criticalCodeDecision$de._(_root);
}

// Path: twint
class _Translations$twint$de extends Translations$twint$en {
	_Translations$twint$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$twint$scanner$de scanner = _Translations$twint$scanner$de._(_root);
	@override late final _Translations$twint$flow$de flow = _Translations$twint$flow$de._(_root);
	@override late final _Translations$twint$waitConfirmation$de waitConfirmation = _Translations$twint$waitConfirmation$de._(_root);
	@override late final _Translations$twint$paymentProcess$de paymentProcess = _Translations$twint$paymentProcess$de._(_root);
	@override late final _Translations$twint$paymentFailed$de paymentFailed = _Translations$twint$paymentFailed$de._(_root);
	@override late final _Translations$twint$paymentSuccess$de paymentSuccess = _Translations$twint$paymentSuccess$de._(_root);
	@override late final _Translations$twint$invalidBlik$de invalidBlik = _Translations$twint$invalidBlik$de._(_root);
	@override late final _Translations$twint$conflict$de conflict = _Translations$twint$conflict$de._(_root);
}

// Path: blik
class _Translations$blik$de extends Translations$blik$en {
	_Translations$blik$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$blik$instructions$de instructions = _Translations$blik$instructions$de._(_root);
}

// Path: home
class _Translations$home$de extends Translations$home$en {
	_Translations$home$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$home$notifications$de notifications = _Translations$home$notifications$de._(_root);
	@override late final _Translations$home$statistics$de statistics = _Translations$home$statistics$de._(_root);
}

// Path: nekoInfo
class _Translations$nekoInfo$de extends Translations$nekoInfo$en {
	_Translations$nekoInfo$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Was ist ein Neko?';
	@override String description({required Object app}) => 'Dein Neko ist deine Identität für die Nutzung von ${app}. Er besteht aus einem privaten und einem öffentlichen Schlüssel, um eine kryptografisch sichere Kommunikation mit dem Koordinator zu gewährleisten.\n\nFür mehr Anonymität wird empfohlen, für jedes Angebot einen neuen, frischen Neko zu verwenden.\n\n⚠️ WICHTIG: Dein privater Schlüssel wird nur auf deinem Gerät gespeichert (clientseitig). Es ist äußerst wichtig, deinen privaten Schlüssel zu sichern, da du ohne ihn möglicherweise keine Streitfälle lösen und deine Gelder nicht wiederherstellen kannst.';
	@override String get backupWarning => 'Denke daran, deinen Neko zu sichern';
}

// Path: generateNewKey
class _Translations$generateNewKey$de extends Translations$generateNewKey$en {
	_Translations$generateNewKey$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neu';
	@override String get description => 'Bist du sicher, dass du einen neuen Neko generieren möchtest? Dein aktueller geht für immer verloren, wenn du ihn nicht gesichert hast.';
	@override late final _Translations$generateNewKey$buttons$de buttons = _Translations$generateNewKey$buttons$de._(_root);
	@override late final _Translations$generateNewKey$errors$de errors = _Translations$generateNewKey$errors$de._(_root);
	@override late final _Translations$generateNewKey$feedback$de feedback = _Translations$generateNewKey$feedback$de._(_root);
	@override late final _Translations$generateNewKey$tooltips$de tooltips = _Translations$generateNewKey$tooltips$de._(_root);
}

// Path: backup
class _Translations$backup$de extends Translations$backup$en {
	_Translations$backup$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sicherung';
	@override String get description => 'Dies ist dein privater Schlüssel. Er sichert die Kommunikation mit dem Koordinator. Gib ihn niemals an Dritte weiter. Sichere ihn an einem sicheren Ort, um Probleme bei Streitfällen zu vermeiden.';
	@override late final _Translations$backup$feedback$de feedback = _Translations$backup$feedback$de._(_root);
	@override late final _Translations$backup$tooltips$de tooltips = _Translations$backup$tooltips$de._(_root);
}

// Path: restore
class _Translations$restore$de extends Translations$restore$en {
	_Translations$restore$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wiederherstellen';
	@override late final _Translations$restore$labels$de labels = _Translations$restore$labels$de._(_root);
	@override late final _Translations$restore$buttons$de buttons = _Translations$restore$buttons$de._(_root);
	@override late final _Translations$restore$errors$de errors = _Translations$restore$errors$de._(_root);
	@override late final _Translations$restore$feedback$de feedback = _Translations$restore$feedback$de._(_root);
	@override late final _Translations$restore$tooltips$de tooltips = _Translations$restore$tooltips$de._(_root);
}

// Path: system
class _Translations$system$de extends Translations$system$en {
	_Translations$system$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loadingPublicKey => 'Dein öffentlicher Schlüssel wird geladen...';
	@override late final _Translations$system$errors$de errors = _Translations$system$errors$de._(_root);
	@override late final _Translations$system$blik$de blik = _Translations$system$blik$de._(_root);
}

// Path: myOffers
class _Translations$myOffers$de extends Translations$myOffers$en {
	_Translations$myOffers$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine Angebote';
	@override String get empty => 'Noch keine Angebote.';
	@override String get unknownCoordinator => 'Unbekannter Koordinator';
	@override String get menuLabel => 'Meine Angebote';
	@override late final _Translations$myOffers$filter$de filter = _Translations$myOffers$filter$de._(_root);
	@override late final _Translations$myOffers$details$de details = _Translations$myOffers$details$de._(_root);
}

// Path: landing
class _Translations$landing$de extends Translations$landing$en {
	_Translations$landing$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String mainTitle({required Object code}) => 'Deine ${code} ⇄ Bitcoin-Brücke';
	@override String subtitle({required Object code}) => 'Bezahle mit oder verkaufe deinen ${code}-Code für Bitcoin';
	@override String get partnership => 'Partnerschaft';
	@override late final _Translations$landing$actions$de actions = _Translations$landing$actions$de._(_root);
}

// Path: faq
class _Translations$faq$de extends Translations$faq$en {
	_Translations$faq$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'FAQ';
	@override String get tooltip => 'FAQ';
}

// Path: settings
class _Translations$settings$de extends Translations$settings$en {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override late final _Translations$settings$offerCreation$de offerCreation = _Translations$settings$offerCreation$de._(_root);
	@override late final _Translations$settings$display$de display = _Translations$settings$display$de._(_root);
	@override late final _Translations$settings$paymentSystem$de paymentSystem = _Translations$settings$paymentSystem$de._(_root);
}

// Path: notificationSettings
class _Translations$notificationSettings$de extends Translations$notificationSettings$en {
	_Translations$notificationSettings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Benachrichtigungen';
	@override String get androidOnly => 'Hintergrund-Benachrichtigungen werden derzeit nur auf Android unterstützt.';
	@override late final _Translations$notificationSettings$newOfferAlerts$de newOfferAlerts = _Translations$notificationSettings$newOfferAlerts$de._(_root);
}

// Path: onboarding
class _Translations$onboarding$de extends Translations$onboarding$en {
	_Translations$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wähle deinen Markt';
	@override String get subtitle => 'Wähle das Land und Zahlungssystem, das du verwenden wirst. Du kannst es jederzeit in den Einstellungen ändern.';
}

// Path: wallet
class _Translations$wallet$de extends Translations$wallet$en {
	_Translations$wallet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wallet';
	@override String get description => 'Verwalte deine Lightning-Wallet-Einstellungen';
	@override late final _Translations$wallet$missingReceiving$de missingReceiving = _Translations$wallet$missingReceiving$de._(_root);
	@override late final _Translations$wallet$incompatibleReceiving$de incompatibleReceiving = _Translations$wallet$incompatibleReceiving$de._(_root);
	@override late final _Translations$wallet$details$de details = _Translations$wallet$details$de._(_root);
}

// Path: nwc
class _Translations$nwc$de extends Translations$nwc$en {
	_Translations$nwc$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nostr Wallet Connect (NWC)';
	@override String get description => 'Verbinde deine Lightning-Wallet über NWC';
	@override late final _Translations$nwc$labels$de labels = _Translations$nwc$labels$de._(_root);
	@override late final _Translations$nwc$prompts$de prompts = _Translations$nwc$prompts$de._(_root);
	@override late final _Translations$nwc$actions$de actions = _Translations$nwc$actions$de._(_root);
	@override late final _Translations$nwc$feedback$de feedback = _Translations$nwc$feedback$de._(_root);
	@override late final _Translations$nwc$errors$de errors = _Translations$nwc$errors$de._(_root);
	@override late final _Translations$nwc$time$de time = _Translations$nwc$time$de._(_root);
}

// Path: nekoManagement
class _Translations$nekoManagement$de extends Translations$nekoManagement$en {
	_Translations$nekoManagement$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neko';
}

// Path: relays
class _Translations$relays$de extends Translations$relays$en {
	_Translations$relays$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Relays';
	@override String get coordinatorRelays => 'Koordinator-Relays';
	@override String get discoveryRelays => 'Discovery-Relays';
	@override late final _Translations$relays$status$de status = _Translations$relays$status$de._(_root);
	@override late final _Translations$relays$popup$de popup = _Translations$relays$popup$de._(_root);
}

// Path: offerNotifications
class _Translations$offerNotifications$de extends Translations$offerNotifications$en {
	_Translations$offerNotifications$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offerNotifications$activeService$de activeService = _Translations$offerNotifications$activeService$de._(_root);
	@override late final _Translations$offerNotifications$funded$de funded = _Translations$offerNotifications$funded$de._(_root);
	@override late final _Translations$offerNotifications$reserved$de reserved = _Translations$offerNotifications$reserved$de._(_root);
	@override late final _Translations$offerNotifications$blikReady$de blikReady = _Translations$offerNotifications$blikReady$de._(_root);
	@override late final _Translations$offerNotifications$newOffer$de newOffer = _Translations$offerNotifications$newOffer$de._(_root);
	@override late final _Translations$offerNotifications$categories$de categories = _Translations$offerNotifications$categories$de._(_root);
	@override late final _Translations$offerNotifications$blikPendingReminder$de blikPendingReminder = _Translations$offerNotifications$blikPendingReminder$de._(_root);
	@override late final _Translations$offerNotifications$takerCharged$de takerCharged = _Translations$offerNotifications$takerCharged$de._(_root);
	@override late final _Translations$offerNotifications$invalidBlik$de invalidBlik = _Translations$offerNotifications$invalidBlik$de._(_root);
	@override late final _Translations$offerNotifications$takerPaid$de takerPaid = _Translations$offerNotifications$takerPaid$de._(_root);
}

// Path: altstore
class _Translations$altstore$de extends Translations$altstore$en {
	_Translations$altstore$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'AltStore nicht installiert';
	@override String get step1Title => 'AltStore PAL herunterladen und installieren';
	@override String get step1Button => 'altstore.io/download';
	@override String get step1Warning => 'Du benötigst Safari, um AltStore PAL zu installieren!';
	@override String step2Title({required Object app}) => '${app} installieren';
	@override String step2Button({required Object app}) => '${app} installieren';
	@override String get step2Fallback => 'Funktioniert immer noch nicht? Füge die Quelle in AltStore ein';
}

// Path: common.buttons
class _Translations$common$buttons$de extends Translations$common$buttons$en {
	_Translations$common$buttons$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get done => 'Fertig';
	@override String get retry => 'Erneut versuchen';
	@override String get goHome => 'Zur Startseite';
	@override String get saveAndContinue => 'Speichern und fortfahren';
	@override String get reveal => 'Anzeigen';
	@override String get hide => 'Verbergen';
	@override String get copy => 'Kopieren';
	@override String get close => 'Schließen';
	@override String get restore => 'Wiederherstellen';
	@override String get faq => 'FAQ';
}

// Path: common.labels
class _Translations$common$labels$de extends Translations$common$labels$en {
	_Translations$common$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String amount({required Object currency}) => 'Betrag (${currency})';
	@override String status({required Object status}) => 'Status: ${status}';
	@override String role({required Object role}) => 'Rolle: ${role}';
}

// Path: common.notifications
class _Translations$common$notifications$de extends Translations$common$notifications$en {
	_Translations$common$notifications$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get success => 'Erfolg';
	@override String get error => 'Fehler';
	@override String get loading => 'Wird geladen...';
}

// Path: common.clipboard
class _Translations$common$clipboard$de extends Translations$common$clipboard$en {
	_Translations$common$clipboard$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get copyToClipboard => 'In Zwischenablage kopieren';
	@override String get pasteFromClipboard => 'Aus Zwischenablage einfügen';
	@override String get copied => 'In die Zwischenablage kopiert!';
}

// Path: common.actions
class _Translations$common$actions$de extends Translations$common$actions$en {
	_Translations$common$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancelAndReturnToOffers => 'Abbrechen und zu den Angeboten zurückkehren';
	@override String get cancelAndReturnHome => 'Abbrechen und zur Startseite zurückkehren';
}

// Path: lightningAddress.labels
class _Translations$lightningAddress$labels$de extends Translations$lightningAddress$labels$en {
	_Translations$lightningAddress$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get address => 'Lightning-Adresse (LNURL)';
	@override String get hint => 'benutzer@domain.com';
	@override String short({required Object address}) => 'Lightning-Adresse: ${address}';
	@override String get receivingAddress => 'Deine Empfangsadresse:';
}

// Path: lightningAddress.prompts
class _Translations$lightningAddress$prompts$de extends Translations$lightningAddress$prompts$en {
	_Translations$lightningAddress$prompts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Gib deine Lightning-Adresse ein, um fortzufahren';
	@override String get edit => 'Bearbeiten';
	@override String get invalid => 'Gib eine gültige Lightning-Adresse ein';
	@override String get required => 'Lightning-Adresse ist erforderlich.';
	@override String get enterToTakeOffer => 'Du musst eine Lightning-Adresse festlegen, um ein Angebot anzunehmen.';
	@override String get missing => 'Lightning-Adresse fehlt. Bitte füge eine hinzu, um Angebote annehmen zu können.';
	@override String get add => 'Hinzufügen';
	@override String get delete => 'Löschen';
	@override String get confirmDelete => 'Bist du sicher, dass du deine Lightning-Adresse löschen möchtest?';
	@override String get howToGet => 'Du hast noch keine Lightning-Adresse? Erfahre, wie du eine bekommst!';
	@override String get learnMore => 'Mehr über Lightning-Adressen erfahren';
}

// Path: lightningAddress.feedback
class _Translations$lightningAddress$feedback$de extends Translations$lightningAddress$feedback$en {
	_Translations$lightningAddress$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Lightning-Adresse gespeichert!';
	@override String get updated => 'Lightning-Adresse aktualisiert!';
	@override String get valid => 'Gültige Lightning-Adresse';
}

// Path: lightningAddress.errors
class _Translations$lightningAddress$errors$de extends Translations$lightningAddress$errors$en {
	_Translations$lightningAddress$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String saving({required Object details}) => 'Fehler beim Speichern der Adresse: ${details}';
	@override String loading({required Object details}) => 'Fehler beim Laden der Lightning-Adresse: ${details}';
}

// Path: nfc.actions
class _Translations$nfc$actions$de extends Translations$nfc$actions$en {
	_Translations$nfc$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get scan => 'NFC scannen';
	@override String get addWallet => 'Wallet hinzufügen';
}

// Path: nfc.prompts
class _Translations$nfc$prompts$de extends Translations$nfc$prompts$en {
	_Translations$nfc$prompts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Lightning-Wallet hinzufügen?';
	@override String addMessage({required Object address}) => 'Diese Lightning-Adresse wurde auf einem NFC-Tag gefunden: ${address}\n\nAls LNURL-Wallet hinzufügen?';
}

// Path: nfc.feedback
class _Translations$nfc$feedback$de extends Translations$nfc$feedback$en {
	_Translations$nfc$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get readyToScan => 'Halte dein Telefon an das NFC-Tag';
	@override String get alreadyScanning => 'NFC-Scan läuft bereits';
	@override String get alreadyAdded => 'Diese Lightning-Adresse ist bereits eingerichtet';
	@override String get walletAdded => 'Lightning-Wallet vom NFC-Tag hinzugefügt';
}

// Path: nfc.errors
class _Translations$nfc$errors$de extends Translations$nfc$errors$en {
	_Translations$nfc$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get disabled => 'NFC ist auf diesem Gerät deaktiviert';
	@override String get unsupported => 'NFC ist auf diesem Gerät nicht verfügbar';
	@override String reading({required Object details}) => 'NFC-Scan fehlgeschlagen: ${details}';
}

// Path: offers.details
class _Translations$offers$details$de extends Translations$offers$details$en {
	_Translations$offers$details$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get yourOffer => 'Dein Angebot:';
	@override String get selectedOffer => 'Angebot:';
	@override String get activeOffer => 'Du hast ein aktives Angebot:';
	@override String get finishedOffers => 'Abgeschlossene Angebote';
	@override String get noAvailable => 'Keine verfügbaren Angebote.';
	@override String noAvailableTip({required Object app}) => 'Tipp: Teile ${app} in deiner Community und unter Freunden, um mehr ${app}-Aufträge zu erhalten.';
	@override String get noSuccessfulTrades => 'Keine erfolgreichen Trades.';
	@override String get loadingDetails => 'Angebotsdetails werden geladen...';
	@override String amount({required Object amount}) => 'Betrag: ${amount} Satoshi';
	@override String amountWithCurrency({required Object amount, required Object currency}) => '${amount} ${currency}';
	@override String makerFee({required Object fee}) => 'Gebühr: ${fee} Sats';
	@override String takerFee({required Object fee}) => 'Gebühr: ${fee} Sats';
	@override String subtitle({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (Gebühr) Satoshi\nStatus: ${status}';
	@override String subtitleWithDate({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (Gebühr) Satoshi\nStatus: ${status}\nBezahlt: ${date}';
	@override String activeSubtitle({required Object status, required Object amount}) => 'Status: ${status}\nBetrag: ${amount} Satoshi';
	@override String id({required Object id}) => 'Angebots-ID: ${id}...';
	@override String created({required Object dateTime}) => 'Erstellt: ${dateTime}';
	@override String takenAfter({required Object duration}) => 'Angenommen nach: ${duration}';
	@override String paidAfter({required Object duration}) => 'Bezahlt nach: ${duration}';
	@override String get exchangeRate => 'Wechselkurs';
	@override String get amountLabel => 'Betrag';
	@override String get makerFeeLabel => 'Maker-Gebühr';
	@override String get takerFeeLabel => 'Taker-Gebühr';
	@override String get feeLabel => 'Gebühr';
	@override String get statusLabel => 'Status';
	@override String get youllReceive => 'Du erhältst';
	@override String get coordinator => 'Koordinator';
	@override String get categoryLabel => 'Kategorie';
	@override late final _Translations$offers$details$categories$de categories = _Translations$offers$details$categories$de._(_root);
	@override late final _Translations$offers$details$consents$de consents = _Translations$offers$details$consents$de._(_root);
}

// Path: offers.labels
class _Translations$offers$labels$de extends Translations$offers$labels$en {
	_Translations$offers$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get premium => 'Premium';
	@override String premiumBadge({required Object percent}) => '+${percent}% Premium';
}

// Path: offers.tooltips
class _Translations$offers$tooltips$de extends Translations$offers$tooltips$en {
	_Translations$offers$tooltips$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String takerFeeInfo({required Object feePercent}) => 'Der Koordinator erhebt eine Taker-Gebühr von ${feePercent}%. Diese enthält Lightning-Routing-Gebühren und wird vom Betrag abgezogen, den du erhältst.';
	@override String get premiumInfoTaker => 'Ein Premium bedeutet, dass dieses Angebot über dem Marktpreis liegt. Für denselben Fiat-Betrag sperrt der Maker weniger Sats in der Hold-Invoice, du zahlst also über Marktpreis und erhältst weniger Sats als zum Marktkurs. Das maximale Premium wird vom Koordinator festgelegt.';
	@override String get ratesFetchedAt => 'Abgerufen um';
	@override String get ratesSources => 'Durchschn. Kursquellen';
}

// Path: offers.actions
class _Translations$offers$actions$de extends Translations$offers$actions$en {
	_Translations$offers$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get take => 'ANNEHMEN';
	@override String get takeOffer => 'Angebot annehmen';
	@override String resume({required Object code}) => '${code} EINGEBEN';
	@override String get cancel => 'Angebot stornieren';
	@override String get view => 'Details anzeigen';
}

// Path: offers.status
class _Translations$offers$status$de extends Translations$offers$status$en {
	_Translations$offers$status$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get created => 'Erstellt';
	@override String get funded => 'Finanziert';
	@override String get expired => 'Abgelaufen';
	@override String get cancelled => 'Storniert';
	@override String get reserved => 'Reserviert';
	@override String blikReceived({required Object code}) => '${code} gesendet';
	@override String blikSentToMaker({required Object code}) => '${code} empfangen';
	@override String expiredBlik({required Object code}) => '${code} abgelaufen';
	@override String expiredSentBlik({required Object code}) => '${code} abgelaufen';
	@override String get takerCharged => 'Taker belastet';
	@override String invalidBlik({required Object code}) => 'Ungültiger ${code}';
	@override String get conflict => 'Konflikt';
	@override String get dispute => 'Streitfall';
	@override String get makerConfirmed => 'Bestätigt';
	@override String get settled => 'Abgewickelt';
	@override String get payingTaker => 'Taker wird bezahlt';
	@override String get takerPaymentFailed => 'Taker-Zahlung fehlgeschlagen';
	@override String get takerPaid => 'Taker bezahlt';
	@override String get unknownStatus => 'Unbekannt';
}

// Path: offers.statusMessages
class _Translations$offers$statusMessages$de extends Translations$offers$statusMessages$en {
	_Translations$offers$statusMessages$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get reserved => 'Angebot vom Taker reserviert!';
	@override String get cancelled => 'Angebot erfolgreich storniert.';
	@override String get cancelledOrExpired => 'Angebot wurde storniert oder ist abgelaufen.';
	@override String noLongerAvailable({required Object status}) => 'Angebot ist nicht mehr verfügbar (Status: ${status}).';
}

// Path: offers.progress
class _Translations$offers$progress$de extends Translations$offers$progress$en {
	_Translations$offers$progress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String waitingForTaker({required Object time}) => 'Warte auf Taker: ${time}';
	@override String reserved({required Object seconds}) => 'Reserviert: ${seconds} s verbleibend';
	@override String confirming({required Object seconds}) => 'Bestätigung: ${seconds} s verbleibend';
}

// Path: offers.errors
class _Translations$offers$errors$de extends Translations$offers$errors$en {
	_Translations$offers$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String loading({required Object details}) => 'Fehler beim Laden der Angebote: ${details}';
	@override String loadingDetails({required Object details}) => 'Fehler beim Laden der Angebotsdetails: ${details}';
	@override String get detailsMissing => 'Fehler: Angebotsdetails fehlen oder sind ungültig.';
	@override String get detailsNotLoaded => 'Angebotsdetails konnten nicht geladen werden.';
	@override String get notFound => 'Fehler: Angebot nicht gefunden.';
	@override String get unexpectedState => 'Fehler: Angebot befindet sich in einem unerwarteten Zustand.';
	@override String unexpectedStateWithStatus({required Object status}) => 'Angebot befindet sich in einem unerwarteten Zustand (${status}). Bitte versuche es erneut oder kontaktiere den Support.';
	@override String get invalidStatus => 'Angebot hat einen ungültigen Status.';
	@override String get couldNotIdentify => 'Fehler: Zu stornierendes Angebot konnte nicht identifiziert werden.';
	@override String cannotBeCancelled({required Object status}) => 'Angebot kann im aktuellen Zustand nicht storniert werden (${status}).';
	@override String failedToCancel({required Object details}) => 'Stornierung des Angebots fehlgeschlagen: ${details}';
	@override String get activeDetailsLost => 'Fehler: Details des aktiven Angebots verloren.';
	@override String checkingActive({required Object details}) => 'Fehler beim Prüfen aktiver Angebote: ${details}';
	@override String cannotResume({required Object status}) => 'Angebot kann in diesem Zustand nicht fortgesetzt werden: ${status}';
	@override String cannotResumeTaker({required Object status}) => 'Taker-Angebot kann in diesem Zustand nicht fortgesetzt werden: ${status}';
	@override String resuming({required Object details}) => 'Fehler beim Fortsetzen des Angebots: ${details}';
	@override String get makerPublicKeyNotFound => 'Öffentlicher Schlüssel des Makers nicht gefunden';
	@override String get takerPublicKeyNotFound => 'Öffentlicher Schlüssel des Takers nicht gefunden.';
	@override String get atmConsentRequired => 'Akzeptiere die Geldautomaten-Gebührenbedingung, bevor du dieses Angebot annimmst.';
	@override String get ecommerceConsentRequired => 'Akzeptiere die Bedingung zur Rückerstattung bei Online-Käufen, bevor du dieses Angebot annimmst.';
	@override String get cannotTakeOwnOffer => 'Du kannst dein eigenes Angebot nicht annehmen.';
}

// Path: offers.success
class _Translations$offers$success$de extends Translations$offers$success$en {
	_Translations$offers$success$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebot abgeschlossen';
	@override String get headline => 'Zahlung bestätigt!';
	@override String get subtitle => 'Der Taker wird jetzt bezahlt.';
	@override String get detailsTitle => 'Angebotsdetails:';
	@override String duration({required Object time}) => 'Das Angebot dauerte ${time} bis zum Abschluss.';
}

// Path: reservations.actions
class _Translations$reservations$actions$de extends Translations$reservations$actions$en {
	_Translations$reservations$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Reservierung stornieren';
}

// Path: reservations.feedback
class _Translations$reservations$feedback$de extends Translations$reservations$feedback$en {
	_Translations$reservations$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancelled => 'Reservierung storniert.';
}

// Path: reservations.errors
class _Translations$reservations$errors$de extends Translations$reservations$errors$en {
	_Translations$reservations$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String cancelling({required Object error}) => 'Stornierung der Reservierung fehlgeschlagen: ${error}';
	@override String failedToReserve({required Object details}) => 'Reservierung des Angebots fehlgeschlagen: ${details}';
	@override String get failedNoTimestamp => 'Reservierung des Angebots fehlgeschlagen (kein Zeitstempel).';
	@override String get timestampMissing => 'Zeitstempel der Angebotsreservierung fehlt.';
	@override String notReserved({required Object status}) => 'Angebot ist nicht mehr im reservierten Zustand (${status}).';
}

// Path: exchange.labels
class _Translations$exchange$labels$de extends Translations$exchange$labels$en {
	_Translations$exchange$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String enterAmount({required Object currency}) => 'Zu zahlenden Betrag (${currency}) eingeben:';
	@override String equivalent({required Object sats}) => '≈ ${sats} Satoshi';
	@override String rate({required Object rate, required Object currency}) => 'Wechselkurs ≈ ${rate} ${currency}/BTC';
}

// Path: exchange.feedback
class _Translations$exchange$feedback$de extends Translations$exchange$feedback$en {
	_Translations$exchange$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get fetching => 'Wechselkurs wird abgerufen...';
}

// Path: exchange.errors
class _Translations$exchange$errors$de extends Translations$exchange$errors$en {
	_Translations$exchange$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get fetchingRate => 'Wechselkurs konnte nicht abgerufen werden.';
	@override String get invalidFormat => 'Ungültiges Zahlenformat';
	@override String get mustBePositive => 'Betrag muss positiv sein';
	@override String get invalidFeePercentage => 'Ungültiger Gebührensatz';
	@override String tooLowFiat({required Object minAmount, required Object currency}) => 'Betrag ist zu niedrig. Minimum ist ${minAmount} ${currency}.';
	@override String tooHighFiat({required Object maxAmount, required Object currency}) => 'Betrag ist zu hoch. Maximum ist ${maxAmount} ${currency}.';
	@override String atmNotDispensable({required Object notes}) => 'Der Geldautomat kann diesen Betrag nicht ausgeben. Verwende eine Kombination von Scheinen: ${notes}.';
	@override String atmOverBankLimit({required Object bank, required Object limit, required Object currency}) => '${bank} zahlt pro Abhebung höchstens ${limit} ${currency} aus.';
}

// Path: coordinator.info
class _Translations$coordinator$info$de extends Translations$coordinator$info$en {
	_Translations$coordinator$info$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get fee => 'Gebühr';
	@override String rangeDisplay({required Object minAmount, required Object maxAmount, required Object currency}) => 'Betrag: ${minAmount}-${maxAmount} ${currency}';
	@override String feeDisplay({required Object fee}) => '${fee}% Gebühr';
}

// Path: coordinator.selector
class _Translations$coordinator$selector$de extends Translations$coordinator$selector$en {
	_Translations$coordinator$selector$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Koordinatoren werden geladen...';
	@override String get errorLoading => 'Fehler beim Laden der Koordinatoren';
	@override String get choose => 'Koordinator wählen';
	@override String get viewNostrProfile => 'Nostr-Profil anzeigen';
	@override String get unresponsive => 'Dieser Koordinator reagiert nicht';
	@override String get waitingResponse => 'Warte auf Antwort des Koordinators';
	@override String get termsAccept => 'Ich akzeptiere die ';
	@override String get termsOfUsage => 'Nutzungsbedingungen des Koordinators';
}

// Path: coordinator.dialog
class _Translations$coordinator$dialog$de extends Translations$coordinator$dialog$en {
	_Translations$coordinator$dialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get makerFee => 'Maker-Gebühr';
	@override String get takerFee => 'Taker-Gebühr';
	@override String get amountRange => 'Betragsbereich';
	@override String get reservationTime => 'Reservierungszeit';
	@override String get currencies => 'Währungen';
	@override String get viewTerms => 'Bedingungen anzeigen';
}

// Path: coordinator.details
class _Translations$coordinator$details$de extends Translations$coordinator$details$en {
	_Translations$coordinator$details$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinator';
	@override String get relaysInUse => 'Verwendete Relays';
	@override String get relaysInUseHint => 'Die gesamte Kommunikation mit diesem Koordinator läuft über diese Relays (aus seiner NIP-65-Liste).';
	@override String get noRelays => 'Noch keine Relays bekannt';
	@override String get makerFee => 'Maker-Gebühr';
	@override String get takerFee => 'Taker-Gebühr';
	@override String get amountRange => 'Betragsbereich';
	@override String get maxPremium => 'Max. Premium';
	@override String get maxPremiumInfoTitle => 'Premium';
	@override String get maxPremiumInfoBody => 'Ein Premium ist ein optionaler Preisaufschlag über dem Marktkurs, den ein Maker auf ein Angebot setzen kann. Mit einem Premium sperrt der Maker weniger Sats für denselben Fiat-Betrag, sodass der Taker über Marktpreis zahlt und der Maker die Differenz behält. Dieser Wert ist das höchste Premium, das dieser Koordinator für seine Angebote erlaubt.';
	@override String get reservationTime => 'Reservierungszeit';
	@override String get currencies => 'Währungen';
	@override String get paymentSystem => 'Zahlungssystem';
	@override String get version => 'Version';
	@override String get yourOffers => 'Deine Angebote';
	@override String get successfulOffers => 'Erfolgreiche Angebote (30 T.)';
	@override String get statusOnline => 'Online';
	@override String get statusOffline => 'Offline';
	@override String get statusUnknown => 'Unbekannt';
	@override String get openNostrProfile => 'Nostr-Profil öffnen';
	@override String get termsOfUsage => 'Nutzungsbedingungen';
}

// Path: coordinator.coldStart
class _Translations$coordinator$coldStart$de extends Translations$coordinator$coldStart$en {
	_Translations$coordinator$coldStart$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinatoren werden gesucht';
	@override String body({required Object app}) => '${app} sucht öffentliche Koordinatoren, prüft, welche erreichbar sind, und aktiviert eine kleine Standardauswahl für dich.';
	@override String get settingsHint => 'Du kannst die aktivierten Koordinatoren später in den Einstellungen ändern.';
	@override String get ok => 'OK';
	@override String get discovered => 'Entdeckt';
	@override String get candidates => 'Kandidaten';
	@override String get enabled => 'Aktiviert';
	@override String get recordsTitle => 'Aktuelle Koordinatoren';
	@override String get recordEnabled => 'Aktiviert';
	@override String get recordHealthyCandidate => 'Funktionierender Kandidat';
	@override String get recordOfflineCandidate => 'Kandidat offline';
	@override String get recordChecking => 'Wird geprüft';
	@override String get recordDiscovered => 'Entdeckt';
	@override late final _Translations$coordinator$coldStart$phases$de phases = _Translations$coordinator$coldStart$phases$de._(_root);
}

// Path: coordinator.management
class _Translations$coordinator$management$de extends Translations$coordinator$management$en {
	_Translations$coordinator$management$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinator-Verwaltung';
	@override String get availableCoordinators => 'Koordinatoren';
	@override String get noCoordinators => 'Noch keine Koordinatoren entdeckt.';
	@override String get online => 'Online';
	@override String get unknownOffline => 'Unbekannt/Offline';
	@override String get openNostrProfile => 'Nostr-Profil öffnen';
	@override String get enable => 'Aktivieren';
	@override String get remove => 'Entfernen';
	@override String get addCustomWhitelist => 'Eigenen Koordinator hinzufügen';
	@override String get addCustomWhitelistHint => 'npub1...';
	@override String get add => 'Hinzufügen';
	@override String get coordinatorDisabled => 'Koordinator deaktiviert';
	@override String get coordinatorEnabled => 'Koordinator aktiviert';
	@override String get coordinatorAdded => 'Koordinator zur eigenen Whitelist hinzugefügt';
	@override String get coordinatorRemoved => 'Koordinator von der eigenen Whitelist entfernt';
	@override String get coordinatorAddInfoUnavailable => 'Keine Koordinator-Informationen auf den Relays gefunden. Koordinator nicht hinzugefügt.';
	@override String get pleaseEnterNpub => 'Bitte gib einen npub ein';
	@override String get error => 'Fehler';
	@override String get metricYourOffers => 'Deine Angebote';
	@override String get metricYourOffersTooltip => 'Anzahl der Angebote, die du mit diesem Koordinator erfolgreich abgeschlossen hast.';
	@override String get metricNetworkOffers => 'Angebote (30 T.)';
	@override String get metricNetworkOffersTooltip => 'Erfolgreiche Angebote, die dieser Koordinator in den letzten 30 Tagen über alle Nutzer abgewickelt hat.';
}

// Path: maker.roleSelection
class _Translations$maker$roleSelection$de extends Translations$maker$roleSelection$en {
	_Translations$maker$roleSelection$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get button => 'Mit Lightning BEZAHLEN';
}

// Path: maker.amountForm
class _Translations$maker$amountForm$de extends Translations$maker$amountForm$en {
	_Translations$maker$amountForm$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$amountForm$progress$de progress = _Translations$maker$amountForm$progress$de._(_root);
	@override late final _Translations$maker$amountForm$labels$de labels = _Translations$maker$amountForm$labels$de._(_root);
	@override late final _Translations$maker$amountForm$actions$de actions = _Translations$maker$amountForm$actions$de._(_root);
	@override late final _Translations$maker$amountForm$bank$de bank = _Translations$maker$amountForm$bank$de._(_root);
	@override late final _Translations$maker$amountForm$twintScan$de twintScan = _Translations$maker$amountForm$twintScan$de._(_root);
	@override late final _Translations$maker$amountForm$tooltips$de tooltips = _Translations$maker$amountForm$tooltips$de._(_root);
	@override late final _Translations$maker$amountForm$category$de category = _Translations$maker$amountForm$category$de._(_root);
	@override late final _Translations$maker$amountForm$onboarding$de onboarding = _Translations$maker$amountForm$onboarding$de._(_root);
	@override late final _Translations$maker$amountForm$errors$de errors = _Translations$maker$amountForm$errors$de._(_root);
}

// Path: maker.payInvoice
class _Translations$maker$payInvoice$de extends Translations$maker$payInvoice$en {
	_Translations$maker$payInvoice$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bezahle diese Hold-Invoice:';
	@override late final _Translations$maker$payInvoice$actions$de actions = _Translations$maker$payInvoice$actions$de._(_root);
	@override late final _Translations$maker$payInvoice$feedback$de feedback = _Translations$maker$payInvoice$feedback$de._(_root);
	@override late final _Translations$maker$payInvoice$errors$de errors = _Translations$maker$payInvoice$errors$de._(_root);
	@override late final _Translations$maker$payInvoice$budgetWarning$de budgetWarning = _Translations$maker$payInvoice$budgetWarning$de._(_root);
}

// Path: maker.waitTaker
class _Translations$maker$waitTaker$de extends Translations$maker$waitTaker$en {
	_Translations$maker$waitTaker$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Warte auf einen Taker, der dein Angebot reserviert...';
	@override String progressLabel({required Object time}) => 'Warte auf Taker: ${time}';
	@override String get errorActiveOfferDetailsLost => 'Fehler: Details des aktiven Angebots verloren.';
	@override String errorFailedToRetrieveBlik({required Object code}) => 'Fehler: ${code}-Code konnte nicht abgerufen werden.';
	@override String errorRetrievingBlik({required Object code, required Object details}) => 'Fehler beim Abrufen des ${code}-Codes: ${details}';
	@override String offerNoLongerAvailable({required Object status}) => 'Angebot ist nicht mehr verfügbar (Status: ${status}).';
	@override String get errorCouldNotIdentifyOffer => 'Fehler: Zu stornierendes Angebot konnte nicht identifiziert werden.';
	@override String offerCannotBeCancelled({required Object status}) => 'Angebot kann im aktuellen Zustand nicht storniert werden (${status}).';
	@override String get offerCancelledSuccessfully => 'Angebot erfolgreich storniert.';
	@override String failedToCancelOffer({required Object details}) => 'Stornierung des Angebots fehlgeschlagen: ${details}';
	@override String get offerExpiredTitle => 'Angebot abgelaufen';
	@override String get offerExpiredMessage => 'Kein Taker hat dein Angebot rechtzeitig reserviert.';
	@override String get recreateOffer => 'Neues Angebot — gleicher Betrag';
}

// Path: maker.waitForBlik
class _Translations$maker$waitForBlik$de extends Translations$maker$waitForBlik$en {
	_Translations$maker$waitForBlik$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Warte auf ${code}';
	@override String get messageInfo => 'Ein Taker hat das Angebot reserviert!';
	@override String messageWaiting({required Object code}) => 'Warte auf Bereitstellung des ${code}-Codes...';
	@override String progressLabel({required Object seconds}) => 'Reserviert: ${seconds} s verbleibend';
}

// Path: maker.confirmPayment
class _Translations$maker$confirmPayment$de extends Translations$maker$confirmPayment$en {
	_Translations$maker$confirmPayment$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code}-Code erhalten!';
	@override String retrieving({required Object code}) => '${code}-Code wird abgerufen...';
	@override String get instructions => 'Gib diesen Code am Zahlungsterminal ein. Wenn der Taker in seiner Banking-App bestätigt und die Zahlung erfolgreich ist, drücke unten auf Bestätigen.';
	@override String instruction1({required Object code}) => 'Gib den Code in die ${code}-Zahlungsanforderung ein.';
	@override String get instruction2 => 'Warte, bis der Taker die Zahlung in seiner App bestätigt.';
	@override String get instruction3 => 'Wenn die Zahlung erfolgreich ist, drücke unten auf Bestätigen:';
	@override String mbwayAtmInstructions({required Object amount, required Object minutes}) => 'Um ${amount} € abzuheben, gehe zum nächsten MULTIBANCO-Geldautomaten, drücke die grüne Taste und wähle die Option "Geld abheben" ("Levantar Dinheiro"). Gib den Code ein. Dieser Code ist ${minutes} Minuten gültig.';
	@override String takerChargedWarning({required Object code}) => 'Der Taker hat gemeldet, dass die ${code}-Zahlung von seinem Bankkonto abgebucht wurde. Wenn du sie als ungültig markierst, führt das zu einem Konflikt.';
	@override String autoConfirmInfo({required Object code}) => 'Sofern du den ${code} nicht als ungültig markierst, wird die Zahlung automatisch bestätigt und der Taker bezahlt, sobald dieser Timer abläuft.';
	@override String autoConfirmCountdown({required Object time}) => 'Automatische Bestätigung in ${time}';
	@override String expiredTitle({required Object code}) => '${code}-Code abgelaufen';
	@override String expiredWarning({required Object code}) => 'Der ${code}-Code ist abgelaufen. Du musst den Zahlungsstatus manuell bestätigen:';
	@override String expiredInstruction1({required Object code}) => 'Wenn die ${code}-Zahlung erfolgreich war und du deinen Kauf abgeschlossen hast, klicke unten auf "Erfolgreiche Zahlung bestätigen".';
	@override String expiredInstruction2({required Object code}) => 'Wenn die ${code}-Zahlung fehlgeschlagen ist oder nicht abgeschlossen wurde, klicke unten auf "Ungültiger ${code}-Code".';
	@override late final _Translations$maker$confirmPayment$actions$de actions = _Translations$maker$confirmPayment$actions$de._(_root);
	@override late final _Translations$maker$confirmPayment$confirmDialog$de confirmDialog = _Translations$maker$confirmPayment$confirmDialog$de._(_root);
	@override late final _Translations$maker$confirmPayment$invalidBlikDisputeDialog$de invalidBlikDisputeDialog = _Translations$maker$confirmPayment$invalidBlikDisputeDialog$de._(_root);
	@override late final _Translations$maker$confirmPayment$feedback$de feedback = _Translations$maker$confirmPayment$feedback$de._(_root);
	@override late final _Translations$maker$confirmPayment$errors$de errors = _Translations$maker$confirmPayment$errors$de._(_root);
}

// Path: maker.invalidBlik
class _Translations$maker$invalidBlik$de extends Translations$maker$invalidBlik$en {
	_Translations$maker$invalidBlik$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Ungültiger ${code}-Code';
	@override String info({required Object code}) => 'Du hast den ${code}-Code als ungültig markiert. Warte, bis der Taker einen neuen Code bereitstellt oder einen Streitfall eröffnet.';
}

// Path: maker.conflict
class _Translations$maker$conflict$de extends Translations$maker$conflict$en {
	_Translations$maker$conflict$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebotskonflikt';
	@override String get headline => 'Angebotskonflikt gemeldet';
	@override String body({required Object code}) => 'Du hast den ${code}-Code als ungültig markiert, aber der Taker hat einen Konflikt gemeldet und ist der Ansicht, dass die Zahlung erfolgreich war.';
	@override String get instructions => 'Warte, bis der Koordinator die Situation prüft. Möglicherweise wirst du um weitere Details gebeten. Schau später wieder vorbei oder kontaktiere bei Bedarf den Support.';
	@override late final _Translations$maker$conflict$actions$de actions = _Translations$maker$conflict$actions$de._(_root);
	@override late final _Translations$maker$conflict$disputeDialog$de disputeDialog = _Translations$maker$conflict$disputeDialog$de._(_root);
	@override late final _Translations$maker$conflict$feedback$de feedback = _Translations$maker$conflict$feedback$de._(_root);
	@override late final _Translations$maker$conflict$errors$de errors = _Translations$maker$conflict$errors$de._(_root);
	@override late final _Translations$maker$conflict$nostrContact$de nostrContact = _Translations$maker$conflict$nostrContact$de._(_root);
}

// Path: maker.success
class _Translations$maker$success$de extends Translations$maker$success$en {
	_Translations$maker$success$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebot abgeschlossen';
	@override String get headline => 'Zahlung bestätigt!';
	@override String get subtitle => 'Der Taker wird jetzt bezahlt.';
	@override String get detailsTitle => 'Angebotsdetails:';
	@override String duration({required Object time}) => 'Das Angebot dauerte ${time}!';
}

// Path: taker.roleSelection
class _Translations$taker$roleSelection$de extends Translations$taker$roleSelection$en {
	_Translations$taker$roleSelection$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String button({required Object code}) => '${code}-Code für Satoshi VERKAUFEN';
}

// Path: taker.progress
class _Translations$taker$progress$de extends Translations$taker$progress$en {
	_Translations$taker$progress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String step1({required Object code}) => '${code} senden';
	@override String step2({required Object code}) => '${code} bestätigen';
	@override String get step3 => 'Bezahlt werden';
}

// Path: taker.submitBlik
class _Translations$taker$submitBlik$de extends Translations$taker$submitBlik$en {
	_Translations$taker$submitBlik$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String generateInBank({required Object bank}) => 'Erstelle den Auszahlungscode in deiner ${bank}-App.';
	@override String title({required Object digits, required Object code}) => '${digits}-stelligen ${code} eingeben';
	@override String label({required Object code}) => '${code}-Code';
	@override String instruction({required Object code}) => 'Gib den ${code} ein, bevor die Zeit abläuft...';
	@override String timeLimit({required Object code, required Object seconds}) => '${code} eingeben innerhalb von: ${seconds} s';
	@override String timeExpired({required Object code}) => 'Die Zeit zur Eingabe des ${code}-Codes ist abgelaufen.';
	@override late final _Translations$taker$submitBlik$actions$de actions = _Translations$taker$submitBlik$actions$de._(_root);
	@override late final _Translations$taker$submitBlik$feedback$de feedback = _Translations$taker$submitBlik$feedback$de._(_root);
	@override late final _Translations$taker$submitBlik$validation$de validation = _Translations$taker$submitBlik$validation$de._(_root);
	@override late final _Translations$taker$submitBlik$errors$de errors = _Translations$taker$submitBlik$errors$de._(_root);
	@override late final _Translations$taker$submitBlik$details$de details = _Translations$taker$submitBlik$details$de._(_root);
}

// Path: taker.criticalCodeDecision
class _Translations$taker$criticalCodeDecision$de extends Translations$taker$criticalCodeDecision$en {
	_Translations$taker$criticalCodeDecision$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kritische Entscheidung';
	@override String explanation({required Object code}) => 'Du hast dem Maker bereits einen ${code}-Code mitgeteilt. Wenn du fortfährst, kann dieser Code ersetzt, deine Reservierung beendet und das Angebot wieder für andere Taker freigegeben werden.';
	@override String get warningTitle => 'DU KANNST DEIN GELD VERLIEREN';
	@override String warningBody({required Object code}) => 'Wenn deine Bank die ${code}-Zahlung belastet hat, fahre NICHT fort. Der Maker könnte deinen Code verwendet haben, und danach kann der Koordinator deine Bitcoin-Auszahlung möglicherweise nicht mehr garantieren.';
	@override late final _Translations$taker$criticalCodeDecision$actions$de actions = _Translations$taker$criticalCodeDecision$actions$de._(_root);
}

// Path: twint.scanner
class _Translations$twint$scanner$de extends Translations$twint$scanner$en {
	_Translations$twint$scanner$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code}-Code scannen';
	@override late final _Translations$twint$scanner$status$de status = _Translations$twint$scanner$status$de._(_root);
}

// Path: twint.flow
class _Translations$twint$flow$de extends Translations$twint$flow$en {
	_Translations$twint$flow$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$twint$flow$progress$de progress = _Translations$twint$flow$progress$de._(_root);
	@override late final _Translations$twint$flow$takerProgress$de takerProgress = _Translations$twint$flow$takerProgress$de._(_root);
	@override late final _Translations$twint$flow$makerWait$de makerWait = _Translations$twint$flow$makerWait$de._(_root);
	@override late final _Translations$twint$flow$makerExpired$de makerExpired = _Translations$twint$flow$makerExpired$de._(_root);
	@override late final _Translations$twint$flow$makerVerify$de makerVerify = _Translations$twint$flow$makerVerify$de._(_root);
	@override late final _Translations$twint$flow$makerRecode$de makerRecode = _Translations$twint$flow$makerRecode$de._(_root);
	@override late final _Translations$twint$flow$takerPay$de takerPay = _Translations$twint$flow$takerPay$de._(_root);
	@override late final _Translations$twint$flow$takerWait$de takerWait = _Translations$twint$flow$takerWait$de._(_root);
	@override late final _Translations$twint$flow$takerExpired$de takerExpired = _Translations$twint$flow$takerExpired$de._(_root);
}

// Path: twint.waitConfirmation
class _Translations$twint$waitConfirmation$de extends Translations$twint$waitConfirmation$en {
	_Translations$twint$waitConfirmation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Warte auf den Maker';
	@override String statusLabel({required Object status}) => 'Angebotsstatus: ${status}';
	@override String waitingMaker({required Object seconds}) => 'Warte auf Bestätigung des Makers: ${seconds} s';
	@override String waitingMakerConfirmation({required Object code, required Object seconds}) => 'Warte darauf, dass der Maker bestätigt, dass der ${code} korrekt ist. Verbleibende Zeit: ${seconds}s';
	@override String importantNotice({required Object code, required Object amount, required Object currency}) => 'SEHR WICHTIG: Stelle sicher, dass du nur eine ${code}-Bestätigung über ${amount} ${currency} akzeptierst';
	@override String importantBlikAmountConfirmation({required Object code, required Object amount, required Object currency}) => 'SEHR WICHTIG: Stelle in deiner Banking-App sicher, dass du eine ${code}-Zahlung über genau ${amount} ${currency} bestätigst.';
	@override String instructions({required Object minutes, required Object code}) => 'Der Maker muss ihn nun innerhalb von ${minutes} Minuten am Zahlungsterminal eingeben. Danach musst du den ${code}-Code in deiner Banking-App bestätigen.';
	@override String instructionsNoConfirm({required Object code, required Object minutes}) => 'Der Maker muss deinen ${code}-Code nun innerhalb von ${minutes} Minuten am Geldautomaten eingeben.';
	@override late final _Translations$twint$waitConfirmation$categoryReminder$de categoryReminder = _Translations$twint$waitConfirmation$categoryReminder$de._(_root);
	@override String waitingForMakerToReceive({required Object code}) => 'Warte, bis der Maker deinen ${code}-Code erhält...';
	@override String makerReceivedBlik({required Object code}) => 'Der Maker hat deinen ${code}-Code erhalten.';
	@override String timerExpiredMessage({required Object minutes, required Object code}) => 'Die ${minutes}-minütige Gültigkeit des ${code} ist abgelaufen. Warte, bis der Maker bestätigt oder den Code als ungültig markiert.';
	@override String timerExpiredActions({required Object minutes, required Object code}) => 'Die ${minutes}-minütige Gültigkeit des ${code} ist abgelaufen, aber der Maker hat den ${code}-Code nicht erhalten. Du kannst einen neuen ${code}-Code senden oder abbrechen.';
	@override String resendBlikButton({required Object code}) => 'Neuen ${code}-Code senden';
	@override String get navigatedHome => 'Zur Startseite navigiert.';
	@override String expiredTitle({required Object code}) => '${code}-Code abgelaufen';
	@override String expiredWarning({required Object code}) => 'Der Maker hat den ${code}-Code nicht erhalten und konnte ihn daher nicht verwenden.';
	@override String get expiredRelistCountdownLabel => 'Reservierung endet in';
	@override String get expiredSentWarning => 'Der Maker hat die Zahlung noch nicht bestätigt. Was möchtest du tun?';
	@override String expiredInstruction1({required Object code}) => 'Wenn du es mit einem neuen ${code}-Code erneut versuchen möchtest, erneuere die Reservierung.';
	@override String get expiredInstruction2 => 'Wenn du diese Transaktion nicht mehr abschließen möchtest, storniere die Reservierung.';
	@override String expiredInstruction3({required Object code}) => 'Falls die ${code}-Zahlung von deinem Bankkonto abgebucht wurde, keine Sorge — die Bitcoin sind weiterhin sicher beim Koordinator gesperrt.';
	@override late final _Translations$twint$waitConfirmation$takerCharged$de takerCharged = _Translations$twint$waitConfirmation$takerCharged$de._(_root);
	@override late final _Translations$twint$waitConfirmation$expiredActions$de expiredActions = _Translations$twint$waitConfirmation$expiredActions$de._(_root);
	@override late final _Translations$twint$waitConfirmation$feedback$de feedback = _Translations$twint$waitConfirmation$feedback$de._(_root);
	@override late final _Translations$twint$waitConfirmation$errors$de errors = _Translations$twint$waitConfirmation$errors$de._(_root);
}

// Path: twint.paymentProcess
class _Translations$twint$paymentProcess$de extends Translations$twint$paymentProcess$en {
	_Translations$twint$paymentProcess$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlungsvorgang';
	@override String get waitingForOfferUpdate => 'Warte auf Statusaktualisierung des Angebots...';
	@override late final _Translations$twint$paymentProcess$states$de states = _Translations$twint$paymentProcess$states$de._(_root);
	@override late final _Translations$twint$paymentProcess$steps$de steps = _Translations$twint$paymentProcess$steps$de._(_root);
	@override late final _Translations$twint$paymentProcess$errors$de errors = _Translations$twint$paymentProcess$errors$de._(_root);
	@override late final _Translations$twint$paymentProcess$loading$de loading = _Translations$twint$paymentProcess$loading$de._(_root);
	@override late final _Translations$twint$paymentProcess$actions$de actions = _Translations$twint$paymentProcess$actions$de._(_root);
}

// Path: twint.paymentFailed
class _Translations$twint$paymentFailed$de extends Translations$twint$paymentFailed$en {
	_Translations$twint$paymentFailed$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlung fehlgeschlagen';
	@override String instructions({required Object netAmount}) => 'Bitte gib eine neue Lightning-Invoice über ${netAmount} an';
	@override late final _Translations$twint$paymentFailed$form$de form = _Translations$twint$paymentFailed$form$de._(_root);
	@override late final _Translations$twint$paymentFailed$actions$de actions = _Translations$twint$paymentFailed$actions$de._(_root);
	@override late final _Translations$twint$paymentFailed$errors$de errors = _Translations$twint$paymentFailed$errors$de._(_root);
	@override late final _Translations$twint$paymentFailed$walletSection$de walletSection = _Translations$twint$paymentFailed$walletSection$de._(_root);
	@override late final _Translations$twint$paymentFailed$loading$de loading = _Translations$twint$paymentFailed$loading$de._(_root);
	@override late final _Translations$twint$paymentFailed$success$de success = _Translations$twint$paymentFailed$success$de._(_root);
}

// Path: twint.paymentSuccess
class _Translations$twint$paymentSuccess$de extends Translations$twint$paymentSuccess$en {
	_Translations$twint$paymentSuccess$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlung erfolgreich';
	@override String get message => 'Deine Zahlung wurde erfolgreich verarbeitet.';
	@override late final _Translations$twint$paymentSuccess$actions$de actions = _Translations$twint$paymentSuccess$actions$de._(_root);
}

// Path: twint.invalidBlik
class _Translations$twint$invalidBlik$de extends Translations$twint$invalidBlik$en {
	_Translations$twint$invalidBlik$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Ungültiger ${code}-Code';
	@override String message({required Object code}) => 'Maker hat den ${code}-Code abgelehnt';
	@override String explanation({required Object code}) => 'Der Ersteller des Angebots hat angegeben, dass der von dir bereitgestellte ${code}-Code ungültig war oder nicht funktioniert hat.\n\nWas möchtest du tun?';
	@override String get werentCharged => 'Falls dir NICHTS abgebucht wurde:';
	@override String get wereCharged => 'Falls dir etwas abgebucht wurde:';
	@override late final _Translations$twint$invalidBlik$actions$de actions = _Translations$twint$invalidBlik$actions$de._(_root);
	@override late final _Translations$twint$invalidBlik$confirmDialog$de confirmDialog = _Translations$twint$invalidBlik$confirmDialog$de._(_root);
	@override late final _Translations$twint$invalidBlik$disputeConfirmDialog$de disputeConfirmDialog = _Translations$twint$invalidBlik$disputeConfirmDialog$de._(_root);
	@override late final _Translations$twint$invalidBlik$feedback$de feedback = _Translations$twint$invalidBlik$feedback$de._(_root);
	@override late final _Translations$twint$invalidBlik$errors$de errors = _Translations$twint$invalidBlik$errors$de._(_root);
}

// Path: twint.conflict
class _Translations$twint$conflict$de extends Translations$twint$conflict$en {
	_Translations$twint$conflict$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebotskonflikt';
	@override String get headline => 'Angebotskonflikt gemeldet';
	@override String body({required Object code}) => 'Der Maker hat den ${code}-Code als ungültig markiert, aber du hast einen Konflikt gemeldet und bist der Ansicht, dass die Zahlung erfolgreich war.';
	@override String get instructions => 'Warte, bis der Koordinator die Situation prüft. Möglicherweise wirst du um weitere Details gebeten. Schau später wieder vorbei oder kontaktiere bei Bedarf den Support.';
	@override late final _Translations$twint$conflict$actions$de actions = _Translations$twint$conflict$actions$de._(_root);
	@override late final _Translations$twint$conflict$feedback$de feedback = _Translations$twint$conflict$feedback$de._(_root);
	@override late final _Translations$twint$conflict$errors$de errors = _Translations$twint$conflict$errors$de._(_root);
	@override late final _Translations$twint$conflict$nostrContact$de nostrContact = _Translations$twint$conflict$nostrContact$de._(_root);
}

// Path: blik.instructions
class _Translations$blik$instructions$de extends Translations$blik$instructions$en {
	_Translations$blik$instructions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String taker({required Object code}) => 'Sobald der Maker den ${code}-Code eingibt, musst du die Zahlung in deiner Banking-App bestätigen. Stelle sicher, dass der Betrag korrekt ist, bevor du bestätigst.';
}

// Path: home.notifications
class _Translations$home$notifications$de extends Translations$home$notifications$en {
	_Translations$home$notifications$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Erhalte Benachrichtigungen über neue Angebote via:';
	@override String get telegram => 'Telegram';
	@override String get simplex => 'SimpleX';
	@override String get matrix => 'Matrix';
	@override String get signal => 'Signal';
	@override String get channelAllBanks => '(alle Banken)';
	@override String get channelForBankPrefix => '(nur Angebote für ';
	@override String get channelForBankSuffix => ')';
	@override String get scopeAllBanks => 'Alle Banken';
	@override String scopeBankOnly({required Object bank}) => 'Nur ${bank}';
}

// Path: home.statistics
class _Translations$home$statistics$de extends Translations$home$statistics$en {
	_Translations$home$statistics$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abgeschlossene Angebote';
	@override String lifetimeCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Gesamt: ${count} Transaktionen\nDurchschn. Wartezeit auf ${code}: ${avgBlikTime}\nDurchschn. Abschlusszeit: ${avgPaidTime}';
	@override String last7DaysCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Letzte 7 T.: ${count} Transaktionen\nDurchschn. Wartezeit auf ${code}: ${avgBlikTime}\nDurchschn. Abschlusszeit: ${avgPaidTime}';
	@override String last7DaysSingleLine({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Letzte 7 T.: ${count} Angebote  |  Durchschn. Reservierung: ${avgReservationTime}  |  Durchschn. Bezahlt: ${avgPaidTime}';
	@override late final _Translations$home$statistics$errors$de errors = _Translations$home$statistics$errors$de._(_root);
}

// Path: generateNewKey.buttons
class _Translations$generateNewKey$buttons$de extends Translations$generateNewKey$buttons$en {
	_Translations$generateNewKey$buttons$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Generieren';
}

// Path: generateNewKey.errors
class _Translations$generateNewKey$errors$de extends Translations$generateNewKey$errors$en {
	_Translations$generateNewKey$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get activeOffer => 'Du kannst keinen neuen Neko generieren, während du ein aktives Angebot hast.';
	@override String get failed => 'Neuer Neko konnte nicht generiert werden';
}

// Path: generateNewKey.feedback
class _Translations$generateNewKey$feedback$de extends Translations$generateNewKey$feedback$en {
	_Translations$generateNewKey$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get success => 'Neuer Neko erfolgreich generiert!';
}

// Path: generateNewKey.tooltips
class _Translations$generateNewKey$tooltips$de extends Translations$generateNewKey$tooltips$en {
	_Translations$generateNewKey$tooltips$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Neuen Neko generieren';
}

// Path: backup.feedback
class _Translations$backup$feedback$de extends Translations$backup$feedback$en {
	_Translations$backup$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Privater Schlüssel in die Zwischenablage kopiert!';
}

// Path: backup.tooltips
class _Translations$backup$tooltips$de extends Translations$backup$tooltips$en {
	_Translations$backup$tooltips$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get backup => 'Neko sichern';
}

// Path: restore.labels
class _Translations$restore$labels$de extends Translations$restore$labels$en {
	_Translations$restore$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get privateKey => 'Privater Schlüssel';
}

// Path: restore.buttons
class _Translations$restore$buttons$de extends Translations$restore$buttons$en {
	_Translations$restore$buttons$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Wiederherstellen';
}

// Path: restore.errors
class _Translations$restore$errors$de extends Translations$restore$errors$en {
	_Translations$restore$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get invalidKey => 'Muss eine 64-stellige Hex-Zeichenfolge sein.';
	@override String get failed => 'Wiederherstellung fehlgeschlagen';
}

// Path: restore.feedback
class _Translations$restore$feedback$de extends Translations$restore$feedback$en {
	_Translations$restore$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get success => 'Neko erfolgreich wiederhergestellt! Die App wird neu gestartet.';
}

// Path: restore.tooltips
class _Translations$restore$tooltips$de extends Translations$restore$tooltips$en {
	_Translations$restore$tooltips$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Neko wiederherstellen';
}

// Path: system.errors
class _Translations$system$errors$de extends Translations$system$errors$en {
	_Translations$system$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get generic => 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
	@override String get loadingTimeoutConfig => 'Fehler beim Laden der Timeout-Konfiguration.';
	@override String get loadingCoordinatorConfig => 'Fehler beim Laden der Koordinator-Konfiguration. Bitte versuche es erneut.';
	@override String get noPublicKey => 'Dein öffentlicher Schlüssel ist nicht verfügbar. Fortfahren nicht möglich.';
	@override String get internalOfferIncomplete => 'Interner Fehler: Angebotsdetails sind unvollständig. Bitte versuche es erneut.';
	@override String get loadingPublicKey => 'Fehler beim Laden deines öffentlichen Schlüssels. Bitte starte die App neu.';
}

// Path: system.blik
class _Translations$system$blik$de extends Translations$system$blik$en {
	_Translations$system$blik$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String copied({required Object code}) => '${code}-Code in die Zwischenablage kopiert';
}

// Path: myOffers.filter
class _Translations$myOffers$filter$de extends Translations$myOffers$filter$en {
	_Translations$myOffers$filter$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get all => 'Alle';
	@override String get active => 'Aktiv';
	@override String get completed => 'Abgeschlossen';
	@override String get failed => 'Fehlgeschlagen';
}

// Path: myOffers.details
class _Translations$myOffers$details$de extends Translations$myOffers$details$en {
	_Translations$myOffers$details$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebotsdetails';
	@override String get notFound => 'Angebot nicht gefunden.';
	@override String get amount => 'Betrag';
	@override String get fees => 'Gebühren';
	@override String get sats => 'Satoshis';
	@override String get maker => 'Maker';
	@override String get taker => 'Taker';
	@override String get yourFee => 'Deine Gebühr';
	@override String get makerFee => 'Maker-Gebühr';
	@override String get takerFee => 'Taker-Gebühr';
	@override String get coordinator => 'Koordinator';
	@override String get createdAt => 'Erstellt';
	@override String get reservedAt => 'Reserviert';
	@override String blikReceivedAt({required Object code}) => '${code} übermittelt';
	@override String get makerConfirmedAt => 'Bestätigt';
	@override String get settledAt => 'Abgewickelt';
	@override String get takerPaidAt => 'Taker bezahlt';
	@override String get id => 'Angebots-ID';
	@override String get paymentHash => 'Payment-Hash';
	@override String get holdInvoice => 'Hold-Invoice';
	@override String get continueActiveOffer => 'Aktives Angebot fortsetzen';
	@override String after({required Object duration}) => 'nach ${duration}';
}

// Path: landing.actions
class _Translations$landing$actions$de extends Translations$landing$actions$en {
	_Translations$landing$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String payBlik({required Object code}) => '${code} bezahlen';
	@override String get payBlikSubtitle => 'mit Bitcoin';
	@override String get sellBlik => 'Bitcoin kaufen';
	@override String sellBlikSubtitle({required Object code}) => 'mit ${code}';
	@override String get howItWorks => 'Wie funktioniert das?';
}

// Path: settings.offerCreation
class _Translations$settings$offerCreation$de extends Translations$settings$offerCreation$en {
	_Translations$settings$offerCreation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebotserstellung';
	@override String get defaultCategory => 'Standardkategorie';
	@override String get defaultBank => 'Standardbank';
	@override String get defaultBankNone => 'Keine (pro Angebot wählen)';
	@override String get preferredCoordinator => 'Bevorzugter Koordinator';
	@override String get automaticCoordinator => 'Zuverlässigster';
	@override String get automaticCoordinatorDescription => 'Wählt den Koordinator mit der besten Erfolgsbilanz, basierend auf deinen eigenen abgeschlossenen Angeboten und der gesamten Netzwerkaktivität.';
	@override String get cheapestCoordinator => 'Günstigster';
	@override String get cheapestCoordinatorDescription => 'Wählt für jedes Angebot den verfügbaren Koordinator mit der niedrigsten Maker-Gebühr.';
	@override String get enablePremium => 'Premium-Preise aktivieren';
	@override String get enablePremiumDescription => 'Zeigt den Premium-Regler beim Erstellen von Maker-Angeboten an.';
	@override String get defaultPremium => 'Standard-Premium';
	@override String get defaultPremiumDisabled => 'Aktiviere Premium-Preise, um ein Standard-Premium festzulegen.';
	@override String get premiumPerCoordinatorNote => 'Jeder Koordinator legt sein eigenes maximales Premium fest, dein Standardwert wird daher durch den für ein Angebot verwendeten Koordinator begrenzt.';
	@override late final _Translations$settings$offerCreation$categoryOptions$de categoryOptions = _Translations$settings$offerCreation$categoryOptions$de._(_root);
	@override late final _Translations$settings$offerCreation$dialogs$de dialogs = _Translations$settings$offerCreation$dialogs$de._(_root);
}

// Path: settings.display
class _Translations$settings$display$de extends Translations$settings$display$en {
	_Translations$settings$display$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Anzeige';
	@override String get bitcoinUnit => 'Bitcoin-Einheit';
	@override String get bitcoinUnitDescription => 'Wähle, wie Bitcoin-Beträge in der App angezeigt werden.';
	@override late final _Translations$settings$display$unitOptions$de unitOptions = _Translations$settings$display$unitOptions$de._(_root);
}

// Path: settings.paymentSystem
class _Translations$settings$paymentSystem$de extends Translations$settings$paymentSystem$en {
	_Translations$settings$paymentSystem$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Land / Zahlungssystem';
	@override String get subtitle => 'Wähle das Zahlungssystem deines Landes.';
	@override String get dialogTitle => 'Zahlungssystem wählen';
	@override late final _Translations$settings$paymentSystem$countries$de countries = _Translations$settings$paymentSystem$countries$de._(_root);
}

// Path: notificationSettings.newOfferAlerts
class _Translations$notificationSettings$newOfferAlerts$de extends Translations$notificationSettings$newOfferAlerts$en {
	_Translations$notificationSettings$newOfferAlerts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Benachrichtigungen über neue Angebote';
	@override String description({required Object app}) => 'Wenn aktiviert, benachrichtigt dich ${app} über neue annehmbare Angebote deiner aktivierten Koordinatoren, während die App im Hintergrund läuft. Das kann schneller sein als externe Messenger.';
}

// Path: wallet.missingReceiving
class _Translations$wallet$missingReceiving$de extends Translations$wallet$missingReceiving$en {
	_Translations$wallet$missingReceiving$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Empfangs-Wallet erforderlich';
	@override String get message => 'Keine Wallet für den Empfang konfiguriert. Füge in den Wallet-Einstellungen eine hinzu, um Angebote anzunehmen.';
	@override String get openSettings => 'Wallet-Einstellungen';
}

// Path: wallet.incompatibleReceiving
class _Translations$wallet$incompatibleReceiving$de extends Translations$wallet$incompatibleReceiving$en {
	_Translations$wallet$incompatibleReceiving$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'BOLT11-Wallet erforderlich';
	@override String get message => 'Dieser Koordinator kann dieses Angebot nur über BOLT11 auszahlen.';
	@override String get explanation => 'Deine Empfangs-Wallet unterstützt BOLT12-Angebote, kann aber die erforderliche BOLT11-Rechnung nicht erstellen. Füge eine BOLT11-kompatible Empfangs-Wallet hinzu.';
}

// Path: wallet.details
class _Translations$wallet$details$de extends Translations$wallet$details$en {
	_Translations$wallet$details$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wallet-Details';
	@override String get pendingTitle => 'Ausstehende Transaktionen';
	@override String get finishedTitle => 'Abgeschlossene Transaktionen';
}

// Path: nwc.labels
class _Translations$nwc$labels$de extends Translations$nwc$labels$en {
	_Translations$nwc$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get connectionString => 'NWC-Verbindungszeichenfolge';
	@override String get hint => 'nostr+walletconnect://...';
	@override String get status => 'Verbindungsstatus';
	@override String get connected => 'Verbunden';
	@override String get disconnected => 'Getrennt';
	@override String get scanQrCode => 'Scanne den QR-Code mit deiner NWC-Verbindung';
	@override String get balance => 'Guthaben';
	@override String get budget => 'Budget';
	@override String get usedBudget => 'Verbraucht';
	@override String get totalBudget => 'Gesamt';
	@override String get renewsIn => 'Erneuert sich in';
	@override String get renewalPeriod => 'Erneuerungszeitraum';
	@override String get relay => 'Relay';
	@override String get relays => 'Relays';
}

// Path: nwc.prompts
class _Translations$nwc$prompts$de extends Translations$nwc$prompts$en {
	_Translations$nwc$prompts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Gib deine NWC-Verbindungszeichenfolge ein';
	@override String get connect => 'Wallet verbinden';
	@override String get disconnect => 'Trennen';
	@override String get confirmDisconnect => 'Bist du sicher, dass du deine NWC-Wallet trennen möchtest?';
	@override String get pasteConnection => 'Verbindungszeichenfolge einfügen';
	@override String get chooseMethod => 'Wähle, wie du deine Lightning-Wallet verbinden möchtest';
	@override String get howToGet => 'Du hast noch keine NWC-Verbindung? Erfahre, wie du eine bekommst!';
	@override String get learnMore => 'Mehr über NWC erfahren';
}

// Path: nwc.actions
class _Translations$nwc$actions$de extends Translations$nwc$actions$en {
	_Translations$nwc$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get connectAlbyGo => 'Mit Alby Go verbinden';
	@override String get connectNwc => 'NWC-QR-Code scannen';
}

// Path: nwc.feedback
class _Translations$nwc$feedback$de extends Translations$nwc$feedback$en {
	_Translations$nwc$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get connected => 'NWC-Wallet erfolgreich verbunden!';
	@override String get disconnected => 'NWC-Wallet getrennt';
	@override String get connecting => 'Verbindung zur NWC-Wallet wird hergestellt...';
	@override String get loadingWalletInfo => 'Wallet-Informationen werden geladen...';
}

// Path: nwc.errors
class _Translations$nwc$errors$de extends Translations$nwc$errors$en {
	_Translations$nwc$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String connecting({required Object details}) => 'Fehler beim Verbinden mit NWC: ${details}';
	@override String disconnecting({required Object details}) => 'Fehler beim Trennen von NWC: ${details}';
	@override String get invalid => 'Ungültige NWC-Verbindungszeichenfolge';
	@override String get required => 'NWC-Verbindungszeichenfolge ist erforderlich';
	@override String get loadingBalance => 'Wallet-Guthaben konnte nicht geladen werden';
	@override String get loadingBudget => 'Wallet-Budget konnte nicht geladen werden';
}

// Path: nwc.time
class _Translations$nwc$time$de extends Translations$nwc$time$en {
	_Translations$nwc$time$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String minutes({required Object count}) => '${count} Min.';
	@override String hours({required Object count}) => '${count} Std.';
	@override String days({required Object count}) => '${count} T.';
	@override String get justNow => 'gerade eben';
}

// Path: relays.status
class _Translations$relays$status$de extends Translations$relays$status$en {
	_Translations$relays$status$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Verbunden';
	@override String get connecting => 'Verbindung wird hergestellt';
	@override String get reconnecting => 'Verbindung wird wiederhergestellt';
	@override String get disconnected => 'Getrennt';
}

// Path: relays.popup
class _Translations$relays$popup$de extends Translations$relays$popup$en {
	_Translations$relays$popup$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object connected, required Object total}) => 'Relays (${connected}/${total} verbunden)';
	@override String get connectingMessage => 'Verbindung zu Relays wird hergestellt...';
}

// Path: offerNotifications.activeService
class _Translations$offerNotifications$activeService$de extends Translations$offerNotifications$activeService$en {
	_Translations$offerNotifications$activeService$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Warte auf neue Angebote';
	@override String body({required Object app}) => 'Nostr-Dienst überwacht Ereignisse von ${app}-Angeboten.';
}

// Path: offerNotifications.funded
class _Translations$offerNotifications$funded$de extends Translations$offerNotifications$funded$en {
	_Translations$offerNotifications$funded$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebot finanziert';
	@override String get body => 'Deine Hold-Invoice wurde akzeptiert. Das Angebot ist jetzt live.';
}

// Path: offerNotifications.reserved
class _Translations$offerNotifications$reserved$de extends Translations$offerNotifications$reserved$en {
	_Translations$offerNotifications$reserved$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebot reserviert';
	@override String get body => 'Ein Taker hat dein Angebot reserviert.';
}

// Path: offerNotifications.blikReady
class _Translations$offerNotifications$blikReady$de extends Translations$offerNotifications$blikReady$en {
	_Translations$offerNotifications$blikReady$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code}-Code bereit';
	@override String body({required Object code}) => 'Dein ${code}-Code kann jetzt angezeigt werden.';
}

// Path: offerNotifications.newOffer
class _Translations$offerNotifications$newOffer$de extends Translations$offerNotifications$newOffer$en {
	_Translations$offerNotifications$newOffer$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neues Angebot verfügbar';
	@override String body({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}';
	@override String premiumSuffix({required Object percent}) => '+${percent}% Premium';
}

// Path: offerNotifications.categories
class _Translations$offerNotifications$categories$de extends Translations$offerNotifications$categories$en {
	_Translations$offerNotifications$categories$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Geschäft';
	@override String get atm => 'Geldautomat';
	@override String get online => 'Online';
}

// Path: offerNotifications.blikPendingReminder
class _Translations$offerNotifications$blikPendingReminder$de extends Translations$offerNotifications$blikPendingReminder$en {
	_Translations$offerNotifications$blikPendingReminder$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} wartet auf deine Aktion';
	@override String body({required Object code}) => 'Bestätige die Zahlung oder markiere den ${code}-Code als ungültig.';
}

// Path: offerNotifications.takerCharged
class _Translations$offerNotifications$takerCharged$de extends Translations$offerNotifications$takerCharged$en {
	_Translations$offerNotifications$takerCharged$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} abgebucht';
	@override String body({required Object code}) => 'Der Taker meldet, dass der ${code} abgebucht wurde. Bestätige oder markiere ihn als ungültig.';
}

// Path: offerNotifications.invalidBlik
class _Translations$offerNotifications$invalidBlik$de extends Translations$offerNotifications$invalidBlik$en {
	_Translations$offerNotifications$invalidBlik$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} als ungültig markiert';
	@override String body({required Object code}) => 'Der Maker hat deinen ${code}-Code als ungültig markiert.';
}

// Path: offerNotifications.takerPaid
class _Translations$offerNotifications$takerPaid$de extends Translations$offerNotifications$takerPaid$en {
	_Translations$offerNotifications$takerPaid$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlung erhalten';
	@override String get body => 'Deine Lightning-Zahlung wurde gesendet.';
}

// Path: offers.details.categories
class _Translations$offers$details$categories$de extends Translations$offers$details$categories$en {
	_Translations$offers$details$categories$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Geschäft, Café oder Restaurant';
	@override String get atmCashout => 'Bargeldbezug am Geldautomaten';
	@override String get onlineService => 'Online-Dienst/-Produkt';
}

// Path: offers.details.consents
class _Translations$offers$details$consents$de extends Translations$offers$details$consents$en {
	_Translations$offers$details$consents$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Manche Geldautomaten erheben eine zusätzliche Gebühr auf den Angebotsbetrag. Mit der Annahme dieses Angebots akzeptierst du alle zusätzlichen Bankgebühren, die der Geldautomat verlangt.';
	@override String ecommerce({required Object code}) => 'Aus verschiedenen Gründen — etwa ein ausverkaufter Artikel, eine Korrektur einer Überzahlung oder andere Probleme auf Händlerseite — kann der Online-Händler automatisch Geld auf das Bankkonto zurücksenden, das mit dem von dir generierten ${code} verknüpft ist. Diese Gelder landen auf deinem Konto und gehören nicht dir. Falls dies passiert, kontaktiere den Koordinator in gutem Glauben und vereinbare die Rückgabe der Gelder an den Maker. Mit der Annahme dieses Angebots akzeptierst du diese Bedingungen und verpflichtest dich ehrenhaft, in solchen Situationen ehrlich zu handeln.';
}

// Path: coordinator.coldStart.phases
class _Translations$coordinator$coldStart$phases$de extends Translations$coordinator$coldStart$phases$en {
	_Translations$coordinator$coldStart$phases$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loadingMuteList => 'Koordinator-Filter werden geladen';
	@override String get discovering => 'Koordinatoren werden auf Nostr gesucht';
	@override String get loadingProfiles => 'Koordinator-Profile werden geladen';
	@override String get loadingStats => 'Koordinator-Historie wird gelesen';
	@override String get checkingHealth => 'Koordinator-Verfügbarkeit wird geprüft';
	@override String get finalizing => 'Standard-Koordinatoren werden aktiviert';
	@override String get completed => 'Fertig';
}

// Path: maker.amountForm.progress
class _Translations$maker$amountForm$progress$de extends Translations$maker$amountForm$progress$en {
	_Translations$maker$amountForm$progress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Angebot erstellen';
	@override String get step2 => '2. Auf Taker warten';
	@override String step3({required Object code}) => '3. ${code} verwenden';
}

// Path: maker.amountForm.labels
class _Translations$maker$amountForm$labels$de extends Translations$maker$amountForm$labels$en {
	_Translations$maker$amountForm$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get coordinator => 'Koordinator';
	@override String get category => 'Kategorie';
	@override String get exchangeRate => 'Wechselkurs';
	@override String get fee => 'Gebühr';
	@override String get satoshisToPay => 'Zu zahlender Betrag';
	@override String get enterAmount => 'Betrag eingeben';
	@override String get customAmount => 'Benutzerdefiniert';
	@override String get tapToSelect => 'Zum Auswählen tippen';
	@override String get premium => 'Premium';
}

// Path: maker.amountForm.actions
class _Translations$maker$amountForm$actions$de extends Translations$maker$amountForm$actions$en {
	_Translations$maker$amountForm$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get generateInvoice => 'Invoice erstellen';
}

// Path: maker.amountForm.bank
class _Translations$maker$amountForm$bank$de extends Translations$maker$amountForm$bank$en {
	_Translations$maker$amountForm$bank$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Bank';
	@override String get required => 'Bitte wähle eine Bank';
	@override String shortValidityWarning({required Object minutes}) => 'Der Code dieser Bank ist nur ${minutes} Min gültig — sei vor dem Reservieren am Geldautomaten.';
}

// Path: maker.amountForm.twintScan
class _Translations$maker$amountForm$twintScan$de extends Translations$maker$amountForm$twintScan$en {
	_Translations$maker$amountForm$twintScan$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String cardTitle({required Object code}) => '${code}-QR und Betrag scannen';
	@override String get cardBody => 'Richte die Kamera auf den Zahlungsbildschirm. Die App füllt den Code und, wenn sichtbar, den Betrag automatisch aus.';
	@override String get scanButton => 'Mit Kamera scannen';
	@override String get manualButton => 'Stattdessen manuell eingeben';
	@override String codeLabel({required Object code}) => '${code}-Code';
	@override String get rescan => 'Erneut scannen';
	@override String helperFilled({required Object code}) => 'Der Taker sieht diesen Code und gibt ihn in ${code} ein.';
	@override String helperEmpty({required Object digits}) => 'Scanne, um dies automatisch auszufüllen, oder gib den ${digits}-stelligen Code manuell ein.';
}

// Path: maker.amountForm.tooltips
class _Translations$maker$amountForm$tooltips$de extends Translations$maker$amountForm$tooltips$en {
	_Translations$maker$amountForm$tooltips$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String feeInfo({required Object feePercent}) => 'Der Koordinator erhebt eine Maker-Gebühr von ${feePercent}%. Diese Gebühr wird von deiner Lightning-Zahlung abgezogen.';
	@override String get payInfo => 'Diese Berechnung basiert auf clientseitig abgerufenen Wechselkursen. Der Koordinator berechnet den genauen Betrag, und der Invoice-Betrag ist der endgültige und exakte Zahlbetrag.';
	@override String get premiumInfo => 'Mit einem optionalen Premium kannst du deine Sats über dem Marktpreis verkaufen. Das Premium reduziert die in deiner Hold-Invoice gesperrten Sats für denselben Fiat-Betrag, sodass der Taker über Marktpreis zahlt und du die Differenz behältst. Standardmäßig deaktiviert (0%). Das maximale Premium wird vom gewählten Koordinator festgelegt.';
}

// Path: maker.amountForm.category
class _Translations$maker$amountForm$category$de extends Translations$maker$amountForm$category$en {
	_Translations$maker$amountForm$category$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Angebotskategorie';
	@override String unsupportedForSystem({required Object system}) => '${system} unterstützt diese Kategorie nicht.';
	@override late final _Translations$maker$amountForm$category$options$de options = _Translations$maker$amountForm$category$options$de._(_root);
	@override late final _Translations$maker$amountForm$category$shortLabels$de shortLabels = _Translations$maker$amountForm$category$shortLabels$de._(_root);
	@override String get atmHint => 'Taker sehen, dass dieses Angebot für einen Bargeldbezug am Geldautomaten ist, und meiden es möglicherweise, wenn ihre Bank zusätzliche Automatengebühren erhebt.';
	@override String physicalShopHint({required Object app, required Object code}) => 'Der ideale Ort, um ${app} zu nutzen, ist ein Selbstbedienungsterminal — denn das Warten darauf, dass ein Taker reserviert, einen ${code}-Code generiert und bestätigt, kann ein paar Minuten dauern. Funktioniert bestens in Geschäften, Cafés und Restaurants. Wenn du mutig genug bist, eine reguläre Kasse (und die Leute in der Schlange hinter dir) diese paar Minuten warten zu lassen — gut für dich.';
	@override String get ecommerceWarningTitle => 'Rückerstattungsrisiko bei Online-Händlern';
	@override String ecommerceWarningBody({required Object code}) => 'Aus verschiedenen Gründen — etwa ein ausverkaufter Artikel, eine Korrektur einer Überzahlung oder andere Probleme auf Händlerseite — kann der Online-Händler automatisch eine Rückerstattung auf das Bankkonto veranlassen, das mit dem ${code} verknüpft ist, also das Konto des Takers. Der Koordinator kann den Taker nicht zwingen, dir diese Gelder zurückzugeben.';
	@override String get ecommerceConfirmation => 'Ich verstehe das Rückerstattungsrisiko und werde der Bestellung eine Notiz hinzufügen, die den Händler anweist, eine eventuelle Rückerstattung auf ein anderes Konto zu leisten.';
	@override String get whyThisIsNeeded => 'Warum ist das nötig?';
}

// Path: maker.amountForm.onboarding
class _Translations$maker$amountForm$onboarding$de extends Translations$maker$amountForm$onboarding$en {
	_Translations$maker$amountForm$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get titlePrefix => 'Neu';
	@override String get title => 'Wähle die Angebotskategorie';
	@override String get body => 'Wähle die Kategorie, die am besten zu deinem Kauf passt, bevor du die Invoice erstellst.';
	@override String get showWhy => 'Warum ist das wichtig?';
	@override String get hideWhy => 'Details ausblenden';
	@override String get whyTitle => 'Die richtige Kategorie hilft Takern, sicher zu entscheiden';
	@override String get whyBody => 'Unterschiedliche Situationen bringen unterschiedliche Erwartungen und Risiken mit sich. Bargeldbezüge am Geldautomaten können zusätzliche Bankgebühren verursachen, und Online-Käufe können Rückerstattungs-Sonderfälle beinhalten. Die richtige Kategorie gibt Takern den Kontext, den sie brauchen, bevor sie dein Angebot annehmen.';
	@override String get cta => 'Verstanden';
}

// Path: maker.amountForm.errors
class _Translations$maker$amountForm$errors$de extends Translations$maker$amountForm$errors$en {
	_Translations$maker$amountForm$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String initiating({required Object details}) => 'Fehler beim Erstellen des Angebots: ${details}';
	@override String get publicKeyNotLoaded => 'Fehler: Öffentlicher Schlüssel noch nicht geladen.';
	@override String get noCoordinatorMatchesAmount => 'Kein Koordinator unterstützt diesen Betrag. Versuche einen anderen Wert.';
	@override String get categoryRequired => 'Wähle eine Angebotskategorie.';
	@override String get ecommerceConfirmationRequired => 'Bestätige das Rückerstattungsrisiko des Online-Händlers, bevor du fortfährst.';
}

// Path: maker.payInvoice.actions
class _Translations$maker$payInvoice$actions$de extends Translations$maker$payInvoice$actions$en {
	_Translations$maker$payInvoice$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get copy => 'Invoice kopieren';
	@override String get payInWallet => 'In externer Wallet öffnen';
	@override String get connectWallet => 'Wallet verbinden';
	@override String get payWithNwc => 'Bezahlen';
	@override String get paying => 'Wird bezahlt...';
}

// Path: maker.payInvoice.feedback
class _Translations$maker$payInvoice$feedback$de extends Translations$maker$payInvoice$feedback$en {
	_Translations$maker$payInvoice$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Invoice in die Zwischenablage kopiert!';
	@override String get waitingConfirmation => 'Warte auf Zahlungsbestätigung...';
	@override String get nwcConnected => 'NWC-Wallet verbunden!';
	@override String get nwcPaymentSuccess => 'Zahlung erfolgreich!';
}

// Path: maker.payInvoice.errors
class _Translations$maker$payInvoice$errors$de extends Translations$maker$payInvoice$errors$en {
	_Translations$maker$payInvoice$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get couldNotOpenApp => 'Lightning-App für die Invoice konnte nicht geöffnet werden.';
	@override String openingApp({required Object details}) => 'Fehler beim Öffnen der Lightning-App: ${details}';
	@override String get publicKeyNotAvailable => 'Öffentlicher Schlüssel ist nicht verfügbar.';
	@override String get couldNotFetchActive => 'Details des aktiven Angebots konnten nicht abgerufen werden. Es ist möglicherweise abgelaufen.';
	@override String nwcPaymentFailed({required Object details}) => 'Zahlung fehlgeschlagen: ${details}';
	@override String get nwcNotConnected => 'NWC-Wallet nicht verbunden';
	@override String insufficientBalance({required Object required, required Object available}) => 'Unzureichendes Guthaben. Benötigt ${required} Sats, verfügbar ${available} Sats';
	@override String get cancelOfferAlreadyFunded => 'Der Koordinator meldet, dass dieses Angebot bereits finanziert ist. Es kann jetzt nicht mehr storniert werden.';
	@override String cancelFailed({required Object details}) => 'Angebot konnte nicht storniert werden: ${details}';
}

// Path: maker.payInvoice.budgetWarning
class _Translations$maker$payInvoice$budgetWarning$de extends Translations$maker$payInvoice$budgetWarning$en {
	_Translations$maker$payInvoice$budgetWarning$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlung könnte fehlschlagen';
	@override String balanceTooLow({required Object name}) => 'Deine Standard-Wallet ${name} hat nicht genug Guthaben für diese Zahlung.';
	@override String budgetTooLow({required Object name}) => 'Deine Standard-Wallet ${name} hat nicht genug Ausgabebudget für diese Zahlung.';
	@override String balanceLine({required Object available}) => 'Guthaben: ${available}';
	@override String budgetLine({required Object remaining}) => 'Verbleibendes NWC-Budget: ${remaining}';
	@override String requiredLine({required Object required}) => 'Benötigt: ${required}';
	@override String addFundsHint({required Object name}) => 'Füge ${name} Guthaben hinzu, um diesen Zahlungsbetrag zu decken.';
	@override String get increaseBudgetHint => 'Erhöhe das NWC-Ausgabebudget für diese Verbindung in deiner Wallet-App.';
	@override String get switchWalletLabel => 'Oder verwende eine andere Wallet:';
	@override String get walletLowFundsTag => 'Könnte fehlschlagen';
	@override String get payAnyway => 'Trotzdem versuchen';
	@override String get cancel => 'Abbrechen';
	@override String get readyTitle => 'Invoice bezahlen';
}

// Path: maker.confirmPayment.actions
class _Translations$maker$confirmPayment$actions$de extends Translations$maker$confirmPayment$actions$en {
	_Translations$maker$confirmPayment$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Erfolgreiche Zahlung bestätigen';
	@override String markInvalid({required Object code}) => 'Ungültiger ${code}-Code';
	@override String copyBlik({required Object code}) => '${code} kopieren';
}

// Path: maker.confirmPayment.confirmDialog
class _Translations$maker$confirmPayment$confirmDialog$de extends Translations$maker$confirmPayment$confirmDialog$en {
	_Translations$maker$confirmPayment$confirmDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlung bestätigen?';
	@override String content({required Object code}) => 'Diese Aktion ist unwiderruflich. Nach der Bestätigung:\n\n• Der Taker erhält die Gelder sofort\n• Der Koordinator kann die Gelder nicht mehr anfechten\n• Du kannst diese Aktion nicht rückgängig machen\n\nBestätige nur, wenn die ${code}-Zahlung erfolgreich war.';
	@override String get cancel => 'Abbrechen';
	@override String get confirmButton => 'Ja, Zahlung bestätigen';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _Translations$maker$confirmPayment$invalidBlikDisputeDialog$de extends Translations$maker$confirmPayment$invalidBlikDisputeDialog$en {
	_Translations$maker$confirmPayment$invalidBlikDisputeDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Streitfall eröffnen?';
	@override String content({required Object code}) => 'Der Taker hat gemeldet, dass die ${code}-Zahlung von seinem Konto abgebucht wurde.\n\nWenn du sie als ungültig markierst, wird sofort ein STREITFALL eröffnet, der ein Eingreifen des Koordinators erfordert.\n\n• Eine Streitfallgebühr kann anfallen, wenn gegen dich entschieden wird\n• Die Hold-Invoice wird sofort abgewickelt\n• Eine manuelle Überprüfung ist erforderlich\n\nFahre nur fort, wenn du sicher bist, dass die ${code}-Zahlung NICHT erfolgreich war.';
	@override String get cancel => 'Abbrechen';
	@override String get confirmButton => 'Ja, Streitfall eröffnen';
}

// Path: maker.confirmPayment.feedback
class _Translations$maker$confirmPayment$feedback$de extends Translations$maker$confirmPayment$feedback$en {
	_Translations$maker$confirmPayment$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Maker hat die Zahlung bestätigt.';
	@override String get confirmedTakerPaid => 'Zahlung bestätigt! Der Taker erhält die Gelder.';
	@override String progressLabel({required Object seconds}) => 'Bestätigung: ${seconds} s verbleibend';
}

// Path: maker.confirmPayment.errors
class _Translations$maker$confirmPayment$errors$de extends Translations$maker$confirmPayment$errors$en {
	_Translations$maker$confirmPayment$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String failedToRetrieve({required Object code}) => 'Fehler: ${code}-Code konnte nicht abgerufen werden.';
	@override String retrieving({required Object code, required Object details}) => 'Fehler beim Abrufen des ${code}-Codes: ${details}';
	@override String get missingHashOrKey => 'Fehler: Payment-Hash oder öffentlicher Schlüssel fehlt.';
	@override String incorrectState({required Object status}) => 'Angebot ist nicht im richtigen Zustand für eine Bestätigung (Status: ${status})';
	@override String confirming({required Object details}) => 'Fehler beim Bestätigen der Zahlung: ${details}';
	@override String get invalidState => 'Fehler: Ungültiger Angebotszustand empfangen.';
	@override String get internalIncomplete => 'Interner Fehler: Unvollständige Angebotsdetails.';
	@override String notAwaitingConfirmation({required Object status}) => 'Angebot wartet nicht mehr auf Bestätigung (Status: ${status}).';
	@override String get unexpectedStatus => 'Unerwarteter Angebotsstatus vom Server empfangen.';
}

// Path: maker.conflict.actions
class _Translations$maker$conflict$actions$de extends Translations$maker$conflict$actions$en {
	_Translations$maker$conflict$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get back => 'Zurück zur Startseite';
	@override String confirmPayment({required Object code}) => 'Mein Fehler, ${code}-Zahlung als erfolgreich bestätigen';
	@override String openDispute({required Object code}) => '${code}-Zahlung war NICHT erfolgreich, STREITFALL ERÖFFNEN';
	@override String get submitDispute => 'Streitfall einreichen';
}

// Path: maker.conflict.disputeDialog
class _Translations$maker$conflict$disputeDialog$de extends Translations$maker$conflict$disputeDialog$en {
	_Translations$maker$conflict$disputeDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Streitfall eröffnen?';
	@override String get content => 'Das Eröffnen eines Streitfalls erfordert eine manuelle Überprüfung durch den Koordinator, was Zeit in Anspruch nimmt. Eine Streitfallgebühr wird abgezogen, wenn gegen dich entschieden wird. Die Hold-Invoice wird abgewickelt, um ihr Ablaufen zu verhindern. Wird zu deinen Gunsten entschieden, erhältst du eine Rückerstattung (abzüglich Gebühren) auf eine Wallet deiner Wahl.';
	@override String get contentDetailed => 'Das Eröffnen eines Streitfalls erfordert ein manuelles Eingreifen des Koordinators, was Zeit kostet und eine Streitfallgebühr verursacht.\n\nDie Hold-Invoice wird sofort abgewickelt, damit sie nicht vor der Lösung des Streitfalls abläuft.\n\nWird der Streitfall zu deinen Gunsten entschieden, wird der Satoshi-Betrag auf eine Wallet deiner Wahl zurückerstattet (abzüglich Gebühren). Stelle sicher, dass du eine empfangsbereite Wallet hast.';
	@override late final _Translations$maker$conflict$disputeDialog$actions$de actions = _Translations$maker$conflict$disputeDialog$actions$de._(_root);
}

// Path: maker.conflict.feedback
class _Translations$maker$conflict$feedback$de extends Translations$maker$conflict$feedback$en {
	_Translations$maker$conflict$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get disputeOpenedSuccess => 'Streitfall erfolgreich eröffnet. Der Koordinator wird ihn prüfen.';
}

// Path: maker.conflict.errors
class _Translations$maker$conflict$errors$de extends Translations$maker$conflict$errors$en {
	_Translations$maker$conflict$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String openingDispute({required Object error}) => 'Fehler beim Eröffnen des Streitfalls: ${error}';
}

// Path: maker.conflict.nostrContact
class _Translations$maker$conflict$nostrContact$de extends Translations$maker$conflict$nostrContact$en {
	_Translations$maker$conflict$nostrContact$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinator auf Nostr kontaktieren';
	@override String get description => 'Du kannst dem Koordinator direkt eine DM senden, um Hilfe bei diesem Streitfall zu erhalten.';
	@override String get copyNpub => 'npub kopieren';
	@override String get openProfile => 'Profil anzeigen';
	@override String get npubCopied => 'Koordinator-npub in die Zwischenablage kopiert!';
	@override String get yourIdentityDescription => 'Um DMs zu senden, melde dich mit deinem privaten Neko-Schlüssel (nsec) in einem beliebigen Nostr-Client an, der Direktnachrichten unterstützt.';
	@override String get manageNekoKeys => 'Neko-Schlüssel verwalten';
}

// Path: taker.submitBlik.actions
class _Translations$taker$submitBlik$actions$de extends Translations$taker$submitBlik$actions$en {
	_Translations$taker$submitBlik$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String submit({required Object code}) => '${code} senden';
}

// Path: taker.submitBlik.feedback
class _Translations$taker$submitBlik$feedback$de extends Translations$taker$submitBlik$feedback$en {
	_Translations$taker$submitBlik$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String pasted({required Object code}) => '${code}-Code eingefügt.';
}

// Path: taker.submitBlik.validation
class _Translations$taker$submitBlik$validation$de extends Translations$taker$submitBlik$validation$en {
	_Translations$taker$submitBlik$validation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String invalidFormat({required Object digits, required Object code}) => 'Gib einen gültigen ${digits}-stelligen ${code}-Code ein.';
}

// Path: taker.submitBlik.errors
class _Translations$taker$submitBlik$errors$de extends Translations$taker$submitBlik$errors$en {
	_Translations$taker$submitBlik$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String submitting({required Object code, required Object details}) => 'Fehler beim Senden des ${code}-Codes: ${details}';
	@override String clipboardInvalid({required Object digits, required Object code}) => 'Die Zwischenablage enthält keinen gültigen ${digits}-stelligen ${code}-Code.';
	@override String get stateChanged => 'Fehler: Angebotszustand hat sich geändert.';
	@override String get stateNotValid => 'Fehler: Angebotszustand ist nicht mehr gültig.';
	@override String fetchedIdMismatch({required Object fetchedId, required Object initialId}) => 'Abgerufene aktive Angebots-ID (${fetchedId}) stimmt nicht mit der ursprünglichen Angebots-ID (${initialId}) überein. Zustandskonflikt?';
	@override String get paymentHashMissing => 'Payment-Hash des Angebots fehlt nach dem Abruf.';
}

// Path: taker.submitBlik.details
class _Translations$taker$submitBlik$details$de extends Translations$taker$submitBlik$details$en {
	_Translations$taker$submitBlik$details$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String requestedAmount({required Object code}) => 'Angeforderter ${code}-Betrag';
	@override String get exchangeRate => 'Wechselkurs';
	@override String get takerFee => 'Taker-Gebühr';
	@override String get status => 'Status';
	@override String get youllReceive => 'Du erhältst';
}

// Path: taker.criticalCodeDecision.actions
class _Translations$taker$criticalCodeDecision$actions$de extends Translations$taker$criticalCodeDecision$actions$en {
	_Translations$taker$criticalCodeDecision$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Zurück und Bankkonto prüfen';
	@override String get proceed => 'Ich wurde NICHT belastet – fortfahren';
}

// Path: twint.scanner.status
class _Translations$twint$scanner$status$de extends Translations$twint$scanner$status$en {
	_Translations$twint$scanner$status$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String align({required Object code}) => 'Richte den ${code}-QR-Code und den Betragstext innerhalb des Kamerarahmens aus.';
	@override String notRecognized({required Object code}) => '${code}-Code noch nicht erkannt. Halte den QR-Code und den Betrag im Bild, oder fülle das Formular manuell aus.';
	@override String get amountFailed => 'Der Kamerascan konnte den Betrag nicht auslesen. Du kannst das QR-Ergebnis trotzdem verwenden und die Felder manuell korrigieren.';
}

// Path: twint.flow.progress
class _Translations$twint$flow$progress$de extends Translations$twint$flow$progress$en {
	_Translations$twint$flow$progress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Angebot erstellen';
	@override String get step2 => '2. Auf Taker warten';
	@override String get step3 => '3. Bestätigen';
}

// Path: twint.flow.takerProgress
class _Translations$twint$flow$takerProgress$de extends Translations$twint$flow$takerProgress$en {
	_Translations$twint$flow$takerProgress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String step1({required Object code}) => '1. ${code} bezahlen';
	@override String get step2 => '2. Sats erhalten';
}

// Path: twint.flow.makerWait
class _Translations$twint$flow$makerWait$de extends Translations$twint$flow$makerWait$en {
	_Translations$twint$flow$makerWait$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get takerPaying => 'Taker bezahlt';
	@override String yourCode({required Object code}) => 'Dein ${code}-Code';
	@override String offerExpires({required Object code}) => '${code} läuft ab';
	@override String get autoExpires => 'Läuft automatisch ab';
	@override String codeExpiresIn({required Object code}) => '${code} läuft ab in...';
	@override String get cancelOffer => 'Angebot stornieren';
	@override String reservedInfo({required Object code}) => 'Ein Taker hat dein Angebot reserviert und bezahlt jetzt deinen ${code}-Code in seiner Banking-App. Sobald die Zahlung bei deinem Händler eingegangen ist, bestätige sie unten.';
	@override String get confirmReceived => 'Zahlungseingang bestätigen';
	@override late final _Translations$twint$flow$makerWait$confirmDialog$de confirmDialog = _Translations$twint$flow$makerWait$confirmDialog$de._(_root);
}

// Path: twint.flow.makerExpired
class _Translations$twint$flow$makerExpired$de extends Translations$twint$flow$makerExpired$en {
	_Translations$twint$flow$makerExpired$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} wahrscheinlich abgelaufen';
	@override String warning({required Object code}) => 'Der ${code}-Code ist inzwischen wahrscheinlich abgelaufen — aber der Taker könnte ihn trotzdem noch bezahlt haben. Prüfe deinen Händler: du hast die unten angezeigte Zeit, um die Zahlung zu bestätigen.';
	@override String get timerCaption => 'Zeit zum Bestätigen';
	@override String get disputeHint => 'Du kannst auch warten, bis der Timer abläuft. Meldet der Taker, bezahlt zu haben, wird daraus ein Konflikt/Disput, bei dem beide Parteien dem Koordinator Nachweise zur Klärung liefern müssen.';
}

// Path: twint.flow.makerVerify
class _Translations$twint$flow$makerVerify$de extends Translations$twint$flow$makerVerify$en {
	_Translations$twint$flow$makerVerify$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hast du die Zahlung erhalten?';
	@override String body({required Object amount, required Object code}) => 'Der Taker meldet, dass er ${amount} an deinen ${code}-Code bezahlt hat.';
	@override String get hint => 'Prüfe den Zahlungsstatus bei deinem Händler (Shop-Terminal oder Online-Transaktion). Im Zweifel warte ab und prüfe später nochmal, bevor du dich entscheidest.';
	@override String get autoConfirms => 'Bestätigt automatisch';
	@override String get confirmReceived => 'Empfang bestätigen';
	@override String get openDispute => 'Streitfall eröffnen';
}

// Path: twint.flow.makerRecode
class _Translations$twint$flow$makerRecode$de extends Translations$twint$flow$makerRecode$en {
	_Translations$twint$flow$makerRecode$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Angebot abgelaufen';
	@override String body({required Object code}) => 'Kein Taker hat den Trade abgeschlossen. Gib einen neuen ${code}-Code ein, um dieses Angebot erneut zu veröffentlichen, oder storniere es.';
	@override String scanCardTitle({required Object code}) => 'Neuen ${code}-QR scannen';
	@override String get scanCardBody => 'Richte die Kamera auf den Zahlungsbildschirm. Die App füllt den neuen Code automatisch aus — der Betrag bleibt gleich.';
	@override String fieldLabel({required Object code}) => 'Neuer ${code}-Code';
	@override String get autoCancels => 'Wird automatisch storniert';
	@override String get relist => 'Mit neuem Code erneut veröffentlichen';
	@override String get cancelOffer => 'Angebot stornieren';
}

// Path: twint.flow.takerPay
class _Translations$twint$flow$takerPay$de extends Translations$twint$flow$takerPay$en {
	_Translations$twint$flow$takerPay$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Mit ${code} bezahlen';
	@override String body({required Object code, required Object amount}) => 'Öffne deine ${code}-App und bezahle ${amount} mit:';
	@override String get codeExpires => 'Code läuft ab';
	@override String get paid => 'Ich habe bezahlt';
	@override String get cancel => 'Abbrechen';
}

// Path: twint.flow.takerWait
class _Translations$twint$flow$takerWait$de extends Translations$twint$flow$takerWait$en {
	_Translations$twint$flow$takerWait$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Warten auf den Maker';
	@override String body({required Object code}) => 'Der Maker prüft, ob deine ${code}-Zahlung bei seinem Händler angekommen ist. Er muss den Erhalt bestätigen oder einen Streitfall eröffnen.';
	@override String get info => 'Wenn der Maker bis zum Ablauf des Timers nichts tut, wird die Zahlung automatisch bestätigt und du erhältst deine Sats.';
	@override String get autoConfirms => 'Bestätigt automatisch';
}

// Path: twint.flow.takerExpired
class _Translations$twint$flow$takerExpired$de extends Translations$twint$flow$takerExpired$en {
	_Translations$twint$flow$takerExpired$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} wahrscheinlich abgelaufen';
	@override String warning({required Object code}) => 'Der ${code}-Code ist inzwischen wahrscheinlich abgelaufen. Du musst jetzt eine wichtige Entscheidung treffen — wähle sorgfältig.';
	@override String optionPaid({required Object code}) => 'Wenn du den ${code}-Code in deiner Banking-App BEZAHLT hast, markiere ihn als bezahlt. Damit verpflichtest du dich zu dieser Aussage: der Maker muss sie bestätigen, um die Bitcoin freizugeben, oder einen Disput starten, bei dem beide Parteien dem Koordinator Nachweise liefern.';
	@override String get optionCancel => 'Wenn du NICHT bezahlt hast, storniere die Reservierung. Das ist unumkehrbar — falls die Zahlung doch durchging, kann der Koordinator deine Sats nicht mehr garantieren.';
	@override String noDecision({required Object code}) => 'Triffst du vor Ablauf des Timers keine Entscheidung, geht der Koordinator davon aus, dass du den ${code}-Code NICHT bezahlt hast. Der Maker kann das Angebot dann stornieren — wodurch die Hold-Invoice storniert wird — und der Koordinator kann dir die Sats danach nicht mehr auszahlen, selbst wenn du bezahlt hast.';
	@override String get timerCaption => 'Zeit zu entscheiden';
	@override String markPaid({required Object code}) => 'Ich habe den ${code}-Code bezahlt';
	@override String get cancel => 'Reservierung stornieren';
	@override late final _Translations$twint$flow$takerExpired$markPaidDialog$de markPaidDialog = _Translations$twint$flow$takerExpired$markPaidDialog$de._(_root);
	@override late final _Translations$twint$flow$takerExpired$cancelDialog$de cancelDialog = _Translations$twint$flow$takerExpired$cancelDialog$de._(_root);
}

// Path: twint.waitConfirmation.categoryReminder
class _Translations$twint$waitConfirmation$categoryReminder$de extends Translations$twint$waitConfirmation$categoryReminder$en {
	_Translations$twint$waitConfirmation$categoryReminder$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Hinweis zum Geldautomaten-Angebot: Deine Bank kann dich zusätzlich bitten, eine extra Automatengebühr zum Hauptbetrag zu genehmigen.';
	@override String get ecommerce => 'Hinweis zur Online-Bestellung: Falls der Händler eine automatische Rückerstattung auf dein Bankkonto sendet, kontaktiere den Koordinator und gib sie zurück.';
}

// Path: twint.waitConfirmation.takerCharged
class _Translations$twint$waitConfirmation$takerCharged$de extends Translations$twint$waitConfirmation$takerCharged$en {
	_Translations$twint$waitConfirmation$takerCharged$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Du hast ${code} als abgebucht markiert';
	@override String message({required Object minutes}) => 'Der Maker hat ${minutes} Min., um die Zahlung zu bestätigen oder anzufechten. Tut er nichts, wird die Zahlung automatisch bestätigt und du erhältst die Bitcoin.';
}

// Path: twint.waitConfirmation.expiredActions
class _Translations$twint$waitConfirmation$expiredActions$de extends Translations$twint$waitConfirmation$expiredActions$en {
	_Translations$twint$waitConfirmation$expiredActions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String reportConflict({required Object code}) => '${code} wurde von meinem Bankkonto abgebucht';
	@override String renewReservation({required Object code}) => 'Mit neuem ${code}-Code erneut versuchen';
	@override String get cancelReservation => 'Reservierung stornieren';
}

// Path: twint.waitConfirmation.feedback
class _Translations$twint$waitConfirmation$feedback$de extends Translations$twint$waitConfirmation$feedback$en {
	_Translations$twint$waitConfirmation$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmed => 'Maker hat die Zahlung bestätigt.';
	@override String get paymentSuccessful => 'Zahlung erfolgreich! Du erhältst die Gelder in Kürze.';
	@override String get conflictReported => 'Konflikt gemeldet. Der Koordinator wird die Situation prüfen.';
}

// Path: twint.waitConfirmation.errors
class _Translations$twint$waitConfirmation$errors$de extends Translations$twint$waitConfirmation$errors$en {
	_Translations$twint$waitConfirmation$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get invalidOfferStateReceived => 'Angebot mit ungültigem Zustand für diesen Bildschirm empfangen. Wird zurückgesetzt.';
	@override String reportingConflict({required Object details}) => 'Fehler beim Melden des Konflikts: ${details}';
}

// Path: twint.paymentProcess.states
class _Translations$twint$paymentProcess$states$de extends Translations$twint$paymentProcess$states$en {
	_Translations$twint$paymentProcess$states$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get preparing => 'Zahlung wird vorbereitet...';
	@override String get sending => 'Zahlung wird gesendet...';
	@override String get received => 'Zahlung erhalten!';
	@override String get failed => 'Zahlung fehlgeschlagen';
	@override String get waitingUpdate => 'Warte auf Angebotsaktualisierung...';
}

// Path: twint.paymentProcess.steps
class _Translations$twint$paymentProcess$steps$de extends Translations$twint$paymentProcess$steps$en {
	_Translations$twint$paymentProcess$steps$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String makerConfirmedBlik({required Object code}) => 'Maker hat die ${code}-Zahlung bestätigt';
	@override String get makerInvoiceSettled => 'Hold-Invoice des Makers abgewickelt';
	@override String get takerInvoicePaid => 'Deine Lightning-Invoice wird bezahlt';
	@override String get takerPaymentFailed => 'Zahlung an deine Invoice fehlgeschlagen';
}

// Path: twint.paymentProcess.errors
class _Translations$twint$paymentProcess$errors$de extends Translations$twint$paymentProcess$errors$en {
	_Translations$twint$paymentProcess$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String sending({required Object details}) => 'Fehler beim Senden der Zahlung: ${details}';
	@override String get notConfirmed => 'Angebot nicht vom Maker bestätigt.';
	@override String get expired => 'Angebot abgelaufen.';
	@override String get cancelled => 'Angebot storniert.';
	@override String get paymentFailed => 'Angebotszahlung fehlgeschlagen.';
	@override String get unknown => 'Unbekannter Angebotsfehler.';
	@override String get takerPaymentFailed => 'Die Zahlung an deine Lightning-Invoice ist fehlgeschlagen.';
	@override String get noPublicKey => 'Fehler: Dein öffentlicher Schlüssel kann nicht abgerufen werden.';
	@override String get loadingPublicKey => 'Fehler beim Laden deiner Daten';
	@override String get missingPaymentHash => 'Fehler: Zahlungsdetails fehlen.';
}

// Path: twint.paymentProcess.loading
class _Translations$twint$paymentProcess$loading$de extends Translations$twint$paymentProcess$loading$en {
	_Translations$twint$paymentProcess$loading$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get publicKey => 'Deine Daten werden geladen...';
}

// Path: twint.paymentProcess.actions
class _Translations$twint$paymentProcess$actions$de extends Translations$twint$paymentProcess$actions$en {
	_Translations$twint$paymentProcess$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get goToFailureDetails => 'Mit neuer Invoice erneut versuchen';
}

// Path: twint.paymentFailed.form
class _Translations$twint$paymentFailed$form$de extends Translations$twint$paymentFailed$form$en {
	_Translations$twint$paymentFailed$form$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get newInvoiceLabel => 'Neue Lightning-Invoice';
	@override String get newInvoiceHint => 'Gib deine BOLT11-Invoice ein';
}

// Path: twint.paymentFailed.actions
class _Translations$twint$paymentFailed$actions$de extends Translations$twint$paymentFailed$actions$en {
	_Translations$twint$paymentFailed$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get retryPayment => 'Neue Invoice senden';
}

// Path: twint.paymentFailed.errors
class _Translations$twint$paymentFailed$errors$de extends Translations$twint$paymentFailed$errors$en {
	_Translations$twint$paymentFailed$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get enterValidInvoice => 'Bitte gib eine gültige Invoice ein';
	@override String updatingInvoice({required Object details}) => 'Fehler beim Aktualisieren der Invoice: ${details}';
	@override String get paymentRetryFailed => 'Zahlungswiederholung fehlgeschlagen. Bitte prüfe die Invoice oder versuche es später erneut.';
	@override String get takerPublicKeyNotFound => 'Öffentlicher Schlüssel des Takers nicht gefunden.';
	@override String generateFailed({required Object details}) => 'Invoice konnte nicht erstellt werden: ${details}';
}

// Path: twint.paymentFailed.walletSection
class _Translations$twint$paymentFailed$walletSection$de extends Translations$twint$paymentFailed$walletSection$en {
	_Translations$twint$paymentFailed$walletSection$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Invoice aus Wallet erstellen';
	@override String get defaultLabel => 'Standard';
	@override String tapToGenerate({required Object amountSats}) => 'Tippe, um eine Invoice über ${amountSats} zu erstellen';
}

// Path: twint.paymentFailed.loading
class _Translations$twint$paymentFailed$loading$de extends Translations$twint$paymentFailed$loading$en {
	_Translations$twint$paymentFailed$loading$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get processingPayment => 'Deine Zahlungswiederholung wird verarbeitet...';
}

// Path: twint.paymentFailed.success
class _Translations$twint$paymentFailed$success$de extends Translations$twint$paymentFailed$success$en {
	_Translations$twint$paymentFailed$success$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlung erfolgreich';
	@override String get message => 'Deine Zahlung wurde erfolgreich verarbeitet.';
}

// Path: twint.paymentSuccess.actions
class _Translations$twint$paymentSuccess$actions$de extends Translations$twint$paymentSuccess$actions$en {
	_Translations$twint$paymentSuccess$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get goHome => 'Zur Startseite';
}

// Path: twint.invalidBlik.actions
class _Translations$twint$invalidBlik$actions$de extends Translations$twint$invalidBlik$actions$en {
	_Translations$twint$invalidBlik$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String retry({required Object code}) => 'Neuen ${code}-Code senden';
	@override String get cancelReservation => 'Transaktion abbrechen';
	@override String get reportConflict => 'Streitfall starten';
	@override String get returnHome => 'Zurück zur Startseite';
}

// Path: twint.invalidBlik.confirmDialog
class _Translations$twint$invalidBlik$confirmDialog$de extends Translations$twint$invalidBlik$confirmDialog$en {
	_Translations$twint$invalidBlik$confirmDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bist du sicher?';
	@override String get content => 'Sobald du hier tippst, gibt es kein Zurück mehr.\n\nWenn der Betrag TATSÄCHLICH von deinem Bankkonto abgebucht wurde, kann der Koordinator NICHT garantieren, dass du die Bitcoin erhältst, und du könntest deine Gelder verlieren.\n\nWenn du unsicher bist, warte am besten kurz und vergewissere dich, dass dir NICHTS abgebucht wurde, bevor du fortfährst.';
	@override late final _Translations$twint$invalidBlik$confirmDialog$actions$de actions = _Translations$twint$invalidBlik$confirmDialog$actions$de._(_root);
}

// Path: twint.invalidBlik.disputeConfirmDialog
class _Translations$twint$invalidBlik$disputeConfirmDialog$de extends Translations$twint$invalidBlik$disputeConfirmDialog$en {
	_Translations$twint$invalidBlik$disputeConfirmDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Streitfall starten?';
	@override String get content => 'Starte nur dann einen Streitfall, wenn der Betrag TATSÄCHLICH von deinem Bankkonto abgebucht wurde.\n\nDer Koordinator prüft deinen Fall manuell, was Zeit in Anspruch nimmt. Du musst einen Zahlungsnachweis vorlegen.';
	@override late final _Translations$twint$invalidBlik$disputeConfirmDialog$actions$de actions = _Translations$twint$invalidBlik$disputeConfirmDialog$actions$de._(_root);
}

// Path: twint.invalidBlik.feedback
class _Translations$twint$invalidBlik$feedback$de extends Translations$twint$invalidBlik$feedback$en {
	_Translations$twint$invalidBlik$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get conflictReportedSuccess => 'Konflikt gemeldet. Der Koordinator wird ihn prüfen.';
}

// Path: twint.invalidBlik.errors
class _Translations$twint$invalidBlik$errors$de extends Translations$twint$invalidBlik$errors$en {
	_Translations$twint$invalidBlik$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get reservationFailed => 'Erneute Reservierung des Angebots fehlgeschlagen';
	@override String conflictReport({required Object details}) => 'Fehler beim Melden des Konflikts: ${details}';
}

// Path: twint.conflict.actions
class _Translations$twint$conflict$actions$de extends Translations$twint$conflict$actions$en {
	_Translations$twint$conflict$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get back => 'Zurück zur Startseite';
}

// Path: twint.conflict.feedback
class _Translations$twint$conflict$feedback$de extends Translations$twint$conflict$feedback$en {
	_Translations$twint$conflict$feedback$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get reported => 'Konflikt gemeldet. Der Koordinator wird ihn prüfen.';
}

// Path: twint.conflict.errors
class _Translations$twint$conflict$errors$de extends Translations$twint$conflict$errors$en {
	_Translations$twint$conflict$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String reporting({required Object details}) => 'Fehler beim Melden des Konflikts: ${details}';
}

// Path: twint.conflict.nostrContact
class _Translations$twint$conflict$nostrContact$de extends Translations$twint$conflict$nostrContact$en {
	_Translations$twint$conflict$nostrContact$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinator auf Nostr kontaktieren';
	@override String get description => 'Du kannst dem Koordinator direkt eine DM senden, um Hilfe bei diesem Streitfall zu erhalten.';
	@override String get copyNpub => 'npub kopieren';
	@override String get openProfile => 'Profil anzeigen';
	@override String get npubCopied => 'Koordinator-npub in die Zwischenablage kopiert!';
	@override String get yourIdentityDescription => 'Um DMs zu senden, melde dich mit deinem privaten Neko-Schlüssel (nsec) in einem beliebigen Nostr-Client an, der Direktnachrichten unterstützt.';
	@override String get manageNekoKeys => 'Neko-Schlüssel verwalten';
}

// Path: home.statistics.errors
class _Translations$home$statistics$errors$de extends Translations$home$statistics$errors$en {
	_Translations$home$statistics$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String loading({required Object error}) => 'Fehler beim Laden der Statistiken: ${error}';
}

// Path: settings.offerCreation.categoryOptions
class _Translations$settings$offerCreation$categoryOptions$de extends Translations$settings$offerCreation$categoryOptions$en {
	_Translations$settings$offerCreation$categoryOptions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Geschäft, Café oder Restaurant';
	@override String get atm => 'Bargeldbezug am Geldautomaten';
	@override String get online => 'Online-Dienst/-Produkt';
}

// Path: settings.offerCreation.dialogs
class _Translations$settings$offerCreation$dialogs$de extends Translations$settings$offerCreation$dialogs$en {
	_Translations$settings$offerCreation$dialogs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get selectCategory => 'Standardkategorie wählen';
	@override String get selectBank => 'Standardbank wählen';
	@override String get selectCoordinator => 'Bevorzugten Koordinator wählen';
	@override String get premiumHint => 'Gib einen Prozentsatz wie 1.5 ein. Werte werden auf 0.5%-Schritte gerundet.';
	@override String get premiumHelper => 'Wird angewendet, wenn Premium-Preise aktiviert sind, und durch das Maximum des gewählten Koordinators begrenzt.';
}

// Path: settings.display.unitOptions
class _Translations$settings$display$unitOptions$de extends Translations$settings$display$unitOptions$en {
	_Translations$settings$display$unitOptions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sats => 'Sats';
	@override String get bitcoin => '₿ (BIP-177)';
}

// Path: settings.paymentSystem.countries
class _Translations$settings$paymentSystem$countries$de extends Translations$settings$paymentSystem$countries$en {
	_Translations$settings$paymentSystem$countries$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get PL => 'Polen';
	@override String get PT => 'Portugal';
	@override String get CH => 'Schweiz';
	@override String get SK => 'Slowakei';
}

// Path: maker.amountForm.category.options
class _Translations$maker$amountForm$category$options$de extends Translations$maker$amountForm$category$options$en {
	_Translations$maker$amountForm$category$options$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Geschäft, Café oder Restaurant';
	@override String get atmCashout => 'Bargeldbezug am Geldautomaten';
	@override String get onlineService => 'Online-Dienst/-Produkt';
}

// Path: maker.amountForm.category.shortLabels
class _Translations$maker$amountForm$category$shortLabels$de extends Translations$maker$amountForm$category$shortLabels$en {
	_Translations$maker$amountForm$category$shortLabels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Geschäft';
	@override String get atm => 'Geldautomat';
	@override String get online => 'Online';
}

// Path: maker.conflict.disputeDialog.actions
class _Translations$maker$conflict$disputeDialog$actions$de extends Translations$maker$conflict$disputeDialog$actions$en {
	_Translations$maker$conflict$disputeDialog$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Streitfall eröffnen';
	@override String get cancel => 'Abbrechen';
}

// Path: twint.flow.makerWait.confirmDialog
class _Translations$twint$flow$makerWait$confirmDialog$de extends Translations$twint$flow$makerWait$confirmDialog$en {
	_Translations$twint$flow$makerWait$confirmDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlungseingang bestätigen?';
	@override String content({required Object code}) => 'Bestätige nur, wenn du dir ABSOLUT sicher bist, dass die ${code}-Zahlung bei deinem Händler erfolgreich eingegangen ist.\n\nDie Bestätigung wickelt die Lightning-Hold-Invoice ab und sendet die Sats sofort an den Taker — das kann nicht rückgängig gemacht werden.';
	@override String get cancel => 'Abbrechen';
	@override String get confirmButton => 'Ja, Zahlung erhalten';
}

// Path: twint.flow.takerExpired.markPaidDialog
class _Translations$twint$flow$takerExpired$markPaidDialog$de extends Translations$twint$flow$takerExpired$markPaidDialog$en {
	_Translations$twint$flow$takerExpired$markPaidDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zahlung bestätigen?';
	@override String content({required Object code}) => 'Fahre nur fort, wenn du sicher bist, dass die ${code}-Zahlung in deiner Banking-App abgebucht wurde.\n\nDer Maker wird gebeten, den Empfang zu bestätigen, um die Bitcoin freizugeben. Bestreitet er ihn, wird ein Disput eröffnet und beide Parteien müssen dem Koordinator Nachweise liefern.';
	@override String get cancel => 'Zurück';
	@override String get confirmButton => 'Ja, ich habe bezahlt';
}

// Path: twint.flow.takerExpired.cancelDialog
class _Translations$twint$flow$takerExpired$cancelDialog$de extends Translations$twint$flow$takerExpired$cancelDialog$en {
	_Translations$twint$flow$takerExpired$cancelDialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reservierung stornieren?';
	@override String content({required Object code}) => 'Storniere nur, wenn du den ${code}-Code NICHT bezahlt hast.\n\nDas kann nicht rückgängig gemacht werden: falls die Zahlung doch durchging, kann der Koordinator NICHT garantieren, dass du die Sats erhältst.';
	@override String get cancel => 'Zurück';
	@override String get confirmButton => 'Ja, stornieren';
}

// Path: twint.invalidBlik.confirmDialog.actions
class _Translations$twint$invalidBlik$confirmDialog$actions$de extends Translations$twint$invalidBlik$confirmDialog$actions$en {
	_Translations$twint$invalidBlik$confirmDialog$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Ich bin sicher, weiter';
	@override String get cancel => 'Abbrechen';
}

// Path: twint.invalidBlik.disputeConfirmDialog.actions
class _Translations$twint$invalidBlik$disputeConfirmDialog$actions$de extends Translations$twint$invalidBlik$disputeConfirmDialog$actions$en {
	_Translations$twint$invalidBlik$disputeConfirmDialog$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Ja, mir wurde etwas abgebucht';
	@override String get cancel => 'Abbrechen';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => ({required Object app}) => '${app}',
			'app.greeting' => 'Hallo!',
			'app.changelog' => 'Änderungsprotokoll',
			'common.buttons.cancel' => 'Abbrechen',
			'common.buttons.save' => 'Speichern',
			'common.buttons.done' => 'Fertig',
			'common.buttons.retry' => 'Erneut versuchen',
			'common.buttons.goHome' => 'Zur Startseite',
			'common.buttons.saveAndContinue' => 'Speichern und fortfahren',
			'common.buttons.reveal' => 'Anzeigen',
			'common.buttons.hide' => 'Verbergen',
			'common.buttons.copy' => 'Kopieren',
			'common.buttons.close' => 'Schließen',
			'common.buttons.restore' => 'Wiederherstellen',
			'common.buttons.faq' => 'FAQ',
			'common.labels.amount' => ({required Object currency}) => 'Betrag (${currency})',
			'common.labels.status' => ({required Object status}) => 'Status: ${status}',
			'common.labels.role' => ({required Object role}) => 'Rolle: ${role}',
			'common.notifications.success' => 'Erfolg',
			'common.notifications.error' => 'Fehler',
			'common.notifications.loading' => 'Wird geladen...',
			'common.clipboard.copyToClipboard' => 'In Zwischenablage kopieren',
			'common.clipboard.pasteFromClipboard' => 'Aus Zwischenablage einfügen',
			'common.clipboard.copied' => 'In die Zwischenablage kopiert!',
			'common.actions.cancelAndReturnToOffers' => 'Abbrechen und zu den Angeboten zurückkehren',
			'common.actions.cancelAndReturnHome' => 'Abbrechen und zur Startseite zurückkehren',
			'lightningAddress.labels.address' => 'Lightning-Adresse (LNURL)',
			'lightningAddress.labels.hint' => 'benutzer@domain.com',
			'lightningAddress.labels.short' => ({required Object address}) => 'Lightning-Adresse: ${address}',
			'lightningAddress.labels.receivingAddress' => 'Deine Empfangsadresse:',
			'lightningAddress.prompts.enter' => 'Gib deine Lightning-Adresse ein, um fortzufahren',
			'lightningAddress.prompts.edit' => 'Bearbeiten',
			'lightningAddress.prompts.invalid' => 'Gib eine gültige Lightning-Adresse ein',
			'lightningAddress.prompts.required' => 'Lightning-Adresse ist erforderlich.',
			'lightningAddress.prompts.enterToTakeOffer' => 'Du musst eine Lightning-Adresse festlegen, um ein Angebot anzunehmen.',
			'lightningAddress.prompts.missing' => 'Lightning-Adresse fehlt. Bitte füge eine hinzu, um Angebote annehmen zu können.',
			'lightningAddress.prompts.add' => 'Hinzufügen',
			'lightningAddress.prompts.delete' => 'Löschen',
			'lightningAddress.prompts.confirmDelete' => 'Bist du sicher, dass du deine Lightning-Adresse löschen möchtest?',
			'lightningAddress.prompts.howToGet' => 'Du hast noch keine Lightning-Adresse? Erfahre, wie du eine bekommst!',
			'lightningAddress.prompts.learnMore' => 'Mehr über Lightning-Adressen erfahren',
			'lightningAddress.feedback.saved' => 'Lightning-Adresse gespeichert!',
			'lightningAddress.feedback.updated' => 'Lightning-Adresse aktualisiert!',
			'lightningAddress.feedback.valid' => 'Gültige Lightning-Adresse',
			'lightningAddress.errors.saving' => ({required Object details}) => 'Fehler beim Speichern der Adresse: ${details}',
			'lightningAddress.errors.loading' => ({required Object details}) => 'Fehler beim Laden der Lightning-Adresse: ${details}',
			'nfc.actions.scan' => 'NFC scannen',
			'nfc.actions.addWallet' => 'Wallet hinzufügen',
			'nfc.prompts.addTitle' => 'Lightning-Wallet hinzufügen?',
			'nfc.prompts.addMessage' => ({required Object address}) => 'Diese Lightning-Adresse wurde auf einem NFC-Tag gefunden: ${address}\n\nAls LNURL-Wallet hinzufügen?',
			'nfc.feedback.readyToScan' => 'Halte dein Telefon an das NFC-Tag',
			'nfc.feedback.alreadyScanning' => 'NFC-Scan läuft bereits',
			'nfc.feedback.alreadyAdded' => 'Diese Lightning-Adresse ist bereits eingerichtet',
			'nfc.feedback.walletAdded' => 'Lightning-Wallet vom NFC-Tag hinzugefügt',
			'nfc.errors.disabled' => 'NFC ist auf diesem Gerät deaktiviert',
			'nfc.errors.unsupported' => 'NFC ist auf diesem Gerät nicht verfügbar',
			'nfc.errors.reading' => ({required Object details}) => 'NFC-Scan fehlgeschlagen: ${details}',
			'offers.details.yourOffer' => 'Dein Angebot:',
			'offers.details.selectedOffer' => 'Angebot:',
			'offers.details.activeOffer' => 'Du hast ein aktives Angebot:',
			'offers.details.finishedOffers' => 'Abgeschlossene Angebote',
			'offers.details.noAvailable' => 'Keine verfügbaren Angebote.',
			'offers.details.noAvailableTip' => ({required Object app}) => 'Tipp: Teile ${app} in deiner Community und unter Freunden, um mehr ${app}-Aufträge zu erhalten.',
			'offers.details.noSuccessfulTrades' => 'Keine erfolgreichen Trades.',
			'offers.details.loadingDetails' => 'Angebotsdetails werden geladen...',
			'offers.details.amount' => ({required Object amount}) => 'Betrag: ${amount} Satoshi',
			'offers.details.amountWithCurrency' => ({required Object amount, required Object currency}) => '${amount} ${currency}',
			'offers.details.makerFee' => ({required Object fee}) => 'Gebühr: ${fee} Sats',
			'offers.details.takerFee' => ({required Object fee}) => 'Gebühr: ${fee} Sats',
			'offers.details.subtitle' => ({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (Gebühr) Satoshi\nStatus: ${status}',
			'offers.details.subtitleWithDate' => ({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (Gebühr) Satoshi\nStatus: ${status}\nBezahlt: ${date}',
			'offers.details.activeSubtitle' => ({required Object status, required Object amount}) => 'Status: ${status}\nBetrag: ${amount} Satoshi',
			'offers.details.id' => ({required Object id}) => 'Angebots-ID: ${id}...',
			'offers.details.created' => ({required Object dateTime}) => 'Erstellt: ${dateTime}',
			'offers.details.takenAfter' => ({required Object duration}) => 'Angenommen nach: ${duration}',
			'offers.details.paidAfter' => ({required Object duration}) => 'Bezahlt nach: ${duration}',
			'offers.details.exchangeRate' => 'Wechselkurs',
			'offers.details.amountLabel' => 'Betrag',
			'offers.details.makerFeeLabel' => 'Maker-Gebühr',
			'offers.details.takerFeeLabel' => 'Taker-Gebühr',
			'offers.details.feeLabel' => 'Gebühr',
			'offers.details.statusLabel' => 'Status',
			'offers.details.youllReceive' => 'Du erhältst',
			'offers.details.coordinator' => 'Koordinator',
			'offers.details.categoryLabel' => 'Kategorie',
			'offers.details.categories.physicalShop' => 'Geschäft, Café oder Restaurant',
			'offers.details.categories.atmCashout' => 'Bargeldbezug am Geldautomaten',
			'offers.details.categories.onlineService' => 'Online-Dienst/-Produkt',
			'offers.details.consents.atm' => 'Manche Geldautomaten erheben eine zusätzliche Gebühr auf den Angebotsbetrag. Mit der Annahme dieses Angebots akzeptierst du alle zusätzlichen Bankgebühren, die der Geldautomat verlangt.',
			'offers.details.consents.ecommerce' => ({required Object code}) => 'Aus verschiedenen Gründen — etwa ein ausverkaufter Artikel, eine Korrektur einer Überzahlung oder andere Probleme auf Händlerseite — kann der Online-Händler automatisch Geld auf das Bankkonto zurücksenden, das mit dem von dir generierten ${code} verknüpft ist. Diese Gelder landen auf deinem Konto und gehören nicht dir. Falls dies passiert, kontaktiere den Koordinator in gutem Glauben und vereinbare die Rückgabe der Gelder an den Maker. Mit der Annahme dieses Angebots akzeptierst du diese Bedingungen und verpflichtest dich ehrenhaft, in solchen Situationen ehrlich zu handeln.',
			'offers.labels.premium' => 'Premium',
			'offers.labels.premiumBadge' => ({required Object percent}) => '+${percent}% Premium',
			'offers.tooltips.takerFeeInfo' => ({required Object feePercent}) => 'Der Koordinator erhebt eine Taker-Gebühr von ${feePercent}%. Diese enthält Lightning-Routing-Gebühren und wird vom Betrag abgezogen, den du erhältst.',
			'offers.tooltips.premiumInfoTaker' => 'Ein Premium bedeutet, dass dieses Angebot über dem Marktpreis liegt. Für denselben Fiat-Betrag sperrt der Maker weniger Sats in der Hold-Invoice, du zahlst also über Marktpreis und erhältst weniger Sats als zum Marktkurs. Das maximale Premium wird vom Koordinator festgelegt.',
			'offers.tooltips.ratesFetchedAt' => 'Abgerufen um',
			'offers.tooltips.ratesSources' => 'Durchschn. Kursquellen',
			'offers.actions.take' => 'ANNEHMEN',
			'offers.actions.takeOffer' => 'Angebot annehmen',
			'offers.actions.resume' => ({required Object code}) => '${code} EINGEBEN',
			'offers.actions.cancel' => 'Angebot stornieren',
			'offers.actions.view' => 'Details anzeigen',
			'offers.status.created' => 'Erstellt',
			'offers.status.funded' => 'Finanziert',
			'offers.status.expired' => 'Abgelaufen',
			'offers.status.cancelled' => 'Storniert',
			'offers.status.reserved' => 'Reserviert',
			'offers.status.blikReceived' => ({required Object code}) => '${code} gesendet',
			'offers.status.blikSentToMaker' => ({required Object code}) => '${code} empfangen',
			'offers.status.expiredBlik' => ({required Object code}) => '${code} abgelaufen',
			'offers.status.expiredSentBlik' => ({required Object code}) => '${code} abgelaufen',
			'offers.status.takerCharged' => 'Taker belastet',
			'offers.status.invalidBlik' => ({required Object code}) => 'Ungültiger ${code}',
			'offers.status.conflict' => 'Konflikt',
			'offers.status.dispute' => 'Streitfall',
			'offers.status.makerConfirmed' => 'Bestätigt',
			'offers.status.settled' => 'Abgewickelt',
			'offers.status.payingTaker' => 'Taker wird bezahlt',
			'offers.status.takerPaymentFailed' => 'Taker-Zahlung fehlgeschlagen',
			'offers.status.takerPaid' => 'Taker bezahlt',
			'offers.status.unknownStatus' => 'Unbekannt',
			'offers.statusMessages.reserved' => 'Angebot vom Taker reserviert!',
			'offers.statusMessages.cancelled' => 'Angebot erfolgreich storniert.',
			'offers.statusMessages.cancelledOrExpired' => 'Angebot wurde storniert oder ist abgelaufen.',
			'offers.statusMessages.noLongerAvailable' => ({required Object status}) => 'Angebot ist nicht mehr verfügbar (Status: ${status}).',
			'offers.progress.waitingForTaker' => ({required Object time}) => 'Warte auf Taker: ${time}',
			'offers.progress.reserved' => ({required Object seconds}) => 'Reserviert: ${seconds} s verbleibend',
			'offers.progress.confirming' => ({required Object seconds}) => 'Bestätigung: ${seconds} s verbleibend',
			'offers.errors.loading' => ({required Object details}) => 'Fehler beim Laden der Angebote: ${details}',
			'offers.errors.loadingDetails' => ({required Object details}) => 'Fehler beim Laden der Angebotsdetails: ${details}',
			'offers.errors.detailsMissing' => 'Fehler: Angebotsdetails fehlen oder sind ungültig.',
			'offers.errors.detailsNotLoaded' => 'Angebotsdetails konnten nicht geladen werden.',
			'offers.errors.notFound' => 'Fehler: Angebot nicht gefunden.',
			'offers.errors.unexpectedState' => 'Fehler: Angebot befindet sich in einem unerwarteten Zustand.',
			'offers.errors.unexpectedStateWithStatus' => ({required Object status}) => 'Angebot befindet sich in einem unerwarteten Zustand (${status}). Bitte versuche es erneut oder kontaktiere den Support.',
			'offers.errors.invalidStatus' => 'Angebot hat einen ungültigen Status.',
			'offers.errors.couldNotIdentify' => 'Fehler: Zu stornierendes Angebot konnte nicht identifiziert werden.',
			'offers.errors.cannotBeCancelled' => ({required Object status}) => 'Angebot kann im aktuellen Zustand nicht storniert werden (${status}).',
			'offers.errors.failedToCancel' => ({required Object details}) => 'Stornierung des Angebots fehlgeschlagen: ${details}',
			'offers.errors.activeDetailsLost' => 'Fehler: Details des aktiven Angebots verloren.',
			'offers.errors.checkingActive' => ({required Object details}) => 'Fehler beim Prüfen aktiver Angebote: ${details}',
			'offers.errors.cannotResume' => ({required Object status}) => 'Angebot kann in diesem Zustand nicht fortgesetzt werden: ${status}',
			'offers.errors.cannotResumeTaker' => ({required Object status}) => 'Taker-Angebot kann in diesem Zustand nicht fortgesetzt werden: ${status}',
			'offers.errors.resuming' => ({required Object details}) => 'Fehler beim Fortsetzen des Angebots: ${details}',
			'offers.errors.makerPublicKeyNotFound' => 'Öffentlicher Schlüssel des Makers nicht gefunden',
			'offers.errors.takerPublicKeyNotFound' => 'Öffentlicher Schlüssel des Takers nicht gefunden.',
			'offers.errors.atmConsentRequired' => 'Akzeptiere die Geldautomaten-Gebührenbedingung, bevor du dieses Angebot annimmst.',
			'offers.errors.ecommerceConsentRequired' => 'Akzeptiere die Bedingung zur Rückerstattung bei Online-Käufen, bevor du dieses Angebot annimmst.',
			'offers.errors.cannotTakeOwnOffer' => 'Du kannst dein eigenes Angebot nicht annehmen.',
			'offers.success.title' => 'Angebot abgeschlossen',
			'offers.success.headline' => 'Zahlung bestätigt!',
			'offers.success.subtitle' => 'Der Taker wird jetzt bezahlt.',
			'offers.success.detailsTitle' => 'Angebotsdetails:',
			'offers.success.duration' => ({required Object time}) => 'Das Angebot dauerte ${time} bis zum Abschluss.',
			'reservations.actions.cancel' => 'Reservierung stornieren',
			'reservations.feedback.cancelled' => 'Reservierung storniert.',
			'reservations.errors.cancelling' => ({required Object error}) => 'Stornierung der Reservierung fehlgeschlagen: ${error}',
			'reservations.errors.failedToReserve' => ({required Object details}) => 'Reservierung des Angebots fehlgeschlagen: ${details}',
			'reservations.errors.failedNoTimestamp' => 'Reservierung des Angebots fehlgeschlagen (kein Zeitstempel).',
			'reservations.errors.timestampMissing' => 'Zeitstempel der Angebotsreservierung fehlt.',
			'reservations.errors.notReserved' => ({required Object status}) => 'Angebot ist nicht mehr im reservierten Zustand (${status}).',
			'exchange.labels.enterAmount' => ({required Object currency}) => 'Zu zahlenden Betrag (${currency}) eingeben:',
			'exchange.labels.equivalent' => ({required Object sats}) => '≈ ${sats} Satoshi',
			'exchange.labels.rate' => ({required Object rate, required Object currency}) => 'Wechselkurs ≈ ${rate} ${currency}/BTC',
			'exchange.feedback.fetching' => 'Wechselkurs wird abgerufen...',
			'exchange.errors.fetchingRate' => 'Wechselkurs konnte nicht abgerufen werden.',
			'exchange.errors.invalidFormat' => 'Ungültiges Zahlenformat',
			'exchange.errors.mustBePositive' => 'Betrag muss positiv sein',
			'exchange.errors.invalidFeePercentage' => 'Ungültiger Gebührensatz',
			'exchange.errors.tooLowFiat' => ({required Object minAmount, required Object currency}) => 'Betrag ist zu niedrig. Minimum ist ${minAmount} ${currency}.',
			'exchange.errors.tooHighFiat' => ({required Object maxAmount, required Object currency}) => 'Betrag ist zu hoch. Maximum ist ${maxAmount} ${currency}.',
			'exchange.errors.atmNotDispensable' => ({required Object notes}) => 'Der Geldautomat kann diesen Betrag nicht ausgeben. Verwende eine Kombination von Scheinen: ${notes}.',
			'exchange.errors.atmOverBankLimit' => ({required Object bank, required Object limit, required Object currency}) => '${bank} zahlt pro Abhebung höchstens ${limit} ${currency} aus.',
			'coordinator.title' => 'Koordinatoren',
			'coordinator.info.fee' => 'Gebühr',
			'coordinator.info.rangeDisplay' => ({required Object minAmount, required Object maxAmount, required Object currency}) => 'Betrag: ${minAmount}-${maxAmount} ${currency}',
			'coordinator.info.feeDisplay' => ({required Object fee}) => '${fee}% Gebühr',
			'coordinator.selector.loading' => 'Koordinatoren werden geladen...',
			'coordinator.selector.errorLoading' => 'Fehler beim Laden der Koordinatoren',
			'coordinator.selector.choose' => 'Koordinator wählen',
			'coordinator.selector.viewNostrProfile' => 'Nostr-Profil anzeigen',
			'coordinator.selector.unresponsive' => 'Dieser Koordinator reagiert nicht',
			'coordinator.selector.waitingResponse' => 'Warte auf Antwort des Koordinators',
			'coordinator.selector.termsAccept' => 'Ich akzeptiere die ',
			'coordinator.selector.termsOfUsage' => 'Nutzungsbedingungen des Koordinators',
			'coordinator.dialog.makerFee' => 'Maker-Gebühr',
			'coordinator.dialog.takerFee' => 'Taker-Gebühr',
			'coordinator.dialog.amountRange' => 'Betragsbereich',
			'coordinator.dialog.reservationTime' => 'Reservierungszeit',
			'coordinator.dialog.currencies' => 'Währungen',
			'coordinator.dialog.viewTerms' => 'Bedingungen anzeigen',
			'coordinator.details.title' => 'Koordinator',
			'coordinator.details.relaysInUse' => 'Verwendete Relays',
			'coordinator.details.relaysInUseHint' => 'Die gesamte Kommunikation mit diesem Koordinator läuft über diese Relays (aus seiner NIP-65-Liste).',
			'coordinator.details.noRelays' => 'Noch keine Relays bekannt',
			'coordinator.details.makerFee' => 'Maker-Gebühr',
			'coordinator.details.takerFee' => 'Taker-Gebühr',
			'coordinator.details.amountRange' => 'Betragsbereich',
			'coordinator.details.maxPremium' => 'Max. Premium',
			'coordinator.details.maxPremiumInfoTitle' => 'Premium',
			'coordinator.details.maxPremiumInfoBody' => 'Ein Premium ist ein optionaler Preisaufschlag über dem Marktkurs, den ein Maker auf ein Angebot setzen kann. Mit einem Premium sperrt der Maker weniger Sats für denselben Fiat-Betrag, sodass der Taker über Marktpreis zahlt und der Maker die Differenz behält. Dieser Wert ist das höchste Premium, das dieser Koordinator für seine Angebote erlaubt.',
			'coordinator.details.reservationTime' => 'Reservierungszeit',
			'coordinator.details.currencies' => 'Währungen',
			'coordinator.details.paymentSystem' => 'Zahlungssystem',
			'coordinator.details.version' => 'Version',
			'coordinator.details.yourOffers' => 'Deine Angebote',
			'coordinator.details.successfulOffers' => 'Erfolgreiche Angebote (30 T.)',
			'coordinator.details.statusOnline' => 'Online',
			'coordinator.details.statusOffline' => 'Offline',
			'coordinator.details.statusUnknown' => 'Unbekannt',
			'coordinator.details.openNostrProfile' => 'Nostr-Profil öffnen',
			'coordinator.details.termsOfUsage' => 'Nutzungsbedingungen',
			'coordinator.coldStart.title' => 'Koordinatoren werden gesucht',
			'coordinator.coldStart.body' => ({required Object app}) => '${app} sucht öffentliche Koordinatoren, prüft, welche erreichbar sind, und aktiviert eine kleine Standardauswahl für dich.',
			'coordinator.coldStart.settingsHint' => 'Du kannst die aktivierten Koordinatoren später in den Einstellungen ändern.',
			'coordinator.coldStart.ok' => 'OK',
			'coordinator.coldStart.discovered' => 'Entdeckt',
			'coordinator.coldStart.candidates' => 'Kandidaten',
			'coordinator.coldStart.enabled' => 'Aktiviert',
			'coordinator.coldStart.recordsTitle' => 'Aktuelle Koordinatoren',
			'coordinator.coldStart.recordEnabled' => 'Aktiviert',
			'coordinator.coldStart.recordHealthyCandidate' => 'Funktionierender Kandidat',
			'coordinator.coldStart.recordOfflineCandidate' => 'Kandidat offline',
			'coordinator.coldStart.recordChecking' => 'Wird geprüft',
			'coordinator.coldStart.recordDiscovered' => 'Entdeckt',
			'coordinator.coldStart.phases.loadingMuteList' => 'Koordinator-Filter werden geladen',
			'coordinator.coldStart.phases.discovering' => 'Koordinatoren werden auf Nostr gesucht',
			'coordinator.coldStart.phases.loadingProfiles' => 'Koordinator-Profile werden geladen',
			'coordinator.coldStart.phases.loadingStats' => 'Koordinator-Historie wird gelesen',
			'coordinator.coldStart.phases.checkingHealth' => 'Koordinator-Verfügbarkeit wird geprüft',
			'coordinator.coldStart.phases.finalizing' => 'Standard-Koordinatoren werden aktiviert',
			'coordinator.coldStart.phases.completed' => 'Fertig',
			'coordinator.management.title' => 'Koordinator-Verwaltung',
			'coordinator.management.availableCoordinators' => 'Koordinatoren',
			'coordinator.management.noCoordinators' => 'Noch keine Koordinatoren entdeckt.',
			'coordinator.management.online' => 'Online',
			'coordinator.management.unknownOffline' => 'Unbekannt/Offline',
			'coordinator.management.openNostrProfile' => 'Nostr-Profil öffnen',
			'coordinator.management.enable' => 'Aktivieren',
			'coordinator.management.remove' => 'Entfernen',
			'coordinator.management.addCustomWhitelist' => 'Eigenen Koordinator hinzufügen',
			'coordinator.management.addCustomWhitelistHint' => 'npub1...',
			'coordinator.management.add' => 'Hinzufügen',
			'coordinator.management.coordinatorDisabled' => 'Koordinator deaktiviert',
			'coordinator.management.coordinatorEnabled' => 'Koordinator aktiviert',
			'coordinator.management.coordinatorAdded' => 'Koordinator zur eigenen Whitelist hinzugefügt',
			'coordinator.management.coordinatorRemoved' => 'Koordinator von der eigenen Whitelist entfernt',
			'coordinator.management.coordinatorAddInfoUnavailable' => 'Keine Koordinator-Informationen auf den Relays gefunden. Koordinator nicht hinzugefügt.',
			'coordinator.management.pleaseEnterNpub' => 'Bitte gib einen npub ein',
			'coordinator.management.error' => 'Fehler',
			'coordinator.management.metricYourOffers' => 'Deine Angebote',
			'coordinator.management.metricYourOffersTooltip' => 'Anzahl der Angebote, die du mit diesem Koordinator erfolgreich abgeschlossen hast.',
			'coordinator.management.metricNetworkOffers' => 'Angebote (30 T.)',
			'coordinator.management.metricNetworkOffersTooltip' => 'Erfolgreiche Angebote, die dieser Koordinator in den letzten 30 Tagen über alle Nutzer abgewickelt hat.',
			'maker.roleSelection.button' => 'Mit Lightning BEZAHLEN',
			'maker.amountForm.progress.step1' => '1. Angebot erstellen',
			'maker.amountForm.progress.step2' => '2. Auf Taker warten',
			'maker.amountForm.progress.step3' => ({required Object code}) => '3. ${code} verwenden',
			'maker.amountForm.labels.coordinator' => 'Koordinator',
			'maker.amountForm.labels.category' => 'Kategorie',
			'maker.amountForm.labels.exchangeRate' => 'Wechselkurs',
			'maker.amountForm.labels.fee' => 'Gebühr',
			'maker.amountForm.labels.satoshisToPay' => 'Zu zahlender Betrag',
			'maker.amountForm.labels.enterAmount' => 'Betrag eingeben',
			'maker.amountForm.labels.customAmount' => 'Benutzerdefiniert',
			'maker.amountForm.labels.tapToSelect' => 'Zum Auswählen tippen',
			'maker.amountForm.labels.premium' => 'Premium',
			'maker.amountForm.actions.generateInvoice' => 'Invoice erstellen',
			'maker.amountForm.bank.label' => 'Bank',
			'maker.amountForm.bank.required' => 'Bitte wähle eine Bank',
			'maker.amountForm.bank.shortValidityWarning' => ({required Object minutes}) => 'Der Code dieser Bank ist nur ${minutes} Min gültig — sei vor dem Reservieren am Geldautomaten.',
			'maker.amountForm.twintScan.cardTitle' => ({required Object code}) => '${code}-QR und Betrag scannen',
			'maker.amountForm.twintScan.cardBody' => 'Richte die Kamera auf den Zahlungsbildschirm. Die App füllt den Code und, wenn sichtbar, den Betrag automatisch aus.',
			'maker.amountForm.twintScan.scanButton' => 'Mit Kamera scannen',
			'maker.amountForm.twintScan.manualButton' => 'Stattdessen manuell eingeben',
			'maker.amountForm.twintScan.codeLabel' => ({required Object code}) => '${code}-Code',
			'maker.amountForm.twintScan.rescan' => 'Erneut scannen',
			'maker.amountForm.twintScan.helperFilled' => ({required Object code}) => 'Der Taker sieht diesen Code und gibt ihn in ${code} ein.',
			'maker.amountForm.twintScan.helperEmpty' => ({required Object digits}) => 'Scanne, um dies automatisch auszufüllen, oder gib den ${digits}-stelligen Code manuell ein.',
			'maker.amountForm.tooltips.feeInfo' => ({required Object feePercent}) => 'Der Koordinator erhebt eine Maker-Gebühr von ${feePercent}%. Diese Gebühr wird von deiner Lightning-Zahlung abgezogen.',
			'maker.amountForm.tooltips.payInfo' => 'Diese Berechnung basiert auf clientseitig abgerufenen Wechselkursen. Der Koordinator berechnet den genauen Betrag, und der Invoice-Betrag ist der endgültige und exakte Zahlbetrag.',
			'maker.amountForm.tooltips.premiumInfo' => 'Mit einem optionalen Premium kannst du deine Sats über dem Marktpreis verkaufen. Das Premium reduziert die in deiner Hold-Invoice gesperrten Sats für denselben Fiat-Betrag, sodass der Taker über Marktpreis zahlt und du die Differenz behältst. Standardmäßig deaktiviert (0%). Das maximale Premium wird vom gewählten Koordinator festgelegt.',
			'maker.amountForm.category.label' => 'Angebotskategorie',
			'maker.amountForm.category.unsupportedForSystem' => ({required Object system}) => '${system} unterstützt diese Kategorie nicht.',
			'maker.amountForm.category.options.physicalShop' => 'Geschäft, Café oder Restaurant',
			'maker.amountForm.category.options.atmCashout' => 'Bargeldbezug am Geldautomaten',
			'maker.amountForm.category.options.onlineService' => 'Online-Dienst/-Produkt',
			'maker.amountForm.category.shortLabels.shop' => 'Geschäft',
			'maker.amountForm.category.shortLabels.atm' => 'Geldautomat',
			'maker.amountForm.category.shortLabels.online' => 'Online',
			'maker.amountForm.category.atmHint' => 'Taker sehen, dass dieses Angebot für einen Bargeldbezug am Geldautomaten ist, und meiden es möglicherweise, wenn ihre Bank zusätzliche Automatengebühren erhebt.',
			'maker.amountForm.category.physicalShopHint' => ({required Object app, required Object code}) => 'Der ideale Ort, um ${app} zu nutzen, ist ein Selbstbedienungsterminal — denn das Warten darauf, dass ein Taker reserviert, einen ${code}-Code generiert und bestätigt, kann ein paar Minuten dauern. Funktioniert bestens in Geschäften, Cafés und Restaurants. Wenn du mutig genug bist, eine reguläre Kasse (und die Leute in der Schlange hinter dir) diese paar Minuten warten zu lassen — gut für dich.',
			'maker.amountForm.category.ecommerceWarningTitle' => 'Rückerstattungsrisiko bei Online-Händlern',
			'maker.amountForm.category.ecommerceWarningBody' => ({required Object code}) => 'Aus verschiedenen Gründen — etwa ein ausverkaufter Artikel, eine Korrektur einer Überzahlung oder andere Probleme auf Händlerseite — kann der Online-Händler automatisch eine Rückerstattung auf das Bankkonto veranlassen, das mit dem ${code} verknüpft ist, also das Konto des Takers. Der Koordinator kann den Taker nicht zwingen, dir diese Gelder zurückzugeben.',
			'maker.amountForm.category.ecommerceConfirmation' => 'Ich verstehe das Rückerstattungsrisiko und werde der Bestellung eine Notiz hinzufügen, die den Händler anweist, eine eventuelle Rückerstattung auf ein anderes Konto zu leisten.',
			'maker.amountForm.category.whyThisIsNeeded' => 'Warum ist das nötig?',
			'maker.amountForm.onboarding.titlePrefix' => 'Neu',
			'maker.amountForm.onboarding.title' => 'Wähle die Angebotskategorie',
			'maker.amountForm.onboarding.body' => 'Wähle die Kategorie, die am besten zu deinem Kauf passt, bevor du die Invoice erstellst.',
			'maker.amountForm.onboarding.showWhy' => 'Warum ist das wichtig?',
			'maker.amountForm.onboarding.hideWhy' => 'Details ausblenden',
			'maker.amountForm.onboarding.whyTitle' => 'Die richtige Kategorie hilft Takern, sicher zu entscheiden',
			'maker.amountForm.onboarding.whyBody' => 'Unterschiedliche Situationen bringen unterschiedliche Erwartungen und Risiken mit sich. Bargeldbezüge am Geldautomaten können zusätzliche Bankgebühren verursachen, und Online-Käufe können Rückerstattungs-Sonderfälle beinhalten. Die richtige Kategorie gibt Takern den Kontext, den sie brauchen, bevor sie dein Angebot annehmen.',
			'maker.amountForm.onboarding.cta' => 'Verstanden',
			'maker.amountForm.errors.initiating' => ({required Object details}) => 'Fehler beim Erstellen des Angebots: ${details}',
			'maker.amountForm.errors.publicKeyNotLoaded' => 'Fehler: Öffentlicher Schlüssel noch nicht geladen.',
			'maker.amountForm.errors.noCoordinatorMatchesAmount' => 'Kein Koordinator unterstützt diesen Betrag. Versuche einen anderen Wert.',
			'maker.amountForm.errors.categoryRequired' => 'Wähle eine Angebotskategorie.',
			'maker.amountForm.errors.ecommerceConfirmationRequired' => 'Bestätige das Rückerstattungsrisiko des Online-Händlers, bevor du fortfährst.',
			'maker.payInvoice.title' => 'Bezahle diese Hold-Invoice:',
			'maker.payInvoice.actions.copy' => 'Invoice kopieren',
			'maker.payInvoice.actions.payInWallet' => 'In externer Wallet öffnen',
			'maker.payInvoice.actions.connectWallet' => 'Wallet verbinden',
			'maker.payInvoice.actions.payWithNwc' => 'Bezahlen',
			'maker.payInvoice.actions.paying' => 'Wird bezahlt...',
			'maker.payInvoice.feedback.copied' => 'Invoice in die Zwischenablage kopiert!',
			'maker.payInvoice.feedback.waitingConfirmation' => 'Warte auf Zahlungsbestätigung...',
			'maker.payInvoice.feedback.nwcConnected' => 'NWC-Wallet verbunden!',
			'maker.payInvoice.feedback.nwcPaymentSuccess' => 'Zahlung erfolgreich!',
			'maker.payInvoice.errors.couldNotOpenApp' => 'Lightning-App für die Invoice konnte nicht geöffnet werden.',
			'maker.payInvoice.errors.openingApp' => ({required Object details}) => 'Fehler beim Öffnen der Lightning-App: ${details}',
			'maker.payInvoice.errors.publicKeyNotAvailable' => 'Öffentlicher Schlüssel ist nicht verfügbar.',
			'maker.payInvoice.errors.couldNotFetchActive' => 'Details des aktiven Angebots konnten nicht abgerufen werden. Es ist möglicherweise abgelaufen.',
			'maker.payInvoice.errors.nwcPaymentFailed' => ({required Object details}) => 'Zahlung fehlgeschlagen: ${details}',
			'maker.payInvoice.errors.nwcNotConnected' => 'NWC-Wallet nicht verbunden',
			'maker.payInvoice.errors.insufficientBalance' => ({required Object required, required Object available}) => 'Unzureichendes Guthaben. Benötigt ${required} Sats, verfügbar ${available} Sats',
			'maker.payInvoice.errors.cancelOfferAlreadyFunded' => 'Der Koordinator meldet, dass dieses Angebot bereits finanziert ist. Es kann jetzt nicht mehr storniert werden.',
			'maker.payInvoice.errors.cancelFailed' => ({required Object details}) => 'Angebot konnte nicht storniert werden: ${details}',
			'maker.payInvoice.budgetWarning.title' => 'Zahlung könnte fehlschlagen',
			'maker.payInvoice.budgetWarning.balanceTooLow' => ({required Object name}) => 'Deine Standard-Wallet ${name} hat nicht genug Guthaben für diese Zahlung.',
			'maker.payInvoice.budgetWarning.budgetTooLow' => ({required Object name}) => 'Deine Standard-Wallet ${name} hat nicht genug Ausgabebudget für diese Zahlung.',
			'maker.payInvoice.budgetWarning.balanceLine' => ({required Object available}) => 'Guthaben: ${available}',
			'maker.payInvoice.budgetWarning.budgetLine' => ({required Object remaining}) => 'Verbleibendes NWC-Budget: ${remaining}',
			'maker.payInvoice.budgetWarning.requiredLine' => ({required Object required}) => 'Benötigt: ${required}',
			'maker.payInvoice.budgetWarning.addFundsHint' => ({required Object name}) => 'Füge ${name} Guthaben hinzu, um diesen Zahlungsbetrag zu decken.',
			'maker.payInvoice.budgetWarning.increaseBudgetHint' => 'Erhöhe das NWC-Ausgabebudget für diese Verbindung in deiner Wallet-App.',
			'maker.payInvoice.budgetWarning.switchWalletLabel' => 'Oder verwende eine andere Wallet:',
			'maker.payInvoice.budgetWarning.walletLowFundsTag' => 'Könnte fehlschlagen',
			'maker.payInvoice.budgetWarning.payAnyway' => 'Trotzdem versuchen',
			'maker.payInvoice.budgetWarning.cancel' => 'Abbrechen',
			'maker.payInvoice.budgetWarning.readyTitle' => 'Invoice bezahlen',
			'maker.waitTaker.message' => 'Warte auf einen Taker, der dein Angebot reserviert...',
			'maker.waitTaker.progressLabel' => ({required Object time}) => 'Warte auf Taker: ${time}',
			'maker.waitTaker.errorActiveOfferDetailsLost' => 'Fehler: Details des aktiven Angebots verloren.',
			'maker.waitTaker.errorFailedToRetrieveBlik' => ({required Object code}) => 'Fehler: ${code}-Code konnte nicht abgerufen werden.',
			'maker.waitTaker.errorRetrievingBlik' => ({required Object code, required Object details}) => 'Fehler beim Abrufen des ${code}-Codes: ${details}',
			'maker.waitTaker.offerNoLongerAvailable' => ({required Object status}) => 'Angebot ist nicht mehr verfügbar (Status: ${status}).',
			'maker.waitTaker.errorCouldNotIdentifyOffer' => 'Fehler: Zu stornierendes Angebot konnte nicht identifiziert werden.',
			'maker.waitTaker.offerCannotBeCancelled' => ({required Object status}) => 'Angebot kann im aktuellen Zustand nicht storniert werden (${status}).',
			'maker.waitTaker.offerCancelledSuccessfully' => 'Angebot erfolgreich storniert.',
			'maker.waitTaker.failedToCancelOffer' => ({required Object details}) => 'Stornierung des Angebots fehlgeschlagen: ${details}',
			'maker.waitTaker.offerExpiredTitle' => 'Angebot abgelaufen',
			'maker.waitTaker.offerExpiredMessage' => 'Kein Taker hat dein Angebot rechtzeitig reserviert.',
			'maker.waitTaker.recreateOffer' => 'Neues Angebot — gleicher Betrag',
			'maker.waitForBlik.title' => ({required Object code}) => 'Warte auf ${code}',
			'maker.waitForBlik.messageInfo' => 'Ein Taker hat das Angebot reserviert!',
			'maker.waitForBlik.messageWaiting' => ({required Object code}) => 'Warte auf Bereitstellung des ${code}-Codes...',
			'maker.waitForBlik.progressLabel' => ({required Object seconds}) => 'Reserviert: ${seconds} s verbleibend',
			'maker.confirmPayment.title' => ({required Object code}) => '${code}-Code erhalten!',
			'maker.confirmPayment.retrieving' => ({required Object code}) => '${code}-Code wird abgerufen...',
			'maker.confirmPayment.instructions' => 'Gib diesen Code am Zahlungsterminal ein. Wenn der Taker in seiner Banking-App bestätigt und die Zahlung erfolgreich ist, drücke unten auf Bestätigen.',
			'maker.confirmPayment.instruction1' => ({required Object code}) => 'Gib den Code in die ${code}-Zahlungsanforderung ein.',
			'maker.confirmPayment.instruction2' => 'Warte, bis der Taker die Zahlung in seiner App bestätigt.',
			'maker.confirmPayment.instruction3' => 'Wenn die Zahlung erfolgreich ist, drücke unten auf Bestätigen:',
			'maker.confirmPayment.mbwayAtmInstructions' => ({required Object amount, required Object minutes}) => 'Um ${amount} € abzuheben, gehe zum nächsten MULTIBANCO-Geldautomaten, drücke die grüne Taste und wähle die Option "Geld abheben" ("Levantar Dinheiro"). Gib den Code ein. Dieser Code ist ${minutes} Minuten gültig.',
			'maker.confirmPayment.takerChargedWarning' => ({required Object code}) => 'Der Taker hat gemeldet, dass die ${code}-Zahlung von seinem Bankkonto abgebucht wurde. Wenn du sie als ungültig markierst, führt das zu einem Konflikt.',
			'maker.confirmPayment.autoConfirmInfo' => ({required Object code}) => 'Sofern du den ${code} nicht als ungültig markierst, wird die Zahlung automatisch bestätigt und der Taker bezahlt, sobald dieser Timer abläuft.',
			'maker.confirmPayment.autoConfirmCountdown' => ({required Object time}) => 'Automatische Bestätigung in ${time}',
			'maker.confirmPayment.expiredTitle' => ({required Object code}) => '${code}-Code abgelaufen',
			'maker.confirmPayment.expiredWarning' => ({required Object code}) => 'Der ${code}-Code ist abgelaufen. Du musst den Zahlungsstatus manuell bestätigen:',
			'maker.confirmPayment.expiredInstruction1' => ({required Object code}) => 'Wenn die ${code}-Zahlung erfolgreich war und du deinen Kauf abgeschlossen hast, klicke unten auf "Erfolgreiche Zahlung bestätigen".',
			'maker.confirmPayment.expiredInstruction2' => ({required Object code}) => 'Wenn die ${code}-Zahlung fehlgeschlagen ist oder nicht abgeschlossen wurde, klicke unten auf "Ungültiger ${code}-Code".',
			'maker.confirmPayment.actions.confirm' => 'Erfolgreiche Zahlung bestätigen',
			'maker.confirmPayment.actions.markInvalid' => ({required Object code}) => 'Ungültiger ${code}-Code',
			'maker.confirmPayment.actions.copyBlik' => ({required Object code}) => '${code} kopieren',
			'maker.confirmPayment.confirmDialog.title' => 'Zahlung bestätigen?',
			'maker.confirmPayment.confirmDialog.content' => ({required Object code}) => 'Diese Aktion ist unwiderruflich. Nach der Bestätigung:\n\n• Der Taker erhält die Gelder sofort\n• Der Koordinator kann die Gelder nicht mehr anfechten\n• Du kannst diese Aktion nicht rückgängig machen\n\nBestätige nur, wenn die ${code}-Zahlung erfolgreich war.',
			'maker.confirmPayment.confirmDialog.cancel' => 'Abbrechen',
			'maker.confirmPayment.confirmDialog.confirmButton' => 'Ja, Zahlung bestätigen',
			'maker.confirmPayment.invalidBlikDisputeDialog.title' => 'Streitfall eröffnen?',
			'maker.confirmPayment.invalidBlikDisputeDialog.content' => ({required Object code}) => 'Der Taker hat gemeldet, dass die ${code}-Zahlung von seinem Konto abgebucht wurde.\n\nWenn du sie als ungültig markierst, wird sofort ein STREITFALL eröffnet, der ein Eingreifen des Koordinators erfordert.\n\n• Eine Streitfallgebühr kann anfallen, wenn gegen dich entschieden wird\n• Die Hold-Invoice wird sofort abgewickelt\n• Eine manuelle Überprüfung ist erforderlich\n\nFahre nur fort, wenn du sicher bist, dass die ${code}-Zahlung NICHT erfolgreich war.',
			'maker.confirmPayment.invalidBlikDisputeDialog.cancel' => 'Abbrechen',
			'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton' => 'Ja, Streitfall eröffnen',
			'maker.confirmPayment.feedback.confirmed' => 'Maker hat die Zahlung bestätigt.',
			'maker.confirmPayment.feedback.confirmedTakerPaid' => 'Zahlung bestätigt! Der Taker erhält die Gelder.',
			'maker.confirmPayment.feedback.progressLabel' => ({required Object seconds}) => 'Bestätigung: ${seconds} s verbleibend',
			'maker.confirmPayment.errors.failedToRetrieve' => ({required Object code}) => 'Fehler: ${code}-Code konnte nicht abgerufen werden.',
			'maker.confirmPayment.errors.retrieving' => ({required Object code, required Object details}) => 'Fehler beim Abrufen des ${code}-Codes: ${details}',
			'maker.confirmPayment.errors.missingHashOrKey' => 'Fehler: Payment-Hash oder öffentlicher Schlüssel fehlt.',
			'maker.confirmPayment.errors.incorrectState' => ({required Object status}) => 'Angebot ist nicht im richtigen Zustand für eine Bestätigung (Status: ${status})',
			'maker.confirmPayment.errors.confirming' => ({required Object details}) => 'Fehler beim Bestätigen der Zahlung: ${details}',
			'maker.confirmPayment.errors.invalidState' => 'Fehler: Ungültiger Angebotszustand empfangen.',
			'maker.confirmPayment.errors.internalIncomplete' => 'Interner Fehler: Unvollständige Angebotsdetails.',
			'maker.confirmPayment.errors.notAwaitingConfirmation' => ({required Object status}) => 'Angebot wartet nicht mehr auf Bestätigung (Status: ${status}).',
			'maker.confirmPayment.errors.unexpectedStatus' => 'Unerwarteter Angebotsstatus vom Server empfangen.',
			'maker.invalidBlik.title' => ({required Object code}) => 'Ungültiger ${code}-Code',
			'maker.invalidBlik.info' => ({required Object code}) => 'Du hast den ${code}-Code als ungültig markiert. Warte, bis der Taker einen neuen Code bereitstellt oder einen Streitfall eröffnet.',
			'maker.conflict.title' => 'Angebotskonflikt',
			'maker.conflict.headline' => 'Angebotskonflikt gemeldet',
			'maker.conflict.body' => ({required Object code}) => 'Du hast den ${code}-Code als ungültig markiert, aber der Taker hat einen Konflikt gemeldet und ist der Ansicht, dass die Zahlung erfolgreich war.',
			'maker.conflict.instructions' => 'Warte, bis der Koordinator die Situation prüft. Möglicherweise wirst du um weitere Details gebeten. Schau später wieder vorbei oder kontaktiere bei Bedarf den Support.',
			'maker.conflict.actions.back' => 'Zurück zur Startseite',
			'maker.conflict.actions.confirmPayment' => ({required Object code}) => 'Mein Fehler, ${code}-Zahlung als erfolgreich bestätigen',
			'maker.conflict.actions.openDispute' => ({required Object code}) => '${code}-Zahlung war NICHT erfolgreich, STREITFALL ERÖFFNEN',
			'maker.conflict.actions.submitDispute' => 'Streitfall einreichen',
			'maker.conflict.disputeDialog.title' => 'Streitfall eröffnen?',
			'maker.conflict.disputeDialog.content' => 'Das Eröffnen eines Streitfalls erfordert eine manuelle Überprüfung durch den Koordinator, was Zeit in Anspruch nimmt. Eine Streitfallgebühr wird abgezogen, wenn gegen dich entschieden wird. Die Hold-Invoice wird abgewickelt, um ihr Ablaufen zu verhindern. Wird zu deinen Gunsten entschieden, erhältst du eine Rückerstattung (abzüglich Gebühren) auf eine Wallet deiner Wahl.',
			'maker.conflict.disputeDialog.contentDetailed' => 'Das Eröffnen eines Streitfalls erfordert ein manuelles Eingreifen des Koordinators, was Zeit kostet und eine Streitfallgebühr verursacht.\n\nDie Hold-Invoice wird sofort abgewickelt, damit sie nicht vor der Lösung des Streitfalls abläuft.\n\nWird der Streitfall zu deinen Gunsten entschieden, wird der Satoshi-Betrag auf eine Wallet deiner Wahl zurückerstattet (abzüglich Gebühren). Stelle sicher, dass du eine empfangsbereite Wallet hast.',
			'maker.conflict.disputeDialog.actions.confirm' => 'Streitfall eröffnen',
			'maker.conflict.disputeDialog.actions.cancel' => 'Abbrechen',
			'maker.conflict.feedback.disputeOpenedSuccess' => 'Streitfall erfolgreich eröffnet. Der Koordinator wird ihn prüfen.',
			'maker.conflict.errors.openingDispute' => ({required Object error}) => 'Fehler beim Eröffnen des Streitfalls: ${error}',
			'maker.conflict.nostrContact.title' => 'Koordinator auf Nostr kontaktieren',
			'maker.conflict.nostrContact.description' => 'Du kannst dem Koordinator direkt eine DM senden, um Hilfe bei diesem Streitfall zu erhalten.',
			'maker.conflict.nostrContact.copyNpub' => 'npub kopieren',
			'maker.conflict.nostrContact.openProfile' => 'Profil anzeigen',
			'maker.conflict.nostrContact.npubCopied' => 'Koordinator-npub in die Zwischenablage kopiert!',
			'maker.conflict.nostrContact.yourIdentityDescription' => 'Um DMs zu senden, melde dich mit deinem privaten Neko-Schlüssel (nsec) in einem beliebigen Nostr-Client an, der Direktnachrichten unterstützt.',
			'maker.conflict.nostrContact.manageNekoKeys' => 'Neko-Schlüssel verwalten',
			'maker.success.title' => 'Angebot abgeschlossen',
			'maker.success.headline' => 'Zahlung bestätigt!',
			'maker.success.subtitle' => 'Der Taker wird jetzt bezahlt.',
			'maker.success.detailsTitle' => 'Angebotsdetails:',
			'maker.success.duration' => ({required Object time}) => 'Das Angebot dauerte ${time}!',
			'taker.roleSelection.button' => ({required Object code}) => '${code}-Code für Satoshi VERKAUFEN',
			'taker.progress.step1' => ({required Object code}) => '${code} senden',
			'taker.progress.step2' => ({required Object code}) => '${code} bestätigen',
			'taker.progress.step3' => 'Bezahlt werden',
			'taker.submitBlik.generateInBank' => ({required Object bank}) => 'Erstelle den Auszahlungscode in deiner ${bank}-App.',
			'taker.submitBlik.title' => ({required Object digits, required Object code}) => '${digits}-stelligen ${code} eingeben',
			'taker.submitBlik.label' => ({required Object code}) => '${code}-Code',
			'taker.submitBlik.instruction' => ({required Object code}) => 'Gib den ${code} ein, bevor die Zeit abläuft...',
			'taker.submitBlik.timeLimit' => ({required Object code, required Object seconds}) => '${code} eingeben innerhalb von: ${seconds} s',
			'taker.submitBlik.timeExpired' => ({required Object code}) => 'Die Zeit zur Eingabe des ${code}-Codes ist abgelaufen.',
			'taker.submitBlik.actions.submit' => ({required Object code}) => '${code} senden',
			'taker.submitBlik.feedback.pasted' => ({required Object code}) => '${code}-Code eingefügt.',
			'taker.submitBlik.validation.invalidFormat' => ({required Object digits, required Object code}) => 'Gib einen gültigen ${digits}-stelligen ${code}-Code ein.',
			'taker.submitBlik.errors.submitting' => ({required Object code, required Object details}) => 'Fehler beim Senden des ${code}-Codes: ${details}',
			'taker.submitBlik.errors.clipboardInvalid' => ({required Object digits, required Object code}) => 'Die Zwischenablage enthält keinen gültigen ${digits}-stelligen ${code}-Code.',
			'taker.submitBlik.errors.stateChanged' => 'Fehler: Angebotszustand hat sich geändert.',
			'taker.submitBlik.errors.stateNotValid' => 'Fehler: Angebotszustand ist nicht mehr gültig.',
			'taker.submitBlik.errors.fetchedIdMismatch' => ({required Object fetchedId, required Object initialId}) => 'Abgerufene aktive Angebots-ID (${fetchedId}) stimmt nicht mit der ursprünglichen Angebots-ID (${initialId}) überein. Zustandskonflikt?',
			'taker.submitBlik.errors.paymentHashMissing' => 'Payment-Hash des Angebots fehlt nach dem Abruf.',
			'taker.submitBlik.details.requestedAmount' => ({required Object code}) => 'Angeforderter ${code}-Betrag',
			'taker.submitBlik.details.exchangeRate' => 'Wechselkurs',
			'taker.submitBlik.details.takerFee' => 'Taker-Gebühr',
			'taker.submitBlik.details.status' => 'Status',
			'taker.submitBlik.details.youllReceive' => 'Du erhältst',
			'taker.criticalCodeDecision.title' => 'Kritische Entscheidung',
			'taker.criticalCodeDecision.explanation' => ({required Object code}) => 'Du hast dem Maker bereits einen ${code}-Code mitgeteilt. Wenn du fortfährst, kann dieser Code ersetzt, deine Reservierung beendet und das Angebot wieder für andere Taker freigegeben werden.',
			'taker.criticalCodeDecision.warningTitle' => 'DU KANNST DEIN GELD VERLIEREN',
			'taker.criticalCodeDecision.warningBody' => ({required Object code}) => 'Wenn deine Bank die ${code}-Zahlung belastet hat, fahre NICHT fort. Der Maker könnte deinen Code verwendet haben, und danach kann der Koordinator deine Bitcoin-Auszahlung möglicherweise nicht mehr garantieren.',
			'taker.criticalCodeDecision.actions.cancel' => 'Zurück und Bankkonto prüfen',
			'taker.criticalCodeDecision.actions.proceed' => 'Ich wurde NICHT belastet – fortfahren',
			'twint.scanner.title' => ({required Object code}) => '${code}-Code scannen',
			'twint.scanner.status.align' => ({required Object code}) => 'Richte den ${code}-QR-Code und den Betragstext innerhalb des Kamerarahmens aus.',
			'twint.scanner.status.notRecognized' => ({required Object code}) => '${code}-Code noch nicht erkannt. Halte den QR-Code und den Betrag im Bild, oder fülle das Formular manuell aus.',
			'twint.scanner.status.amountFailed' => 'Der Kamerascan konnte den Betrag nicht auslesen. Du kannst das QR-Ergebnis trotzdem verwenden und die Felder manuell korrigieren.',
			'twint.flow.progress.step1' => '1. Angebot erstellen',
			'twint.flow.progress.step2' => '2. Auf Taker warten',
			'twint.flow.progress.step3' => '3. Bestätigen',
			'twint.flow.takerProgress.step1' => ({required Object code}) => '1. ${code} bezahlen',
			'twint.flow.takerProgress.step2' => '2. Sats erhalten',
			'twint.flow.makerWait.takerPaying' => 'Taker bezahlt',
			'twint.flow.makerWait.yourCode' => ({required Object code}) => 'Dein ${code}-Code',
			'twint.flow.makerWait.offerExpires' => ({required Object code}) => '${code} läuft ab',
			'twint.flow.makerWait.autoExpires' => 'Läuft automatisch ab',
			'twint.flow.makerWait.codeExpiresIn' => ({required Object code}) => '${code} läuft ab in...',
			'twint.flow.makerWait.cancelOffer' => 'Angebot stornieren',
			'twint.flow.makerWait.reservedInfo' => ({required Object code}) => 'Ein Taker hat dein Angebot reserviert und bezahlt jetzt deinen ${code}-Code in seiner Banking-App. Sobald die Zahlung bei deinem Händler eingegangen ist, bestätige sie unten.',
			'twint.flow.makerWait.confirmReceived' => 'Zahlungseingang bestätigen',
			'twint.flow.makerWait.confirmDialog.title' => 'Zahlungseingang bestätigen?',
			'twint.flow.makerWait.confirmDialog.content' => ({required Object code}) => 'Bestätige nur, wenn du dir ABSOLUT sicher bist, dass die ${code}-Zahlung bei deinem Händler erfolgreich eingegangen ist.\n\nDie Bestätigung wickelt die Lightning-Hold-Invoice ab und sendet die Sats sofort an den Taker — das kann nicht rückgängig gemacht werden.',
			'twint.flow.makerWait.confirmDialog.cancel' => 'Abbrechen',
			'twint.flow.makerWait.confirmDialog.confirmButton' => 'Ja, Zahlung erhalten',
			'twint.flow.makerExpired.title' => ({required Object code}) => '${code} wahrscheinlich abgelaufen',
			'twint.flow.makerExpired.warning' => ({required Object code}) => 'Der ${code}-Code ist inzwischen wahrscheinlich abgelaufen — aber der Taker könnte ihn trotzdem noch bezahlt haben. Prüfe deinen Händler: du hast die unten angezeigte Zeit, um die Zahlung zu bestätigen.',
			'twint.flow.makerExpired.timerCaption' => 'Zeit zum Bestätigen',
			'twint.flow.makerExpired.disputeHint' => 'Du kannst auch warten, bis der Timer abläuft. Meldet der Taker, bezahlt zu haben, wird daraus ein Konflikt/Disput, bei dem beide Parteien dem Koordinator Nachweise zur Klärung liefern müssen.',
			'twint.flow.makerVerify.title' => 'Hast du die Zahlung erhalten?',
			'twint.flow.makerVerify.body' => ({required Object amount, required Object code}) => 'Der Taker meldet, dass er ${amount} an deinen ${code}-Code bezahlt hat.',
			'twint.flow.makerVerify.hint' => 'Prüfe den Zahlungsstatus bei deinem Händler (Shop-Terminal oder Online-Transaktion). Im Zweifel warte ab und prüfe später nochmal, bevor du dich entscheidest.',
			'twint.flow.makerVerify.autoConfirms' => 'Bestätigt automatisch',
			'twint.flow.makerVerify.confirmReceived' => 'Empfang bestätigen',
			'twint.flow.makerVerify.openDispute' => 'Streitfall eröffnen',
			'twint.flow.makerRecode.title' => 'Angebot abgelaufen',
			'twint.flow.makerRecode.body' => ({required Object code}) => 'Kein Taker hat den Trade abgeschlossen. Gib einen neuen ${code}-Code ein, um dieses Angebot erneut zu veröffentlichen, oder storniere es.',
			'twint.flow.makerRecode.scanCardTitle' => ({required Object code}) => 'Neuen ${code}-QR scannen',
			'twint.flow.makerRecode.scanCardBody' => 'Richte die Kamera auf den Zahlungsbildschirm. Die App füllt den neuen Code automatisch aus — der Betrag bleibt gleich.',
			'twint.flow.makerRecode.fieldLabel' => ({required Object code}) => 'Neuer ${code}-Code',
			'twint.flow.makerRecode.autoCancels' => 'Wird automatisch storniert',
			'twint.flow.makerRecode.relist' => 'Mit neuem Code erneut veröffentlichen',
			'twint.flow.makerRecode.cancelOffer' => 'Angebot stornieren',
			'twint.flow.takerPay.title' => ({required Object code}) => 'Mit ${code} bezahlen',
			'twint.flow.takerPay.body' => ({required Object code, required Object amount}) => 'Öffne deine ${code}-App und bezahle ${amount} mit:',
			'twint.flow.takerPay.codeExpires' => 'Code läuft ab',
			'twint.flow.takerPay.paid' => 'Ich habe bezahlt',
			'twint.flow.takerPay.cancel' => 'Abbrechen',
			'twint.flow.takerWait.title' => 'Warten auf den Maker',
			'twint.flow.takerWait.body' => ({required Object code}) => 'Der Maker prüft, ob deine ${code}-Zahlung bei seinem Händler angekommen ist. Er muss den Erhalt bestätigen oder einen Streitfall eröffnen.',
			'twint.flow.takerWait.info' => 'Wenn der Maker bis zum Ablauf des Timers nichts tut, wird die Zahlung automatisch bestätigt und du erhältst deine Sats.',
			'twint.flow.takerWait.autoConfirms' => 'Bestätigt automatisch',
			'twint.flow.takerExpired.title' => ({required Object code}) => '${code} wahrscheinlich abgelaufen',
			'twint.flow.takerExpired.warning' => ({required Object code}) => 'Der ${code}-Code ist inzwischen wahrscheinlich abgelaufen. Du musst jetzt eine wichtige Entscheidung treffen — wähle sorgfältig.',
			'twint.flow.takerExpired.optionPaid' => ({required Object code}) => 'Wenn du den ${code}-Code in deiner Banking-App BEZAHLT hast, markiere ihn als bezahlt. Damit verpflichtest du dich zu dieser Aussage: der Maker muss sie bestätigen, um die Bitcoin freizugeben, oder einen Disput starten, bei dem beide Parteien dem Koordinator Nachweise liefern.',
			'twint.flow.takerExpired.optionCancel' => 'Wenn du NICHT bezahlt hast, storniere die Reservierung. Das ist unumkehrbar — falls die Zahlung doch durchging, kann der Koordinator deine Sats nicht mehr garantieren.',
			'twint.flow.takerExpired.noDecision' => ({required Object code}) => 'Triffst du vor Ablauf des Timers keine Entscheidung, geht der Koordinator davon aus, dass du den ${code}-Code NICHT bezahlt hast. Der Maker kann das Angebot dann stornieren — wodurch die Hold-Invoice storniert wird — und der Koordinator kann dir die Sats danach nicht mehr auszahlen, selbst wenn du bezahlt hast.',
			'twint.flow.takerExpired.timerCaption' => 'Zeit zu entscheiden',
			'twint.flow.takerExpired.markPaid' => ({required Object code}) => 'Ich habe den ${code}-Code bezahlt',
			'twint.flow.takerExpired.cancel' => 'Reservierung stornieren',
			'twint.flow.takerExpired.markPaidDialog.title' => 'Zahlung bestätigen?',
			'twint.flow.takerExpired.markPaidDialog.content' => ({required Object code}) => 'Fahre nur fort, wenn du sicher bist, dass die ${code}-Zahlung in deiner Banking-App abgebucht wurde.\n\nDer Maker wird gebeten, den Empfang zu bestätigen, um die Bitcoin freizugeben. Bestreitet er ihn, wird ein Disput eröffnet und beide Parteien müssen dem Koordinator Nachweise liefern.',
			'twint.flow.takerExpired.markPaidDialog.cancel' => 'Zurück',
			_ => null,
		} ?? switch (path) {
			'twint.flow.takerExpired.markPaidDialog.confirmButton' => 'Ja, ich habe bezahlt',
			'twint.flow.takerExpired.cancelDialog.title' => 'Reservierung stornieren?',
			'twint.flow.takerExpired.cancelDialog.content' => ({required Object code}) => 'Storniere nur, wenn du den ${code}-Code NICHT bezahlt hast.\n\nDas kann nicht rückgängig gemacht werden: falls die Zahlung doch durchging, kann der Koordinator NICHT garantieren, dass du die Sats erhältst.',
			'twint.flow.takerExpired.cancelDialog.cancel' => 'Zurück',
			'twint.flow.takerExpired.cancelDialog.confirmButton' => 'Ja, stornieren',
			'twint.waitConfirmation.title' => 'Warte auf den Maker',
			'twint.waitConfirmation.statusLabel' => ({required Object status}) => 'Angebotsstatus: ${status}',
			'twint.waitConfirmation.waitingMaker' => ({required Object seconds}) => 'Warte auf Bestätigung des Makers: ${seconds} s',
			'twint.waitConfirmation.waitingMakerConfirmation' => ({required Object code, required Object seconds}) => 'Warte darauf, dass der Maker bestätigt, dass der ${code} korrekt ist. Verbleibende Zeit: ${seconds}s',
			'twint.waitConfirmation.importantNotice' => ({required Object code, required Object amount, required Object currency}) => 'SEHR WICHTIG: Stelle sicher, dass du nur eine ${code}-Bestätigung über ${amount} ${currency} akzeptierst',
			'twint.waitConfirmation.importantBlikAmountConfirmation' => ({required Object code, required Object amount, required Object currency}) => 'SEHR WICHTIG: Stelle in deiner Banking-App sicher, dass du eine ${code}-Zahlung über genau ${amount} ${currency} bestätigst.',
			'twint.waitConfirmation.instructions' => ({required Object minutes, required Object code}) => 'Der Maker muss ihn nun innerhalb von ${minutes} Minuten am Zahlungsterminal eingeben. Danach musst du den ${code}-Code in deiner Banking-App bestätigen.',
			'twint.waitConfirmation.instructionsNoConfirm' => ({required Object code, required Object minutes}) => 'Der Maker muss deinen ${code}-Code nun innerhalb von ${minutes} Minuten am Geldautomaten eingeben.',
			'twint.waitConfirmation.categoryReminder.atm' => 'Hinweis zum Geldautomaten-Angebot: Deine Bank kann dich zusätzlich bitten, eine extra Automatengebühr zum Hauptbetrag zu genehmigen.',
			'twint.waitConfirmation.categoryReminder.ecommerce' => 'Hinweis zur Online-Bestellung: Falls der Händler eine automatische Rückerstattung auf dein Bankkonto sendet, kontaktiere den Koordinator und gib sie zurück.',
			'twint.waitConfirmation.waitingForMakerToReceive' => ({required Object code}) => 'Warte, bis der Maker deinen ${code}-Code erhält...',
			'twint.waitConfirmation.makerReceivedBlik' => ({required Object code}) => 'Der Maker hat deinen ${code}-Code erhalten.',
			'twint.waitConfirmation.timerExpiredMessage' => ({required Object minutes, required Object code}) => 'Die ${minutes}-minütige Gültigkeit des ${code} ist abgelaufen. Warte, bis der Maker bestätigt oder den Code als ungültig markiert.',
			'twint.waitConfirmation.timerExpiredActions' => ({required Object minutes, required Object code}) => 'Die ${minutes}-minütige Gültigkeit des ${code} ist abgelaufen, aber der Maker hat den ${code}-Code nicht erhalten. Du kannst einen neuen ${code}-Code senden oder abbrechen.',
			'twint.waitConfirmation.resendBlikButton' => ({required Object code}) => 'Neuen ${code}-Code senden',
			'twint.waitConfirmation.navigatedHome' => 'Zur Startseite navigiert.',
			'twint.waitConfirmation.expiredTitle' => ({required Object code}) => '${code}-Code abgelaufen',
			'twint.waitConfirmation.expiredWarning' => ({required Object code}) => 'Der Maker hat den ${code}-Code nicht erhalten und konnte ihn daher nicht verwenden.',
			'twint.waitConfirmation.expiredRelistCountdownLabel' => 'Reservierung endet in',
			'twint.waitConfirmation.expiredSentWarning' => 'Der Maker hat die Zahlung noch nicht bestätigt. Was möchtest du tun?',
			'twint.waitConfirmation.expiredInstruction1' => ({required Object code}) => 'Wenn du es mit einem neuen ${code}-Code erneut versuchen möchtest, erneuere die Reservierung.',
			'twint.waitConfirmation.expiredInstruction2' => 'Wenn du diese Transaktion nicht mehr abschließen möchtest, storniere die Reservierung.',
			'twint.waitConfirmation.expiredInstruction3' => ({required Object code}) => 'Falls die ${code}-Zahlung von deinem Bankkonto abgebucht wurde, keine Sorge — die Bitcoin sind weiterhin sicher beim Koordinator gesperrt.',
			'twint.waitConfirmation.takerCharged.title' => ({required Object code}) => 'Du hast ${code} als abgebucht markiert',
			'twint.waitConfirmation.takerCharged.message' => ({required Object minutes}) => 'Der Maker hat ${minutes} Min., um die Zahlung zu bestätigen oder anzufechten. Tut er nichts, wird die Zahlung automatisch bestätigt und du erhältst die Bitcoin.',
			'twint.waitConfirmation.expiredActions.reportConflict' => ({required Object code}) => '${code} wurde von meinem Bankkonto abgebucht',
			'twint.waitConfirmation.expiredActions.renewReservation' => ({required Object code}) => 'Mit neuem ${code}-Code erneut versuchen',
			'twint.waitConfirmation.expiredActions.cancelReservation' => 'Reservierung stornieren',
			'twint.waitConfirmation.feedback.makerConfirmed' => 'Maker hat die Zahlung bestätigt.',
			'twint.waitConfirmation.feedback.paymentSuccessful' => 'Zahlung erfolgreich! Du erhältst die Gelder in Kürze.',
			'twint.waitConfirmation.feedback.conflictReported' => 'Konflikt gemeldet. Der Koordinator wird die Situation prüfen.',
			'twint.waitConfirmation.errors.invalidOfferStateReceived' => 'Angebot mit ungültigem Zustand für diesen Bildschirm empfangen. Wird zurückgesetzt.',
			'twint.waitConfirmation.errors.reportingConflict' => ({required Object details}) => 'Fehler beim Melden des Konflikts: ${details}',
			'twint.paymentProcess.title' => 'Zahlungsvorgang',
			'twint.paymentProcess.waitingForOfferUpdate' => 'Warte auf Statusaktualisierung des Angebots...',
			'twint.paymentProcess.states.preparing' => 'Zahlung wird vorbereitet...',
			'twint.paymentProcess.states.sending' => 'Zahlung wird gesendet...',
			'twint.paymentProcess.states.received' => 'Zahlung erhalten!',
			'twint.paymentProcess.states.failed' => 'Zahlung fehlgeschlagen',
			'twint.paymentProcess.states.waitingUpdate' => 'Warte auf Angebotsaktualisierung...',
			'twint.paymentProcess.steps.makerConfirmedBlik' => ({required Object code}) => 'Maker hat die ${code}-Zahlung bestätigt',
			'twint.paymentProcess.steps.makerInvoiceSettled' => 'Hold-Invoice des Makers abgewickelt',
			'twint.paymentProcess.steps.takerInvoicePaid' => 'Deine Lightning-Invoice wird bezahlt',
			'twint.paymentProcess.steps.takerPaymentFailed' => 'Zahlung an deine Invoice fehlgeschlagen',
			'twint.paymentProcess.errors.sending' => ({required Object details}) => 'Fehler beim Senden der Zahlung: ${details}',
			'twint.paymentProcess.errors.notConfirmed' => 'Angebot nicht vom Maker bestätigt.',
			'twint.paymentProcess.errors.expired' => 'Angebot abgelaufen.',
			'twint.paymentProcess.errors.cancelled' => 'Angebot storniert.',
			'twint.paymentProcess.errors.paymentFailed' => 'Angebotszahlung fehlgeschlagen.',
			'twint.paymentProcess.errors.unknown' => 'Unbekannter Angebotsfehler.',
			'twint.paymentProcess.errors.takerPaymentFailed' => 'Die Zahlung an deine Lightning-Invoice ist fehlgeschlagen.',
			'twint.paymentProcess.errors.noPublicKey' => 'Fehler: Dein öffentlicher Schlüssel kann nicht abgerufen werden.',
			'twint.paymentProcess.errors.loadingPublicKey' => 'Fehler beim Laden deiner Daten',
			'twint.paymentProcess.errors.missingPaymentHash' => 'Fehler: Zahlungsdetails fehlen.',
			'twint.paymentProcess.loading.publicKey' => 'Deine Daten werden geladen...',
			'twint.paymentProcess.actions.goToFailureDetails' => 'Mit neuer Invoice erneut versuchen',
			'twint.paymentFailed.title' => 'Zahlung fehlgeschlagen',
			'twint.paymentFailed.instructions' => ({required Object netAmount}) => 'Bitte gib eine neue Lightning-Invoice über ${netAmount} an',
			'twint.paymentFailed.form.newInvoiceLabel' => 'Neue Lightning-Invoice',
			'twint.paymentFailed.form.newInvoiceHint' => 'Gib deine BOLT11-Invoice ein',
			'twint.paymentFailed.actions.retryPayment' => 'Neue Invoice senden',
			'twint.paymentFailed.errors.enterValidInvoice' => 'Bitte gib eine gültige Invoice ein',
			'twint.paymentFailed.errors.updatingInvoice' => ({required Object details}) => 'Fehler beim Aktualisieren der Invoice: ${details}',
			'twint.paymentFailed.errors.paymentRetryFailed' => 'Zahlungswiederholung fehlgeschlagen. Bitte prüfe die Invoice oder versuche es später erneut.',
			'twint.paymentFailed.errors.takerPublicKeyNotFound' => 'Öffentlicher Schlüssel des Takers nicht gefunden.',
			'twint.paymentFailed.errors.generateFailed' => ({required Object details}) => 'Invoice konnte nicht erstellt werden: ${details}',
			'twint.paymentFailed.walletSection.title' => 'Invoice aus Wallet erstellen',
			'twint.paymentFailed.walletSection.defaultLabel' => 'Standard',
			'twint.paymentFailed.walletSection.tapToGenerate' => ({required Object amountSats}) => 'Tippe, um eine Invoice über ${amountSats} zu erstellen',
			'twint.paymentFailed.loading.processingPayment' => 'Deine Zahlungswiederholung wird verarbeitet...',
			'twint.paymentFailed.success.title' => 'Zahlung erfolgreich',
			'twint.paymentFailed.success.message' => 'Deine Zahlung wurde erfolgreich verarbeitet.',
			'twint.paymentSuccess.title' => 'Zahlung erfolgreich',
			'twint.paymentSuccess.message' => 'Deine Zahlung wurde erfolgreich verarbeitet.',
			'twint.paymentSuccess.actions.goHome' => 'Zur Startseite',
			'twint.invalidBlik.title' => ({required Object code}) => 'Ungültiger ${code}-Code',
			'twint.invalidBlik.message' => ({required Object code}) => 'Maker hat den ${code}-Code abgelehnt',
			'twint.invalidBlik.explanation' => ({required Object code}) => 'Der Ersteller des Angebots hat angegeben, dass der von dir bereitgestellte ${code}-Code ungültig war oder nicht funktioniert hat.\n\nWas möchtest du tun?',
			'twint.invalidBlik.werentCharged' => 'Falls dir NICHTS abgebucht wurde:',
			'twint.invalidBlik.wereCharged' => 'Falls dir etwas abgebucht wurde:',
			'twint.invalidBlik.actions.retry' => ({required Object code}) => 'Neuen ${code}-Code senden',
			'twint.invalidBlik.actions.cancelReservation' => 'Transaktion abbrechen',
			'twint.invalidBlik.actions.reportConflict' => 'Streitfall starten',
			'twint.invalidBlik.actions.returnHome' => 'Zurück zur Startseite',
			'twint.invalidBlik.confirmDialog.title' => 'Bist du sicher?',
			'twint.invalidBlik.confirmDialog.content' => 'Sobald du hier tippst, gibt es kein Zurück mehr.\n\nWenn der Betrag TATSÄCHLICH von deinem Bankkonto abgebucht wurde, kann der Koordinator NICHT garantieren, dass du die Bitcoin erhältst, und du könntest deine Gelder verlieren.\n\nWenn du unsicher bist, warte am besten kurz und vergewissere dich, dass dir NICHTS abgebucht wurde, bevor du fortfährst.',
			'twint.invalidBlik.confirmDialog.actions.proceed' => 'Ich bin sicher, weiter',
			'twint.invalidBlik.confirmDialog.actions.cancel' => 'Abbrechen',
			'twint.invalidBlik.disputeConfirmDialog.title' => 'Streitfall starten?',
			'twint.invalidBlik.disputeConfirmDialog.content' => 'Starte nur dann einen Streitfall, wenn der Betrag TATSÄCHLICH von deinem Bankkonto abgebucht wurde.\n\nDer Koordinator prüft deinen Fall manuell, was Zeit in Anspruch nimmt. Du musst einen Zahlungsnachweis vorlegen.',
			'twint.invalidBlik.disputeConfirmDialog.actions.proceed' => 'Ja, mir wurde etwas abgebucht',
			'twint.invalidBlik.disputeConfirmDialog.actions.cancel' => 'Abbrechen',
			'twint.invalidBlik.feedback.conflictReportedSuccess' => 'Konflikt gemeldet. Der Koordinator wird ihn prüfen.',
			'twint.invalidBlik.errors.reservationFailed' => 'Erneute Reservierung des Angebots fehlgeschlagen',
			'twint.invalidBlik.errors.conflictReport' => ({required Object details}) => 'Fehler beim Melden des Konflikts: ${details}',
			'twint.conflict.title' => 'Angebotskonflikt',
			'twint.conflict.headline' => 'Angebotskonflikt gemeldet',
			'twint.conflict.body' => ({required Object code}) => 'Der Maker hat den ${code}-Code als ungültig markiert, aber du hast einen Konflikt gemeldet und bist der Ansicht, dass die Zahlung erfolgreich war.',
			'twint.conflict.instructions' => 'Warte, bis der Koordinator die Situation prüft. Möglicherweise wirst du um weitere Details gebeten. Schau später wieder vorbei oder kontaktiere bei Bedarf den Support.',
			'twint.conflict.actions.back' => 'Zurück zur Startseite',
			'twint.conflict.feedback.reported' => 'Konflikt gemeldet. Der Koordinator wird ihn prüfen.',
			'twint.conflict.errors.reporting' => ({required Object details}) => 'Fehler beim Melden des Konflikts: ${details}',
			'twint.conflict.nostrContact.title' => 'Koordinator auf Nostr kontaktieren',
			'twint.conflict.nostrContact.description' => 'Du kannst dem Koordinator direkt eine DM senden, um Hilfe bei diesem Streitfall zu erhalten.',
			'twint.conflict.nostrContact.copyNpub' => 'npub kopieren',
			'twint.conflict.nostrContact.openProfile' => 'Profil anzeigen',
			'twint.conflict.nostrContact.npubCopied' => 'Koordinator-npub in die Zwischenablage kopiert!',
			'twint.conflict.nostrContact.yourIdentityDescription' => 'Um DMs zu senden, melde dich mit deinem privaten Neko-Schlüssel (nsec) in einem beliebigen Nostr-Client an, der Direktnachrichten unterstützt.',
			'twint.conflict.nostrContact.manageNekoKeys' => 'Neko-Schlüssel verwalten',
			'blik.instructions.taker' => ({required Object code}) => 'Sobald der Maker den ${code}-Code eingibt, musst du die Zahlung in deiner Banking-App bestätigen. Stelle sicher, dass der Betrag korrekt ist, bevor du bestätigst.',
			'home.notifications.title' => 'Erhalte Benachrichtigungen über neue Angebote via:',
			'home.notifications.telegram' => 'Telegram',
			'home.notifications.simplex' => 'SimpleX',
			'home.notifications.matrix' => 'Matrix',
			'home.notifications.signal' => 'Signal',
			'home.notifications.channelAllBanks' => '(alle Banken)',
			'home.notifications.channelForBankPrefix' => '(nur Angebote für ',
			'home.notifications.channelForBankSuffix' => ')',
			'home.notifications.scopeAllBanks' => 'Alle Banken',
			'home.notifications.scopeBankOnly' => ({required Object bank}) => 'Nur ${bank}',
			'home.statistics.title' => 'Abgeschlossene Angebote',
			'home.statistics.lifetimeCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Gesamt: ${count} Transaktionen\nDurchschn. Wartezeit auf ${code}: ${avgBlikTime}\nDurchschn. Abschlusszeit: ${avgPaidTime}',
			'home.statistics.last7DaysCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Letzte 7 T.: ${count} Transaktionen\nDurchschn. Wartezeit auf ${code}: ${avgBlikTime}\nDurchschn. Abschlusszeit: ${avgPaidTime}',
			'home.statistics.last7DaysSingleLine' => ({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Letzte 7 T.: ${count} Angebote  |  Durchschn. Reservierung: ${avgReservationTime}  |  Durchschn. Bezahlt: ${avgPaidTime}',
			'home.statistics.errors.loading' => ({required Object error}) => 'Fehler beim Laden der Statistiken: ${error}',
			'nekoInfo.title' => 'Was ist ein Neko?',
			'nekoInfo.description' => ({required Object app}) => 'Dein Neko ist deine Identität für die Nutzung von ${app}. Er besteht aus einem privaten und einem öffentlichen Schlüssel, um eine kryptografisch sichere Kommunikation mit dem Koordinator zu gewährleisten.\n\nFür mehr Anonymität wird empfohlen, für jedes Angebot einen neuen, frischen Neko zu verwenden.\n\n⚠️ WICHTIG: Dein privater Schlüssel wird nur auf deinem Gerät gespeichert (clientseitig). Es ist äußerst wichtig, deinen privaten Schlüssel zu sichern, da du ohne ihn möglicherweise keine Streitfälle lösen und deine Gelder nicht wiederherstellen kannst.',
			'nekoInfo.backupWarning' => 'Denke daran, deinen Neko zu sichern',
			'generateNewKey.title' => 'Neu',
			'generateNewKey.description' => 'Bist du sicher, dass du einen neuen Neko generieren möchtest? Dein aktueller geht für immer verloren, wenn du ihn nicht gesichert hast.',
			'generateNewKey.buttons.generate' => 'Generieren',
			'generateNewKey.errors.activeOffer' => 'Du kannst keinen neuen Neko generieren, während du ein aktives Angebot hast.',
			'generateNewKey.errors.failed' => 'Neuer Neko konnte nicht generiert werden',
			'generateNewKey.feedback.success' => 'Neuer Neko erfolgreich generiert!',
			'generateNewKey.tooltips.generate' => 'Neuen Neko generieren',
			'backup.title' => 'Sicherung',
			'backup.description' => 'Dies ist dein privater Schlüssel. Er sichert die Kommunikation mit dem Koordinator. Gib ihn niemals an Dritte weiter. Sichere ihn an einem sicheren Ort, um Probleme bei Streitfällen zu vermeiden.',
			'backup.feedback.copied' => 'Privater Schlüssel in die Zwischenablage kopiert!',
			'backup.tooltips.backup' => 'Neko sichern',
			'restore.title' => 'Wiederherstellen',
			'restore.labels.privateKey' => 'Privater Schlüssel',
			'restore.buttons.restore' => 'Wiederherstellen',
			'restore.errors.invalidKey' => 'Muss eine 64-stellige Hex-Zeichenfolge sein.',
			'restore.errors.failed' => 'Wiederherstellung fehlgeschlagen',
			'restore.feedback.success' => 'Neko erfolgreich wiederhergestellt! Die App wird neu gestartet.',
			'restore.tooltips.restore' => 'Neko wiederherstellen',
			'system.loadingPublicKey' => 'Dein öffentlicher Schlüssel wird geladen...',
			'system.errors.generic' => 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.',
			'system.errors.loadingTimeoutConfig' => 'Fehler beim Laden der Timeout-Konfiguration.',
			'system.errors.loadingCoordinatorConfig' => 'Fehler beim Laden der Koordinator-Konfiguration. Bitte versuche es erneut.',
			'system.errors.noPublicKey' => 'Dein öffentlicher Schlüssel ist nicht verfügbar. Fortfahren nicht möglich.',
			'system.errors.internalOfferIncomplete' => 'Interner Fehler: Angebotsdetails sind unvollständig. Bitte versuche es erneut.',
			'system.errors.loadingPublicKey' => 'Fehler beim Laden deines öffentlichen Schlüssels. Bitte starte die App neu.',
			'system.blik.copied' => ({required Object code}) => '${code}-Code in die Zwischenablage kopiert',
			'myOffers.title' => 'Meine Angebote',
			'myOffers.empty' => 'Noch keine Angebote.',
			'myOffers.unknownCoordinator' => 'Unbekannter Koordinator',
			'myOffers.menuLabel' => 'Meine Angebote',
			'myOffers.filter.all' => 'Alle',
			'myOffers.filter.active' => 'Aktiv',
			'myOffers.filter.completed' => 'Abgeschlossen',
			'myOffers.filter.failed' => 'Fehlgeschlagen',
			'myOffers.details.title' => 'Angebotsdetails',
			'myOffers.details.notFound' => 'Angebot nicht gefunden.',
			'myOffers.details.amount' => 'Betrag',
			'myOffers.details.fees' => 'Gebühren',
			'myOffers.details.sats' => 'Satoshis',
			'myOffers.details.maker' => 'Maker',
			'myOffers.details.taker' => 'Taker',
			'myOffers.details.yourFee' => 'Deine Gebühr',
			'myOffers.details.makerFee' => 'Maker-Gebühr',
			'myOffers.details.takerFee' => 'Taker-Gebühr',
			'myOffers.details.coordinator' => 'Koordinator',
			'myOffers.details.createdAt' => 'Erstellt',
			'myOffers.details.reservedAt' => 'Reserviert',
			'myOffers.details.blikReceivedAt' => ({required Object code}) => '${code} übermittelt',
			'myOffers.details.makerConfirmedAt' => 'Bestätigt',
			'myOffers.details.settledAt' => 'Abgewickelt',
			'myOffers.details.takerPaidAt' => 'Taker bezahlt',
			'myOffers.details.id' => 'Angebots-ID',
			'myOffers.details.paymentHash' => 'Payment-Hash',
			'myOffers.details.holdInvoice' => 'Hold-Invoice',
			'myOffers.details.continueActiveOffer' => 'Aktives Angebot fortsetzen',
			'myOffers.details.after' => ({required Object duration}) => 'nach ${duration}',
			'landing.mainTitle' => ({required Object code}) => 'Deine ${code} ⇄ Bitcoin-Brücke',
			'landing.subtitle' => ({required Object code}) => 'Bezahle mit oder verkaufe deinen ${code}-Code für Bitcoin',
			'landing.partnership' => 'Partnerschaft',
			'landing.actions.payBlik' => ({required Object code}) => '${code} bezahlen',
			'landing.actions.payBlikSubtitle' => 'mit Bitcoin',
			'landing.actions.sellBlik' => 'Bitcoin kaufen',
			'landing.actions.sellBlikSubtitle' => ({required Object code}) => 'mit ${code}',
			'landing.actions.howItWorks' => 'Wie funktioniert das?',
			'faq.screenTitle' => 'FAQ',
			'faq.tooltip' => 'FAQ',
			'settings.title' => 'Einstellungen',
			'settings.offerCreation.title' => 'Angebotserstellung',
			'settings.offerCreation.defaultCategory' => 'Standardkategorie',
			'settings.offerCreation.defaultBank' => 'Standardbank',
			'settings.offerCreation.defaultBankNone' => 'Keine (pro Angebot wählen)',
			'settings.offerCreation.preferredCoordinator' => 'Bevorzugter Koordinator',
			'settings.offerCreation.automaticCoordinator' => 'Zuverlässigster',
			'settings.offerCreation.automaticCoordinatorDescription' => 'Wählt den Koordinator mit der besten Erfolgsbilanz, basierend auf deinen eigenen abgeschlossenen Angeboten und der gesamten Netzwerkaktivität.',
			'settings.offerCreation.cheapestCoordinator' => 'Günstigster',
			'settings.offerCreation.cheapestCoordinatorDescription' => 'Wählt für jedes Angebot den verfügbaren Koordinator mit der niedrigsten Maker-Gebühr.',
			'settings.offerCreation.enablePremium' => 'Premium-Preise aktivieren',
			'settings.offerCreation.enablePremiumDescription' => 'Zeigt den Premium-Regler beim Erstellen von Maker-Angeboten an.',
			'settings.offerCreation.defaultPremium' => 'Standard-Premium',
			'settings.offerCreation.defaultPremiumDisabled' => 'Aktiviere Premium-Preise, um ein Standard-Premium festzulegen.',
			'settings.offerCreation.premiumPerCoordinatorNote' => 'Jeder Koordinator legt sein eigenes maximales Premium fest, dein Standardwert wird daher durch den für ein Angebot verwendeten Koordinator begrenzt.',
			'settings.offerCreation.categoryOptions.shop' => 'Geschäft, Café oder Restaurant',
			'settings.offerCreation.categoryOptions.atm' => 'Bargeldbezug am Geldautomaten',
			'settings.offerCreation.categoryOptions.online' => 'Online-Dienst/-Produkt',
			'settings.offerCreation.dialogs.selectCategory' => 'Standardkategorie wählen',
			'settings.offerCreation.dialogs.selectBank' => 'Standardbank wählen',
			'settings.offerCreation.dialogs.selectCoordinator' => 'Bevorzugten Koordinator wählen',
			'settings.offerCreation.dialogs.premiumHint' => 'Gib einen Prozentsatz wie 1.5 ein. Werte werden auf 0.5%-Schritte gerundet.',
			'settings.offerCreation.dialogs.premiumHelper' => 'Wird angewendet, wenn Premium-Preise aktiviert sind, und durch das Maximum des gewählten Koordinators begrenzt.',
			'settings.display.title' => 'Anzeige',
			'settings.display.bitcoinUnit' => 'Bitcoin-Einheit',
			'settings.display.bitcoinUnitDescription' => 'Wähle, wie Bitcoin-Beträge in der App angezeigt werden.',
			'settings.display.unitOptions.sats' => 'Sats',
			'settings.display.unitOptions.bitcoin' => '₿ (BIP-177)',
			'settings.paymentSystem.title' => 'Land / Zahlungssystem',
			'settings.paymentSystem.subtitle' => 'Wähle das Zahlungssystem deines Landes.',
			'settings.paymentSystem.dialogTitle' => 'Zahlungssystem wählen',
			'settings.paymentSystem.countries.PL' => 'Polen',
			'settings.paymentSystem.countries.PT' => 'Portugal',
			'settings.paymentSystem.countries.CH' => 'Schweiz',
			'settings.paymentSystem.countries.SK' => 'Slowakei',
			'notificationSettings.title' => 'Benachrichtigungen',
			'notificationSettings.androidOnly' => 'Hintergrund-Benachrichtigungen werden derzeit nur auf Android unterstützt.',
			'notificationSettings.newOfferAlerts.label' => 'Benachrichtigungen über neue Angebote',
			'notificationSettings.newOfferAlerts.description' => ({required Object app}) => 'Wenn aktiviert, benachrichtigt dich ${app} über neue annehmbare Angebote deiner aktivierten Koordinatoren, während die App im Hintergrund läuft. Das kann schneller sein als externe Messenger.',
			'onboarding.title' => 'Wähle deinen Markt',
			'onboarding.subtitle' => 'Wähle das Land und Zahlungssystem, das du verwenden wirst. Du kannst es jederzeit in den Einstellungen ändern.',
			'wallet.title' => 'Wallet',
			'wallet.description' => 'Verwalte deine Lightning-Wallet-Einstellungen',
			'wallet.missingReceiving.title' => 'Empfangs-Wallet erforderlich',
			'wallet.missingReceiving.message' => 'Keine Wallet für den Empfang konfiguriert. Füge in den Wallet-Einstellungen eine hinzu, um Angebote anzunehmen.',
			'wallet.missingReceiving.openSettings' => 'Wallet-Einstellungen',
			'wallet.incompatibleReceiving.title' => 'BOLT11-Wallet erforderlich',
			'wallet.incompatibleReceiving.message' => 'Dieser Koordinator kann dieses Angebot nur über BOLT11 auszahlen.',
			'wallet.incompatibleReceiving.explanation' => 'Deine Empfangs-Wallet unterstützt BOLT12-Angebote, kann aber die erforderliche BOLT11-Rechnung nicht erstellen. Füge eine BOLT11-kompatible Empfangs-Wallet hinzu.',
			'wallet.details.title' => 'Wallet-Details',
			'wallet.details.pendingTitle' => 'Ausstehende Transaktionen',
			'wallet.details.finishedTitle' => 'Abgeschlossene Transaktionen',
			'nwc.title' => 'Nostr Wallet Connect (NWC)',
			'nwc.description' => 'Verbinde deine Lightning-Wallet über NWC',
			'nwc.labels.connectionString' => 'NWC-Verbindungszeichenfolge',
			'nwc.labels.hint' => 'nostr+walletconnect://...',
			'nwc.labels.status' => 'Verbindungsstatus',
			'nwc.labels.connected' => 'Verbunden',
			'nwc.labels.disconnected' => 'Getrennt',
			'nwc.labels.scanQrCode' => 'Scanne den QR-Code mit deiner NWC-Verbindung',
			'nwc.labels.balance' => 'Guthaben',
			'nwc.labels.budget' => 'Budget',
			'nwc.labels.usedBudget' => 'Verbraucht',
			'nwc.labels.totalBudget' => 'Gesamt',
			'nwc.labels.renewsIn' => 'Erneuert sich in',
			'nwc.labels.renewalPeriod' => 'Erneuerungszeitraum',
			'nwc.labels.relay' => 'Relay',
			'nwc.labels.relays' => 'Relays',
			'nwc.prompts.enter' => 'Gib deine NWC-Verbindungszeichenfolge ein',
			'nwc.prompts.connect' => 'Wallet verbinden',
			'nwc.prompts.disconnect' => 'Trennen',
			'nwc.prompts.confirmDisconnect' => 'Bist du sicher, dass du deine NWC-Wallet trennen möchtest?',
			'nwc.prompts.pasteConnection' => 'Verbindungszeichenfolge einfügen',
			'nwc.prompts.chooseMethod' => 'Wähle, wie du deine Lightning-Wallet verbinden möchtest',
			'nwc.prompts.howToGet' => 'Du hast noch keine NWC-Verbindung? Erfahre, wie du eine bekommst!',
			'nwc.prompts.learnMore' => 'Mehr über NWC erfahren',
			'nwc.actions.connectAlbyGo' => 'Mit Alby Go verbinden',
			'nwc.actions.connectNwc' => 'NWC-QR-Code scannen',
			'nwc.feedback.connected' => 'NWC-Wallet erfolgreich verbunden!',
			'nwc.feedback.disconnected' => 'NWC-Wallet getrennt',
			'nwc.feedback.connecting' => 'Verbindung zur NWC-Wallet wird hergestellt...',
			'nwc.feedback.loadingWalletInfo' => 'Wallet-Informationen werden geladen...',
			'nwc.errors.connecting' => ({required Object details}) => 'Fehler beim Verbinden mit NWC: ${details}',
			'nwc.errors.disconnecting' => ({required Object details}) => 'Fehler beim Trennen von NWC: ${details}',
			'nwc.errors.invalid' => 'Ungültige NWC-Verbindungszeichenfolge',
			'nwc.errors.required' => 'NWC-Verbindungszeichenfolge ist erforderlich',
			'nwc.errors.loadingBalance' => 'Wallet-Guthaben konnte nicht geladen werden',
			'nwc.errors.loadingBudget' => 'Wallet-Budget konnte nicht geladen werden',
			'nwc.time.minutes' => ({required Object count}) => '${count} Min.',
			'nwc.time.hours' => ({required Object count}) => '${count} Std.',
			'nwc.time.days' => ({required Object count}) => '${count} T.',
			'nwc.time.justNow' => 'gerade eben',
			'nekoManagement.title' => 'Neko',
			'relays.title' => 'Relays',
			'relays.coordinatorRelays' => 'Koordinator-Relays',
			'relays.discoveryRelays' => 'Discovery-Relays',
			'relays.status.connected' => 'Verbunden',
			'relays.status.connecting' => 'Verbindung wird hergestellt',
			'relays.status.reconnecting' => 'Verbindung wird wiederhergestellt',
			'relays.status.disconnected' => 'Getrennt',
			'relays.popup.title' => ({required Object connected, required Object total}) => 'Relays (${connected}/${total} verbunden)',
			'relays.popup.connectingMessage' => 'Verbindung zu Relays wird hergestellt...',
			'offerNotifications.activeService.title' => 'Warte auf neue Angebote',
			'offerNotifications.activeService.body' => ({required Object app}) => 'Nostr-Dienst überwacht Ereignisse von ${app}-Angeboten.',
			'offerNotifications.funded.title' => 'Angebot finanziert',
			'offerNotifications.funded.body' => 'Deine Hold-Invoice wurde akzeptiert. Das Angebot ist jetzt live.',
			'offerNotifications.reserved.title' => 'Angebot reserviert',
			'offerNotifications.reserved.body' => 'Ein Taker hat dein Angebot reserviert.',
			'offerNotifications.blikReady.title' => ({required Object code}) => '${code}-Code bereit',
			'offerNotifications.blikReady.body' => ({required Object code}) => 'Dein ${code}-Code kann jetzt angezeigt werden.',
			'offerNotifications.newOffer.title' => 'Neues Angebot verfügbar',
			'offerNotifications.newOffer.body' => ({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}',
			'offerNotifications.newOffer.premiumSuffix' => ({required Object percent}) => '+${percent}% Premium',
			'offerNotifications.categories.shop' => 'Geschäft',
			'offerNotifications.categories.atm' => 'Geldautomat',
			'offerNotifications.categories.online' => 'Online',
			'offerNotifications.blikPendingReminder.title' => ({required Object code}) => '${code} wartet auf deine Aktion',
			'offerNotifications.blikPendingReminder.body' => ({required Object code}) => 'Bestätige die Zahlung oder markiere den ${code}-Code als ungültig.',
			'offerNotifications.takerCharged.title' => ({required Object code}) => '${code} abgebucht',
			'offerNotifications.takerCharged.body' => ({required Object code}) => 'Der Taker meldet, dass der ${code} abgebucht wurde. Bestätige oder markiere ihn als ungültig.',
			'offerNotifications.invalidBlik.title' => ({required Object code}) => '${code} als ungültig markiert',
			'offerNotifications.invalidBlik.body' => ({required Object code}) => 'Der Maker hat deinen ${code}-Code als ungültig markiert.',
			'offerNotifications.takerPaid.title' => 'Zahlung erhalten',
			'offerNotifications.takerPaid.body' => 'Deine Lightning-Zahlung wurde gesendet.',
			'altstore.dialogTitle' => 'AltStore nicht installiert',
			'altstore.step1Title' => 'AltStore PAL herunterladen und installieren',
			'altstore.step1Button' => 'altstore.io/download',
			'altstore.step1Warning' => 'Du benötigst Safari, um AltStore PAL zu installieren!',
			'altstore.step2Title' => ({required Object app}) => '${app} installieren',
			'altstore.step2Button' => ({required Object app}) => '${app} installieren',
			'altstore.step2Fallback' => 'Funktioniert immer noch nicht? Füge die Quelle in AltStore ein',
			_ => null,
		};
	}
}
