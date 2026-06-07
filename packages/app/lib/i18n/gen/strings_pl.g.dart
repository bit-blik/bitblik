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
class TranslationsPl extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsPl _root = this; // ignore: unused_field

	@override 
	TranslationsPl $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPl(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$pl app = _Translations$app$pl._(_root);
	@override late final _Translations$common$pl common = _Translations$common$pl._(_root);
	@override late final _Translations$lightningAddress$pl lightningAddress = _Translations$lightningAddress$pl._(_root);
	@override late final _Translations$offers$pl offers = _Translations$offers$pl._(_root);
	@override late final _Translations$reservations$pl reservations = _Translations$reservations$pl._(_root);
	@override late final _Translations$exchange$pl exchange = _Translations$exchange$pl._(_root);
	@override late final _Translations$coordinator$pl coordinator = _Translations$coordinator$pl._(_root);
	@override late final _Translations$maker$pl maker = _Translations$maker$pl._(_root);
	@override late final _Translations$taker$pl taker = _Translations$taker$pl._(_root);
	@override late final _Translations$blik$pl blik = _Translations$blik$pl._(_root);
	@override late final _Translations$nekoInfo$pl nekoInfo = _Translations$nekoInfo$pl._(_root);
	@override late final _Translations$generateNewKey$pl generateNewKey = _Translations$generateNewKey$pl._(_root);
	@override late final _Translations$backup$pl backup = _Translations$backup$pl._(_root);
	@override late final _Translations$restore$pl restore = _Translations$restore$pl._(_root);
	@override late final _Translations$home$pl home = _Translations$home$pl._(_root);
	@override late final _Translations$system$pl system = _Translations$system$pl._(_root);
	@override late final _Translations$myOffers$pl myOffers = _Translations$myOffers$pl._(_root);
	@override late final _Translations$landing$pl landing = _Translations$landing$pl._(_root);
	@override late final _Translations$faq$pl faq = _Translations$faq$pl._(_root);
	@override late final _Translations$settings$pl settings = _Translations$settings$pl._(_root);
	@override late final _Translations$notificationSettings$pl notificationSettings = _Translations$notificationSettings$pl._(_root);
	@override late final _Translations$wallet$pl wallet = _Translations$wallet$pl._(_root);
	@override late final _Translations$nwc$pl nwc = _Translations$nwc$pl._(_root);
	@override late final _Translations$nekoManagement$pl nekoManagement = _Translations$nekoManagement$pl._(_root);
	@override late final _Translations$relays$pl relays = _Translations$relays$pl._(_root);
	@override late final _Translations$offerNotifications$pl offerNotifications = _Translations$offerNotifications$pl._(_root);
	@override late final _Translations$altstore$pl altstore = _Translations$altstore$pl._(_root);
}

// Path: app
class _Translations$app$pl extends Translations$app$en {
	_Translations$app$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'BitBlik';
	@override String get greeting => 'Cześć!';
	@override String get changelog => 'Historia zmian';
}

// Path: common
class _Translations$common$pl extends Translations$common$en {
	_Translations$common$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$buttons$pl buttons = _Translations$common$buttons$pl._(_root);
	@override late final _Translations$common$labels$pl labels = _Translations$common$labels$pl._(_root);
	@override late final _Translations$common$notifications$pl notifications = _Translations$common$notifications$pl._(_root);
	@override late final _Translations$common$clipboard$pl clipboard = _Translations$common$clipboard$pl._(_root);
	@override late final _Translations$common$actions$pl actions = _Translations$common$actions$pl._(_root);
}

// Path: lightningAddress
class _Translations$lightningAddress$pl extends Translations$lightningAddress$en {
	_Translations$lightningAddress$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$lightningAddress$labels$pl labels = _Translations$lightningAddress$labels$pl._(_root);
	@override late final _Translations$lightningAddress$prompts$pl prompts = _Translations$lightningAddress$prompts$pl._(_root);
	@override late final _Translations$lightningAddress$feedback$pl feedback = _Translations$lightningAddress$feedback$pl._(_root);
	@override late final _Translations$lightningAddress$errors$pl errors = _Translations$lightningAddress$errors$pl._(_root);
}

// Path: offers
class _Translations$offers$pl extends Translations$offers$en {
	_Translations$offers$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offers$details$pl details = _Translations$offers$details$pl._(_root);
	@override late final _Translations$offers$labels$pl labels = _Translations$offers$labels$pl._(_root);
	@override late final _Translations$offers$tooltips$pl tooltips = _Translations$offers$tooltips$pl._(_root);
	@override late final _Translations$offers$actions$pl actions = _Translations$offers$actions$pl._(_root);
	@override late final _Translations$offers$status$pl status = _Translations$offers$status$pl._(_root);
	@override late final _Translations$offers$statusMessages$pl statusMessages = _Translations$offers$statusMessages$pl._(_root);
	@override late final _Translations$offers$progress$pl progress = _Translations$offers$progress$pl._(_root);
	@override late final _Translations$offers$errors$pl errors = _Translations$offers$errors$pl._(_root);
	@override late final _Translations$offers$success$pl success = _Translations$offers$success$pl._(_root);
}

// Path: reservations
class _Translations$reservations$pl extends Translations$reservations$en {
	_Translations$reservations$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reservations$actions$pl actions = _Translations$reservations$actions$pl._(_root);
	@override late final _Translations$reservations$feedback$pl feedback = _Translations$reservations$feedback$pl._(_root);
	@override late final _Translations$reservations$errors$pl errors = _Translations$reservations$errors$pl._(_root);
}

// Path: exchange
class _Translations$exchange$pl extends Translations$exchange$en {
	_Translations$exchange$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$exchange$labels$pl labels = _Translations$exchange$labels$pl._(_root);
	@override late final _Translations$exchange$feedback$pl feedback = _Translations$exchange$feedback$pl._(_root);
	@override late final _Translations$exchange$errors$pl errors = _Translations$exchange$errors$pl._(_root);
}

// Path: coordinator
class _Translations$coordinator$pl extends Translations$coordinator$en {
	_Translations$coordinator$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordynatorzy';
	@override late final _Translations$coordinator$info$pl info = _Translations$coordinator$info$pl._(_root);
	@override late final _Translations$coordinator$selector$pl selector = _Translations$coordinator$selector$pl._(_root);
	@override late final _Translations$coordinator$dialog$pl dialog = _Translations$coordinator$dialog$pl._(_root);
	@override late final _Translations$coordinator$details$pl details = _Translations$coordinator$details$pl._(_root);
	@override late final _Translations$coordinator$management$pl management = _Translations$coordinator$management$pl._(_root);
}

// Path: maker
class _Translations$maker$pl extends Translations$maker$en {
	_Translations$maker$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$roleSelection$pl roleSelection = _Translations$maker$roleSelection$pl._(_root);
	@override late final _Translations$maker$amountForm$pl amountForm = _Translations$maker$amountForm$pl._(_root);
	@override late final _Translations$maker$payInvoice$pl payInvoice = _Translations$maker$payInvoice$pl._(_root);
	@override late final _Translations$maker$waitTaker$pl waitTaker = _Translations$maker$waitTaker$pl._(_root);
	@override late final _Translations$maker$waitForBlik$pl waitForBlik = _Translations$maker$waitForBlik$pl._(_root);
	@override late final _Translations$maker$confirmPayment$pl confirmPayment = _Translations$maker$confirmPayment$pl._(_root);
	@override late final _Translations$maker$invalidBlik$pl invalidBlik = _Translations$maker$invalidBlik$pl._(_root);
	@override late final _Translations$maker$conflict$pl conflict = _Translations$maker$conflict$pl._(_root);
	@override late final _Translations$maker$success$pl success = _Translations$maker$success$pl._(_root);
}

// Path: taker
class _Translations$taker$pl extends Translations$taker$en {
	_Translations$taker$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$taker$roleSelection$pl roleSelection = _Translations$taker$roleSelection$pl._(_root);
	@override late final _Translations$taker$progress$pl progress = _Translations$taker$progress$pl._(_root);
	@override late final _Translations$taker$submitBlik$pl submitBlik = _Translations$taker$submitBlik$pl._(_root);
	@override late final _Translations$taker$waitConfirmation$pl waitConfirmation = _Translations$taker$waitConfirmation$pl._(_root);
	@override late final _Translations$taker$paymentProcess$pl paymentProcess = _Translations$taker$paymentProcess$pl._(_root);
	@override late final _Translations$taker$paymentFailed$pl paymentFailed = _Translations$taker$paymentFailed$pl._(_root);
	@override late final _Translations$taker$paymentSuccess$pl paymentSuccess = _Translations$taker$paymentSuccess$pl._(_root);
	@override late final _Translations$taker$invalidBlik$pl invalidBlik = _Translations$taker$invalidBlik$pl._(_root);
	@override late final _Translations$taker$conflict$pl conflict = _Translations$taker$conflict$pl._(_root);
}

// Path: blik
class _Translations$blik$pl extends Translations$blik$en {
	_Translations$blik$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$blik$instructions$pl instructions = _Translations$blik$instructions$pl._(_root);
}

// Path: nekoInfo
class _Translations$nekoInfo$pl extends Translations$nekoInfo$en {
	_Translations$nekoInfo$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Czym jest Neko?';
	@override String get description => 'Twoje Neko to Twoja tożsamość do korzystania z BitBlik. Składa się z klucza prywatnego i publicznego, aby zapewnić kryptograficznie bezpieczną komunikację z koordynatorem.\n\nAby zapewnić większą anonimowość, zaleca się używanie nowego, świeżego Neko dla każdej oferty.\n\n⚠️ WAŻNE: Twój klucz prywatny jest przechowywany tylko na Twoim urządzeniu (po stronie klienta). Niezwykle ważne jest zarchiwizowanie klucza prywatnego, ponieważ utrata dostępu do niego może uniemożliwić rozstrzygnięcie sporów i odzyskanie środków.';
	@override String get backupWarning => 'Pamiętaj, aby zarchiwizować swoje Neko';
}

// Path: generateNewKey
class _Translations$generateNewKey$pl extends Translations$generateNewKey$en {
	_Translations$generateNewKey$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nowy';
	@override String get description => 'Czy na pewno chcesz wygenerować nowe Neko? Twoje obecne zostanie utracone na zawsze, jeśli go nie zarchiwizowałeś.';
	@override late final _Translations$generateNewKey$buttons$pl buttons = _Translations$generateNewKey$buttons$pl._(_root);
	@override late final _Translations$generateNewKey$errors$pl errors = _Translations$generateNewKey$errors$pl._(_root);
	@override late final _Translations$generateNewKey$feedback$pl feedback = _Translations$generateNewKey$feedback$pl._(_root);
	@override late final _Translations$generateNewKey$tooltips$pl tooltips = _Translations$generateNewKey$tooltips$pl._(_root);
}

// Path: backup
class _Translations$backup$pl extends Translations$backup$en {
	_Translations$backup$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zarchiwizuj';
	@override String get description => 'To jest Twój klucz prywatny. Zabezpiecza on komunikację z koordynatorem. Nigdy nikomu go nie ujawniaj. Zarchiwizuj go w bezpiecznym miejscu, aby uniknąć problemów podczas sporów.';
	@override late final _Translations$backup$feedback$pl feedback = _Translations$backup$feedback$pl._(_root);
	@override late final _Translations$backup$tooltips$pl tooltips = _Translations$backup$tooltips$pl._(_root);
}

// Path: restore
class _Translations$restore$pl extends Translations$restore$en {
	_Translations$restore$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Przywróć';
	@override late final _Translations$restore$labels$pl labels = _Translations$restore$labels$pl._(_root);
	@override late final _Translations$restore$buttons$pl buttons = _Translations$restore$buttons$pl._(_root);
	@override late final _Translations$restore$errors$pl errors = _Translations$restore$errors$pl._(_root);
	@override late final _Translations$restore$feedback$pl feedback = _Translations$restore$feedback$pl._(_root);
	@override late final _Translations$restore$tooltips$pl tooltips = _Translations$restore$tooltips$pl._(_root);
}

// Path: home
class _Translations$home$pl extends Translations$home$en {
	_Translations$home$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$home$notifications$pl notifications = _Translations$home$notifications$pl._(_root);
	@override late final _Translations$home$statistics$pl statistics = _Translations$home$statistics$pl._(_root);
}

// Path: system
class _Translations$system$pl extends Translations$system$en {
	_Translations$system$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get loadingPublicKey => 'Ładowanie Twojego klucza publicznego...';
	@override late final _Translations$system$errors$pl errors = _Translations$system$errors$pl._(_root);
	@override late final _Translations$system$blik$pl blik = _Translations$system$blik$pl._(_root);
}

// Path: myOffers
class _Translations$myOffers$pl extends Translations$myOffers$en {
	_Translations$myOffers$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Moje oferty';
	@override String get empty => 'Brak ofert.';
	@override String get unknownCoordinator => 'Nieznany koordynator';
	@override String get menuLabel => 'Moje oferty';
	@override late final _Translations$myOffers$filter$pl filter = _Translations$myOffers$filter$pl._(_root);
	@override late final _Translations$myOffers$details$pl details = _Translations$myOffers$details$pl._(_root);
}

// Path: landing
class _Translations$landing$pl extends Translations$landing$en {
	_Translations$landing$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get mainTitle => 'Wymiana\n BLIK ⇄ bitcoin';
	@override String get subtitle => 'Płać lub sprzedawaj kod BLIK za bitcoin';
	@override String get partnership => 'współpraca';
	@override late final _Translations$landing$actions$pl actions = _Translations$landing$actions$pl._(_root);
}

// Path: faq
class _Translations$faq$pl extends Translations$faq$en {
	_Translations$faq$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'FAQ';
	@override String get tooltip => 'FAQ';
}

// Path: settings
class _Translations$settings$pl extends Translations$settings$en {
	_Translations$settings$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ustawienia';
	@override late final _Translations$settings$offerCreation$pl offerCreation = _Translations$settings$offerCreation$pl._(_root);
	@override late final _Translations$settings$display$pl display = _Translations$settings$display$pl._(_root);
}

// Path: notificationSettings
class _Translations$notificationSettings$pl extends Translations$notificationSettings$en {
	_Translations$notificationSettings$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Powiadomienia';
	@override String get androidOnly => 'Powiadomienia w tle są obecnie obsługiwane tylko na Androidzie.';
	@override late final _Translations$notificationSettings$newOfferAlerts$pl newOfferAlerts = _Translations$notificationSettings$newOfferAlerts$pl._(_root);
}

// Path: wallet
class _Translations$wallet$pl extends Translations$wallet$en {
	_Translations$wallet$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portfel';
	@override String get description => 'Zarządzaj ustawieniami portfela Lightning';
	@override late final _Translations$wallet$missingReceiving$pl missingReceiving = _Translations$wallet$missingReceiving$pl._(_root);
}

// Path: nwc
class _Translations$nwc$pl extends Translations$nwc$en {
	_Translations$nwc$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nostr Wallet Connect (NWC)';
	@override String get description => 'Połącz swój portfel Lightning przez NWC';
	@override late final _Translations$nwc$labels$pl labels = _Translations$nwc$labels$pl._(_root);
	@override late final _Translations$nwc$prompts$pl prompts = _Translations$nwc$prompts$pl._(_root);
	@override late final _Translations$nwc$actions$pl actions = _Translations$nwc$actions$pl._(_root);
	@override late final _Translations$nwc$feedback$pl feedback = _Translations$nwc$feedback$pl._(_root);
	@override late final _Translations$nwc$errors$pl errors = _Translations$nwc$errors$pl._(_root);
	@override late final _Translations$nwc$time$pl time = _Translations$nwc$time$pl._(_root);
}

// Path: nekoManagement
class _Translations$nekoManagement$pl extends Translations$nekoManagement$en {
	_Translations$nekoManagement$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neko';
}

// Path: relays
class _Translations$relays$pl extends Translations$relays$en {
	_Translations$relays$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Przekaźniki';
	@override String get coordinatorRelays => 'Przekaźniki koordynatora';
	@override String get discoveryRelays => 'Przekaźniki wykrywania';
	@override late final _Translations$relays$status$pl status = _Translations$relays$status$pl._(_root);
	@override late final _Translations$relays$popup$pl popup = _Translations$relays$popup$pl._(_root);
}

// Path: offerNotifications
class _Translations$offerNotifications$pl extends Translations$offerNotifications$en {
	_Translations$offerNotifications$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offerNotifications$activeService$pl activeService = _Translations$offerNotifications$activeService$pl._(_root);
	@override late final _Translations$offerNotifications$funded$pl funded = _Translations$offerNotifications$funded$pl._(_root);
	@override late final _Translations$offerNotifications$reserved$pl reserved = _Translations$offerNotifications$reserved$pl._(_root);
	@override late final _Translations$offerNotifications$blikReady$pl blikReady = _Translations$offerNotifications$blikReady$pl._(_root);
	@override late final _Translations$offerNotifications$newOffer$pl newOffer = _Translations$offerNotifications$newOffer$pl._(_root);
	@override late final _Translations$offerNotifications$categories$pl categories = _Translations$offerNotifications$categories$pl._(_root);
	@override late final _Translations$offerNotifications$blikPendingReminder$pl blikPendingReminder = _Translations$offerNotifications$blikPendingReminder$pl._(_root);
	@override late final _Translations$offerNotifications$takerCharged$pl takerCharged = _Translations$offerNotifications$takerCharged$pl._(_root);
	@override late final _Translations$offerNotifications$invalidBlik$pl invalidBlik = _Translations$offerNotifications$invalidBlik$pl._(_root);
	@override late final _Translations$offerNotifications$takerPaid$pl takerPaid = _Translations$offerNotifications$takerPaid$pl._(_root);
}

// Path: altstore
class _Translations$altstore$pl extends Translations$altstore$en {
	_Translations$altstore$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'AltStore Nie Zainstalowany';
	@override String get step1Title => 'Pobierz i zainstaluj AltStore PAL';
	@override String get step1Button => 'altstore.io/download';
	@override String get step1Warning => 'Potrzebujesz Safari, aby zainstalować AltStore PAL!';
	@override String get step2Title => 'Zainstaluj BitBlik';
	@override String get step2Button => 'Zainstaluj BitBlik';
	@override String get step2Fallback => 'Nie działa? Wklej źródło do AltStore';
}

// Path: common.buttons
class _Translations$common$buttons$pl extends Translations$common$buttons$en {
	_Translations$common$buttons$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Anuluj';
	@override String get save => 'Zapisz';
	@override String get done => 'Gotowe';
	@override String get retry => 'Spróbuj ponownie';
	@override String get goHome => 'Wróć do strony głównej';
	@override String get saveAndContinue => 'Zapisz i kontynuuj';
	@override String get reveal => 'Pokaż';
	@override String get hide => 'Ukryj';
	@override String get copy => 'Kopiuj';
	@override String get close => 'Zamknij';
	@override String get restore => 'Przywróć';
	@override String get faq => 'FAQ';
}

// Path: common.labels
class _Translations$common$labels$pl extends Translations$common$labels$en {
	_Translations$common$labels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get amount => 'Kwota (PLN)';
	@override String status({required Object status}) => 'Status: ${status}';
	@override String role({required Object role}) => 'Rola: ${role}';
}

// Path: common.notifications
class _Translations$common$notifications$pl extends Translations$common$notifications$en {
	_Translations$common$notifications$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get success => 'Sukces';
	@override String get error => 'Błąd';
	@override String get loading => 'Ładowanie...';
}

// Path: common.clipboard
class _Translations$common$clipboard$pl extends Translations$common$clipboard$en {
	_Translations$common$clipboard$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get copyToClipboard => 'Kopiuj do schowka';
	@override String get pasteFromClipboard => 'Wklej ze schowka';
	@override String get copied => 'Skopiowano do schowka!';
}

// Path: common.actions
class _Translations$common$actions$pl extends Translations$common$actions$en {
	_Translations$common$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get cancelAndReturnToOffers => 'Anuluj i wróć do ofert';
	@override String get cancelAndReturnHome => 'Anuluj i wróć do strony głównej';
}

// Path: lightningAddress.labels
class _Translations$lightningAddress$labels$pl extends Translations$lightningAddress$labels$en {
	_Translations$lightningAddress$labels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get address => 'Adres Lightning (LNURL)';
	@override String get hint => 'uzytkownik@domena.com';
	@override String short({required Object address}) => 'Adres Lightning: ${address}';
	@override String get receivingAddress => 'Twój adres odbiorczy:';
}

// Path: lightningAddress.prompts
class _Translations$lightningAddress$prompts$pl extends Translations$lightningAddress$prompts$en {
	_Translations$lightningAddress$prompts$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Wprowadź swój adres Lightning, aby kontynuować';
	@override String get edit => 'Edytuj';
	@override String get invalid => 'Wprowadź prawidłowy adres Lightning';
	@override String get required => 'Adres Lightning jest wymagany.';
	@override String get enterToTakeOffer => 'Musisz ustawić adres Lightning, aby przyjąć ofertę.';
	@override String get missing => 'Brak adresu Lightning. Dodaj go, aby móc przyjmować oferty.';
	@override String get add => 'Dodaj';
	@override String get delete => 'Usuń';
	@override String get confirmDelete => 'Czy na pewno chcesz usunąć swój adres Lightning?';
	@override String get howToGet => 'Nie masz jeszcze adresu Lightning? Dowiedz się, jak go zdobyć!';
	@override String get learnMore => 'Dowiedz się więcej o adresach Lightning';
}

// Path: lightningAddress.feedback
class _Translations$lightningAddress$feedback$pl extends Translations$lightningAddress$feedback$en {
	_Translations$lightningAddress$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Adres Lightning zapisany!';
	@override String get updated => 'Adres Lightning zaktualizowany!';
	@override String get valid => 'Prawidłowy adres Lightning';
}

// Path: lightningAddress.errors
class _Translations$lightningAddress$errors$pl extends Translations$lightningAddress$errors$en {
	_Translations$lightningAddress$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String saving({required Object details}) => 'Błąd podczas zapisywania adresu: ${details}';
	@override String loading({required Object details}) => 'Błąd podczas ładowania adresu Lightning: ${details}';
}

// Path: offers.details
class _Translations$offers$details$pl extends Translations$offers$details$en {
	_Translations$offers$details$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get yourOffer => 'Twoja oferta:';
	@override String get selectedOffer => 'Oferta:';
	@override String get activeOffer => 'Masz aktywną ofertę:';
	@override String get finishedOffers => 'Zakończone oferty';
	@override String get noAvailable => 'Brak dostępnych ofert.';
	@override String get noAvailableTip => 'Wskazówka: udostępnij Bitblik w swojej społeczności i wśród znajomych, aby zwiększyć liczbę zamówień w Bitblik.';
	@override String get noSuccessfulTrades => 'Brak udanych transakcji.';
	@override String get loadingDetails => 'Ładowanie szczegółów oferty...';
	@override String amount({required Object amount}) => 'Kwota: ${amount} satoshi';
	@override String amountWithCurrency({required Object amount, required Object currency}) => '${amount} ${currency}';
	@override String makerFee({required Object fee}) => 'Opłata: ${fee} sats';
	@override String takerFee({required Object fee}) => 'Opłata: ${fee} sats';
	@override String subtitle({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}';
	@override String subtitleWithDate({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}\nZapłacono: ${date}';
	@override String activeSubtitle({required Object status, required Object amount}) => 'Status: ${status}\nKwota: ${amount} satoshi';
	@override String id({required Object id}) => 'ID Oferty: ${id}...';
	@override String created({required Object dateTime}) => 'Utworzono: ${dateTime}';
	@override String takenAfter({required Object duration}) => 'Przyjęto po: ${duration}';
	@override String paidAfter({required Object duration}) => 'Zapłacono po: ${duration}';
	@override String get exchangeRate => 'Kurs wymiany';
	@override String get takerFeeLabel => 'Opłata';
	@override String get amountLabel => 'Kwota';
	@override String get feeLabel => 'Opłata';
	@override String get statusLabel => 'Status';
	@override String get youllReceive => 'Otrzymasz';
	@override String get coordinator => 'Koordynator';
	@override String get categoryLabel => 'Kategoria';
	@override late final _Translations$offers$details$categories$pl categories = _Translations$offers$details$categories$pl._(_root);
	@override late final _Translations$offers$details$consents$pl consents = _Translations$offers$details$consents$pl._(_root);
}

// Path: offers.labels
class _Translations$offers$labels$pl extends Translations$offers$labels$en {
	_Translations$offers$labels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get premium => 'Premia';
	@override String premiumBadge({required Object percent}) => '+${percent}% premii';
}

// Path: offers.tooltips
class _Translations$offers$tooltips$pl extends Translations$offers$tooltips$en {
	_Translations$offers$tooltips$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String takerFeeInfo({required Object feePercent}) => 'Koordynator pobiera ${feePercent}% opłaty dla kupującego. To obejmuje opłaty za routing Lightning i jest potrącane z kwoty, którą otrzymujesz.';
	@override String get premiumInfoTaker => 'Premia oznacza, że ta oferta jest wyceniona powyżej rynku. Dla tej samej kwoty fiat maker blokuje mniej satów w fakturze hold, więc płacisz powyżej rynku i otrzymujesz mniej satów niż po kursie rynkowym. Maksymalną premię ustala koordynator.';
	@override String get ratesFetchedAt => 'Pobrano o';
	@override String get ratesSources => 'Źródła średniego kursu';
}

// Path: offers.actions
class _Translations$offers$actions$pl extends Translations$offers$actions$en {
	_Translations$offers$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get take => 'WEŹ';
	@override String get takeOffer => 'Weź ofertę';
	@override String get resume => 'Wprowadź BLIK';
	@override String get cancel => 'Anuluj ofertę';
	@override String get view => 'Zobacz';
}

// Path: offers.status
class _Translations$offers$status$pl extends Translations$offers$status$en {
	_Translations$offers$status$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get created => 'Utworzona';
	@override String get funded => 'Sfinansowana';
	@override String get expired => 'Wygasła';
	@override String get cancelled => 'Anulowana';
	@override String get reserved => 'Zarezerwowana';
	@override String get blikReceived => 'BLIK wysłany';
	@override String get blikSentToMaker => 'Otrzymano BLIK';
	@override String get expiredBlik => 'BLIK wygasł';
	@override String get expiredSentBlik => 'BLIK wygasł';
	@override String get takerCharged => 'Taker obciążony';
	@override String get invalidBlik => 'Nieprawidłowy BLIK';
	@override String get conflict => 'Konflikt';
	@override String get dispute => 'Spór';
	@override String get makerConfirmed => 'Potwierdzona';
	@override String get settled => 'Rozliczona';
	@override String get payingTaker => 'Płacenie Takera';
	@override String get takerPaymentFailed => 'Płatność Takera nieudana';
	@override String get takerPaid => 'Zapłacony';
	@override String get unknownStatus => 'Nieznany';
}

// Path: offers.statusMessages
class _Translations$offers$statusMessages$pl extends Translations$offers$statusMessages$en {
	_Translations$offers$statusMessages$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get reserved => 'Oferta zarezerwowana przez Takera!';
	@override String get cancelled => 'Oferta anulowana pomyślnie.';
	@override String get cancelledOrExpired => 'Oferta została anulowana lub wygasła.';
	@override String noLongerAvailable({required Object status}) => 'Oferta nie jest już dostępna (Status: ${status}).';
}

// Path: offers.progress
class _Translations$offers$progress$pl extends Translations$offers$progress$en {
	_Translations$offers$progress$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String waitingForTaker({required Object time}) => 'Oczekiwanie na takera: ${time}';
	@override String reserved({required Object seconds}) => 'Zarezerwowano: ${seconds} s pozostało';
	@override String confirming({required Object seconds}) => 'Potwierdzanie: ${seconds} s pozostało';
}

// Path: offers.errors
class _Translations$offers$errors$pl extends Translations$offers$errors$en {
	_Translations$offers$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String loading({required Object details}) => 'Błąd ładowania ofert: ${details}';
	@override String loadingDetails({required Object details}) => 'Błąd ładowania szczegółów oferty: ${details}';
	@override String get detailsMissing => 'Błąd: Brakujące lub nieprawidłowe szczegóły oferty.';
	@override String get detailsNotLoaded => 'Nie udało się załadować szczegółów oferty.';
	@override String get notFound => 'Błąd: Oferta nie znaleziona.';
	@override String get unexpectedState => 'Błąd: Oferta jest w nieoczekiwanym stanie.';
	@override String unexpectedStateWithStatus({required Object status}) => 'Oferta jest w nieoczekiwanym stanie (${status}). Spróbuj ponownie lub skontaktuj się z pomocą.';
	@override String get invalidStatus => 'Oferta ma nieprawidłowy status.';
	@override String get couldNotIdentify => 'Błąd: Nie można zidentyfikować oferty do anulowania.';
	@override String cannotBeCancelled({required Object status}) => 'Oferty nie można anulować w obecnym stanie (${status}).';
	@override String failedToCancel({required Object details}) => 'Nie udało się anulować oferty: ${details}';
	@override String get activeDetailsLost => 'Błąd: Utracono szczegóły aktywnej oferty.';
	@override String checkingActive({required Object details}) => 'Błąd sprawdzania aktywnych ofert: ${details}';
	@override String cannotResume({required Object status}) => 'Nie można wznowić oferty w stanie: ${status}';
	@override String cannotResumeTaker({required Object status}) => 'Nie można wznowić oferty takera w stanie: ${status}';
	@override String resuming({required Object details}) => 'Błąd wznawiania oferty: ${details}';
	@override String get makerPublicKeyNotFound => 'Nie znaleziono klucza publicznego Makera';
	@override String get takerPublicKeyNotFound => 'Nie znaleziono klucza publicznego Takera.';
	@override String get atmConsentRequired => 'Zaakceptuj warunek dodatkowej opłaty ATM przed wzięciem tej oferty.';
	@override String get ecommerceConsentRequired => 'Zaakceptuj warunek zwrotu środków z ecommerce przed wzięciem tej oferty.';
	@override String get cannotTakeOwnOffer => 'Nie możesz wziąć własnej oferty.';
}

// Path: offers.success
class _Translations$offers$success$pl extends Translations$offers$success$en {
	_Translations$offers$success$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta zakończona';
	@override String get headline => 'Płatność potwierdzona!';
	@override String get subtitle => 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.';
	@override String get detailsTitle => 'Szczegóły oferty:';
	@override String duration({required Object time}) => 'Realizacja oferty zajęła ${time}.';
}

// Path: reservations.actions
class _Translations$reservations$actions$pl extends Translations$reservations$actions$en {
	_Translations$reservations$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Anuluj rezerwację';
}

// Path: reservations.feedback
class _Translations$reservations$feedback$pl extends Translations$reservations$feedback$en {
	_Translations$reservations$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get cancelled => 'Rezerwacja anulowana.';
}

// Path: reservations.errors
class _Translations$reservations$errors$pl extends Translations$reservations$errors$en {
	_Translations$reservations$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String cancelling({required Object error}) => 'Nie udało się anulować rezerwacji: ${error}';
	@override String failedToReserve({required Object details}) => 'Nie udało się zarezerwować oferty: ${details}';
	@override String get failedNoTimestamp => 'Nie udało się zarezerwować oferty (brak znacznika czasu).';
	@override String get timestampMissing => 'Brak znacznika czasu rezerwacji oferty.';
	@override String notReserved({required Object status}) => 'Oferta nie jest już w stanie zarezerwowanym (${status}).';
}

// Path: exchange.labels
class _Translations$exchange$labels$pl extends Translations$exchange$labels$en {
	_Translations$exchange$labels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get enterAmount => 'Wprowadź kwotę (PLN) do zapłaty:';
	@override String equivalent({required Object sats}) => '≈ ${sats} satoshi';
	@override String rate({required Object rate}) => 'Kurs wymiany ≈ ${rate} PLN/BTC';
}

// Path: exchange.feedback
class _Translations$exchange$feedback$pl extends Translations$exchange$feedback$en {
	_Translations$exchange$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get fetching => 'Pobieranie kursu wymiany...';
}

// Path: exchange.errors
class _Translations$exchange$errors$pl extends Translations$exchange$errors$en {
	_Translations$exchange$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get fetchingRate => 'Nie udało się pobrać kursu wymiany.';
	@override String get invalidFormat => 'Nieprawidłowy format liczby';
	@override String get mustBePositive => 'Kwota musi być dodatnia';
	@override String get invalidFeePercentage => 'Nieprawidłowy procent opłaty';
	@override String tooLowFiat({required Object minAmount, required Object currency}) => 'Kwota jest za niska. Minimum to ${minAmount} ${currency}.';
	@override String tooHighFiat({required Object maxAmount, required Object currency}) => 'Kwota jest za wysoka. Maksimum to ${maxAmount} ${currency}.';
}

// Path: coordinator.info
class _Translations$coordinator$info$pl extends Translations$coordinator$info$en {
	_Translations$coordinator$info$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get fee => 'opłata';
	@override String rangeDisplay({required Object minAmount, required Object maxAmount, required Object currency}) => 'Kwota: ${minAmount}-${maxAmount} ${currency}';
	@override String feeDisplay({required Object fee}) => '${fee}% opłata';
}

// Path: coordinator.selector
class _Translations$coordinator$selector$pl extends Translations$coordinator$selector$en {
	_Translations$coordinator$selector$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Ładowanie koordynatorów...';
	@override String get errorLoading => 'Błąd ładowania koordynatorów';
	@override String get choose => 'Wybierz koordynatora';
	@override String get viewNostrProfile => 'Zobacz profil Nostr';
	@override String get unresponsive => 'Ten koordynator nie odpowiada';
	@override String get waitingResponse => 'Oczekiwanie na odpowiedź koordynatora';
	@override String get termsAccept => 'Akceptuję ';
	@override String get termsOfUsage => 'Warunki użytkowania';
}

// Path: coordinator.dialog
class _Translations$coordinator$dialog$pl extends Translations$coordinator$dialog$en {
	_Translations$coordinator$dialog$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get makerFee => 'Opłata twórcy';
	@override String get takerFee => 'Opłata odbiorcy';
	@override String get amountRange => 'Zakres kwoty';
	@override String get reservationTime => 'Czas rezerwacji';
	@override String get currencies => 'Waluty';
	@override String get viewTerms => 'Zobacz warunki';
}

// Path: coordinator.details
class _Translations$coordinator$details$pl extends Translations$coordinator$details$en {
	_Translations$coordinator$details$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordynator';
	@override String get relaysInUse => 'Używane przekaźniki';
	@override String get relaysInUseHint => 'Cała komunikacja z tym koordynatorem odbywa się przez te przekaźniki (z jego listy NIP-65).';
	@override String get noRelays => 'Brak znanych przekaźników';
	@override String get makerFee => 'Opłata makera';
	@override String get takerFee => 'Opłata takera';
	@override String get amountRange => 'Zakres kwoty';
	@override String get maxPremium => 'Maks. premia';
	@override String get maxPremiumInfoTitle => 'Premia';
	@override String get maxPremiumInfoBody => 'Premia to opcjonalna marża ponad kurs rynkowy, którą wystawiający (maker) może ustawić na ofercie. Przy premii maker blokuje mniej satoshi za tę samą kwotę fiat, więc biorący (taker) płaci powyżej rynku, a maker zatrzymuje różnicę. Ta wartość to najwyższa premia dozwolona przez tego koordynatora w jego ofertach.';
	@override String get reservationTime => 'Czas rezerwacji';
	@override String get currencies => 'Waluty';
	@override String get version => 'Wersja';
	@override String get yourOffers => 'Twoje oferty';
	@override String get successfulOffers => 'Udane oferty (30d)';
	@override String get statusOnline => 'Online';
	@override String get statusOffline => 'Offline';
	@override String get statusUnknown => 'Nieznany';
	@override String get openNostrProfile => 'Otwórz profil Nostr';
	@override String get termsOfUsage => 'Warunki użytkowania';
}

// Path: coordinator.management
class _Translations$coordinator$management$pl extends Translations$coordinator$management$en {
	_Translations$coordinator$management$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zarządzanie Koordynatorami';
	@override String get availableCoordinators => 'Koordynatorzy';
	@override String get noCoordinators => 'Nie odkryto jeszcze żadnych koordynatorów.';
	@override String get online => 'Online';
	@override String get unknownOffline => 'Nieznany/Offline';
	@override String get openNostrProfile => 'Otwórz profil Nostr';
	@override String get enable => 'Włącz';
	@override String get remove => 'Usuń';
	@override String get addCustomWhitelist => 'Dodaj koordynatora';
	@override String get addCustomWhitelistHint => 'npub1...';
	@override String get add => 'Dodaj';
	@override String get coordinatorDisabled => 'Koordynator wyłączony';
	@override String get coordinatorEnabled => 'Koordynator włączony';
	@override String get coordinatorAdded => 'Koordynator dodany do niestandardowej białej listy';
	@override String get coordinatorRemoved => 'Koordynator usunięty z niestandardowej białej listy';
	@override String get coordinatorAddInfoUnavailable => 'Nie znaleziono informacji o koordynatorze w przekaźnikach. Koordynator nie został dodany.';
	@override String get pleaseEnterNpub => 'Proszę wprowadzić npub';
	@override String get error => 'Błąd';
	@override String get metricYourOffers => 'Twoje oferty';
	@override String get metricYourOffersTooltip => 'Liczba ofert, które pomyślnie zrealizowałeś z tym koordynatorem.';
	@override String get metricNetworkOffers => 'Oferty (30 dni)';
	@override String get metricNetworkOffersTooltip => 'Pomyślnie rozliczone oferty przez tego koordynatora dla wszystkich użytkowników w ciągu ostatnich 30 dni.';
}

// Path: maker.roleSelection
class _Translations$maker$roleSelection$pl extends Translations$maker$roleSelection$en {
	_Translations$maker$roleSelection$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get button => 'ZAPŁAĆ przez Lightning';
}

// Path: maker.amountForm
class _Translations$maker$amountForm$pl extends Translations$maker$amountForm$en {
	_Translations$maker$amountForm$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$amountForm$progress$pl progress = _Translations$maker$amountForm$progress$pl._(_root);
	@override late final _Translations$maker$amountForm$labels$pl labels = _Translations$maker$amountForm$labels$pl._(_root);
	@override late final _Translations$maker$amountForm$actions$pl actions = _Translations$maker$amountForm$actions$pl._(_root);
	@override late final _Translations$maker$amountForm$tooltips$pl tooltips = _Translations$maker$amountForm$tooltips$pl._(_root);
	@override late final _Translations$maker$amountForm$category$pl category = _Translations$maker$amountForm$category$pl._(_root);
	@override late final _Translations$maker$amountForm$onboarding$pl onboarding = _Translations$maker$amountForm$onboarding$pl._(_root);
	@override late final _Translations$maker$amountForm$errors$pl errors = _Translations$maker$amountForm$errors$pl._(_root);
}

// Path: maker.payInvoice
class _Translations$maker$payInvoice$pl extends Translations$maker$payInvoice$en {
	_Translations$maker$payInvoice$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zapłać tę fakturę Hold:';
	@override late final _Translations$maker$payInvoice$actions$pl actions = _Translations$maker$payInvoice$actions$pl._(_root);
	@override late final _Translations$maker$payInvoice$feedback$pl feedback = _Translations$maker$payInvoice$feedback$pl._(_root);
	@override late final _Translations$maker$payInvoice$errors$pl errors = _Translations$maker$payInvoice$errors$pl._(_root);
}

// Path: maker.waitTaker
class _Translations$maker$waitTaker$pl extends Translations$maker$waitTaker$en {
	_Translations$maker$waitTaker$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get message => 'Oczekiwanie na rezerwację przez Kupującego...';
	@override String get errorActiveOfferDetailsLost => 'Błąd: Utracono szczegóły aktywnej oferty.';
	@override String get errorFailedToRetrieveBlik => 'Błąd: Nie udało się pobrać kodu BLIK.';
	@override String errorRetrievingBlik({required Object details}) => 'Błąd pobierania kodu BLIK: ${details}';
	@override String offerNoLongerAvailable({required Object status}) => 'Oferta nie jest już dostępna (Status: ${status}).';
	@override String get errorCouldNotIdentifyOffer => 'Błąd: Nie można zidentyfikować oferty do anulowania.';
	@override String offerCannotBeCancelled({required Object status}) => 'Oferty nie można anulować w obecnym stanie (${status}).';
	@override String get offerCancelledSuccessfully => 'Oferta anulowana pomyślnie.';
	@override String failedToCancelOffer({required Object details}) => 'Nie udało się anulować oferty: ${details}';
	@override String get offerExpiredTitle => 'Oferta wygasła';
	@override String get offerExpiredMessage => 'Żaden taker nie zarezerwował oferty w czasie.';
	@override String get recreateOffer => 'Nowa oferta — ta sama kwota';
}

// Path: maker.waitForBlik
class _Translations$maker$waitForBlik$pl extends Translations$maker$waitForBlik$en {
	_Translations$maker$waitForBlik$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oczekiwanie na BLIK';
	@override String get messageInfo => 'Ktoś zarezerwował twoją ofertę!';
	@override String get messageWaiting => 'Oczekiwanie na kod BLIK...';
	@override String progressLabel({required Object seconds}) => 'Zarezerwowano: ${seconds} s pozostało';
}

// Path: maker.confirmPayment
class _Translations$maker$confirmPayment$pl extends Translations$maker$confirmPayment$en {
	_Translations$maker$confirmPayment$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Otrzymano kod BLIK!';
	@override String get retrieving => 'Pobieranie kodu BLIK...';
	@override String get instruction1 => 'Wprowadź kod do systemu płatności BLIK.';
	@override String get instruction2 => 'Poczekaj, aż Kupujący potwierdzi płatność w swojej aplikacji banku.';
	@override String get instruction3 => 'Gdy płatność zakończy się sukcesem, naciśnij Potwierdź poniżej:';
	@override String get takerChargedWarning => 'Pobierający zgłosił, że płatność BLIK została pobrana z jego konta bankowego. Oznaczenie tego jako nieprawidłowe spowoduje konflikt.';
	@override String get expiredTitle => 'Kod BLIK wygasł';
	@override String get expiredWarning => 'Kod BLIK wygasł. Musisz ręcznie potwierdzić status płatności:';
	@override String get expiredInstruction1 => 'Jeśli płatność BLIK zakończyła się sukcesem i zrealizowałeś zakup, kliknij "Potwierdź udaną płatność" poniżej.';
	@override String get expiredInstruction2 => 'Jeśli płatność BLIK nie powiodła się lub nie została zrealizowana, kliknij "Nieprawidłowy kod BLIK" poniżej.';
	@override late final _Translations$maker$confirmPayment$actions$pl actions = _Translations$maker$confirmPayment$actions$pl._(_root);
	@override late final _Translations$maker$confirmPayment$confirmDialog$pl confirmDialog = _Translations$maker$confirmPayment$confirmDialog$pl._(_root);
	@override late final _Translations$maker$confirmPayment$invalidBlikDisputeDialog$pl invalidBlikDisputeDialog = _Translations$maker$confirmPayment$invalidBlikDisputeDialog$pl._(_root);
	@override late final _Translations$maker$confirmPayment$feedback$pl feedback = _Translations$maker$confirmPayment$feedback$pl._(_root);
	@override late final _Translations$maker$confirmPayment$errors$pl errors = _Translations$maker$confirmPayment$errors$pl._(_root);
}

// Path: maker.invalidBlik
class _Translations$maker$invalidBlik$pl extends Translations$maker$invalidBlik$en {
	_Translations$maker$invalidBlik$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nieprawidłowy kod BLIK';
	@override String get info => 'Oznaczyłeś kod BLIK jako nieprawidłowy. Oczekiwanie na podanie nowego kodu przez takera lub rozpoczęcie sporu.';
}

// Path: maker.conflict
class _Translations$maker$conflict$pl extends Translations$maker$conflict$en {
	_Translations$maker$conflict$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konflikt Oferty';
	@override String get headline => 'Zgłoszono Konflikt Oferty';
	@override String get body => 'Oznaczyłeś kod BLIK jako nieprawidłowy, ale Taker zgłosił konflikt, wskazując, że uważa, iż płatność zakończyła się sukcesem.';
	@override String get instructions => 'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.';
	@override late final _Translations$maker$conflict$actions$pl actions = _Translations$maker$conflict$actions$pl._(_root);
	@override late final _Translations$maker$conflict$disputeDialog$pl disputeDialog = _Translations$maker$conflict$disputeDialog$pl._(_root);
	@override late final _Translations$maker$conflict$feedback$pl feedback = _Translations$maker$conflict$feedback$pl._(_root);
	@override late final _Translations$maker$conflict$errors$pl errors = _Translations$maker$conflict$errors$pl._(_root);
	@override late final _Translations$maker$conflict$nostrContact$pl nostrContact = _Translations$maker$conflict$nostrContact$pl._(_root);
}

// Path: maker.success
class _Translations$maker$success$pl extends Translations$maker$success$en {
	_Translations$maker$success$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta zakończona';
	@override String get headline => 'Płatność potwierdzona!';
	@override String get subtitle => 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.';
	@override String get detailsTitle => 'Szczegóły oferty:';
	@override String duration({required Object time}) => 'Oferta zajęła ${time}!';
}

// Path: taker.roleSelection
class _Translations$taker$roleSelection$pl extends Translations$taker$roleSelection$en {
	_Translations$taker$roleSelection$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get button => 'SPRZEDAJ kod BLIK za satoshi';
}

// Path: taker.progress
class _Translations$taker$progress$pl extends Translations$taker$progress$en {
	_Translations$taker$progress$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get step1 => 'Wyślij BLIK';
	@override String get step2 => 'Potwierdź BLIK';
	@override String get step3 => 'Otrzymaj płatność';
}

// Path: taker.submitBlik
class _Translations$taker$submitBlik$pl extends Translations$taker$submitBlik$en {
	_Translations$taker$submitBlik$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wpisz 6-cyfr BLIK';
	@override String get label => 'Kod BLIK';
	@override String get instruction => 'Wprowadź BLIK zanim upłynie czas...';
	@override String timeLimit({required Object seconds}) => 'Wprowadź BLIK w ciągu: ${seconds} s';
	@override String get timeExpired => 'Czas na wprowadzenie kodu BLIK minął.';
	@override late final _Translations$taker$submitBlik$actions$pl actions = _Translations$taker$submitBlik$actions$pl._(_root);
	@override late final _Translations$taker$submitBlik$feedback$pl feedback = _Translations$taker$submitBlik$feedback$pl._(_root);
	@override late final _Translations$taker$submitBlik$validation$pl validation = _Translations$taker$submitBlik$validation$pl._(_root);
	@override late final _Translations$taker$submitBlik$errors$pl errors = _Translations$taker$submitBlik$errors$pl._(_root);
	@override late final _Translations$taker$submitBlik$details$pl details = _Translations$taker$submitBlik$details$pl._(_root);
}

// Path: taker.waitConfirmation
class _Translations$taker$waitConfirmation$pl extends Translations$taker$waitConfirmation$en {
	_Translations$taker$waitConfirmation$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oczekiwanie na Makera';
	@override String statusLabel({required Object status}) => 'Status oferty: ${status}';
	@override String waitingMaker({required Object seconds}) => 'Oczekiwanie na potwierdzenie Makera: ${seconds} s';
	@override String waitingMakerConfirmation({required Object seconds}) => 'Oczekiwanie na potwierdzenie płatności BLIK przez Makera w jego aplikacji bankowej. Pozostały czas: ${seconds}s';
	@override String importantNotice({required Object amount, required Object currency}) => 'BARDZO WAŻNE: Upewnij się, że akceptujesz potwierdzenie BLIK tylko na kwotę ${amount} ${currency}';
	@override String importantBlikAmountConfirmation({required Object amount, required Object currency}) => 'BARDZO WAŻNE: W swojej aplikacji bankowej upewnij się, że potwierdzasz płatność BLIK na kwotę dokładnie ${amount} ${currency}.';
	@override String get instructions => 'Osoba wystawiająca ofertę musi teraz wpisać kod BLIK w ciągu 2 minut. Następnie musisz zaakceptować kod BLIK w swojej aplikacji bankowej.';
	@override late final _Translations$taker$waitConfirmation$categoryReminder$pl categoryReminder = _Translations$taker$waitConfirmation$categoryReminder$pl._(_root);
	@override String get waitingForMakerToReceive => 'Czekamy, aż twórca oferty otrzyma Twój kod BLIK...';
	@override String get makerReceivedBlik => 'Twórca oferty otrzymał Twój kod BLIK';
	@override String get timerExpiredMessage => 'Minął termin ważności kodu BLIK 2m. Czekamy na potwierdzenie lub oznaczenie kodu jako nieważnego przez wystawcę oferty.';
	@override String get timerExpiredActions => 'Minął termin ważności kodu BLIK 2m, ale wystawca nie otrzymał kodu BLIK. Możesz wysłać nowy kod BLIK lub anulować.';
	@override String get resendBlikButton => 'Wyślij nowy kod BLIK';
	@override String get navigatedHome => 'Przeniesiono na stronę główną.';
	@override String get expiredTitle => 'Kod BLIK wygasł';
	@override String get expiredWarning => 'Twórca oferty nie otrzymał kodu BLIK, więc nie mógł go użyć.';
	@override String get expiredRelistCountdownLabel => 'Koniec rezerwacji za';
	@override String get expiredSentWarning => 'Twórca oferty jeszcze nie potwierdził płatności. Co chcesz zrobić?';
	@override String get expiredInstruction1 => 'Jeśli chcesz spróbować ponownie z nowym kodem BLIK, odnów rezerwację.';
	@override String get expiredInstruction2 => 'Jeśli nie chcesz już dokończyć tej transakcji, anuluj rezerwację.';
	@override String get expiredInstruction3 => 'Jeśli płatność BLIK została pobrana z Twojego konta bankowego, nie martw się, bitcoin jest nadal bezpiecznie zablokowany u koordynatora.';
	@override late final _Translations$taker$waitConfirmation$takerCharged$pl takerCharged = _Translations$taker$waitConfirmation$takerCharged$pl._(_root);
	@override late final _Translations$taker$waitConfirmation$expiredActions$pl expiredActions = _Translations$taker$waitConfirmation$expiredActions$pl._(_root);
	@override late final _Translations$taker$waitConfirmation$feedback$pl feedback = _Translations$taker$waitConfirmation$feedback$pl._(_root);
	@override late final _Translations$taker$waitConfirmation$errors$pl errors = _Translations$taker$waitConfirmation$errors$pl._(_root);
}

// Path: taker.paymentProcess
class _Translations$taker$paymentProcess$pl extends Translations$taker$paymentProcess$en {
	_Translations$taker$paymentProcess$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Proces Płatności';
	@override String get waitingForOfferUpdate => 'Oczekiwanie na aktualizację statusu oferty...';
	@override late final _Translations$taker$paymentProcess$states$pl states = _Translations$taker$paymentProcess$states$pl._(_root);
	@override late final _Translations$taker$paymentProcess$steps$pl steps = _Translations$taker$paymentProcess$steps$pl._(_root);
	@override late final _Translations$taker$paymentProcess$errors$pl errors = _Translations$taker$paymentProcess$errors$pl._(_root);
	@override late final _Translations$taker$paymentProcess$loading$pl loading = _Translations$taker$paymentProcess$loading$pl._(_root);
	@override late final _Translations$taker$paymentProcess$actions$pl actions = _Translations$taker$paymentProcess$actions$pl._(_root);
}

// Path: taker.paymentFailed
class _Translations$taker$paymentFailed$pl extends Translations$taker$paymentFailed$en {
	_Translations$taker$paymentFailed$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Płatność Nie Powiodła Się';
	@override String instructions({required Object netAmount}) => 'Proszę podać nową fakturę Lightning na kwotę ${netAmount}';
	@override late final _Translations$taker$paymentFailed$form$pl form = _Translations$taker$paymentFailed$form$pl._(_root);
	@override late final _Translations$taker$paymentFailed$actions$pl actions = _Translations$taker$paymentFailed$actions$pl._(_root);
	@override late final _Translations$taker$paymentFailed$errors$pl errors = _Translations$taker$paymentFailed$errors$pl._(_root);
	@override late final _Translations$taker$paymentFailed$walletSection$pl walletSection = _Translations$taker$paymentFailed$walletSection$pl._(_root);
	@override late final _Translations$taker$paymentFailed$loading$pl loading = _Translations$taker$paymentFailed$loading$pl._(_root);
	@override late final _Translations$taker$paymentFailed$success$pl success = _Translations$taker$paymentFailed$success$pl._(_root);
}

// Path: taker.paymentSuccess
class _Translations$taker$paymentSuccess$pl extends Translations$taker$paymentSuccess$en {
	_Translations$taker$paymentSuccess$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Płatność Udana';
	@override String get message => 'Twoja płatność została przetworzona pomyślnie.';
	@override late final _Translations$taker$paymentSuccess$actions$pl actions = _Translations$taker$paymentSuccess$actions$pl._(_root);
}

// Path: taker.invalidBlik
class _Translations$taker$invalidBlik$pl extends Translations$taker$invalidBlik$en {
	_Translations$taker$invalidBlik$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nieprawidłowy Kod BLIK';
	@override String get message => 'Maker Odrzucił Kod BLIK';
	@override String get explanation => 'Maker oferty wskazał, że podany przez Ciebie kod BLIK był nieprawidłowy lub nie zadziałał.\n\nCo chcesz zrobić?';
	@override String get werentCharged => 'Jeśli Twoje konto NIE zostało obciążone:';
	@override String get wereCharged => 'Jeśli Twoje konto zostało obciążone:';
	@override late final _Translations$taker$invalidBlik$actions$pl actions = _Translations$taker$invalidBlik$actions$pl._(_root);
	@override late final _Translations$taker$invalidBlik$feedback$pl feedback = _Translations$taker$invalidBlik$feedback$pl._(_root);
	@override late final _Translations$taker$invalidBlik$errors$pl errors = _Translations$taker$invalidBlik$errors$pl._(_root);
}

// Path: taker.conflict
class _Translations$taker$conflict$pl extends Translations$taker$conflict$en {
	_Translations$taker$conflict$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konflikt Oferty';
	@override String get headline => 'Zgłoszono Konflikt Oferty';
	@override String get body => 'Maker oznaczył kod BLIK jako nieprawidłowy, ale Ty zgłosiłeś konflikt, wskazując, że uważasz, iż płatność zakończyła się sukcesem.';
	@override String get instructions => 'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.';
	@override late final _Translations$taker$conflict$actions$pl actions = _Translations$taker$conflict$actions$pl._(_root);
	@override late final _Translations$taker$conflict$feedback$pl feedback = _Translations$taker$conflict$feedback$pl._(_root);
	@override late final _Translations$taker$conflict$errors$pl errors = _Translations$taker$conflict$errors$pl._(_root);
	@override late final _Translations$taker$conflict$nostrContact$pl nostrContact = _Translations$taker$conflict$nostrContact$pl._(_root);
}

// Path: blik.instructions
class _Translations$blik$instructions$pl extends Translations$blik$instructions$en {
	_Translations$blik$instructions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get taker => 'Gdy Maker wprowadzi kod BLIK, będziesz musiał potwierdzić płatność w swojej aplikacji bankowej. Upewnij się, że kwota jest poprawna przed potwierdzeniem.';
}

// Path: generateNewKey.buttons
class _Translations$generateNewKey$buttons$pl extends Translations$generateNewKey$buttons$en {
	_Translations$generateNewKey$buttons$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Generuj';
}

// Path: generateNewKey.errors
class _Translations$generateNewKey$errors$pl extends Translations$generateNewKey$errors$en {
	_Translations$generateNewKey$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get activeOffer => 'Nie możesz wygenerować nowego Neko, gdy masz aktywną ofertę.';
	@override String get failed => 'Nie udało się wygenerować nowego Neko';
}

// Path: generateNewKey.feedback
class _Translations$generateNewKey$feedback$pl extends Translations$generateNewKey$feedback$en {
	_Translations$generateNewKey$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get success => 'Nowe Neko wygenerowane pomyślnie!';
}

// Path: generateNewKey.tooltips
class _Translations$generateNewKey$tooltips$pl extends Translations$generateNewKey$tooltips$en {
	_Translations$generateNewKey$tooltips$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Wygeneruj nowe Neko';
}

// Path: backup.feedback
class _Translations$backup$feedback$pl extends Translations$backup$feedback$en {
	_Translations$backup$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Klucz prywatny skopiowany do schowka!';
}

// Path: backup.tooltips
class _Translations$backup$tooltips$pl extends Translations$backup$tooltips$en {
	_Translations$backup$tooltips$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get backup => 'Zarchiwizuj Neko';
}

// Path: restore.labels
class _Translations$restore$labels$pl extends Translations$restore$labels$en {
	_Translations$restore$labels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get privateKey => 'Klucz prywatny';
}

// Path: restore.buttons
class _Translations$restore$buttons$pl extends Translations$restore$buttons$en {
	_Translations$restore$buttons$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Przywróć';
}

// Path: restore.errors
class _Translations$restore$errors$pl extends Translations$restore$errors$en {
	_Translations$restore$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get invalidKey => 'Musi to być 64-znakowy ciąg szesnastkowy.';
	@override String get failed => 'Przywracanie nie powiodło się';
}

// Path: restore.feedback
class _Translations$restore$feedback$pl extends Translations$restore$feedback$en {
	_Translations$restore$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get success => 'Neko przywrócone pomyślnie! Aplikacja zostanie ponownie uruchomiona.';
}

// Path: restore.tooltips
class _Translations$restore$tooltips$pl extends Translations$restore$tooltips$en {
	_Translations$restore$tooltips$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Przywróć Neko';
}

// Path: home.notifications
class _Translations$home$notifications$pl extends Translations$home$notifications$en {
	_Translations$home$notifications$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Otrzymuj powiadomienia o nowych ofertach przez:';
	@override String get telegram => 'Telegram';
	@override String get simplex => 'SimpleX';
	@override String get element => 'Element';
	@override String get signal => 'Signal';
}

// Path: home.statistics
class _Translations$home$statistics$pl extends Translations$home$statistics$en {
	_Translations$home$statistics$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zakończone oferty';
	@override String lifetimeCompact({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Wszystkie: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}';
	@override String last7DaysCompact({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ost. 7 dni: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}';
	@override String last7DaysSingleLine({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ost. 7 dni: ${count} ofert  |  Śr. BLIK: ${avgBlikTime}  |  Śr. płatność: ${avgPaidTime}';
	@override late final _Translations$home$statistics$errors$pl errors = _Translations$home$statistics$errors$pl._(_root);
}

// Path: system.errors
class _Translations$system$errors$pl extends Translations$system$errors$en {
	_Translations$system$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get generic => 'Wystąpił nieoczekiwany błąd. Proszę spróbować ponownie.';
	@override String get loadingTimeoutConfig => 'Błąd ładowania konfiguracji limitu czasu.';
	@override String get loadingCoordinatorConfig => 'Błąd ładowania konfiguracji koordynatora. Proszę spróbować ponownie.';
	@override String get noPublicKey => 'Twój klucz publiczny nie jest dostępny. Nie można kontynuować.';
	@override String get internalOfferIncomplete => 'Błąd wewnętrzny: Szczegóły oferty są niekompletne. Spróbuj ponownie.';
	@override String get loadingPublicKey => 'Błąd ładowania Twojego klucza publicznego. Uruchom ponownie aplikację.';
}

// Path: system.blik
class _Translations$system$blik$pl extends Translations$system$blik$en {
	_Translations$system$blik$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Kod BLIK skopiowany do schowka';
}

// Path: myOffers.filter
class _Translations$myOffers$filter$pl extends Translations$myOffers$filter$en {
	_Translations$myOffers$filter$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get all => 'Wszystkie';
	@override String get active => 'Aktywne';
	@override String get completed => 'Zakończone';
	@override String get failed => 'Nieudane';
}

// Path: myOffers.details
class _Translations$myOffers$details$pl extends Translations$myOffers$details$en {
	_Translations$myOffers$details$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Szczegóły oferty';
	@override String get notFound => 'Nie znaleziono oferty.';
	@override String get amount => 'Kwota';
	@override String get fees => 'Opłaty';
	@override String get sats => 'Satoshi';
	@override String get maker => 'Maker';
	@override String get taker => 'Taker';
	@override String get yourFee => 'Twoja opłata';
	@override String get makerFee => 'Opłata makera';
	@override String get takerFee => 'Opłata takera';
	@override String get coordinator => 'Koordynator';
	@override String get createdAt => 'Utworzono';
	@override String get reservedAt => 'Zarezerwowano';
	@override String get blikReceivedAt => 'BLIK wysłany';
	@override String get makerConfirmedAt => 'Potwierdzono';
	@override String get settledAt => 'Rozliczono';
	@override String get takerPaidAt => 'Taker opłacony';
	@override String get id => 'ID oferty';
	@override String get paymentHash => 'Hash płatności';
	@override String get holdInvoice => 'Hold Invoice';
	@override String get continueActiveOffer => 'Przejdź do aktywnej oferty';
	@override String after({required Object duration}) => 'po ${duration}';
}

// Path: landing.actions
class _Translations$landing$actions$pl extends Translations$landing$actions$en {
	_Translations$landing$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get payBlik => 'Zapłać BLIK';
	@override String get payBlikSubtitle => 'używając bitcoin';
	@override String get sellBlik => 'Kup bitcoin';
	@override String get sellBlikSubtitle => 'używając BLIK';
	@override String get howItWorks => 'Jak to działa?';
}

// Path: settings.offerCreation
class _Translations$settings$offerCreation$pl extends Translations$settings$offerCreation$en {
	_Translations$settings$offerCreation$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tworzenie ofert';
	@override String get defaultCategory => 'Domyślna kategoria';
	@override String get preferredCoordinator => 'Preferowany koordynator';
	@override String get automaticCoordinator => 'Najbardziej niezawodny';
	@override String get automaticCoordinatorDescription => 'Wybiera koordynatora z najlepszą historią, uwzględniając Twoje własne zrealizowane oferty oraz ogólną aktywność w sieci.';
	@override String get cheapestCoordinator => 'Najtańszy';
	@override String get cheapestCoordinatorDescription => 'Wybiera dostępnego koordynatora z najniższą prowizją wystawiającego dla każdej oferty.';
	@override String get enablePremium => 'Włącz premię cenową';
	@override String get enablePremiumDescription => 'Pokaż suwak premii podczas tworzenia ofert makera.';
	@override String get defaultPremium => 'Domyślna premia';
	@override String get defaultPremiumDisabled => 'Włącz premię cenową, aby ustawić domyślną premię.';
	@override String get premiumPerCoordinatorNote => 'Każdy koordynator ustala własną maksymalną premię, więc Twoja domyślna wartość jest ograniczona przez koordynatora użytego do oferty.';
	@override late final _Translations$settings$offerCreation$categoryOptions$pl categoryOptions = _Translations$settings$offerCreation$categoryOptions$pl._(_root);
	@override late final _Translations$settings$offerCreation$dialogs$pl dialogs = _Translations$settings$offerCreation$dialogs$pl._(_root);
}

// Path: settings.display
class _Translations$settings$display$pl extends Translations$settings$display$en {
	_Translations$settings$display$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wygląd';
	@override String get bitcoinUnit => 'Jednostka Bitcoina';
	@override String get bitcoinUnitDescription => 'Wybierz, jak kwoty bitcoina są pokazywane w całej aplikacji.';
	@override late final _Translations$settings$display$unitOptions$pl unitOptions = _Translations$settings$display$unitOptions$pl._(_root);
}

// Path: notificationSettings.newOfferAlerts
class _Translations$notificationSettings$newOfferAlerts$pl extends Translations$notificationSettings$newOfferAlerts$en {
	_Translations$notificationSettings$newOfferAlerts$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Alerty o nowych ofertach';
	@override String get description => 'Po włączeniu BitBlik będzie powiadamiać o nowych ofertach dostępnych do wzięcia od włączonych koordynatorów, gdy aplikacja działa w tle. Może to być szybsze niż zewnętrzne komunikatory.';
}

// Path: wallet.missingReceiving
class _Translations$wallet$missingReceiving$pl extends Translations$wallet$missingReceiving$en {
	_Translations$wallet$missingReceiving$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wymagany portfel odbiorczy';
	@override String get message => 'Brak skonfigurowanego portfela do odbierania. Dodaj go w ustawieniach portfela, aby przyjmować oferty.';
	@override String get openSettings => 'Ustawienia portfela';
}

// Path: nwc.labels
class _Translations$nwc$labels$pl extends Translations$nwc$labels$en {
	_Translations$nwc$labels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get connectionString => 'Ciąg połączenia NWC';
	@override String get hint => 'nostr+walletconnect://...';
	@override String get status => 'Status połączenia';
	@override String get connected => 'Połączono';
	@override String get disconnected => 'Rozłączono';
	@override String get scanQrCode => 'Zeskanuj kod QR z połączeniem NWC';
	@override String get balance => 'Saldo';
	@override String get budget => 'Budżet';
	@override String get usedBudget => 'Wykorzystano';
	@override String get totalBudget => 'Łącznie';
	@override String get renewsIn => 'Odnowienie za';
	@override String get renewalPeriod => 'Okres odnowienia';
	@override String get relay => 'Przekaźnik';
	@override String get relays => 'Przekaźniki';
}

// Path: nwc.prompts
class _Translations$nwc$prompts$pl extends Translations$nwc$prompts$en {
	_Translations$nwc$prompts$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Wprowadź swój ciąg połączenia NWC';
	@override String get connect => 'Połącz portfel';
	@override String get disconnect => 'Rozłącz';
	@override String get confirmDisconnect => 'Czy na pewno chcesz rozłączyć portfel NWC?';
	@override String get pasteConnection => 'Wklej ciąg połączenia';
	@override String get chooseMethod => 'Wybierz sposób połączenia portfela Lightning';
	@override String get howToGet => 'Nie masz jeszcze połączenia NWC? Dowiedz się, jak je uzyskać!';
	@override String get learnMore => 'Dowiedz się więcej o NWC';
}

// Path: nwc.actions
class _Translations$nwc$actions$pl extends Translations$nwc$actions$en {
	_Translations$nwc$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get connectAlbyGo => 'Połącz z Alby Go';
	@override String get connectNwc => 'Skanuj kod QR NWC';
}

// Path: nwc.feedback
class _Translations$nwc$feedback$pl extends Translations$nwc$feedback$en {
	_Translations$nwc$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Portfel NWC połączony pomyślnie!';
	@override String get disconnected => 'Portfel NWC rozłączony';
	@override String get connecting => 'Łączenie z portfelem NWC...';
	@override String get loadingWalletInfo => 'Ładowanie informacji o portfelu...';
}

// Path: nwc.errors
class _Translations$nwc$errors$pl extends Translations$nwc$errors$en {
	_Translations$nwc$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String connecting({required Object details}) => 'Błąd połączenia z NWC: ${details}';
	@override String disconnecting({required Object details}) => 'Błąd rozłączania NWC: ${details}';
	@override String get invalid => 'Nieprawidłowy ciąg połączenia NWC';
	@override String get required => 'Wymagany ciąg połączenia NWC';
	@override String get loadingBalance => 'Nie udało się załadować salda portfela';
	@override String get loadingBudget => 'Nie udało się załadować budżetu portfela';
}

// Path: nwc.time
class _Translations$nwc$time$pl extends Translations$nwc$time$en {
	_Translations$nwc$time$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String minutes({required Object count}) => '${count}m';
	@override String hours({required Object count}) => '${count}h';
	@override String days({required Object count}) => '${count}d';
	@override String get justNow => 'teraz';
}

// Path: relays.status
class _Translations$relays$status$pl extends Translations$relays$status$en {
	_Translations$relays$status$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Połączony';
	@override String get connecting => 'Łączenie';
	@override String get reconnecting => 'Ponowne łączenie';
	@override String get disconnected => 'Rozłączony';
}

// Path: relays.popup
class _Translations$relays$popup$pl extends Translations$relays$popup$en {
	_Translations$relays$popup$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String title({required Object connected, required Object total}) => 'Przekaźniki (${connected}/${total} połączonych)';
	@override String get connectingMessage => 'Łączenie z przekaźnikami...';
}

// Path: offerNotifications.activeService
class _Translations$offerNotifications$activeService$pl extends Translations$offerNotifications$activeService$en {
	_Translations$offerNotifications$activeService$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oczekiwanie na nowe oferty';
	@override String get body => 'Usługa w tle monitorująca ofert BitBlik.';
}

// Path: offerNotifications.funded
class _Translations$offerNotifications$funded$pl extends Translations$offerNotifications$funded$en {
	_Translations$offerNotifications$funded$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta zasilona';
	@override String get body => 'Twoja faktura hold została zaakceptowana. Oferta jest teraz aktywna.';
}

// Path: offerNotifications.reserved
class _Translations$offerNotifications$reserved$pl extends Translations$offerNotifications$reserved$en {
	_Translations$offerNotifications$reserved$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta zarezerwowana';
	@override String get body => 'Taker zarezerwował Twoją ofertę.';
}

// Path: offerNotifications.blikReady
class _Translations$offerNotifications$blikReady$pl extends Translations$offerNotifications$blikReady$en {
	_Translations$offerNotifications$blikReady$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kod BLIK gotowy';
	@override String get body => 'Twój kod BLIK jest gotowy do wyświetlenia.';
}

// Path: offerNotifications.newOffer
class _Translations$offerNotifications$newOffer$pl extends Translations$offerNotifications$newOffer$en {
	_Translations$offerNotifications$newOffer$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nowa oferta dostępna';
	@override String body({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}';
	@override String premiumSuffix({required Object percent}) => '+${percent}% premii';
}

// Path: offerNotifications.categories
class _Translations$offerNotifications$categories$pl extends Translations$offerNotifications$categories$en {
	_Translations$offerNotifications$categories$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Sklep';
	@override String get atm => 'Bankomat';
	@override String get online => 'Online';
}

// Path: offerNotifications.blikPendingReminder
class _Translations$offerNotifications$blikPendingReminder$pl extends Translations$offerNotifications$blikPendingReminder$en {
	_Translations$offerNotifications$blikPendingReminder$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'BLIK czeka na Twoją akcję';
	@override String get body => 'Potwierdź płatność lub oznacz kod BLIK jako nieprawidłowy.';
}

// Path: offerNotifications.takerCharged
class _Translations$offerNotifications$takerCharged$pl extends Translations$offerNotifications$takerCharged$en {
	_Translations$offerNotifications$takerCharged$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'BLIK obciążony';
	@override String get body => 'Taker zgłasza, że BLIK został obciążony. Potwierdź lub oznacz jako nieprawidłowy.';
}

// Path: offerNotifications.invalidBlik
class _Translations$offerNotifications$invalidBlik$pl extends Translations$offerNotifications$invalidBlik$en {
	_Translations$offerNotifications$invalidBlik$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'BLIK oznaczony jako nieprawidłowy';
	@override String get body => 'Maker oznaczył Twój kod BLIK jako nieprawidłowy.';
}

// Path: offerNotifications.takerPaid
class _Translations$offerNotifications$takerPaid$pl extends Translations$offerNotifications$takerPaid$en {
	_Translations$offerNotifications$takerPaid$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Płatność otrzymana';
	@override String get body => 'Twoja płatność Lightning została wysłana.';
}

// Path: offers.details.categories
class _Translations$offers$details$categories$pl extends Translations$offers$details$categories$en {
	_Translations$offers$details$categories$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Sklep, kawiarnia lub restauracja';
	@override String get atmCashout => 'Wypłata gotówki z bankomatu';
	@override String get onlineService => 'Produkt lub usługa online';
}

// Path: offers.details.consents
class _Translations$offers$details$consents$pl extends Translations$offers$details$consents$en {
	_Translations$offers$details$consents$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Niektóre bankomaty doliczają dodatkową opłatę ponad kwotę oferty. Biorąc tę ofertę, akceptujesz wszelkie dodatkowe koszty bankowe wymagane przez bankomat.';
	@override String get ecommerce => 'Z różnych powodów — takich jak brak towaru, korekta nadpłaty lub inne problemy po stronie sprzedawcy — internetowy sprzedawca może automatycznie odesłać pieniądze na konto bankowe powiązane z wygenerowanym przez Ciebie kodem BLIK. Te środki trafiają na Twoje konto i nie należą do Ciebie. Jeśli tak się stanie, skontaktuj się w dobrej wierze z koordynatorem i umów się na zwrot środków makerowi. Biorąc tę ofertę, akceptujesz te warunki i uroczyście przysięgasz postępować uczciwie w takich sytuacjach.';
}

// Path: maker.amountForm.progress
class _Translations$maker$amountForm$progress$pl extends Translations$maker$amountForm$progress$en {
	_Translations$maker$amountForm$progress$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Utwórz Ofertę';
	@override String get step2 => '2. Czekaj na zabranie';
	@override String get step3 => '3. Użyj BLIK';
}

// Path: maker.amountForm.labels
class _Translations$maker$amountForm$labels$pl extends Translations$maker$amountForm$labels$en {
	_Translations$maker$amountForm$labels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get coordinator => 'Koordynator';
	@override String get category => 'Kategoria';
	@override String get exchangeRate => 'Kurs wymiany';
	@override String get fee => 'Opłata';
	@override String get satoshisToPay => 'Do zapłaty';
	@override String get enterAmount => 'Wprowadź kwotę';
	@override String get tapToSelect => 'Kliknij, aby wybrać';
	@override String get premium => 'Premia';
}

// Path: maker.amountForm.actions
class _Translations$maker$amountForm$actions$pl extends Translations$maker$amountForm$actions$en {
	_Translations$maker$amountForm$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get generateInvoice => 'Wygeneruj Fakturę';
}

// Path: maker.amountForm.tooltips
class _Translations$maker$amountForm$tooltips$pl extends Translations$maker$amountForm$tooltips$en {
	_Translations$maker$amountForm$tooltips$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String feeInfo({required Object feePercent}) => 'Koordynator pobiera od twórcy opłatę w wysokości ${feePercent}%. Ta opłata jest odejmowana od Twojej płatności Lightning.';
	@override String get payInfo => 'Ta kalkulacja jest oparta na kursach wymiany pobranych po stronie klienta. Koordynator obliczy dokładną kwotę, a kwota faktury będzie ostateczną i dokładną kwotą do zapłaty.';
	@override String get premiumInfo => 'Opcjonalna premia pozwala sprzedać saty powyżej ceny rynkowej. Premia zmniejsza liczbę satów zablokowanych w fakturze hold dla tej samej kwoty fiat, więc kupujący płaci powyżej rynku, a Ty zatrzymujesz różnicę. Domyślnie wyłączona (0%). Maksymalną premię ustala wybrany koordynator.';
}

// Path: maker.amountForm.category
class _Translations$maker$amountForm$category$pl extends Translations$maker$amountForm$category$en {
	_Translations$maker$amountForm$category$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get label => 'Kategoria oferty';
	@override late final _Translations$maker$amountForm$category$options$pl options = _Translations$maker$amountForm$category$options$pl._(_root);
	@override late final _Translations$maker$amountForm$category$shortLabels$pl shortLabels = _Translations$maker$amountForm$category$shortLabels$pl._(_root);
	@override String get atmHint => 'Kupujący zobaczą, że oferta dotyczy wypłaty z bankomatu i mogą ją pominąć, jeśli ich bank dolicza dodatkowe opłaty.';
	@override String get physicalShopHint => 'Idealne miejsce do użycia Bitblik to kasa samoobsługowa — ponieważ oczekiwanie na takera, który musi zarezerwować ofertę, wygenerować i potwierdzić kod BLIK, może zająć kilka minut. Sprawdza się świetnie w sklepach, kawiarniach i restauracjach. Jeśli czujesz się na tyle odważny, żeby kazać zwykłemu kasjerowi (i osobom stojącym za Tobą w kolejce) czekać te kilka minut — chwała Ci za to.';
	@override String get ecommerceWarningTitle => 'Ryzyko zwrotu od sprzedawcy online';
	@override String get ecommerceWarningBody => 'Z różnych powodów — takich jak brak towaru, korekta nadpłaty lub inne problemy po stronie sprzedawcy — internetowy sprzedawca może automatycznie wystawić zwrot na konto bankowe powiązane z kodem BLIK, czyli konto takera. Koordynator nie może wymusić, aby taker zwrócił te środki Tobie.';
	@override String get ecommerceConfirmation => 'Rozumiem ryzyko zwrotu i dodam do zamówienia informację, aby sprzedawca w razie zwrotu przelał środki na inne konto.';
	@override String get whyThisIsNeeded => 'dlaczego to jest potrzebne?';
}

// Path: maker.amountForm.onboarding
class _Translations$maker$amountForm$onboarding$pl extends Translations$maker$amountForm$onboarding$en {
	_Translations$maker$amountForm$onboarding$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get titlePrefix => 'Nowość';
	@override String get title => 'Wybierz kategorię oferty';
	@override String get body => 'Przed wygenerowaniem faktury wybierz kategorię, która najlepiej opisuje to, za co płacisz.';
	@override String get showWhy => 'Dlaczego to jest ważne?';
	@override String get hideWhy => 'Ukryj szczegóły';
	@override String get whyTitle => 'Dobra kategoria pomaga takerom bezpiecznie podjąć decyzję';
	@override String get whyBody => 'Różne sytuacje oznaczają różne oczekiwania i ryzyka. Wypłaty z bankomatu mogą mieć dodatkowe opłaty bankowe, a zakupy online mogą wiązać się z problemami przy zwrotach. Oznaczenie właściwej kategorii daje takerowi potrzebny kontekst przed akceptacją oferty.';
	@override String get cta => 'Rozumiem';
}

// Path: maker.amountForm.errors
class _Translations$maker$amountForm$errors$pl extends Translations$maker$amountForm$errors$en {
	_Translations$maker$amountForm$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String initiating({required Object details}) => 'Błąd inicjowania oferty: ${details}';
	@override String get publicKeyNotLoaded => 'Błąd: Klucz publiczny nie został jeszcze załadowany.';
	@override String get noCoordinatorMatchesAmount => 'Żaden koordynator nie obsługuje tej kwoty. Spróbuj inną wartość.';
	@override String get categoryRequired => 'Wybierz kategorię oferty.';
	@override String get ecommerceConfirmationRequired => 'Potwierdź ryzyko zwrotu od sprzedawcy online przed kontynuacją.';
}

// Path: maker.payInvoice.actions
class _Translations$maker$payInvoice$actions$pl extends Translations$maker$payInvoice$actions$en {
	_Translations$maker$payInvoice$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get copy => 'Kopiuj Fakturę';
	@override String get payInWallet => 'Otwórz w portfelu zewnętrznym';
	@override String get connectWallet => 'Połącz portfel';
	@override String get payWithNwc => 'Zapłać';
	@override String get paying => 'Płacenie...';
}

// Path: maker.payInvoice.feedback
class _Translations$maker$payInvoice$feedback$pl extends Translations$maker$payInvoice$feedback$en {
	_Translations$maker$payInvoice$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Faktura skopiowana do schowka!';
	@override String get waitingConfirmation => 'Oczekiwanie na potwierdzenie płatności...';
	@override String get nwcConnected => 'Portfel NWC połączony!';
	@override String get nwcPaymentSuccess => 'Płatność udana!';
}

// Path: maker.payInvoice.errors
class _Translations$maker$payInvoice$errors$pl extends Translations$maker$payInvoice$errors$en {
	_Translations$maker$payInvoice$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get couldNotOpenApp => 'Nie można otworzyć aplikacji Lightning dla faktury.';
	@override String openingApp({required Object details}) => 'Błąd otwierania aplikacji Lightning: ${details}';
	@override String get publicKeyNotAvailable => 'Klucz publiczny nie jest dostępny.';
	@override String get couldNotFetchActive => 'Nie udało się pobrać szczegółów aktywnej oferty. Mogła wygasnąć.';
	@override String nwcPaymentFailed({required Object details}) => 'Płatność nie powiodła się: ${details}';
	@override String get nwcNotConnected => 'Portfel NWC nie jest połączony';
	@override String insufficientBalance({required Object required, required Object available}) => 'Niewystarczające środki. Potrzeba ${required} sats, dostępne ${available} sats';
	@override String get cancelOfferAlreadyFunded => 'Koordynator zgłasza, że ta oferta jest już opłacona. Nie można jej teraz anulować.';
	@override String cancelFailed({required Object details}) => 'Nie można anulować oferty: ${details}';
}

// Path: maker.confirmPayment.actions
class _Translations$maker$confirmPayment$actions$pl extends Translations$maker$confirmPayment$actions$en {
	_Translations$maker$confirmPayment$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Potwierdź udaną płatność';
	@override String get markInvalid => 'Nieprawidłowy kod BLIK';
	@override String get copyBlik => 'Kopiuj BLIK';
}

// Path: maker.confirmPayment.confirmDialog
class _Translations$maker$confirmPayment$confirmDialog$pl extends Translations$maker$confirmPayment$confirmDialog$en {
	_Translations$maker$confirmPayment$confirmDialog$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Potwierdzić płatność?';
	@override String get content => 'Ta akcja jest nieodwracalna. Po potwierdzeniu:\n\n• Kupujący otrzyma środki natychmiast\n• Koordynator nie będzie mógł zakwestionować środków\n• Nie możesz cofnąć tej akcji\n\nPotwierdź tylko wtedy, gdy płatność BLIK zakończyła się sukcesem.';
	@override String get cancel => 'Anuluj';
	@override String get confirmButton => 'Tak, potwierdź płatność';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _Translations$maker$confirmPayment$invalidBlikDisputeDialog$pl extends Translations$maker$confirmPayment$invalidBlikDisputeDialog$en {
	_Translations$maker$confirmPayment$invalidBlikDisputeDialog$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Otworzyć spór?';
	@override String get content => 'Kupujący zgłosił, że płatność BLIK została pobrana z jego konta.\n\nOznaczenie tego jako nieprawidłowe natychmiast otworzy SPÓR wymagający interwencji koordynatora.\n\n• Opłata za spór może zostać naliczona, jeśli zostanie rozstrzygnięty na Twoją niekorzyść\n• Faktura hold zostanie rozliczona natychmiast\n• Wymagana będzie ręczna weryfikacja\n\nKontynuuj tylko wtedy, gdy masz pewność, że płatność BLIK NIE powiodła się.';
	@override String get cancel => 'Anuluj';
	@override String get confirmButton => 'Tak, otwórz spór';
}

// Path: maker.confirmPayment.feedback
class _Translations$maker$confirmPayment$feedback$pl extends Translations$maker$confirmPayment$feedback$en {
	_Translations$maker$confirmPayment$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Maker potwierdził płatność.';
	@override String get confirmedTakerPaid => 'Płatność potwierdzona! Taker otrzyma środki.';
	@override String progressLabel({required Object seconds}) => 'Potwierdzanie: ${seconds} s pozostało';
}

// Path: maker.confirmPayment.errors
class _Translations$maker$confirmPayment$errors$pl extends Translations$maker$confirmPayment$errors$en {
	_Translations$maker$confirmPayment$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get failedToRetrieve => 'Błąd: Nie udało się pobrać kodu BLIK.';
	@override String retrieving({required Object details}) => 'Błąd pobierania kodu BLIK: ${details}';
	@override String get missingHashOrKey => 'Błąd: Brakujący hash płatności lub klucz publiczny.';
	@override String incorrectState({required Object status}) => 'Oferta nie jest w prawidłowym stanie do potwierdzenia (Status: ${status})';
	@override String confirming({required Object details}) => 'Błąd potwierdzania płatności: ${details}';
	@override String get invalidState => 'Błąd: Otrzymano nieprawidłowy stan oferty.';
	@override String get internalIncomplete => 'Błąd wewnętrzny: Niekompletne szczegóły oferty.';
	@override String notAwaitingConfirmation({required Object status}) => 'Oferta nie oczekuje już na potwierdzenie (Status: ${status}).';
	@override String get unexpectedStatus => 'Otrzymano nieoczekiwany status oferty z serwera.';
}

// Path: maker.conflict.actions
class _Translations$maker$conflict$actions$pl extends Translations$maker$conflict$actions$en {
	_Translations$maker$conflict$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get back => 'Powrót do strony głównej';
	@override String get confirmPayment => 'Mój błąd, potwierdź sukces płatności BLIK';
	@override String get openDispute => 'Płatność BLIK NIE powiodła się, OTWÓRZ SPÓR';
	@override String get submitDispute => 'Zgłoś Spór';
}

// Path: maker.conflict.disputeDialog
class _Translations$maker$conflict$disputeDialog$pl extends Translations$maker$conflict$disputeDialog$en {
	_Translations$maker$conflict$disputeDialog$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Otworzyć spór?';
	@override String get content => 'Otwarcie sporu wymaga ręcznej weryfikacji przez koordynatora, co zajmie czas. Opłata za spór zostanie potrącona, jeśli spór zostanie rozstrzygnięty na Twoją niekorzyść. Faktura hold zostanie rozliczona, aby zapobiec jej wygaśnięciu. Jeśli spór zostanie rozstrzygnięty na Twoją korzyść, otrzymasz zwrot środków (pomniejszony o opłaty) do portfela według własnego wyboru.';
	@override String get contentDetailed => 'Otwarcie sporu będzie wymagało ręcznej interwencji koordynatora, co zajmuje czas i wiąże się z opłatą za spór.\n\nFaktura hold zostanie natychmiast rozliczona, aby zapobiec jej wygaśnięciu przed rozstrzygnięciem sporu.\n\nJeśli spór zostanie rozstrzygnięty na Twoją korzyść, kwota satoshi zostanie zwrócona do portfela według własnego wyboru (pomniejszona o opłaty). Upewnij się, że masz portfel gotowy do odbioru.';
	@override late final _Translations$maker$conflict$disputeDialog$actions$pl actions = _Translations$maker$conflict$disputeDialog$actions$pl._(_root);
}

// Path: maker.conflict.feedback
class _Translations$maker$conflict$feedback$pl extends Translations$maker$conflict$feedback$en {
	_Translations$maker$conflict$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get disputeOpenedSuccess => 'Spór pomyślnie otwarty. Koordynator rozpatrzy sprawę.';
}

// Path: maker.conflict.errors
class _Translations$maker$conflict$errors$pl extends Translations$maker$conflict$errors$en {
	_Translations$maker$conflict$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String openingDispute({required Object error}) => 'Błąd otwierania sporu: ${error}';
}

// Path: maker.conflict.nostrContact
class _Translations$maker$conflict$nostrContact$pl extends Translations$maker$conflict$nostrContact$en {
	_Translations$maker$conflict$nostrContact$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Skontaktuj się z Koordynatorem na Nostr';
	@override String get description => 'Możesz wysłać DM do koordynatora bezpośrednio, aby uzyskać pomoc w tym sporze.';
	@override String get copyNpub => 'Kopiuj npub';
	@override String get openProfile => 'Zobacz Profil';
	@override String get npubCopied => 'Npub koordynatora skopiowany do schowka!';
	@override String get yourIdentityDescription => 'Aby wysyłać DM, zaloguj się swoim kluczem prywatnym Neko (nsec) w dowolnym kliencie Nostr obsługującym wiadomości bezpośrednie.';
	@override String get manageNekoKeys => 'Zarządzaj Kluczami Neko';
}

// Path: taker.submitBlik.actions
class _Translations$taker$submitBlik$actions$pl extends Translations$taker$submitBlik$actions$en {
	_Translations$taker$submitBlik$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get submit => 'Wyślij BLIK';
}

// Path: taker.submitBlik.feedback
class _Translations$taker$submitBlik$feedback$pl extends Translations$taker$submitBlik$feedback$en {
	_Translations$taker$submitBlik$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get pasted => 'Wklejono kod BLIK.';
}

// Path: taker.submitBlik.validation
class _Translations$taker$submitBlik$validation$pl extends Translations$taker$submitBlik$validation$en {
	_Translations$taker$submitBlik$validation$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get invalidFormat => 'Wprowadź prawidłowy 6-cyfrowy kod BLIK.';
}

// Path: taker.submitBlik.errors
class _Translations$taker$submitBlik$errors$pl extends Translations$taker$submitBlik$errors$en {
	_Translations$taker$submitBlik$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String submitting({required Object details}) => 'Błąd wysyłania kodu BLIK: ${details}';
	@override String get clipboardInvalid => 'Schowek nie zawiera prawidłowego 6-cyfrowego kodu BLIK.';
	@override String get stateChanged => 'Błąd: Stan oferty uległ zmianie.';
	@override String get stateNotValid => 'Błąd: Stan oferty nie jest już ważny.';
	@override String fetchedIdMismatch({required Object fetchedId, required Object initialId}) => 'Pobrane ID aktywnej oferty (${fetchedId}) nie pasuje do początkowego ID oferty (${initialId}). Niezgodność stanu?';
	@override String get paymentHashMissing => 'Brak hasha płatności oferty po pobraniu.';
}

// Path: taker.submitBlik.details
class _Translations$taker$submitBlik$details$pl extends Translations$taker$submitBlik$details$en {
	_Translations$taker$submitBlik$details$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get requestedAmount => 'Żądana kwota BLIK';
	@override String get exchangeRate => 'Kurs wymiany';
	@override String get takerFee => 'Opłata Taker';
	@override String get status => 'Status';
	@override String get youllReceive => 'Otrzymasz';
}

// Path: taker.waitConfirmation.categoryReminder
class _Translations$taker$waitConfirmation$categoryReminder$pl extends Translations$taker$waitConfirmation$categoryReminder$en {
	_Translations$taker$waitConfirmation$categoryReminder$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Przypomnienie dla oferty ATM: Twój bank może nadal poprosić o zatwierdzenie dodatkowej opłaty bankomatowej ponad główną kwotę.';
	@override String get ecommerce => 'Przypomnienie dla zamówienia online: jeśli sprzedawca wyśle automatyczny zwrot na Twoje konto, skontaktuj się z koordynatorem i oddaj środki.';
}

// Path: taker.waitConfirmation.takerCharged
class _Translations$taker$waitConfirmation$takerCharged$pl extends Translations$taker$waitConfirmation$takerCharged$en {
	_Translations$taker$waitConfirmation$takerCharged$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oznaczyłeś BLIK jako opłacony';
	@override String get message => 'Twórca oferty musi potwierdzić płatność lub ją zakwestionować. Jeśli nic nie zrobi, płatność zostanie automatycznie potwierdzona, a Ty otrzymasz bitcoiny.';
}

// Path: taker.waitConfirmation.expiredActions
class _Translations$taker$waitConfirmation$expiredActions$pl extends Translations$taker$waitConfirmation$expiredActions$en {
	_Translations$taker$waitConfirmation$expiredActions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get reportConflict => 'BLIK został pobrany z mojego konta';
	@override String get renewReservation => 'Spróbuj ponownie z nowym kodem BLIK';
	@override String get cancelReservation => 'Anuluj rezerwację';
}

// Path: taker.waitConfirmation.feedback
class _Translations$taker$waitConfirmation$feedback$pl extends Translations$taker$waitConfirmation$feedback$en {
	_Translations$taker$waitConfirmation$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmed => 'Maker potwierdził płatność.';
	@override String get paymentSuccessful => 'Płatność udana! Wkrótce otrzymasz środki.';
	@override String get conflictReported => 'Konflikt zgłoszony. Koordynator rozpatrzy sytuację.';
}

// Path: taker.waitConfirmation.errors
class _Translations$taker$waitConfirmation$errors$pl extends Translations$taker$waitConfirmation$errors$en {
	_Translations$taker$waitConfirmation$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get invalidOfferStateReceived => 'Otrzymano ofertę o nieprawidłowym stanie dla tego ekranu. Resetowanie.';
	@override String reportingConflict({required Object details}) => 'Błąd zgłaszania konfliktu: ${details}';
}

// Path: taker.paymentProcess.states
class _Translations$taker$paymentProcess$states$pl extends Translations$taker$paymentProcess$states$en {
	_Translations$taker$paymentProcess$states$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get preparing => 'Przygotowywanie do wysłania płatności...';
	@override String get sending => 'Wysyłanie płatności...';
	@override String get received => 'Płatność otrzymana!';
	@override String get failed => 'Płatność nie powiodła się';
	@override String get waitingUpdate => 'Oczekiwanie na aktualizację oferty...';
}

// Path: taker.paymentProcess.steps
class _Translations$taker$paymentProcess$steps$pl extends Translations$taker$paymentProcess$steps$en {
	_Translations$taker$paymentProcess$steps$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmedBlik => 'Maker potwierdził płatność BLIK';
	@override String get makerInvoiceSettled => 'Faktura hold Makera rozliczona';
	@override String get takerInvoicePaid => 'Opłacanie Twojej faktury Lightning';
	@override String get takerPaymentFailed => 'Płatność na Twoją fakturę nie powiodła się';
}

// Path: taker.paymentProcess.errors
class _Translations$taker$paymentProcess$errors$pl extends Translations$taker$paymentProcess$errors$en {
	_Translations$taker$paymentProcess$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String sending({required Object details}) => 'Błąd wysyłania płatności: ${details}';
	@override String get notConfirmed => 'Oferta niepotwierdzona przez Makera.';
	@override String get expired => 'Oferta wygasła.';
	@override String get cancelled => 'Oferta anulowana.';
	@override String get paymentFailed => 'Płatność oferty nie powiodła się.';
	@override String get unknown => 'Nieznany błąd oferty.';
	@override String get takerPaymentFailed => 'Płatność na Twoją fakturę Lightning nie powiodła się.';
	@override String get noPublicKey => 'Błąd: Nie można pobrać Twojego klucza publicznego.';
	@override String get loadingPublicKey => 'Błąd ładowania Twoich danych';
	@override String get missingPaymentHash => 'Błąd: Brakujące szczegóły płatności.';
}

// Path: taker.paymentProcess.loading
class _Translations$taker$paymentProcess$loading$pl extends Translations$taker$paymentProcess$loading$en {
	_Translations$taker$paymentProcess$loading$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get publicKey => 'Ładowanie Twoich danych...';
}

// Path: taker.paymentProcess.actions
class _Translations$taker$paymentProcess$actions$pl extends Translations$taker$paymentProcess$actions$en {
	_Translations$taker$paymentProcess$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get goToFailureDetails => 'Wprowadź nową fakturę Lightning';
}

// Path: taker.paymentFailed.form
class _Translations$taker$paymentFailed$form$pl extends Translations$taker$paymentFailed$form$en {
	_Translations$taker$paymentFailed$form$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get newInvoiceLabel => 'Nowa faktura Lightning';
	@override String get newInvoiceHint => 'Wprowadź swoją fakturę BOLT11';
}

// Path: taker.paymentFailed.actions
class _Translations$taker$paymentFailed$actions$pl extends Translations$taker$paymentFailed$actions$en {
	_Translations$taker$paymentFailed$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get retryPayment => 'Wyślij nową fakturę';
}

// Path: taker.paymentFailed.errors
class _Translations$taker$paymentFailed$errors$pl extends Translations$taker$paymentFailed$errors$en {
	_Translations$taker$paymentFailed$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get enterValidInvoice => 'Proszę wprowadzić prawidłową fakturę';
	@override String updatingInvoice({required Object details}) => 'Błąd aktualizacji faktury: ${details}';
	@override String get paymentRetryFailed => 'Ponowna próba płatności nie powiodła się. Sprawdź fakturę lub spróbuj ponownie później.';
	@override String get takerPublicKeyNotFound => 'Nie znaleziono klucza publicznego Kupującego.';
	@override String generateFailed({required Object details}) => 'Nie udało się wygenerować faktury: ${details}';
}

// Path: taker.paymentFailed.walletSection
class _Translations$taker$paymentFailed$walletSection$pl extends Translations$taker$paymentFailed$walletSection$en {
	_Translations$taker$paymentFailed$walletSection$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Generuj fakturę z portfela';
	@override String get defaultLabel => 'domyślny';
	@override String tapToGenerate({required Object amountSats}) => 'Dotknij, aby wygenerować fakturę na ${amountSats}';
}

// Path: taker.paymentFailed.loading
class _Translations$taker$paymentFailed$loading$pl extends Translations$taker$paymentFailed$loading$en {
	_Translations$taker$paymentFailed$loading$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get processingPayment => 'Przetwarzanie ponownej płatności...';
}

// Path: taker.paymentFailed.success
class _Translations$taker$paymentFailed$success$pl extends Translations$taker$paymentFailed$success$en {
	_Translations$taker$paymentFailed$success$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Płatność udana';
	@override String get message => 'Twoja płatność została przetworzona pomyślnie.';
}

// Path: taker.paymentSuccess.actions
class _Translations$taker$paymentSuccess$actions$pl extends Translations$taker$paymentSuccess$actions$en {
	_Translations$taker$paymentSuccess$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get goHome => 'Przejdź do strony głównej';
}

// Path: taker.invalidBlik.actions
class _Translations$taker$invalidBlik$actions$pl extends Translations$taker$invalidBlik$actions$en {
	_Translations$taker$invalidBlik$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get retry => 'Wyślij nowy kod BLIK';
	@override String get cancelReservation => 'Anuluj Transakcję';
	@override String get reportConflict => 'Rozpocząć Spór';
	@override String get returnHome => 'Wróć do strony głównej';
}

// Path: taker.invalidBlik.feedback
class _Translations$taker$invalidBlik$feedback$pl extends Translations$taker$invalidBlik$feedback$en {
	_Translations$taker$invalidBlik$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get conflictReportedSuccess => 'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.';
}

// Path: taker.invalidBlik.errors
class _Translations$taker$invalidBlik$errors$pl extends Translations$taker$invalidBlik$errors$en {
	_Translations$taker$invalidBlik$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get reservationFailed => 'Nie udało się ponownie zarezerwować oferty';
	@override String conflictReport({required Object details}) => 'Błąd zgłaszania konfliktu: ${details}';
}

// Path: taker.conflict.actions
class _Translations$taker$conflict$actions$pl extends Translations$taker$conflict$actions$en {
	_Translations$taker$conflict$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get back => 'Powrót do strony głównej';
}

// Path: taker.conflict.feedback
class _Translations$taker$conflict$feedback$pl extends Translations$taker$conflict$feedback$en {
	_Translations$taker$conflict$feedback$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get reported => 'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.';
}

// Path: taker.conflict.errors
class _Translations$taker$conflict$errors$pl extends Translations$taker$conflict$errors$en {
	_Translations$taker$conflict$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String reporting({required Object details}) => 'Błąd zgłaszania konfliktu: ${details}';
}

// Path: taker.conflict.nostrContact
class _Translations$taker$conflict$nostrContact$pl extends Translations$taker$conflict$nostrContact$en {
	_Translations$taker$conflict$nostrContact$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Skontaktuj się z Koordynatorem na Nostr';
	@override String get description => 'Możesz wysłać DM do koordynatora bezpośrednio, aby uzyskać pomoc w tym sporze.';
	@override String get copyNpub => 'Kopiuj npub';
	@override String get openProfile => 'Zobacz Profil';
	@override String get npubCopied => 'Npub koordynatora skopiowany do schowka!';
	@override String get yourIdentityDescription => 'Aby wysyłać DM, zaloguj się swoim kluczem prywatnym Neko (nsec) w dowolnym kliencie Nostr obsługującym wiadomości bezpośrednie.';
	@override String get manageNekoKeys => 'Zarządzaj Kluczami Neko';
}

// Path: home.statistics.errors
class _Translations$home$statistics$errors$pl extends Translations$home$statistics$errors$en {
	_Translations$home$statistics$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String loading({required Object error}) => 'Błąd ładowania statystyk: ${error}';
}

// Path: settings.offerCreation.categoryOptions
class _Translations$settings$offerCreation$categoryOptions$pl extends Translations$settings$offerCreation$categoryOptions$en {
	_Translations$settings$offerCreation$categoryOptions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Sklep, kawiarnia lub restauracja';
	@override String get atm => 'Wypłata z bankomatu';
	@override String get online => 'Usługa/produkt online';
}

// Path: settings.offerCreation.dialogs
class _Translations$settings$offerCreation$dialogs$pl extends Translations$settings$offerCreation$dialogs$en {
	_Translations$settings$offerCreation$dialogs$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get selectCategory => 'Wybierz domyślną kategorię';
	@override String get selectCoordinator => 'Wybierz preferowanego koordynatora';
	@override String get premiumHint => 'Wpisz wartość procentową, np. 1.5. Wartości są zaokrąglane do kroków co 0.5%.';
	@override String get premiumHelper => 'Stosowane po włączeniu premii cenowej i ograniczane do maksimum wybranego koordynatora.';
}

// Path: settings.display.unitOptions
class _Translations$settings$display$unitOptions$pl extends Translations$settings$display$unitOptions$en {
	_Translations$settings$display$unitOptions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get sats => 'saty';
	@override String get bitcoin => '₿ (BIP-177)';
}

// Path: maker.amountForm.category.options
class _Translations$maker$amountForm$category$options$pl extends Translations$maker$amountForm$category$options$en {
	_Translations$maker$amountForm$category$options$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Sklep, kawiarnia lub restauracja';
	@override String get atmCashout => 'Wypłata gotówki z bankomatu';
	@override String get onlineService => 'Produkt lub usługa online';
}

// Path: maker.amountForm.category.shortLabels
class _Translations$maker$amountForm$category$shortLabels$pl extends Translations$maker$amountForm$category$shortLabels$en {
	_Translations$maker$amountForm$category$shortLabels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Sklep';
	@override String get atm => 'Bankomat';
	@override String get online => 'Online';
}

// Path: maker.conflict.disputeDialog.actions
class _Translations$maker$conflict$disputeDialog$actions$pl extends Translations$maker$conflict$disputeDialog$actions$en {
	_Translations$maker$conflict$disputeDialog$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Otwórz Spór';
	@override String get cancel => 'Anuluj';
}

/// The flat map containing all translations for locale <pl>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPl {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'BitBlik',
			'app.greeting' => 'Cześć!',
			'app.changelog' => 'Historia zmian',
			'common.buttons.cancel' => 'Anuluj',
			'common.buttons.save' => 'Zapisz',
			'common.buttons.done' => 'Gotowe',
			'common.buttons.retry' => 'Spróbuj ponownie',
			'common.buttons.goHome' => 'Wróć do strony głównej',
			'common.buttons.saveAndContinue' => 'Zapisz i kontynuuj',
			'common.buttons.reveal' => 'Pokaż',
			'common.buttons.hide' => 'Ukryj',
			'common.buttons.copy' => 'Kopiuj',
			'common.buttons.close' => 'Zamknij',
			'common.buttons.restore' => 'Przywróć',
			'common.buttons.faq' => 'FAQ',
			'common.labels.amount' => 'Kwota (PLN)',
			'common.labels.status' => ({required Object status}) => 'Status: ${status}',
			'common.labels.role' => ({required Object role}) => 'Rola: ${role}',
			'common.notifications.success' => 'Sukces',
			'common.notifications.error' => 'Błąd',
			'common.notifications.loading' => 'Ładowanie...',
			'common.clipboard.copyToClipboard' => 'Kopiuj do schowka',
			'common.clipboard.pasteFromClipboard' => 'Wklej ze schowka',
			'common.clipboard.copied' => 'Skopiowano do schowka!',
			'common.actions.cancelAndReturnToOffers' => 'Anuluj i wróć do ofert',
			'common.actions.cancelAndReturnHome' => 'Anuluj i wróć do strony głównej',
			'lightningAddress.labels.address' => 'Adres Lightning (LNURL)',
			'lightningAddress.labels.hint' => 'uzytkownik@domena.com',
			'lightningAddress.labels.short' => ({required Object address}) => 'Adres Lightning: ${address}',
			'lightningAddress.labels.receivingAddress' => 'Twój adres odbiorczy:',
			'lightningAddress.prompts.enter' => 'Wprowadź swój adres Lightning, aby kontynuować',
			'lightningAddress.prompts.edit' => 'Edytuj',
			'lightningAddress.prompts.invalid' => 'Wprowadź prawidłowy adres Lightning',
			'lightningAddress.prompts.required' => 'Adres Lightning jest wymagany.',
			'lightningAddress.prompts.enterToTakeOffer' => 'Musisz ustawić adres Lightning, aby przyjąć ofertę.',
			'lightningAddress.prompts.missing' => 'Brak adresu Lightning. Dodaj go, aby móc przyjmować oferty.',
			'lightningAddress.prompts.add' => 'Dodaj',
			'lightningAddress.prompts.delete' => 'Usuń',
			'lightningAddress.prompts.confirmDelete' => 'Czy na pewno chcesz usunąć swój adres Lightning?',
			'lightningAddress.prompts.howToGet' => 'Nie masz jeszcze adresu Lightning? Dowiedz się, jak go zdobyć!',
			'lightningAddress.prompts.learnMore' => 'Dowiedz się więcej o adresach Lightning',
			'lightningAddress.feedback.saved' => 'Adres Lightning zapisany!',
			'lightningAddress.feedback.updated' => 'Adres Lightning zaktualizowany!',
			'lightningAddress.feedback.valid' => 'Prawidłowy adres Lightning',
			'lightningAddress.errors.saving' => ({required Object details}) => 'Błąd podczas zapisywania adresu: ${details}',
			'lightningAddress.errors.loading' => ({required Object details}) => 'Błąd podczas ładowania adresu Lightning: ${details}',
			'offers.details.yourOffer' => 'Twoja oferta:',
			'offers.details.selectedOffer' => 'Oferta:',
			'offers.details.activeOffer' => 'Masz aktywną ofertę:',
			'offers.details.finishedOffers' => 'Zakończone oferty',
			'offers.details.noAvailable' => 'Brak dostępnych ofert.',
			'offers.details.noAvailableTip' => 'Wskazówka: udostępnij Bitblik w swojej społeczności i wśród znajomych, aby zwiększyć liczbę zamówień w Bitblik.',
			'offers.details.noSuccessfulTrades' => 'Brak udanych transakcji.',
			'offers.details.loadingDetails' => 'Ładowanie szczegółów oferty...',
			'offers.details.amount' => ({required Object amount}) => 'Kwota: ${amount} satoshi',
			'offers.details.amountWithCurrency' => ({required Object amount, required Object currency}) => '${amount} ${currency}',
			'offers.details.makerFee' => ({required Object fee}) => 'Opłata: ${fee} sats',
			'offers.details.takerFee' => ({required Object fee}) => 'Opłata: ${fee} sats',
			'offers.details.subtitle' => ({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}',
			'offers.details.subtitleWithDate' => ({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (opłata) satoshi\nStatus: ${status}\nZapłacono: ${date}',
			'offers.details.activeSubtitle' => ({required Object status, required Object amount}) => 'Status: ${status}\nKwota: ${amount} satoshi',
			'offers.details.id' => ({required Object id}) => 'ID Oferty: ${id}...',
			'offers.details.created' => ({required Object dateTime}) => 'Utworzono: ${dateTime}',
			'offers.details.takenAfter' => ({required Object duration}) => 'Przyjęto po: ${duration}',
			'offers.details.paidAfter' => ({required Object duration}) => 'Zapłacono po: ${duration}',
			'offers.details.exchangeRate' => 'Kurs wymiany',
			'offers.details.takerFeeLabel' => 'Opłata',
			'offers.details.amountLabel' => 'Kwota',
			'offers.details.feeLabel' => 'Opłata',
			'offers.details.statusLabel' => 'Status',
			'offers.details.youllReceive' => 'Otrzymasz',
			'offers.details.coordinator' => 'Koordynator',
			'offers.details.categoryLabel' => 'Kategoria',
			'offers.details.categories.physicalShop' => 'Sklep, kawiarnia lub restauracja',
			'offers.details.categories.atmCashout' => 'Wypłata gotówki z bankomatu',
			'offers.details.categories.onlineService' => 'Produkt lub usługa online',
			'offers.details.consents.atm' => 'Niektóre bankomaty doliczają dodatkową opłatę ponad kwotę oferty. Biorąc tę ofertę, akceptujesz wszelkie dodatkowe koszty bankowe wymagane przez bankomat.',
			'offers.details.consents.ecommerce' => 'Z różnych powodów — takich jak brak towaru, korekta nadpłaty lub inne problemy po stronie sprzedawcy — internetowy sprzedawca może automatycznie odesłać pieniądze na konto bankowe powiązane z wygenerowanym przez Ciebie kodem BLIK. Te środki trafiają na Twoje konto i nie należą do Ciebie. Jeśli tak się stanie, skontaktuj się w dobrej wierze z koordynatorem i umów się na zwrot środków makerowi. Biorąc tę ofertę, akceptujesz te warunki i uroczyście przysięgasz postępować uczciwie w takich sytuacjach.',
			'offers.labels.premium' => 'Premia',
			'offers.labels.premiumBadge' => ({required Object percent}) => '+${percent}% premii',
			'offers.tooltips.takerFeeInfo' => ({required Object feePercent}) => 'Koordynator pobiera ${feePercent}% opłaty dla kupującego. To obejmuje opłaty za routing Lightning i jest potrącane z kwoty, którą otrzymujesz.',
			'offers.tooltips.premiumInfoTaker' => 'Premia oznacza, że ta oferta jest wyceniona powyżej rynku. Dla tej samej kwoty fiat maker blokuje mniej satów w fakturze hold, więc płacisz powyżej rynku i otrzymujesz mniej satów niż po kursie rynkowym. Maksymalną premię ustala koordynator.',
			'offers.tooltips.ratesFetchedAt' => 'Pobrano o',
			'offers.tooltips.ratesSources' => 'Źródła średniego kursu',
			'offers.actions.take' => 'WEŹ',
			'offers.actions.takeOffer' => 'Weź ofertę',
			'offers.actions.resume' => 'Wprowadź BLIK',
			'offers.actions.cancel' => 'Anuluj ofertę',
			'offers.actions.view' => 'Zobacz',
			'offers.status.created' => 'Utworzona',
			'offers.status.funded' => 'Sfinansowana',
			'offers.status.expired' => 'Wygasła',
			'offers.status.cancelled' => 'Anulowana',
			'offers.status.reserved' => 'Zarezerwowana',
			'offers.status.blikReceived' => 'BLIK wysłany',
			'offers.status.blikSentToMaker' => 'Otrzymano BLIK',
			'offers.status.expiredBlik' => 'BLIK wygasł',
			'offers.status.expiredSentBlik' => 'BLIK wygasł',
			'offers.status.takerCharged' => 'Taker obciążony',
			'offers.status.invalidBlik' => 'Nieprawidłowy BLIK',
			'offers.status.conflict' => 'Konflikt',
			'offers.status.dispute' => 'Spór',
			'offers.status.makerConfirmed' => 'Potwierdzona',
			'offers.status.settled' => 'Rozliczona',
			'offers.status.payingTaker' => 'Płacenie Takera',
			'offers.status.takerPaymentFailed' => 'Płatność Takera nieudana',
			'offers.status.takerPaid' => 'Zapłacony',
			'offers.status.unknownStatus' => 'Nieznany',
			'offers.statusMessages.reserved' => 'Oferta zarezerwowana przez Takera!',
			'offers.statusMessages.cancelled' => 'Oferta anulowana pomyślnie.',
			'offers.statusMessages.cancelledOrExpired' => 'Oferta została anulowana lub wygasła.',
			'offers.statusMessages.noLongerAvailable' => ({required Object status}) => 'Oferta nie jest już dostępna (Status: ${status}).',
			'offers.progress.waitingForTaker' => ({required Object time}) => 'Oczekiwanie na takera: ${time}',
			'offers.progress.reserved' => ({required Object seconds}) => 'Zarezerwowano: ${seconds} s pozostało',
			'offers.progress.confirming' => ({required Object seconds}) => 'Potwierdzanie: ${seconds} s pozostało',
			'offers.errors.loading' => ({required Object details}) => 'Błąd ładowania ofert: ${details}',
			'offers.errors.loadingDetails' => ({required Object details}) => 'Błąd ładowania szczegółów oferty: ${details}',
			'offers.errors.detailsMissing' => 'Błąd: Brakujące lub nieprawidłowe szczegóły oferty.',
			'offers.errors.detailsNotLoaded' => 'Nie udało się załadować szczegółów oferty.',
			'offers.errors.notFound' => 'Błąd: Oferta nie znaleziona.',
			'offers.errors.unexpectedState' => 'Błąd: Oferta jest w nieoczekiwanym stanie.',
			'offers.errors.unexpectedStateWithStatus' => ({required Object status}) => 'Oferta jest w nieoczekiwanym stanie (${status}). Spróbuj ponownie lub skontaktuj się z pomocą.',
			'offers.errors.invalidStatus' => 'Oferta ma nieprawidłowy status.',
			'offers.errors.couldNotIdentify' => 'Błąd: Nie można zidentyfikować oferty do anulowania.',
			'offers.errors.cannotBeCancelled' => ({required Object status}) => 'Oferty nie można anulować w obecnym stanie (${status}).',
			'offers.errors.failedToCancel' => ({required Object details}) => 'Nie udało się anulować oferty: ${details}',
			'offers.errors.activeDetailsLost' => 'Błąd: Utracono szczegóły aktywnej oferty.',
			'offers.errors.checkingActive' => ({required Object details}) => 'Błąd sprawdzania aktywnych ofert: ${details}',
			'offers.errors.cannotResume' => ({required Object status}) => 'Nie można wznowić oferty w stanie: ${status}',
			'offers.errors.cannotResumeTaker' => ({required Object status}) => 'Nie można wznowić oferty takera w stanie: ${status}',
			'offers.errors.resuming' => ({required Object details}) => 'Błąd wznawiania oferty: ${details}',
			'offers.errors.makerPublicKeyNotFound' => 'Nie znaleziono klucza publicznego Makera',
			'offers.errors.takerPublicKeyNotFound' => 'Nie znaleziono klucza publicznego Takera.',
			'offers.errors.atmConsentRequired' => 'Zaakceptuj warunek dodatkowej opłaty ATM przed wzięciem tej oferty.',
			'offers.errors.ecommerceConsentRequired' => 'Zaakceptuj warunek zwrotu środków z ecommerce przed wzięciem tej oferty.',
			'offers.errors.cannotTakeOwnOffer' => 'Nie możesz wziąć własnej oferty.',
			'offers.success.title' => 'Oferta zakończona',
			'offers.success.headline' => 'Płatność potwierdzona!',
			'offers.success.subtitle' => 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.',
			'offers.success.detailsTitle' => 'Szczegóły oferty:',
			'offers.success.duration' => ({required Object time}) => 'Realizacja oferty zajęła ${time}.',
			'reservations.actions.cancel' => 'Anuluj rezerwację',
			'reservations.feedback.cancelled' => 'Rezerwacja anulowana.',
			'reservations.errors.cancelling' => ({required Object error}) => 'Nie udało się anulować rezerwacji: ${error}',
			'reservations.errors.failedToReserve' => ({required Object details}) => 'Nie udało się zarezerwować oferty: ${details}',
			'reservations.errors.failedNoTimestamp' => 'Nie udało się zarezerwować oferty (brak znacznika czasu).',
			'reservations.errors.timestampMissing' => 'Brak znacznika czasu rezerwacji oferty.',
			'reservations.errors.notReserved' => ({required Object status}) => 'Oferta nie jest już w stanie zarezerwowanym (${status}).',
			'exchange.labels.enterAmount' => 'Wprowadź kwotę (PLN) do zapłaty:',
			'exchange.labels.equivalent' => ({required Object sats}) => '≈ ${sats} satoshi',
			'exchange.labels.rate' => ({required Object rate}) => 'Kurs wymiany ≈ ${rate} PLN/BTC',
			'exchange.feedback.fetching' => 'Pobieranie kursu wymiany...',
			'exchange.errors.fetchingRate' => 'Nie udało się pobrać kursu wymiany.',
			'exchange.errors.invalidFormat' => 'Nieprawidłowy format liczby',
			'exchange.errors.mustBePositive' => 'Kwota musi być dodatnia',
			'exchange.errors.invalidFeePercentage' => 'Nieprawidłowy procent opłaty',
			'exchange.errors.tooLowFiat' => ({required Object minAmount, required Object currency}) => 'Kwota jest za niska. Minimum to ${minAmount} ${currency}.',
			'exchange.errors.tooHighFiat' => ({required Object maxAmount, required Object currency}) => 'Kwota jest za wysoka. Maksimum to ${maxAmount} ${currency}.',
			'coordinator.title' => 'Koordynatorzy',
			'coordinator.info.fee' => 'opłata',
			'coordinator.info.rangeDisplay' => ({required Object minAmount, required Object maxAmount, required Object currency}) => 'Kwota: ${minAmount}-${maxAmount} ${currency}',
			'coordinator.info.feeDisplay' => ({required Object fee}) => '${fee}% opłata',
			'coordinator.selector.loading' => 'Ładowanie koordynatorów...',
			'coordinator.selector.errorLoading' => 'Błąd ładowania koordynatorów',
			'coordinator.selector.choose' => 'Wybierz koordynatora',
			'coordinator.selector.viewNostrProfile' => 'Zobacz profil Nostr',
			'coordinator.selector.unresponsive' => 'Ten koordynator nie odpowiada',
			'coordinator.selector.waitingResponse' => 'Oczekiwanie na odpowiedź koordynatora',
			'coordinator.selector.termsAccept' => 'Akceptuję ',
			'coordinator.selector.termsOfUsage' => 'Warunki użytkowania',
			'coordinator.dialog.makerFee' => 'Opłata twórcy',
			'coordinator.dialog.takerFee' => 'Opłata odbiorcy',
			'coordinator.dialog.amountRange' => 'Zakres kwoty',
			'coordinator.dialog.reservationTime' => 'Czas rezerwacji',
			'coordinator.dialog.currencies' => 'Waluty',
			'coordinator.dialog.viewTerms' => 'Zobacz warunki',
			'coordinator.details.title' => 'Koordynator',
			'coordinator.details.relaysInUse' => 'Używane przekaźniki',
			'coordinator.details.relaysInUseHint' => 'Cała komunikacja z tym koordynatorem odbywa się przez te przekaźniki (z jego listy NIP-65).',
			'coordinator.details.noRelays' => 'Brak znanych przekaźników',
			'coordinator.details.makerFee' => 'Opłata makera',
			'coordinator.details.takerFee' => 'Opłata takera',
			'coordinator.details.amountRange' => 'Zakres kwoty',
			'coordinator.details.maxPremium' => 'Maks. premia',
			'coordinator.details.maxPremiumInfoTitle' => 'Premia',
			'coordinator.details.maxPremiumInfoBody' => 'Premia to opcjonalna marża ponad kurs rynkowy, którą wystawiający (maker) może ustawić na ofercie. Przy premii maker blokuje mniej satoshi za tę samą kwotę fiat, więc biorący (taker) płaci powyżej rynku, a maker zatrzymuje różnicę. Ta wartość to najwyższa premia dozwolona przez tego koordynatora w jego ofertach.',
			'coordinator.details.reservationTime' => 'Czas rezerwacji',
			'coordinator.details.currencies' => 'Waluty',
			'coordinator.details.version' => 'Wersja',
			'coordinator.details.yourOffers' => 'Twoje oferty',
			'coordinator.details.successfulOffers' => 'Udane oferty (30d)',
			'coordinator.details.statusOnline' => 'Online',
			'coordinator.details.statusOffline' => 'Offline',
			'coordinator.details.statusUnknown' => 'Nieznany',
			'coordinator.details.openNostrProfile' => 'Otwórz profil Nostr',
			'coordinator.details.termsOfUsage' => 'Warunki użytkowania',
			'coordinator.management.title' => 'Zarządzanie Koordynatorami',
			'coordinator.management.availableCoordinators' => 'Koordynatorzy',
			'coordinator.management.noCoordinators' => 'Nie odkryto jeszcze żadnych koordynatorów.',
			'coordinator.management.online' => 'Online',
			'coordinator.management.unknownOffline' => 'Nieznany/Offline',
			'coordinator.management.openNostrProfile' => 'Otwórz profil Nostr',
			'coordinator.management.enable' => 'Włącz',
			'coordinator.management.remove' => 'Usuń',
			'coordinator.management.addCustomWhitelist' => 'Dodaj koordynatora',
			'coordinator.management.addCustomWhitelistHint' => 'npub1...',
			'coordinator.management.add' => 'Dodaj',
			'coordinator.management.coordinatorDisabled' => 'Koordynator wyłączony',
			'coordinator.management.coordinatorEnabled' => 'Koordynator włączony',
			'coordinator.management.coordinatorAdded' => 'Koordynator dodany do niestandardowej białej listy',
			'coordinator.management.coordinatorRemoved' => 'Koordynator usunięty z niestandardowej białej listy',
			'coordinator.management.coordinatorAddInfoUnavailable' => 'Nie znaleziono informacji o koordynatorze w przekaźnikach. Koordynator nie został dodany.',
			'coordinator.management.pleaseEnterNpub' => 'Proszę wprowadzić npub',
			'coordinator.management.error' => 'Błąd',
			'coordinator.management.metricYourOffers' => 'Twoje oferty',
			'coordinator.management.metricYourOffersTooltip' => 'Liczba ofert, które pomyślnie zrealizowałeś z tym koordynatorem.',
			'coordinator.management.metricNetworkOffers' => 'Oferty (30 dni)',
			'coordinator.management.metricNetworkOffersTooltip' => 'Pomyślnie rozliczone oferty przez tego koordynatora dla wszystkich użytkowników w ciągu ostatnich 30 dni.',
			'maker.roleSelection.button' => 'ZAPŁAĆ przez Lightning',
			'maker.amountForm.progress.step1' => '1. Utwórz Ofertę',
			'maker.amountForm.progress.step2' => '2. Czekaj na zabranie',
			'maker.amountForm.progress.step3' => '3. Użyj BLIK',
			'maker.amountForm.labels.coordinator' => 'Koordynator',
			'maker.amountForm.labels.category' => 'Kategoria',
			'maker.amountForm.labels.exchangeRate' => 'Kurs wymiany',
			'maker.amountForm.labels.fee' => 'Opłata',
			'maker.amountForm.labels.satoshisToPay' => 'Do zapłaty',
			'maker.amountForm.labels.enterAmount' => 'Wprowadź kwotę',
			'maker.amountForm.labels.tapToSelect' => 'Kliknij, aby wybrać',
			'maker.amountForm.labels.premium' => 'Premia',
			'maker.amountForm.actions.generateInvoice' => 'Wygeneruj Fakturę',
			'maker.amountForm.tooltips.feeInfo' => ({required Object feePercent}) => 'Koordynator pobiera od twórcy opłatę w wysokości ${feePercent}%. Ta opłata jest odejmowana od Twojej płatności Lightning.',
			'maker.amountForm.tooltips.payInfo' => 'Ta kalkulacja jest oparta na kursach wymiany pobranych po stronie klienta. Koordynator obliczy dokładną kwotę, a kwota faktury będzie ostateczną i dokładną kwotą do zapłaty.',
			'maker.amountForm.tooltips.premiumInfo' => 'Opcjonalna premia pozwala sprzedać saty powyżej ceny rynkowej. Premia zmniejsza liczbę satów zablokowanych w fakturze hold dla tej samej kwoty fiat, więc kupujący płaci powyżej rynku, a Ty zatrzymujesz różnicę. Domyślnie wyłączona (0%). Maksymalną premię ustala wybrany koordynator.',
			'maker.amountForm.category.label' => 'Kategoria oferty',
			'maker.amountForm.category.options.physicalShop' => 'Sklep, kawiarnia lub restauracja',
			'maker.amountForm.category.options.atmCashout' => 'Wypłata gotówki z bankomatu',
			'maker.amountForm.category.options.onlineService' => 'Produkt lub usługa online',
			'maker.amountForm.category.shortLabels.shop' => 'Sklep',
			'maker.amountForm.category.shortLabels.atm' => 'Bankomat',
			'maker.amountForm.category.shortLabels.online' => 'Online',
			'maker.amountForm.category.atmHint' => 'Kupujący zobaczą, że oferta dotyczy wypłaty z bankomatu i mogą ją pominąć, jeśli ich bank dolicza dodatkowe opłaty.',
			'maker.amountForm.category.physicalShopHint' => 'Idealne miejsce do użycia Bitblik to kasa samoobsługowa — ponieważ oczekiwanie na takera, który musi zarezerwować ofertę, wygenerować i potwierdzić kod BLIK, może zająć kilka minut. Sprawdza się świetnie w sklepach, kawiarniach i restauracjach. Jeśli czujesz się na tyle odważny, żeby kazać zwykłemu kasjerowi (i osobom stojącym za Tobą w kolejce) czekać te kilka minut — chwała Ci za to.',
			'maker.amountForm.category.ecommerceWarningTitle' => 'Ryzyko zwrotu od sprzedawcy online',
			'maker.amountForm.category.ecommerceWarningBody' => 'Z różnych powodów — takich jak brak towaru, korekta nadpłaty lub inne problemy po stronie sprzedawcy — internetowy sprzedawca może automatycznie wystawić zwrot na konto bankowe powiązane z kodem BLIK, czyli konto takera. Koordynator nie może wymusić, aby taker zwrócił te środki Tobie.',
			'maker.amountForm.category.ecommerceConfirmation' => 'Rozumiem ryzyko zwrotu i dodam do zamówienia informację, aby sprzedawca w razie zwrotu przelał środki na inne konto.',
			'maker.amountForm.category.whyThisIsNeeded' => 'dlaczego to jest potrzebne?',
			'maker.amountForm.onboarding.titlePrefix' => 'Nowość',
			'maker.amountForm.onboarding.title' => 'Wybierz kategorię oferty',
			'maker.amountForm.onboarding.body' => 'Przed wygenerowaniem faktury wybierz kategorię, która najlepiej opisuje to, za co płacisz.',
			'maker.amountForm.onboarding.showWhy' => 'Dlaczego to jest ważne?',
			'maker.amountForm.onboarding.hideWhy' => 'Ukryj szczegóły',
			'maker.amountForm.onboarding.whyTitle' => 'Dobra kategoria pomaga takerom bezpiecznie podjąć decyzję',
			'maker.amountForm.onboarding.whyBody' => 'Różne sytuacje oznaczają różne oczekiwania i ryzyka. Wypłaty z bankomatu mogą mieć dodatkowe opłaty bankowe, a zakupy online mogą wiązać się z problemami przy zwrotach. Oznaczenie właściwej kategorii daje takerowi potrzebny kontekst przed akceptacją oferty.',
			'maker.amountForm.onboarding.cta' => 'Rozumiem',
			'maker.amountForm.errors.initiating' => ({required Object details}) => 'Błąd inicjowania oferty: ${details}',
			'maker.amountForm.errors.publicKeyNotLoaded' => 'Błąd: Klucz publiczny nie został jeszcze załadowany.',
			'maker.amountForm.errors.noCoordinatorMatchesAmount' => 'Żaden koordynator nie obsługuje tej kwoty. Spróbuj inną wartość.',
			'maker.amountForm.errors.categoryRequired' => 'Wybierz kategorię oferty.',
			'maker.amountForm.errors.ecommerceConfirmationRequired' => 'Potwierdź ryzyko zwrotu od sprzedawcy online przed kontynuacją.',
			'maker.payInvoice.title' => 'Zapłać tę fakturę Hold:',
			'maker.payInvoice.actions.copy' => 'Kopiuj Fakturę',
			'maker.payInvoice.actions.payInWallet' => 'Otwórz w portfelu zewnętrznym',
			'maker.payInvoice.actions.connectWallet' => 'Połącz portfel',
			'maker.payInvoice.actions.payWithNwc' => 'Zapłać',
			'maker.payInvoice.actions.paying' => 'Płacenie...',
			'maker.payInvoice.feedback.copied' => 'Faktura skopiowana do schowka!',
			'maker.payInvoice.feedback.waitingConfirmation' => 'Oczekiwanie na potwierdzenie płatności...',
			'maker.payInvoice.feedback.nwcConnected' => 'Portfel NWC połączony!',
			'maker.payInvoice.feedback.nwcPaymentSuccess' => 'Płatność udana!',
			'maker.payInvoice.errors.couldNotOpenApp' => 'Nie można otworzyć aplikacji Lightning dla faktury.',
			'maker.payInvoice.errors.openingApp' => ({required Object details}) => 'Błąd otwierania aplikacji Lightning: ${details}',
			'maker.payInvoice.errors.publicKeyNotAvailable' => 'Klucz publiczny nie jest dostępny.',
			'maker.payInvoice.errors.couldNotFetchActive' => 'Nie udało się pobrać szczegółów aktywnej oferty. Mogła wygasnąć.',
			'maker.payInvoice.errors.nwcPaymentFailed' => ({required Object details}) => 'Płatność nie powiodła się: ${details}',
			'maker.payInvoice.errors.nwcNotConnected' => 'Portfel NWC nie jest połączony',
			'maker.payInvoice.errors.insufficientBalance' => ({required Object required, required Object available}) => 'Niewystarczające środki. Potrzeba ${required} sats, dostępne ${available} sats',
			'maker.payInvoice.errors.cancelOfferAlreadyFunded' => 'Koordynator zgłasza, że ta oferta jest już opłacona. Nie można jej teraz anulować.',
			'maker.payInvoice.errors.cancelFailed' => ({required Object details}) => 'Nie można anulować oferty: ${details}',
			'maker.waitTaker.message' => 'Oczekiwanie na rezerwację przez Kupującego...',
			'maker.waitTaker.errorActiveOfferDetailsLost' => 'Błąd: Utracono szczegóły aktywnej oferty.',
			'maker.waitTaker.errorFailedToRetrieveBlik' => 'Błąd: Nie udało się pobrać kodu BLIK.',
			'maker.waitTaker.errorRetrievingBlik' => ({required Object details}) => 'Błąd pobierania kodu BLIK: ${details}',
			'maker.waitTaker.offerNoLongerAvailable' => ({required Object status}) => 'Oferta nie jest już dostępna (Status: ${status}).',
			'maker.waitTaker.errorCouldNotIdentifyOffer' => 'Błąd: Nie można zidentyfikować oferty do anulowania.',
			'maker.waitTaker.offerCannotBeCancelled' => ({required Object status}) => 'Oferty nie można anulować w obecnym stanie (${status}).',
			'maker.waitTaker.offerCancelledSuccessfully' => 'Oferta anulowana pomyślnie.',
			'maker.waitTaker.failedToCancelOffer' => ({required Object details}) => 'Nie udało się anulować oferty: ${details}',
			'maker.waitTaker.offerExpiredTitle' => 'Oferta wygasła',
			'maker.waitTaker.offerExpiredMessage' => 'Żaden taker nie zarezerwował oferty w czasie.',
			'maker.waitTaker.recreateOffer' => 'Nowa oferta — ta sama kwota',
			'maker.waitForBlik.title' => 'Oczekiwanie na BLIK',
			'maker.waitForBlik.messageInfo' => 'Ktoś zarezerwował twoją ofertę!',
			'maker.waitForBlik.messageWaiting' => 'Oczekiwanie na kod BLIK...',
			'maker.waitForBlik.progressLabel' => ({required Object seconds}) => 'Zarezerwowano: ${seconds} s pozostało',
			'maker.confirmPayment.title' => 'Otrzymano kod BLIK!',
			'maker.confirmPayment.retrieving' => 'Pobieranie kodu BLIK...',
			'maker.confirmPayment.instruction1' => 'Wprowadź kod do systemu płatności BLIK.',
			'maker.confirmPayment.instruction2' => 'Poczekaj, aż Kupujący potwierdzi płatność w swojej aplikacji banku.',
			'maker.confirmPayment.instruction3' => 'Gdy płatność zakończy się sukcesem, naciśnij Potwierdź poniżej:',
			'maker.confirmPayment.takerChargedWarning' => 'Pobierający zgłosił, że płatność BLIK została pobrana z jego konta bankowego. Oznaczenie tego jako nieprawidłowe spowoduje konflikt.',
			'maker.confirmPayment.expiredTitle' => 'Kod BLIK wygasł',
			'maker.confirmPayment.expiredWarning' => 'Kod BLIK wygasł. Musisz ręcznie potwierdzić status płatności:',
			'maker.confirmPayment.expiredInstruction1' => 'Jeśli płatność BLIK zakończyła się sukcesem i zrealizowałeś zakup, kliknij "Potwierdź udaną płatność" poniżej.',
			'maker.confirmPayment.expiredInstruction2' => 'Jeśli płatność BLIK nie powiodła się lub nie została zrealizowana, kliknij "Nieprawidłowy kod BLIK" poniżej.',
			'maker.confirmPayment.actions.confirm' => 'Potwierdź udaną płatność',
			'maker.confirmPayment.actions.markInvalid' => 'Nieprawidłowy kod BLIK',
			'maker.confirmPayment.actions.copyBlik' => 'Kopiuj BLIK',
			'maker.confirmPayment.confirmDialog.title' => 'Potwierdzić płatność?',
			'maker.confirmPayment.confirmDialog.content' => 'Ta akcja jest nieodwracalna. Po potwierdzeniu:\n\n• Kupujący otrzyma środki natychmiast\n• Koordynator nie będzie mógł zakwestionować środków\n• Nie możesz cofnąć tej akcji\n\nPotwierdź tylko wtedy, gdy płatność BLIK zakończyła się sukcesem.',
			'maker.confirmPayment.confirmDialog.cancel' => 'Anuluj',
			'maker.confirmPayment.confirmDialog.confirmButton' => 'Tak, potwierdź płatność',
			'maker.confirmPayment.invalidBlikDisputeDialog.title' => 'Otworzyć spór?',
			'maker.confirmPayment.invalidBlikDisputeDialog.content' => 'Kupujący zgłosił, że płatność BLIK została pobrana z jego konta.\n\nOznaczenie tego jako nieprawidłowe natychmiast otworzy SPÓR wymagający interwencji koordynatora.\n\n• Opłata za spór może zostać naliczona, jeśli zostanie rozstrzygnięty na Twoją niekorzyść\n• Faktura hold zostanie rozliczona natychmiast\n• Wymagana będzie ręczna weryfikacja\n\nKontynuuj tylko wtedy, gdy masz pewność, że płatność BLIK NIE powiodła się.',
			'maker.confirmPayment.invalidBlikDisputeDialog.cancel' => 'Anuluj',
			'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton' => 'Tak, otwórz spór',
			'maker.confirmPayment.feedback.confirmed' => 'Maker potwierdził płatność.',
			'maker.confirmPayment.feedback.confirmedTakerPaid' => 'Płatność potwierdzona! Taker otrzyma środki.',
			'maker.confirmPayment.feedback.progressLabel' => ({required Object seconds}) => 'Potwierdzanie: ${seconds} s pozostało',
			'maker.confirmPayment.errors.failedToRetrieve' => 'Błąd: Nie udało się pobrać kodu BLIK.',
			'maker.confirmPayment.errors.retrieving' => ({required Object details}) => 'Błąd pobierania kodu BLIK: ${details}',
			'maker.confirmPayment.errors.missingHashOrKey' => 'Błąd: Brakujący hash płatności lub klucz publiczny.',
			'maker.confirmPayment.errors.incorrectState' => ({required Object status}) => 'Oferta nie jest w prawidłowym stanie do potwierdzenia (Status: ${status})',
			'maker.confirmPayment.errors.confirming' => ({required Object details}) => 'Błąd potwierdzania płatności: ${details}',
			'maker.confirmPayment.errors.invalidState' => 'Błąd: Otrzymano nieprawidłowy stan oferty.',
			'maker.confirmPayment.errors.internalIncomplete' => 'Błąd wewnętrzny: Niekompletne szczegóły oferty.',
			'maker.confirmPayment.errors.notAwaitingConfirmation' => ({required Object status}) => 'Oferta nie oczekuje już na potwierdzenie (Status: ${status}).',
			'maker.confirmPayment.errors.unexpectedStatus' => 'Otrzymano nieoczekiwany status oferty z serwera.',
			'maker.invalidBlik.title' => 'Nieprawidłowy kod BLIK',
			'maker.invalidBlik.info' => 'Oznaczyłeś kod BLIK jako nieprawidłowy. Oczekiwanie na podanie nowego kodu przez takera lub rozpoczęcie sporu.',
			'maker.conflict.title' => 'Konflikt Oferty',
			'maker.conflict.headline' => 'Zgłoszono Konflikt Oferty',
			'maker.conflict.body' => 'Oznaczyłeś kod BLIK jako nieprawidłowy, ale Taker zgłosił konflikt, wskazując, że uważa, iż płatność zakończyła się sukcesem.',
			'maker.conflict.instructions' => 'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.',
			'maker.conflict.actions.back' => 'Powrót do strony głównej',
			'maker.conflict.actions.confirmPayment' => 'Mój błąd, potwierdź sukces płatności BLIK',
			'maker.conflict.actions.openDispute' => 'Płatność BLIK NIE powiodła się, OTWÓRZ SPÓR',
			'maker.conflict.actions.submitDispute' => 'Zgłoś Spór',
			'maker.conflict.disputeDialog.title' => 'Otworzyć spór?',
			'maker.conflict.disputeDialog.content' => 'Otwarcie sporu wymaga ręcznej weryfikacji przez koordynatora, co zajmie czas. Opłata za spór zostanie potrącona, jeśli spór zostanie rozstrzygnięty na Twoją niekorzyść. Faktura hold zostanie rozliczona, aby zapobiec jej wygaśnięciu. Jeśli spór zostanie rozstrzygnięty na Twoją korzyść, otrzymasz zwrot środków (pomniejszony o opłaty) do portfela według własnego wyboru.',
			'maker.conflict.disputeDialog.contentDetailed' => 'Otwarcie sporu będzie wymagało ręcznej interwencji koordynatora, co zajmuje czas i wiąże się z opłatą za spór.\n\nFaktura hold zostanie natychmiast rozliczona, aby zapobiec jej wygaśnięciu przed rozstrzygnięciem sporu.\n\nJeśli spór zostanie rozstrzygnięty na Twoją korzyść, kwota satoshi zostanie zwrócona do portfela według własnego wyboru (pomniejszona o opłaty). Upewnij się, że masz portfel gotowy do odbioru.',
			'maker.conflict.disputeDialog.actions.confirm' => 'Otwórz Spór',
			'maker.conflict.disputeDialog.actions.cancel' => 'Anuluj',
			'maker.conflict.feedback.disputeOpenedSuccess' => 'Spór pomyślnie otwarty. Koordynator rozpatrzy sprawę.',
			'maker.conflict.errors.openingDispute' => ({required Object error}) => 'Błąd otwierania sporu: ${error}',
			'maker.conflict.nostrContact.title' => 'Skontaktuj się z Koordynatorem na Nostr',
			'maker.conflict.nostrContact.description' => 'Możesz wysłać DM do koordynatora bezpośrednio, aby uzyskać pomoc w tym sporze.',
			'maker.conflict.nostrContact.copyNpub' => 'Kopiuj npub',
			'maker.conflict.nostrContact.openProfile' => 'Zobacz Profil',
			'maker.conflict.nostrContact.npubCopied' => 'Npub koordynatora skopiowany do schowka!',
			'maker.conflict.nostrContact.yourIdentityDescription' => 'Aby wysyłać DM, zaloguj się swoim kluczem prywatnym Neko (nsec) w dowolnym kliencie Nostr obsługującym wiadomości bezpośrednie.',
			'maker.conflict.nostrContact.manageNekoKeys' => 'Zarządzaj Kluczami Neko',
			'maker.success.title' => 'Oferta zakończona',
			'maker.success.headline' => 'Płatność potwierdzona!',
			'maker.success.subtitle' => 'Osoba przyjmująca ofertę otrzyma teraz zapłatę.',
			'maker.success.detailsTitle' => 'Szczegóły oferty:',
			'maker.success.duration' => ({required Object time}) => 'Oferta zajęła ${time}!',
			'taker.roleSelection.button' => 'SPRZEDAJ kod BLIK za satoshi',
			'taker.progress.step1' => 'Wyślij BLIK',
			'taker.progress.step2' => 'Potwierdź BLIK',
			'taker.progress.step3' => 'Otrzymaj płatność',
			'taker.submitBlik.title' => 'Wpisz 6-cyfr BLIK',
			'taker.submitBlik.label' => 'Kod BLIK',
			'taker.submitBlik.instruction' => 'Wprowadź BLIK zanim upłynie czas...',
			'taker.submitBlik.timeLimit' => ({required Object seconds}) => 'Wprowadź BLIK w ciągu: ${seconds} s',
			'taker.submitBlik.timeExpired' => 'Czas na wprowadzenie kodu BLIK minął.',
			'taker.submitBlik.actions.submit' => 'Wyślij BLIK',
			'taker.submitBlik.feedback.pasted' => 'Wklejono kod BLIK.',
			'taker.submitBlik.validation.invalidFormat' => 'Wprowadź prawidłowy 6-cyfrowy kod BLIK.',
			'taker.submitBlik.errors.submitting' => ({required Object details}) => 'Błąd wysyłania kodu BLIK: ${details}',
			'taker.submitBlik.errors.clipboardInvalid' => 'Schowek nie zawiera prawidłowego 6-cyfrowego kodu BLIK.',
			'taker.submitBlik.errors.stateChanged' => 'Błąd: Stan oferty uległ zmianie.',
			'taker.submitBlik.errors.stateNotValid' => 'Błąd: Stan oferty nie jest już ważny.',
			'taker.submitBlik.errors.fetchedIdMismatch' => ({required Object fetchedId, required Object initialId}) => 'Pobrane ID aktywnej oferty (${fetchedId}) nie pasuje do początkowego ID oferty (${initialId}). Niezgodność stanu?',
			'taker.submitBlik.errors.paymentHashMissing' => 'Brak hasha płatności oferty po pobraniu.',
			'taker.submitBlik.details.requestedAmount' => 'Żądana kwota BLIK',
			'taker.submitBlik.details.exchangeRate' => 'Kurs wymiany',
			'taker.submitBlik.details.takerFee' => 'Opłata Taker',
			'taker.submitBlik.details.status' => 'Status',
			'taker.submitBlik.details.youllReceive' => 'Otrzymasz',
			'taker.waitConfirmation.title' => 'Oczekiwanie na Makera',
			'taker.waitConfirmation.statusLabel' => ({required Object status}) => 'Status oferty: ${status}',
			'taker.waitConfirmation.waitingMaker' => ({required Object seconds}) => 'Oczekiwanie na potwierdzenie Makera: ${seconds} s',
			'taker.waitConfirmation.waitingMakerConfirmation' => ({required Object seconds}) => 'Oczekiwanie na potwierdzenie płatności BLIK przez Makera w jego aplikacji bankowej. Pozostały czas: ${seconds}s',
			'taker.waitConfirmation.importantNotice' => ({required Object amount, required Object currency}) => 'BARDZO WAŻNE: Upewnij się, że akceptujesz potwierdzenie BLIK tylko na kwotę ${amount} ${currency}',
			'taker.waitConfirmation.importantBlikAmountConfirmation' => ({required Object amount, required Object currency}) => 'BARDZO WAŻNE: W swojej aplikacji bankowej upewnij się, że potwierdzasz płatność BLIK na kwotę dokładnie ${amount} ${currency}.',
			'taker.waitConfirmation.instructions' => 'Osoba wystawiająca ofertę musi teraz wpisać kod BLIK w ciągu 2 minut. Następnie musisz zaakceptować kod BLIK w swojej aplikacji bankowej.',
			'taker.waitConfirmation.categoryReminder.atm' => 'Przypomnienie dla oferty ATM: Twój bank może nadal poprosić o zatwierdzenie dodatkowej opłaty bankomatowej ponad główną kwotę.',
			'taker.waitConfirmation.categoryReminder.ecommerce' => 'Przypomnienie dla zamówienia online: jeśli sprzedawca wyśle automatyczny zwrot na Twoje konto, skontaktuj się z koordynatorem i oddaj środki.',
			'taker.waitConfirmation.waitingForMakerToReceive' => 'Czekamy, aż twórca oferty otrzyma Twój kod BLIK...',
			'taker.waitConfirmation.makerReceivedBlik' => 'Twórca oferty otrzymał Twój kod BLIK',
			'taker.waitConfirmation.timerExpiredMessage' => 'Minął termin ważności kodu BLIK 2m. Czekamy na potwierdzenie lub oznaczenie kodu jako nieważnego przez wystawcę oferty.',
			'taker.waitConfirmation.timerExpiredActions' => 'Minął termin ważności kodu BLIK 2m, ale wystawca nie otrzymał kodu BLIK. Możesz wysłać nowy kod BLIK lub anulować.',
			'taker.waitConfirmation.resendBlikButton' => 'Wyślij nowy kod BLIK',
			'taker.waitConfirmation.navigatedHome' => 'Przeniesiono na stronę główną.',
			'taker.waitConfirmation.expiredTitle' => 'Kod BLIK wygasł',
			'taker.waitConfirmation.expiredWarning' => 'Twórca oferty nie otrzymał kodu BLIK, więc nie mógł go użyć.',
			'taker.waitConfirmation.expiredRelistCountdownLabel' => 'Koniec rezerwacji za',
			'taker.waitConfirmation.expiredSentWarning' => 'Twórca oferty jeszcze nie potwierdził płatności. Co chcesz zrobić?',
			'taker.waitConfirmation.expiredInstruction1' => 'Jeśli chcesz spróbować ponownie z nowym kodem BLIK, odnów rezerwację.',
			'taker.waitConfirmation.expiredInstruction2' => 'Jeśli nie chcesz już dokończyć tej transakcji, anuluj rezerwację.',
			'taker.waitConfirmation.expiredInstruction3' => 'Jeśli płatność BLIK została pobrana z Twojego konta bankowego, nie martw się, bitcoin jest nadal bezpiecznie zablokowany u koordynatora.',
			'taker.waitConfirmation.takerCharged.title' => 'Oznaczyłeś BLIK jako opłacony',
			'taker.waitConfirmation.takerCharged.message' => 'Twórca oferty musi potwierdzić płatność lub ją zakwestionować. Jeśli nic nie zrobi, płatność zostanie automatycznie potwierdzona, a Ty otrzymasz bitcoiny.',
			'taker.waitConfirmation.expiredActions.reportConflict' => 'BLIK został pobrany z mojego konta',
			'taker.waitConfirmation.expiredActions.renewReservation' => 'Spróbuj ponownie z nowym kodem BLIK',
			'taker.waitConfirmation.expiredActions.cancelReservation' => 'Anuluj rezerwację',
			'taker.waitConfirmation.feedback.makerConfirmed' => 'Maker potwierdził płatność.',
			'taker.waitConfirmation.feedback.paymentSuccessful' => 'Płatność udana! Wkrótce otrzymasz środki.',
			'taker.waitConfirmation.feedback.conflictReported' => 'Konflikt zgłoszony. Koordynator rozpatrzy sytuację.',
			'taker.waitConfirmation.errors.invalidOfferStateReceived' => 'Otrzymano ofertę o nieprawidłowym stanie dla tego ekranu. Resetowanie.',
			'taker.waitConfirmation.errors.reportingConflict' => ({required Object details}) => 'Błąd zgłaszania konfliktu: ${details}',
			'taker.paymentProcess.title' => 'Proces Płatności',
			'taker.paymentProcess.waitingForOfferUpdate' => 'Oczekiwanie na aktualizację statusu oferty...',
			'taker.paymentProcess.states.preparing' => 'Przygotowywanie do wysłania płatności...',
			'taker.paymentProcess.states.sending' => 'Wysyłanie płatności...',
			'taker.paymentProcess.states.received' => 'Płatność otrzymana!',
			'taker.paymentProcess.states.failed' => 'Płatność nie powiodła się',
			'taker.paymentProcess.states.waitingUpdate' => 'Oczekiwanie na aktualizację oferty...',
			'taker.paymentProcess.steps.makerConfirmedBlik' => 'Maker potwierdził płatność BLIK',
			'taker.paymentProcess.steps.makerInvoiceSettled' => 'Faktura hold Makera rozliczona',
			'taker.paymentProcess.steps.takerInvoicePaid' => 'Opłacanie Twojej faktury Lightning',
			'taker.paymentProcess.steps.takerPaymentFailed' => 'Płatność na Twoją fakturę nie powiodła się',
			'taker.paymentProcess.errors.sending' => ({required Object details}) => 'Błąd wysyłania płatności: ${details}',
			'taker.paymentProcess.errors.notConfirmed' => 'Oferta niepotwierdzona przez Makera.',
			'taker.paymentProcess.errors.expired' => 'Oferta wygasła.',
			'taker.paymentProcess.errors.cancelled' => 'Oferta anulowana.',
			'taker.paymentProcess.errors.paymentFailed' => 'Płatność oferty nie powiodła się.',
			'taker.paymentProcess.errors.unknown' => 'Nieznany błąd oferty.',
			'taker.paymentProcess.errors.takerPaymentFailed' => 'Płatność na Twoją fakturę Lightning nie powiodła się.',
			'taker.paymentProcess.errors.noPublicKey' => 'Błąd: Nie można pobrać Twojego klucza publicznego.',
			'taker.paymentProcess.errors.loadingPublicKey' => 'Błąd ładowania Twoich danych',
			'taker.paymentProcess.errors.missingPaymentHash' => 'Błąd: Brakujące szczegóły płatności.',
			'taker.paymentProcess.loading.publicKey' => 'Ładowanie Twoich danych...',
			'taker.paymentProcess.actions.goToFailureDetails' => 'Wprowadź nową fakturę Lightning',
			'taker.paymentFailed.title' => 'Płatność Nie Powiodła Się',
			'taker.paymentFailed.instructions' => ({required Object netAmount}) => 'Proszę podać nową fakturę Lightning na kwotę ${netAmount}',
			'taker.paymentFailed.form.newInvoiceLabel' => 'Nowa faktura Lightning',
			'taker.paymentFailed.form.newInvoiceHint' => 'Wprowadź swoją fakturę BOLT11',
			'taker.paymentFailed.actions.retryPayment' => 'Wyślij nową fakturę',
			'taker.paymentFailed.errors.enterValidInvoice' => 'Proszę wprowadzić prawidłową fakturę',
			'taker.paymentFailed.errors.updatingInvoice' => ({required Object details}) => 'Błąd aktualizacji faktury: ${details}',
			'taker.paymentFailed.errors.paymentRetryFailed' => 'Ponowna próba płatności nie powiodła się. Sprawdź fakturę lub spróbuj ponownie później.',
			'taker.paymentFailed.errors.takerPublicKeyNotFound' => 'Nie znaleziono klucza publicznego Kupującego.',
			'taker.paymentFailed.errors.generateFailed' => ({required Object details}) => 'Nie udało się wygenerować faktury: ${details}',
			'taker.paymentFailed.walletSection.title' => 'Generuj fakturę z portfela',
			'taker.paymentFailed.walletSection.defaultLabel' => 'domyślny',
			'taker.paymentFailed.walletSection.tapToGenerate' => ({required Object amountSats}) => 'Dotknij, aby wygenerować fakturę na ${amountSats}',
			'taker.paymentFailed.loading.processingPayment' => 'Przetwarzanie ponownej płatności...',
			'taker.paymentFailed.success.title' => 'Płatność udana',
			'taker.paymentFailed.success.message' => 'Twoja płatność została przetworzona pomyślnie.',
			'taker.paymentSuccess.title' => 'Płatność Udana',
			'taker.paymentSuccess.message' => 'Twoja płatność została przetworzona pomyślnie.',
			'taker.paymentSuccess.actions.goHome' => 'Przejdź do strony głównej',
			'taker.invalidBlik.title' => 'Nieprawidłowy Kod BLIK',
			'taker.invalidBlik.message' => 'Maker Odrzucił Kod BLIK',
			'taker.invalidBlik.explanation' => 'Maker oferty wskazał, że podany przez Ciebie kod BLIK był nieprawidłowy lub nie zadziałał.\n\nCo chcesz zrobić?',
			'taker.invalidBlik.werentCharged' => 'Jeśli Twoje konto NIE zostało obciążone:',
			'taker.invalidBlik.wereCharged' => 'Jeśli Twoje konto zostało obciążone:',
			'taker.invalidBlik.actions.retry' => 'Wyślij nowy kod BLIK',
			'taker.invalidBlik.actions.cancelReservation' => 'Anuluj Transakcję',
			'taker.invalidBlik.actions.reportConflict' => 'Rozpocząć Spór',
			'taker.invalidBlik.actions.returnHome' => 'Wróć do strony głównej',
			'taker.invalidBlik.feedback.conflictReportedSuccess' => 'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.',
			'taker.invalidBlik.errors.reservationFailed' => 'Nie udało się ponownie zarezerwować oferty',
			'taker.invalidBlik.errors.conflictReport' => ({required Object details}) => 'Błąd zgłaszania konfliktu: ${details}',
			'taker.conflict.title' => 'Konflikt Oferty',
			'taker.conflict.headline' => 'Zgłoszono Konflikt Oferty',
			'taker.conflict.body' => 'Maker oznaczył kod BLIK jako nieprawidłowy, ale Ty zgłosiłeś konflikt, wskazując, że uważasz, iż płatność zakończyła się sukcesem.',
			'taker.conflict.instructions' => 'Poczekaj na rozpatrzenie sytuacji przez koordynatora. Możesz zostać poproszony o więcej szczegółów. Sprawdź później lub skontaktuj się z pomocą techniczną.',
			'taker.conflict.actions.back' => 'Powrót do strony głównej',
			'taker.conflict.feedback.reported' => 'Konflikt zgłoszony. Koordynator rozpatrzy sprawę.',
			'taker.conflict.errors.reporting' => ({required Object details}) => 'Błąd zgłaszania konfliktu: ${details}',
			'taker.conflict.nostrContact.title' => 'Skontaktuj się z Koordynatorem na Nostr',
			'taker.conflict.nostrContact.description' => 'Możesz wysłać DM do koordynatora bezpośrednio, aby uzyskać pomoc w tym sporze.',
			'taker.conflict.nostrContact.copyNpub' => 'Kopiuj npub',
			'taker.conflict.nostrContact.openProfile' => 'Zobacz Profil',
			'taker.conflict.nostrContact.npubCopied' => 'Npub koordynatora skopiowany do schowka!',
			'taker.conflict.nostrContact.yourIdentityDescription' => 'Aby wysyłać DM, zaloguj się swoim kluczem prywatnym Neko (nsec) w dowolnym kliencie Nostr obsługującym wiadomości bezpośrednie.',
			'taker.conflict.nostrContact.manageNekoKeys' => 'Zarządzaj Kluczami Neko',
			'blik.instructions.taker' => 'Gdy Maker wprowadzi kod BLIK, będziesz musiał potwierdzić płatność w swojej aplikacji bankowej. Upewnij się, że kwota jest poprawna przed potwierdzeniem.',
			'nekoInfo.title' => 'Czym jest Neko?',
			'nekoInfo.description' => 'Twoje Neko to Twoja tożsamość do korzystania z BitBlik. Składa się z klucza prywatnego i publicznego, aby zapewnić kryptograficznie bezpieczną komunikację z koordynatorem.\n\nAby zapewnić większą anonimowość, zaleca się używanie nowego, świeżego Neko dla każdej oferty.\n\n⚠️ WAŻNE: Twój klucz prywatny jest przechowywany tylko na Twoim urządzeniu (po stronie klienta). Niezwykle ważne jest zarchiwizowanie klucza prywatnego, ponieważ utrata dostępu do niego może uniemożliwić rozstrzygnięcie sporów i odzyskanie środków.',
			'nekoInfo.backupWarning' => 'Pamiętaj, aby zarchiwizować swoje Neko',
			'generateNewKey.title' => 'Nowy',
			'generateNewKey.description' => 'Czy na pewno chcesz wygenerować nowe Neko? Twoje obecne zostanie utracone na zawsze, jeśli go nie zarchiwizowałeś.',
			'generateNewKey.buttons.generate' => 'Generuj',
			'generateNewKey.errors.activeOffer' => 'Nie możesz wygenerować nowego Neko, gdy masz aktywną ofertę.',
			'generateNewKey.errors.failed' => 'Nie udało się wygenerować nowego Neko',
			'generateNewKey.feedback.success' => 'Nowe Neko wygenerowane pomyślnie!',
			'generateNewKey.tooltips.generate' => 'Wygeneruj nowe Neko',
			'backup.title' => 'Zarchiwizuj',
			'backup.description' => 'To jest Twój klucz prywatny. Zabezpiecza on komunikację z koordynatorem. Nigdy nikomu go nie ujawniaj. Zarchiwizuj go w bezpiecznym miejscu, aby uniknąć problemów podczas sporów.',
			'backup.feedback.copied' => 'Klucz prywatny skopiowany do schowka!',
			'backup.tooltips.backup' => 'Zarchiwizuj Neko',
			'restore.title' => 'Przywróć',
			'restore.labels.privateKey' => 'Klucz prywatny',
			'restore.buttons.restore' => 'Przywróć',
			'restore.errors.invalidKey' => 'Musi to być 64-znakowy ciąg szesnastkowy.',
			'restore.errors.failed' => 'Przywracanie nie powiodło się',
			'restore.feedback.success' => 'Neko przywrócone pomyślnie! Aplikacja zostanie ponownie uruchomiona.',
			'restore.tooltips.restore' => 'Przywróć Neko',
			'home.notifications.title' => 'Otrzymuj powiadomienia o nowych ofertach przez:',
			'home.notifications.telegram' => 'Telegram',
			'home.notifications.simplex' => 'SimpleX',
			'home.notifications.element' => 'Element',
			'home.notifications.signal' => 'Signal',
			'home.statistics.title' => 'Zakończone oferty',
			'home.statistics.lifetimeCompact' => ({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Wszystkie: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}',
			'home.statistics.last7DaysCompact' => ({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ost. 7 dni: ${count} transakcji\nŚr. czas oczekiwania na BLIK: ${avgBlikTime}\nŚr. czas realizacji: ${avgPaidTime}',
			'home.statistics.last7DaysSingleLine' => ({required Object count, required Object avgBlikTime, required Object avgPaidTime}) => 'Ost. 7 dni: ${count} ofert  |  Śr. BLIK: ${avgBlikTime}  |  Śr. płatność: ${avgPaidTime}',
			'home.statistics.errors.loading' => ({required Object error}) => 'Błąd ładowania statystyk: ${error}',
			_ => null,
		} ?? switch (path) {
			'system.loadingPublicKey' => 'Ładowanie Twojego klucza publicznego...',
			'system.errors.generic' => 'Wystąpił nieoczekiwany błąd. Proszę spróbować ponownie.',
			'system.errors.loadingTimeoutConfig' => 'Błąd ładowania konfiguracji limitu czasu.',
			'system.errors.loadingCoordinatorConfig' => 'Błąd ładowania konfiguracji koordynatora. Proszę spróbować ponownie.',
			'system.errors.noPublicKey' => 'Twój klucz publiczny nie jest dostępny. Nie można kontynuować.',
			'system.errors.internalOfferIncomplete' => 'Błąd wewnętrzny: Szczegóły oferty są niekompletne. Spróbuj ponownie.',
			'system.errors.loadingPublicKey' => 'Błąd ładowania Twojego klucza publicznego. Uruchom ponownie aplikację.',
			'system.blik.copied' => 'Kod BLIK skopiowany do schowka',
			'myOffers.title' => 'Moje oferty',
			'myOffers.empty' => 'Brak ofert.',
			'myOffers.unknownCoordinator' => 'Nieznany koordynator',
			'myOffers.menuLabel' => 'Moje oferty',
			'myOffers.filter.all' => 'Wszystkie',
			'myOffers.filter.active' => 'Aktywne',
			'myOffers.filter.completed' => 'Zakończone',
			'myOffers.filter.failed' => 'Nieudane',
			'myOffers.details.title' => 'Szczegóły oferty',
			'myOffers.details.notFound' => 'Nie znaleziono oferty.',
			'myOffers.details.amount' => 'Kwota',
			'myOffers.details.fees' => 'Opłaty',
			'myOffers.details.sats' => 'Satoshi',
			'myOffers.details.maker' => 'Maker',
			'myOffers.details.taker' => 'Taker',
			'myOffers.details.yourFee' => 'Twoja opłata',
			'myOffers.details.makerFee' => 'Opłata makera',
			'myOffers.details.takerFee' => 'Opłata takera',
			'myOffers.details.coordinator' => 'Koordynator',
			'myOffers.details.createdAt' => 'Utworzono',
			'myOffers.details.reservedAt' => 'Zarezerwowano',
			'myOffers.details.blikReceivedAt' => 'BLIK wysłany',
			'myOffers.details.makerConfirmedAt' => 'Potwierdzono',
			'myOffers.details.settledAt' => 'Rozliczono',
			'myOffers.details.takerPaidAt' => 'Taker opłacony',
			'myOffers.details.id' => 'ID oferty',
			'myOffers.details.paymentHash' => 'Hash płatności',
			'myOffers.details.holdInvoice' => 'Hold Invoice',
			'myOffers.details.continueActiveOffer' => 'Przejdź do aktywnej oferty',
			'myOffers.details.after' => ({required Object duration}) => 'po ${duration}',
			'landing.mainTitle' => 'Wymiana\n BLIK ⇄ bitcoin',
			'landing.subtitle' => 'Płać lub sprzedawaj kod BLIK za bitcoin',
			'landing.partnership' => 'współpraca',
			'landing.actions.payBlik' => 'Zapłać BLIK',
			'landing.actions.payBlikSubtitle' => 'używając bitcoin',
			'landing.actions.sellBlik' => 'Kup bitcoin',
			'landing.actions.sellBlikSubtitle' => 'używając BLIK',
			'landing.actions.howItWorks' => 'Jak to działa?',
			'faq.screenTitle' => 'FAQ',
			'faq.tooltip' => 'FAQ',
			'settings.title' => 'Ustawienia',
			'settings.offerCreation.title' => 'Tworzenie ofert',
			'settings.offerCreation.defaultCategory' => 'Domyślna kategoria',
			'settings.offerCreation.preferredCoordinator' => 'Preferowany koordynator',
			'settings.offerCreation.automaticCoordinator' => 'Najbardziej niezawodny',
			'settings.offerCreation.automaticCoordinatorDescription' => 'Wybiera koordynatora z najlepszą historią, uwzględniając Twoje własne zrealizowane oferty oraz ogólną aktywność w sieci.',
			'settings.offerCreation.cheapestCoordinator' => 'Najtańszy',
			'settings.offerCreation.cheapestCoordinatorDescription' => 'Wybiera dostępnego koordynatora z najniższą prowizją wystawiającego dla każdej oferty.',
			'settings.offerCreation.enablePremium' => 'Włącz premię cenową',
			'settings.offerCreation.enablePremiumDescription' => 'Pokaż suwak premii podczas tworzenia ofert makera.',
			'settings.offerCreation.defaultPremium' => 'Domyślna premia',
			'settings.offerCreation.defaultPremiumDisabled' => 'Włącz premię cenową, aby ustawić domyślną premię.',
			'settings.offerCreation.premiumPerCoordinatorNote' => 'Każdy koordynator ustala własną maksymalną premię, więc Twoja domyślna wartość jest ograniczona przez koordynatora użytego do oferty.',
			'settings.offerCreation.categoryOptions.shop' => 'Sklep, kawiarnia lub restauracja',
			'settings.offerCreation.categoryOptions.atm' => 'Wypłata z bankomatu',
			'settings.offerCreation.categoryOptions.online' => 'Usługa/produkt online',
			'settings.offerCreation.dialogs.selectCategory' => 'Wybierz domyślną kategorię',
			'settings.offerCreation.dialogs.selectCoordinator' => 'Wybierz preferowanego koordynatora',
			'settings.offerCreation.dialogs.premiumHint' => 'Wpisz wartość procentową, np. 1.5. Wartości są zaokrąglane do kroków co 0.5%.',
			'settings.offerCreation.dialogs.premiumHelper' => 'Stosowane po włączeniu premii cenowej i ograniczane do maksimum wybranego koordynatora.',
			'settings.display.title' => 'Wygląd',
			'settings.display.bitcoinUnit' => 'Jednostka Bitcoina',
			'settings.display.bitcoinUnitDescription' => 'Wybierz, jak kwoty bitcoina są pokazywane w całej aplikacji.',
			'settings.display.unitOptions.sats' => 'saty',
			'settings.display.unitOptions.bitcoin' => '₿ (BIP-177)',
			'notificationSettings.title' => 'Powiadomienia',
			'notificationSettings.androidOnly' => 'Powiadomienia w tle są obecnie obsługiwane tylko na Androidzie.',
			'notificationSettings.newOfferAlerts.label' => 'Alerty o nowych ofertach',
			'notificationSettings.newOfferAlerts.description' => 'Po włączeniu BitBlik będzie powiadamiać o nowych ofertach dostępnych do wzięcia od włączonych koordynatorów, gdy aplikacja działa w tle. Może to być szybsze niż zewnętrzne komunikatory.',
			'wallet.title' => 'Portfel',
			'wallet.description' => 'Zarządzaj ustawieniami portfela Lightning',
			'wallet.missingReceiving.title' => 'Wymagany portfel odbiorczy',
			'wallet.missingReceiving.message' => 'Brak skonfigurowanego portfela do odbierania. Dodaj go w ustawieniach portfela, aby przyjmować oferty.',
			'wallet.missingReceiving.openSettings' => 'Ustawienia portfela',
			'nwc.title' => 'Nostr Wallet Connect (NWC)',
			'nwc.description' => 'Połącz swój portfel Lightning przez NWC',
			'nwc.labels.connectionString' => 'Ciąg połączenia NWC',
			'nwc.labels.hint' => 'nostr+walletconnect://...',
			'nwc.labels.status' => 'Status połączenia',
			'nwc.labels.connected' => 'Połączono',
			'nwc.labels.disconnected' => 'Rozłączono',
			'nwc.labels.scanQrCode' => 'Zeskanuj kod QR z połączeniem NWC',
			'nwc.labels.balance' => 'Saldo',
			'nwc.labels.budget' => 'Budżet',
			'nwc.labels.usedBudget' => 'Wykorzystano',
			'nwc.labels.totalBudget' => 'Łącznie',
			'nwc.labels.renewsIn' => 'Odnowienie za',
			'nwc.labels.renewalPeriod' => 'Okres odnowienia',
			'nwc.labels.relay' => 'Przekaźnik',
			'nwc.labels.relays' => 'Przekaźniki',
			'nwc.prompts.enter' => 'Wprowadź swój ciąg połączenia NWC',
			'nwc.prompts.connect' => 'Połącz portfel',
			'nwc.prompts.disconnect' => 'Rozłącz',
			'nwc.prompts.confirmDisconnect' => 'Czy na pewno chcesz rozłączyć portfel NWC?',
			'nwc.prompts.pasteConnection' => 'Wklej ciąg połączenia',
			'nwc.prompts.chooseMethod' => 'Wybierz sposób połączenia portfela Lightning',
			'nwc.prompts.howToGet' => 'Nie masz jeszcze połączenia NWC? Dowiedz się, jak je uzyskać!',
			'nwc.prompts.learnMore' => 'Dowiedz się więcej o NWC',
			'nwc.actions.connectAlbyGo' => 'Połącz z Alby Go',
			'nwc.actions.connectNwc' => 'Skanuj kod QR NWC',
			'nwc.feedback.connected' => 'Portfel NWC połączony pomyślnie!',
			'nwc.feedback.disconnected' => 'Portfel NWC rozłączony',
			'nwc.feedback.connecting' => 'Łączenie z portfelem NWC...',
			'nwc.feedback.loadingWalletInfo' => 'Ładowanie informacji o portfelu...',
			'nwc.errors.connecting' => ({required Object details}) => 'Błąd połączenia z NWC: ${details}',
			'nwc.errors.disconnecting' => ({required Object details}) => 'Błąd rozłączania NWC: ${details}',
			'nwc.errors.invalid' => 'Nieprawidłowy ciąg połączenia NWC',
			'nwc.errors.required' => 'Wymagany ciąg połączenia NWC',
			'nwc.errors.loadingBalance' => 'Nie udało się załadować salda portfela',
			'nwc.errors.loadingBudget' => 'Nie udało się załadować budżetu portfela',
			'nwc.time.minutes' => ({required Object count}) => '${count}m',
			'nwc.time.hours' => ({required Object count}) => '${count}h',
			'nwc.time.days' => ({required Object count}) => '${count}d',
			'nwc.time.justNow' => 'teraz',
			'nekoManagement.title' => 'Neko',
			'relays.title' => 'Przekaźniki',
			'relays.coordinatorRelays' => 'Przekaźniki koordynatora',
			'relays.discoveryRelays' => 'Przekaźniki wykrywania',
			'relays.status.connected' => 'Połączony',
			'relays.status.connecting' => 'Łączenie',
			'relays.status.reconnecting' => 'Ponowne łączenie',
			'relays.status.disconnected' => 'Rozłączony',
			'relays.popup.title' => ({required Object connected, required Object total}) => 'Przekaźniki (${connected}/${total} połączonych)',
			'relays.popup.connectingMessage' => 'Łączenie z przekaźnikami...',
			'offerNotifications.activeService.title' => 'Oczekiwanie na nowe oferty',
			'offerNotifications.activeService.body' => 'Usługa w tle monitorująca ofert BitBlik.',
			'offerNotifications.funded.title' => 'Oferta zasilona',
			'offerNotifications.funded.body' => 'Twoja faktura hold została zaakceptowana. Oferta jest teraz aktywna.',
			'offerNotifications.reserved.title' => 'Oferta zarezerwowana',
			'offerNotifications.reserved.body' => 'Taker zarezerwował Twoją ofertę.',
			'offerNotifications.blikReady.title' => 'Kod BLIK gotowy',
			'offerNotifications.blikReady.body' => 'Twój kod BLIK jest gotowy do wyświetlenia.',
			'offerNotifications.newOffer.title' => 'Nowa oferta dostępna',
			'offerNotifications.newOffer.body' => ({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}',
			'offerNotifications.newOffer.premiumSuffix' => ({required Object percent}) => '+${percent}% premii',
			'offerNotifications.categories.shop' => 'Sklep',
			'offerNotifications.categories.atm' => 'Bankomat',
			'offerNotifications.categories.online' => 'Online',
			'offerNotifications.blikPendingReminder.title' => 'BLIK czeka na Twoją akcję',
			'offerNotifications.blikPendingReminder.body' => 'Potwierdź płatność lub oznacz kod BLIK jako nieprawidłowy.',
			'offerNotifications.takerCharged.title' => 'BLIK obciążony',
			'offerNotifications.takerCharged.body' => 'Taker zgłasza, że BLIK został obciążony. Potwierdź lub oznacz jako nieprawidłowy.',
			'offerNotifications.invalidBlik.title' => 'BLIK oznaczony jako nieprawidłowy',
			'offerNotifications.invalidBlik.body' => 'Maker oznaczył Twój kod BLIK jako nieprawidłowy.',
			'offerNotifications.takerPaid.title' => 'Płatność otrzymana',
			'offerNotifications.takerPaid.body' => 'Twoja płatność Lightning została wysłana.',
			'altstore.dialogTitle' => 'AltStore Nie Zainstalowany',
			'altstore.step1Title' => 'Pobierz i zainstaluj AltStore PAL',
			'altstore.step1Button' => 'altstore.io/download',
			'altstore.step1Warning' => 'Potrzebujesz Safari, aby zainstalować AltStore PAL!',
			'altstore.step2Title' => 'Zainstaluj BitBlik',
			'altstore.step2Button' => 'Zainstaluj BitBlik',
			'altstore.step2Fallback' => 'Nie działa? Wklej źródło do AltStore',
			_ => null,
		};
	}
}
