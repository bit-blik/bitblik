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
class TranslationsSk extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsSk({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.sk,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <sk>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsSk _root = this; // ignore: unused_field

	@override 
	TranslationsSk $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsSk(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$sk app = _Translations$app$sk._(_root);
	@override late final _Translations$common$sk common = _Translations$common$sk._(_root);
	@override late final _Translations$lightningAddress$sk lightningAddress = _Translations$lightningAddress$sk._(_root);
	@override late final _Translations$offers$sk offers = _Translations$offers$sk._(_root);
	@override late final _Translations$reservations$sk reservations = _Translations$reservations$sk._(_root);
	@override late final _Translations$exchange$sk exchange = _Translations$exchange$sk._(_root);
	@override late final _Translations$coordinator$sk coordinator = _Translations$coordinator$sk._(_root);
	@override late final _Translations$disputeChat$sk disputeChat = _Translations$disputeChat$sk._(_root);
	@override late final _Translations$receivingInvoice$sk receivingInvoice = _Translations$receivingInvoice$sk._(_root);
	@override late final _Translations$maker$sk maker = _Translations$maker$sk._(_root);
	@override late final _Translations$taker$sk taker = _Translations$taker$sk._(_root);
	@override late final _Translations$blik$sk blik = _Translations$blik$sk._(_root);
	@override late final _Translations$home$sk home = _Translations$home$sk._(_root);
	@override late final _Translations$onboarding$sk onboarding = _Translations$onboarding$sk._(_root);
	@override late final _Translations$nekoInfo$sk nekoInfo = _Translations$nekoInfo$sk._(_root);
	@override late final _Translations$generateNewKey$sk generateNewKey = _Translations$generateNewKey$sk._(_root);
	@override late final _Translations$backup$sk backup = _Translations$backup$sk._(_root);
	@override late final _Translations$restore$sk restore = _Translations$restore$sk._(_root);
	@override late final _Translations$system$sk system = _Translations$system$sk._(_root);
	@override late final _Translations$myOffers$sk myOffers = _Translations$myOffers$sk._(_root);
	@override late final _Translations$landing$sk landing = _Translations$landing$sk._(_root);
	@override late final _Translations$faq$sk faq = _Translations$faq$sk._(_root);
	@override late final _Translations$settings$sk settings = _Translations$settings$sk._(_root);
	@override late final _Translations$notificationSettings$sk notificationSettings = _Translations$notificationSettings$sk._(_root);
	@override late final _Translations$wallet$sk wallet = _Translations$wallet$sk._(_root);
	@override late final _Translations$nwc$sk nwc = _Translations$nwc$sk._(_root);
	@override late final _Translations$nekoManagement$sk nekoManagement = _Translations$nekoManagement$sk._(_root);
	@override late final _Translations$relays$sk relays = _Translations$relays$sk._(_root);
	@override late final _Translations$offerNotifications$sk offerNotifications = _Translations$offerNotifications$sk._(_root);
	@override late final _Translations$altstore$sk altstore = _Translations$altstore$sk._(_root);
}

// Path: app
class _Translations$app$sk extends Translations$app$en {
	_Translations$app$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object app}) => '${app}';
	@override String get greeting => 'Ahoj!';
	@override String get changelog => 'Zoznam zmien';
}

// Path: common
class _Translations$common$sk extends Translations$common$en {
	_Translations$common$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get code => 'kód';
	@override late final _Translations$common$buttons$sk buttons = _Translations$common$buttons$sk._(_root);
	@override late final _Translations$common$labels$sk labels = _Translations$common$labels$sk._(_root);
	@override late final _Translations$common$notifications$sk notifications = _Translations$common$notifications$sk._(_root);
	@override late final _Translations$common$clipboard$sk clipboard = _Translations$common$clipboard$sk._(_root);
	@override late final _Translations$common$actions$sk actions = _Translations$common$actions$sk._(_root);
}

// Path: lightningAddress
class _Translations$lightningAddress$sk extends Translations$lightningAddress$en {
	_Translations$lightningAddress$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$lightningAddress$labels$sk labels = _Translations$lightningAddress$labels$sk._(_root);
	@override late final _Translations$lightningAddress$prompts$sk prompts = _Translations$lightningAddress$prompts$sk._(_root);
	@override late final _Translations$lightningAddress$feedback$sk feedback = _Translations$lightningAddress$feedback$sk._(_root);
	@override late final _Translations$lightningAddress$errors$sk errors = _Translations$lightningAddress$errors$sk._(_root);
}

// Path: offers
class _Translations$offers$sk extends Translations$offers$en {
	_Translations$offers$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offers$details$sk details = _Translations$offers$details$sk._(_root);
	@override late final _Translations$offers$labels$sk labels = _Translations$offers$labels$sk._(_root);
	@override late final _Translations$offers$tooltips$sk tooltips = _Translations$offers$tooltips$sk._(_root);
	@override late final _Translations$offers$actions$sk actions = _Translations$offers$actions$sk._(_root);
	@override late final _Translations$offers$status$sk status = _Translations$offers$status$sk._(_root);
	@override late final _Translations$offers$statusMessages$sk statusMessages = _Translations$offers$statusMessages$sk._(_root);
	@override late final _Translations$offers$progress$sk progress = _Translations$offers$progress$sk._(_root);
	@override late final _Translations$offers$errors$sk errors = _Translations$offers$errors$sk._(_root);
	@override late final _Translations$offers$success$sk success = _Translations$offers$success$sk._(_root);
}

// Path: reservations
class _Translations$reservations$sk extends Translations$reservations$en {
	_Translations$reservations$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reservations$actions$sk actions = _Translations$reservations$actions$sk._(_root);
	@override late final _Translations$reservations$feedback$sk feedback = _Translations$reservations$feedback$sk._(_root);
	@override late final _Translations$reservations$errors$sk errors = _Translations$reservations$errors$sk._(_root);
}

// Path: exchange
class _Translations$exchange$sk extends Translations$exchange$en {
	_Translations$exchange$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$exchange$labels$sk labels = _Translations$exchange$labels$sk._(_root);
	@override late final _Translations$exchange$feedback$sk feedback = _Translations$exchange$feedback$sk._(_root);
	@override late final _Translations$exchange$errors$sk errors = _Translations$exchange$errors$sk._(_root);
}

// Path: coordinator
class _Translations$coordinator$sk extends Translations$coordinator$en {
	_Translations$coordinator$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinátori';
	@override late final _Translations$coordinator$info$sk info = _Translations$coordinator$info$sk._(_root);
	@override late final _Translations$coordinator$selector$sk selector = _Translations$coordinator$selector$sk._(_root);
	@override late final _Translations$coordinator$dialog$sk dialog = _Translations$coordinator$dialog$sk._(_root);
	@override late final _Translations$coordinator$details$sk details = _Translations$coordinator$details$sk._(_root);
	@override late final _Translations$coordinator$coldStart$sk coldStart = _Translations$coordinator$coldStart$sk._(_root);
	@override late final _Translations$coordinator$management$sk management = _Translations$coordinator$management$sk._(_root);
}

// Path: disputeChat
class _Translations$disputeChat$sk extends Translations$disputeChat$en {
	_Translations$disputeChat$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get viewHistory => 'Zobraziť históriu sporu';
	@override String get historyTitle => 'História sporu';
	@override String get ruledForMaker => 'Rozhodnuté v prospech Makera';
	@override String get ruledForTaker => 'Rozhodnuté v prospech Takera';
	@override String get legacyChannel => 'Starší kompatibilný kanál NIP-04';
	@override String get privateConversation => 'Súkromná konverzácia s koordinátorom';
	@override String get noMessages => 'Zatiaľ žiadne správy.';
	@override String get replyHint => 'Odpovedzte tu';
	@override String get readOnly => 'História tohto vyriešeného sporu je iba na čítanie.';
	@override late final _Translations$disputeChat$evidenceDeadline$sk evidenceDeadline = _Translations$disputeChat$evidenceDeadline$sk._(_root);
	@override late final _Translations$disputeChat$tooltips$sk tooltips = _Translations$disputeChat$tooltips$sk._(_root);
	@override late final _Translations$disputeChat$errors$sk errors = _Translations$disputeChat$errors$sk._(_root);
}

// Path: receivingInvoice
class _Translations$receivingInvoice$sk extends Translations$receivingInvoice$en {
	_Translations$receivingInvoice$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$receivingInvoice$errors$sk errors = _Translations$receivingInvoice$errors$sk._(_root);
}

// Path: maker
class _Translations$maker$sk extends Translations$maker$en {
	_Translations$maker$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$refundInvoice$sk refundInvoice = _Translations$maker$refundInvoice$sk._(_root);
	@override late final _Translations$maker$roleSelection$sk roleSelection = _Translations$maker$roleSelection$sk._(_root);
	@override late final _Translations$maker$amountForm$sk amountForm = _Translations$maker$amountForm$sk._(_root);
	@override late final _Translations$maker$payInvoice$sk payInvoice = _Translations$maker$payInvoice$sk._(_root);
	@override late final _Translations$maker$waitTaker$sk waitTaker = _Translations$maker$waitTaker$sk._(_root);
	@override late final _Translations$maker$waitForBlik$sk waitForBlik = _Translations$maker$waitForBlik$sk._(_root);
	@override late final _Translations$maker$confirmPayment$sk confirmPayment = _Translations$maker$confirmPayment$sk._(_root);
	@override late final _Translations$maker$invalidBlik$sk invalidBlik = _Translations$maker$invalidBlik$sk._(_root);
	@override late final _Translations$maker$conflict$sk conflict = _Translations$maker$conflict$sk._(_root);
	@override late final _Translations$maker$success$sk success = _Translations$maker$success$sk._(_root);
}

// Path: taker
class _Translations$taker$sk extends Translations$taker$en {
	_Translations$taker$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$taker$roleSelection$sk roleSelection = _Translations$taker$roleSelection$sk._(_root);
	@override late final _Translations$taker$progress$sk progress = _Translations$taker$progress$sk._(_root);
	@override late final _Translations$taker$submitBlik$sk submitBlik = _Translations$taker$submitBlik$sk._(_root);
	@override late final _Translations$taker$waitConfirmation$sk waitConfirmation = _Translations$taker$waitConfirmation$sk._(_root);
	@override late final _Translations$taker$paymentProcess$sk paymentProcess = _Translations$taker$paymentProcess$sk._(_root);
	@override late final _Translations$taker$paymentFailed$sk paymentFailed = _Translations$taker$paymentFailed$sk._(_root);
	@override late final _Translations$taker$paymentSuccess$sk paymentSuccess = _Translations$taker$paymentSuccess$sk._(_root);
	@override late final _Translations$taker$criticalCodeDecision$sk criticalCodeDecision = _Translations$taker$criticalCodeDecision$sk._(_root);
	@override late final _Translations$taker$invalidBlik$sk invalidBlik = _Translations$taker$invalidBlik$sk._(_root);
	@override late final _Translations$taker$conflict$sk conflict = _Translations$taker$conflict$sk._(_root);
	@override late final _Translations$taker$dispute$sk dispute = _Translations$taker$dispute$sk._(_root);
}

// Path: blik
class _Translations$blik$sk extends Translations$blik$en {
	_Translations$blik$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$blik$instructions$sk instructions = _Translations$blik$instructions$sk._(_root);
}

// Path: home
class _Translations$home$sk extends Translations$home$en {
	_Translations$home$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$home$notifications$sk notifications = _Translations$home$notifications$sk._(_root);
	@override late final _Translations$home$statistics$sk statistics = _Translations$home$statistics$sk._(_root);
}

// Path: onboarding
class _Translations$onboarding$sk extends Translations$onboarding$en {
	_Translations$onboarding$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vyber si trh';
	@override String get subtitle => 'Vyber krajinu a platobný systém, ktorý budeš používať. Môžeš to kedykoľvek zmeniť v Nastaveniach.';
}

// Path: nekoInfo
class _Translations$nekoInfo$sk extends Translations$nekoInfo$en {
	_Translations$nekoInfo$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Čo je Neko?';
	@override String description({required Object app}) => 'Tvoje Neko je tvoja identita na používanie ${app}. Skladá sa zo súkromného a verejného kľúča, aby zaručilo kryptograficky bezpečnú komunikáciu s koordinátorom.\n\nPre väčšiu anonymitu sa odporúča použiť pre každú ponuku nové, čerstvé Neko.\n\n⚠️ DÔLEŽITÉ: Tvoj súkromný kľúč je uložený iba na tvojom zariadení (na strane klienta). Je mimoriadne dôležité si súkromný kľúč zálohovať, pretože strata prístupu k nemu ti môže znemožniť riešenie sporov a obnovu tvojich prostriedkov.';
	@override String get backupWarning => 'Nezabudni si zálohovať svoje Neko';
}

// Path: generateNewKey
class _Translations$generateNewKey$sk extends Translations$generateNewKey$en {
	_Translations$generateNewKey$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nové';
	@override String get description => 'Naozaj chceš vygenerovať nové Neko? Tvoje súčasné sa navždy stratí, ak si ho nezálohoval.';
	@override late final _Translations$generateNewKey$buttons$sk buttons = _Translations$generateNewKey$buttons$sk._(_root);
	@override late final _Translations$generateNewKey$errors$sk errors = _Translations$generateNewKey$errors$sk._(_root);
	@override late final _Translations$generateNewKey$feedback$sk feedback = _Translations$generateNewKey$feedback$sk._(_root);
	@override late final _Translations$generateNewKey$tooltips$sk tooltips = _Translations$generateNewKey$tooltips$sk._(_root);
}

// Path: backup
class _Translations$backup$sk extends Translations$backup$en {
	_Translations$backup$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Záloha';
	@override String get description => 'Toto je tvoj súkromný kľúč. Zabezpečuje komunikáciu s koordinátorom. Nikdy ho nikomu neprezraď. Zálohuj ho na bezpečnom mieste, aby si predišiel problémom počas sporov.';
	@override late final _Translations$backup$feedback$sk feedback = _Translations$backup$feedback$sk._(_root);
	@override late final _Translations$backup$tooltips$sk tooltips = _Translations$backup$tooltips$sk._(_root);
}

// Path: restore
class _Translations$restore$sk extends Translations$restore$en {
	_Translations$restore$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Obnoviť';
	@override late final _Translations$restore$labels$sk labels = _Translations$restore$labels$sk._(_root);
	@override late final _Translations$restore$buttons$sk buttons = _Translations$restore$buttons$sk._(_root);
	@override late final _Translations$restore$errors$sk errors = _Translations$restore$errors$sk._(_root);
	@override late final _Translations$restore$feedback$sk feedback = _Translations$restore$feedback$sk._(_root);
	@override late final _Translations$restore$tooltips$sk tooltips = _Translations$restore$tooltips$sk._(_root);
}

// Path: system
class _Translations$system$sk extends Translations$system$en {
	_Translations$system$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get loadingPublicKey => 'Načítava sa tvoj verejný kľúč...';
	@override late final _Translations$system$errors$sk errors = _Translations$system$errors$sk._(_root);
	@override late final _Translations$system$blik$sk blik = _Translations$system$blik$sk._(_root);
}

// Path: myOffers
class _Translations$myOffers$sk extends Translations$myOffers$en {
	_Translations$myOffers$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Moje ponuky';
	@override String get empty => 'Zatiaľ žiadne ponuky.';
	@override String get unknownCoordinator => 'Neznámy koordinátor';
	@override String get menuLabel => 'Moje ponuky';
	@override late final _Translations$myOffers$filter$sk filter = _Translations$myOffers$filter$sk._(_root);
	@override late final _Translations$myOffers$details$sk details = _Translations$myOffers$details$sk._(_root);
}

// Path: landing
class _Translations$landing$sk extends Translations$landing$en {
	_Translations$landing$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String mainTitle({required Object code}) => 'Tvoj most ${code} ⇄ bitcoin';
	@override String subtitle({required Object code}) => 'Zaplať alebo predaj svoj ${code} za bitcoin';
	@override String get partnership => 'partnerstvo';
	@override late final _Translations$landing$actions$sk actions = _Translations$landing$actions$sk._(_root);
}

// Path: faq
class _Translations$faq$sk extends Translations$faq$en {
	_Translations$faq$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'FAQ';
	@override String get tooltip => 'FAQ';
}

// Path: settings
class _Translations$settings$sk extends Translations$settings$en {
	_Translations$settings$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nastavenia';
	@override late final _Translations$settings$coordinatorConsole$sk coordinatorConsole = _Translations$settings$coordinatorConsole$sk._(_root);
	@override late final _Translations$settings$offerCreation$sk offerCreation = _Translations$settings$offerCreation$sk._(_root);
	@override late final _Translations$settings$display$sk display = _Translations$settings$display$sk._(_root);
	@override late final _Translations$settings$paymentSystem$sk paymentSystem = _Translations$settings$paymentSystem$sk._(_root);
}

// Path: notificationSettings
class _Translations$notificationSettings$sk extends Translations$notificationSettings$en {
	_Translations$notificationSettings$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifikácie';
	@override String get androidOnly => 'Notifikácie na pozadí sú momentálne podporované iba na Androide.';
	@override late final _Translations$notificationSettings$newOfferAlerts$sk newOfferAlerts = _Translations$notificationSettings$newOfferAlerts$sk._(_root);
}

// Path: wallet
class _Translations$wallet$sk extends Translations$wallet$en {
	_Translations$wallet$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Peňaženka';
	@override String get description => 'Spravuj nastavenia svojej Lightning peňaženky';
	@override late final _Translations$wallet$missingReceiving$sk missingReceiving = _Translations$wallet$missingReceiving$sk._(_root);
	@override late final _Translations$wallet$details$sk details = _Translations$wallet$details$sk._(_root);
}

// Path: nwc
class _Translations$nwc$sk extends Translations$nwc$en {
	_Translations$nwc$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nostr Wallet Connect (NWC)';
	@override String get description => 'Pripoj svoju Lightning peňaženku cez NWC';
	@override late final _Translations$nwc$labels$sk labels = _Translations$nwc$labels$sk._(_root);
	@override late final _Translations$nwc$prompts$sk prompts = _Translations$nwc$prompts$sk._(_root);
	@override late final _Translations$nwc$actions$sk actions = _Translations$nwc$actions$sk._(_root);
	@override late final _Translations$nwc$feedback$sk feedback = _Translations$nwc$feedback$sk._(_root);
	@override late final _Translations$nwc$errors$sk errors = _Translations$nwc$errors$sk._(_root);
	@override late final _Translations$nwc$time$sk time = _Translations$nwc$time$sk._(_root);
}

// Path: nekoManagement
class _Translations$nekoManagement$sk extends Translations$nekoManagement$en {
	_Translations$nekoManagement$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neko';
}

// Path: relays
class _Translations$relays$sk extends Translations$relays$en {
	_Translations$relays$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Relaye';
	@override String get coordinatorRelays => 'Relaye koordinátora';
	@override String get discoveryRelays => 'Relaye na vyhľadávanie';
	@override late final _Translations$relays$status$sk status = _Translations$relays$status$sk._(_root);
	@override late final _Translations$relays$popup$sk popup = _Translations$relays$popup$sk._(_root);
}

// Path: offerNotifications
class _Translations$offerNotifications$sk extends Translations$offerNotifications$en {
	_Translations$offerNotifications$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offerNotifications$activeService$sk activeService = _Translations$offerNotifications$activeService$sk._(_root);
	@override late final _Translations$offerNotifications$funded$sk funded = _Translations$offerNotifications$funded$sk._(_root);
	@override late final _Translations$offerNotifications$reserved$sk reserved = _Translations$offerNotifications$reserved$sk._(_root);
	@override late final _Translations$offerNotifications$blikReady$sk blikReady = _Translations$offerNotifications$blikReady$sk._(_root);
	@override late final _Translations$offerNotifications$newOffer$sk newOffer = _Translations$offerNotifications$newOffer$sk._(_root);
	@override late final _Translations$offerNotifications$categories$sk categories = _Translations$offerNotifications$categories$sk._(_root);
	@override late final _Translations$offerNotifications$blikPendingReminder$sk blikPendingReminder = _Translations$offerNotifications$blikPendingReminder$sk._(_root);
	@override late final _Translations$offerNotifications$takerCharged$sk takerCharged = _Translations$offerNotifications$takerCharged$sk._(_root);
	@override late final _Translations$offerNotifications$invalidBlik$sk invalidBlik = _Translations$offerNotifications$invalidBlik$sk._(_root);
	@override late final _Translations$offerNotifications$takerPaid$sk takerPaid = _Translations$offerNotifications$takerPaid$sk._(_root);
}

// Path: altstore
class _Translations$altstore$sk extends Translations$altstore$en {
	_Translations$altstore$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'AltStore nie je nainštalovaný';
	@override String get step1Title => 'Stiahni a nainštaluj AltStore PAL';
	@override String get step1Button => 'altstore.io/download';
	@override String get step1Warning => 'Na inštaláciu AltStore PAL potrebuješ Safari!';
	@override String step2Title({required Object app}) => 'Nainštaluj ${app}';
	@override String step2Button({required Object app}) => 'Nainštalovať ${app}';
	@override String get step2Fallback => 'Stále to nefunguje? Vlož zdroj do AltStore';
}

// Path: common.buttons
class _Translations$common$buttons$sk extends Translations$common$buttons$en {
	_Translations$common$buttons$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Zrušiť';
	@override String get save => 'Uložiť';
	@override String get done => 'Hotovo';
	@override String get retry => 'Skúsiť znova';
	@override String get goHome => 'Domov';
	@override String get saveAndContinue => 'Uložiť a pokračovať';
	@override String get reveal => 'Zobraziť';
	@override String get hide => 'Skryť';
	@override String get copy => 'Kopírovať';
	@override String get close => 'Zavrieť';
	@override String get restore => 'Obnoviť';
	@override String get faq => 'FAQ';
}

// Path: common.labels
class _Translations$common$labels$sk extends Translations$common$labels$en {
	_Translations$common$labels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String amount({required Object currency}) => 'Suma (${currency})';
	@override String status({required Object status}) => 'Stav: ${status}';
	@override String role({required Object role}) => 'Rola: ${role}';
}

// Path: common.notifications
class _Translations$common$notifications$sk extends Translations$common$notifications$en {
	_Translations$common$notifications$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get success => 'Hotovo';
	@override String get error => 'Chyba';
	@override String get loading => 'Načítava sa...';
}

// Path: common.clipboard
class _Translations$common$clipboard$sk extends Translations$common$clipboard$en {
	_Translations$common$clipboard$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get copyToClipboard => 'Kopírovať do schránky';
	@override String get pasteFromClipboard => 'Vložiť zo schránky';
	@override String get copied => 'Skopírované do schránky!';
}

// Path: common.actions
class _Translations$common$actions$sk extends Translations$common$actions$en {
	_Translations$common$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get cancelAndReturnToOffers => 'Zrušiť a vrátiť sa k ponukám';
	@override String get cancelAndReturnHome => 'Zrušiť a vrátiť sa domov';
}

// Path: lightningAddress.labels
class _Translations$lightningAddress$labels$sk extends Translations$lightningAddress$labels$en {
	_Translations$lightningAddress$labels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get address => 'Lightning adresa (LNURL)';
	@override String get hint => 'pouzivatel@domena.com';
	@override String short({required Object address}) => 'Lightning adresa: ${address}';
	@override String get receivingAddress => 'Tvoja adresa na prijímanie:';
}

// Path: lightningAddress.prompts
class _Translations$lightningAddress$prompts$sk extends Translations$lightningAddress$prompts$en {
	_Translations$lightningAddress$prompts$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Zadaj svoju Lightning adresu a pokračuj';
	@override String get edit => 'Upraviť';
	@override String get invalid => 'Zadaj platnú Lightning adresu';
	@override String get required => 'Lightning adresa je povinná.';
	@override String get enterToTakeOffer => 'Na prijatie ponuky musíš nastaviť Lightning adresu.';
	@override String get missing => 'Chýba Lightning adresa. Pridaj ju, aby si mohol prijímať ponuky.';
	@override String get add => 'Pridať';
	@override String get delete => 'Odstrániť';
	@override String get confirmDelete => 'Naozaj chceš odstrániť svoju Lightning adresu?';
	@override String get howToGet => 'Ešte nemáš Lightning adresu? Zisti, ako ju získať!';
	@override String get learnMore => 'Zisti viac o Lightning adrese';
}

// Path: lightningAddress.feedback
class _Translations$lightningAddress$feedback$sk extends Translations$lightningAddress$feedback$en {
	_Translations$lightningAddress$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Lightning adresa uložená!';
	@override String get updated => 'Lightning adresa aktualizovaná!';
	@override String get valid => 'Platná Lightning adresa';
}

// Path: lightningAddress.errors
class _Translations$lightningAddress$errors$sk extends Translations$lightningAddress$errors$en {
	_Translations$lightningAddress$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String saving({required Object details}) => 'Chyba pri ukladaní adresy: ${details}';
	@override String loading({required Object details}) => 'Chyba pri načítaní Lightning adresy: ${details}';
}

// Path: offers.details
class _Translations$offers$details$sk extends Translations$offers$details$en {
	_Translations$offers$details$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get yourOffer => 'Tvoja ponuka:';
	@override String get selectedOffer => 'Ponuka:';
	@override String get activeOffer => 'Máš aktívnu ponuku:';
	@override String get finishedOffers => 'Dokončené ponuky';
	@override String get noAvailable => 'Žiadne dostupné ponuky.';
	@override String noAvailableTip({required Object app}) => 'Tip: zdieľaj ${app} vo svojej komunite a medzi priateľmi, aby si zvýšil počet objednávok v ${app}.';
	@override String get noSuccessfulTrades => 'Žiadne úspešné obchody.';
	@override String get loadingDetails => 'Načítavajú sa detaily ponuky...';
	@override String amount({required Object amount}) => 'Suma: ${amount} satoshi';
	@override String amountWithCurrency({required Object amount, required Object currency}) => '${amount} ${currency}';
	@override String makerFee({required Object fee}) => 'Poplatok: ${fee} sats';
	@override String takerFee({required Object fee}) => 'Poplatok: ${fee} sats';
	@override String subtitle({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (poplatok) satoshi\nStav: ${status}';
	@override String subtitleWithDate({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (poplatok) satoshi\nStav: ${status}\nZaplatené: ${date}';
	@override String activeSubtitle({required Object status, required Object amount}) => 'Stav: ${status}\nSuma: ${amount} satoshi';
	@override String id({required Object id}) => 'ID ponuky: ${id}...';
	@override String created({required Object dateTime}) => 'Vytvorené: ${dateTime}';
	@override String takenAfter({required Object duration}) => 'Prijaté po: ${duration}';
	@override String paidAfter({required Object duration}) => 'Zaplatené po: ${duration}';
	@override String get exchangeRate => 'Výmenný kurz';
	@override String get amountLabel => 'Suma';
	@override String get makerFeeLabel => 'Poplatok predávajúceho';
	@override String get takerFeeLabel => 'Poplatok kupujúceho';
	@override String get feeLabel => 'Poplatok';
	@override String get statusLabel => 'Stav';
	@override String get youllReceive => 'Dostaneš';
	@override String get coordinator => 'Koordinátor';
	@override String get categoryLabel => 'Kategória';
	@override late final _Translations$offers$details$categories$sk categories = _Translations$offers$details$categories$sk._(_root);
	@override late final _Translations$offers$details$consents$sk consents = _Translations$offers$details$consents$sk._(_root);
}

// Path: offers.labels
class _Translations$offers$labels$sk extends Translations$offers$labels$en {
	_Translations$offers$labels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get premium => 'Prémia';
	@override String premiumBadge({required Object percent}) => '+${percent}% prémia';
}

// Path: offers.tooltips
class _Translations$offers$tooltips$sk extends Translations$offers$tooltips$en {
	_Translations$offers$tooltips$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String takerFeeInfo({required Object feePercent}) => 'Koordinátor si účtuje ${feePercent}% poplatok kupujúceho. Ten zahŕňa smerovacie poplatky Lightning a odpočíta sa zo sumy, ktorú dostaneš.';
	@override String get premiumInfoTaker => 'Prémia znamená, že táto ponuka je ocenená nad trhovou cenou. Za rovnakú sumu vo fiate predávajúci uzamkne menej sats v hold faktúre, takže platíš nad trh a dostaneš menej sats než pri trhovom kurze. Maximálnu prémiu určuje koordinátor.';
	@override String get ratesFetchedAt => 'Načítané o';
	@override String get ratesSources => 'Zdroje priem. kurzu';
}

// Path: offers.actions
class _Translations$offers$actions$sk extends Translations$offers$actions$en {
	_Translations$offers$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get take => 'PRIJAŤ';
	@override String get takeOffer => 'Prijať ponuku';
	@override String resume({required Object code}) => 'ZADAŤ ${code}';
	@override String get cancel => 'Zrušiť ponuku';
	@override String get view => 'Zobraziť detaily';
}

// Path: offers.status
class _Translations$offers$status$sk extends Translations$offers$status$en {
	_Translations$offers$status$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get created => 'Vytvorená';
	@override String get funded => 'Financovaná';
	@override String get expired => 'Vypršaná';
	@override String get cancelled => 'Zrušená';
	@override String get reserved => 'Rezervovaná';
	@override String blikReceived({required Object code}) => '${code} odoslaný';
	@override String blikSentToMaker({required Object code}) => '${code} prijatý';
	@override String expiredBlik({required Object code}) => '${code} vypršal';
	@override String expiredSentBlik({required Object code}) => '${code} vypršal';
	@override String get takerCharged => 'Kupujúci zaťažený';
	@override String invalidBlik({required Object code}) => 'Neplatný ${code}';
	@override String get conflict => 'Konflikt';
	@override String get dispute => 'Spor';
	@override String get refundedMaker => 'Makerovi boli vrátené prostriedky';
	@override String get refundingMaker => 'Vrátenie platby makerovi';
	@override String get makerConfirmed => 'Potvrdená';
	@override String get settled => 'Vyrovnaná';
	@override String get payingTaker => 'Platí sa kupujúcemu';
	@override String get takerPaymentFailed => 'Platba kupujúcemu zlyhala';
	@override String get takerPaid => 'Kupujúci zaplatený';
	@override String get unknownStatus => 'Neznámy';
}

// Path: offers.statusMessages
class _Translations$offers$statusMessages$sk extends Translations$offers$statusMessages$en {
	_Translations$offers$statusMessages$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get reserved => 'Ponuku rezervoval kupujúci!';
	@override String get cancelled => 'Ponuka úspešne zrušená.';
	@override String get cancelledOrExpired => 'Ponuka bola zrušená alebo vypršala.';
	@override String noLongerAvailable({required Object status}) => 'Ponuka už nie je dostupná (Stav: ${status}).';
}

// Path: offers.progress
class _Translations$offers$progress$sk extends Translations$offers$progress$en {
	_Translations$offers$progress$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String waitingForTaker({required Object time}) => 'Čaká sa na kupujúceho: ${time}';
	@override String reserved({required Object seconds}) => 'Rezervované: ostáva ${seconds} s';
	@override String confirming({required Object seconds}) => 'Potvrdzuje sa: ostáva ${seconds} s';
}

// Path: offers.errors
class _Translations$offers$errors$sk extends Translations$offers$errors$en {
	_Translations$offers$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String loading({required Object details}) => 'Chyba pri načítaní ponúk: ${details}';
	@override String loadingDetails({required Object details}) => 'Chyba pri načítaní detailov ponuky: ${details}';
	@override String get detailsMissing => 'Chyba: Detaily ponuky chýbajú alebo sú neplatné.';
	@override String get detailsNotLoaded => 'Nepodarilo sa načítať detaily ponuky.';
	@override String get notFound => 'Chyba: Ponuka sa nenašla.';
	@override String get unexpectedState => 'Chyba: Ponuka je v neočakávanom stave.';
	@override String unexpectedStateWithStatus({required Object status}) => 'Ponuka je v neočakávanom stave (${status}). Skús to znova alebo kontaktuj podporu.';
	@override String get invalidStatus => 'Ponuka má neplatný stav.';
	@override String get couldNotIdentify => 'Chyba: Nepodarilo sa identifikovať ponuku na zrušenie.';
	@override String cannotBeCancelled({required Object status}) => 'Ponuku nie je možné zrušiť v aktuálnom stave (${status}).';
	@override String failedToCancel({required Object details}) => 'Nepodarilo sa zrušiť ponuku: ${details}';
	@override String get activeDetailsLost => 'Chyba: Stratili sa detaily aktívnej ponuky.';
	@override String checkingActive({required Object details}) => 'Chyba pri kontrole aktívnych ponúk: ${details}';
	@override String cannotResume({required Object status}) => 'Ponuku nie je možné obnoviť v stave: ${status}';
	@override String cannotResumeTaker({required Object status}) => 'Ponuku kupujúceho nie je možné obnoviť v stave: ${status}';
	@override String resuming({required Object details}) => 'Chyba pri obnovovaní ponuky: ${details}';
	@override String get makerPublicKeyNotFound => 'Verejný kľúč predávajúceho sa nenašiel';
	@override String get takerPublicKeyNotFound => 'Verejný kľúč kupujúceho sa nenašiel.';
	@override String get atmConsentRequired => 'Pred prijatím tejto ponuky prijmi podmienku dodatočného poplatku bankomatu.';
	@override String get ecommerceConsentRequired => 'Pred prijatím tejto ponuky prijmi podmienku vrátenia peňazí pri e-commerce.';
	@override String get cannotTakeOwnOffer => 'Nemôžeš prijať vlastnú ponuku.';
}

// Path: offers.success
class _Translations$offers$success$sk extends Translations$offers$success$en {
	_Translations$offers$success$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ponuka dokončená';
	@override String get headline => 'Platba potvrdená!';
	@override String get subtitle => 'Kupujúcemu sa teraz zaplatí.';
	@override String get detailsTitle => 'Detaily ponuky:';
	@override String duration({required Object time}) => 'Dokončenie ponuky trvalo ${time}.';
}

// Path: reservations.actions
class _Translations$reservations$actions$sk extends Translations$reservations$actions$en {
	_Translations$reservations$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Zrušiť rezerváciu';
}

// Path: reservations.feedback
class _Translations$reservations$feedback$sk extends Translations$reservations$feedback$en {
	_Translations$reservations$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get cancelled => 'Rezervácia zrušená.';
}

// Path: reservations.errors
class _Translations$reservations$errors$sk extends Translations$reservations$errors$en {
	_Translations$reservations$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String cancelling({required Object error}) => 'Nepodarilo sa zrušiť rezerváciu: ${error}';
	@override String failedToReserve({required Object details}) => 'Nepodarilo sa rezervovať ponuku: ${details}';
	@override String get failedNoTimestamp => 'Nepodarilo sa rezervovať ponuku (chýba časová značka).';
	@override String get timestampMissing => 'Chýba časová značka rezervácie ponuky.';
	@override String notReserved({required Object status}) => 'Ponuka už nie je v rezervovanom stave (${status}).';
}

// Path: exchange.labels
class _Translations$exchange$labels$sk extends Translations$exchange$labels$en {
	_Translations$exchange$labels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String enterAmount({required Object currency}) => 'Zadaj sumu (${currency}) na zaplatenie:';
	@override String equivalent({required Object sats}) => '≈ ${sats} satoshi';
	@override String rate({required Object rate, required Object currency}) => 'Výmenný kurz ≈ ${rate} ${currency}/BTC';
}

// Path: exchange.feedback
class _Translations$exchange$feedback$sk extends Translations$exchange$feedback$en {
	_Translations$exchange$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get fetching => 'Načítava sa výmenný kurz...';
}

// Path: exchange.errors
class _Translations$exchange$errors$sk extends Translations$exchange$errors$en {
	_Translations$exchange$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get fetchingRate => 'Nepodarilo sa načítať výmenný kurz.';
	@override String get invalidFormat => 'Neplatný formát čísla';
	@override String get mustBePositive => 'Suma musí byť kladná';
	@override String get invalidFeePercentage => 'Neplatné percento poplatku';
	@override String tooLowFiat({required Object minAmount, required Object currency}) => 'Suma je príliš nízka. Minimum je ${minAmount} ${currency}.';
	@override String tooHighFiat({required Object maxAmount, required Object currency}) => 'Suma je príliš vysoká. Maximum je ${maxAmount} ${currency}.';
	@override String atmNotDispensable({required Object notes}) => 'Bankomat nedokáže vydať túto sumu. Použi kombináciu bankoviek: ${notes}.';
	@override String atmOverBankLimit({required Object bank, required Object limit, required Object currency}) => '${bank} vydá na jeden výber najviac ${limit} ${currency}.';
}

// Path: coordinator.info
class _Translations$coordinator$info$sk extends Translations$coordinator$info$en {
	_Translations$coordinator$info$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get fee => 'poplatok';
	@override String rangeDisplay({required Object minAmount, required Object maxAmount, required Object currency}) => 'Suma: ${minAmount}-${maxAmount} ${currency}';
	@override String feeDisplay({required Object fee}) => '${fee}% poplatok';
}

// Path: coordinator.selector
class _Translations$coordinator$selector$sk extends Translations$coordinator$selector$en {
	_Translations$coordinator$selector$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Načítavajú sa koordinátori...';
	@override String get errorLoading => 'Chyba pri načítaní koordinátorov';
	@override String get choose => 'Vyber koordinátora';
	@override String get viewNostrProfile => 'Zobraziť Nostr profil';
	@override String get unresponsive => 'Tento koordinátor neodpovedá';
	@override String get waitingResponse => 'Čaká sa na odpoveď koordinátora';
	@override String get termsAccept => 'Súhlasím s ';
	@override String get termsOfUsage => 'podmienkami používania';
}

// Path: coordinator.dialog
class _Translations$coordinator$dialog$sk extends Translations$coordinator$dialog$en {
	_Translations$coordinator$dialog$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get makerFee => 'Poplatok predávajúceho';
	@override String get takerFee => 'Poplatok kupujúceho';
	@override String get amountRange => 'Rozsah sumy';
	@override String get reservationTime => 'Čas rezervácie';
	@override String get currencies => 'Meny';
	@override String get viewTerms => 'Zobraziť podmienky';
}

// Path: coordinator.details
class _Translations$coordinator$details$sk extends Translations$coordinator$details$en {
	_Translations$coordinator$details$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinátor';
	@override String get relaysInUse => 'Používané relaye';
	@override String get relaysInUseHint => 'Všetka komunikácia s týmto koordinátorom prebieha cez tieto relaye (z jeho zoznamu NIP-65).';
	@override String get noRelays => 'Zatiaľ nie sú známe žiadne relaye';
	@override String get makerFee => 'Poplatok predávajúceho';
	@override String get takerFee => 'Poplatok kupujúceho';
	@override String get amountRange => 'Rozsah sumy';
	@override String get maxPremium => 'Max. prémia';
	@override String get maxPremiumInfoTitle => 'Prémia';
	@override String get maxPremiumInfoBody => 'Prémia je voliteľná prirážka nad trhový kurz, ktorú môže predávajúci nastaviť na ponuke. S prémiou predávajúci uzamkne menej sats za rovnakú sumu vo fiate, takže kupujúci platí nad trh a predávajúci si ponechá rozdiel. Táto hodnota je najvyššia prémia, ktorú tento koordinátor na svojich ponukách povoľuje.';
	@override String get reservationTime => 'Čas rezervácie';
	@override String get currencies => 'Meny';
	@override String get paymentSystem => 'Platobný systém';
	@override String get version => 'Verzia';
	@override String get yourOffers => 'Tvoje ponuky';
	@override String get successfulOffers => 'Úspešné ponuky (30d)';
	@override String get statusOnline => 'Online';
	@override String get statusOffline => 'Offline';
	@override String get statusUnknown => 'Neznámy';
	@override String get openNostrProfile => 'Otvoriť Nostr profil';
	@override String get termsOfUsage => 'Podmienky používania';
}

// Path: coordinator.coldStart
class _Translations$coordinator$coldStart$sk extends Translations$coordinator$coldStart$en {
	_Translations$coordinator$coldStart$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vyhľadávanie koordinátorov';
	@override String body({required Object app}) => '${app} hľadá verejných koordinátorov, kontroluje, ktorí sú dostupní, a zapne pre teba malú predvolenú skupinu.';
	@override String get settingsHint => 'Zapnutých koordinátorov môžeš neskôr zmeniť v Nastaveniach.';
	@override String get ok => 'OK';
	@override String get discovered => 'Nájdení';
	@override String get candidates => 'Kandidáti';
	@override String get enabled => 'Zapnutí';
	@override String get recordsTitle => 'Aktuálni koordinátori';
	@override String get recordEnabled => 'Zapnutý';
	@override String get recordHealthyCandidate => 'Zdravý kandidát';
	@override String get recordOfflineCandidate => 'Kandidát offline';
	@override String get recordChecking => 'Kontroluje sa';
	@override String get recordDiscovered => 'Nájdený';
	@override late final _Translations$coordinator$coldStart$phases$sk phases = _Translations$coordinator$coldStart$phases$sk._(_root);
}

// Path: coordinator.management
class _Translations$coordinator$management$sk extends Translations$coordinator$management$en {
	_Translations$coordinator$management$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Správa koordinátorov';
	@override String get availableCoordinators => 'Koordinátori';
	@override String get noCoordinators => 'Zatiaľ neboli nájdení žiadni koordinátori.';
	@override String get online => 'Online';
	@override String get unknownOffline => 'Neznámy/Offline';
	@override String get openNostrProfile => 'Otvoriť Nostr profil';
	@override String get enable => 'Zapnúť';
	@override String get remove => 'Odstrániť';
	@override String get addCustomWhitelist => 'Pridať koordinátora';
	@override String get addCustomWhitelistHint => 'npub1...';
	@override String get add => 'Pridať';
	@override String get coordinatorDisabled => 'Koordinátor vypnutý';
	@override String get coordinatorEnabled => 'Koordinátor zapnutý';
	@override String get coordinatorAdded => 'Koordinátor pridaný do vlastného zoznamu';
	@override String get coordinatorRemoved => 'Koordinátor odstránený z vlastného zoznamu';
	@override String get coordinatorAddInfoUnavailable => 'Na relayoch sa nenašli žiadne informácie o koordinátorovi. Koordinátor nebol pridaný.';
	@override String get pleaseEnterNpub => 'Zadaj npub';
	@override String get error => 'Chyba';
	@override String get metricYourOffers => 'Tvoje ponuky';
	@override String get metricYourOffersTooltip => 'Počet ponúk, ktoré si úspešne dokončil s týmto koordinátorom.';
	@override String get metricNetworkOffers => 'Ponuky (30d)';
	@override String get metricNetworkOffersTooltip => 'Úspešné ponuky vyrovnané týmto koordinátorom naprieč všetkými používateľmi za posledných 30 dní.';
}

// Path: disputeChat.evidenceDeadline
class _Translations$disputeChat$evidenceDeadline$sk extends Translations$disputeChat$evidenceDeadline$en {
	_Translations$disputeChat$evidenceDeadline$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lehota na predloženie dôkazov';
	@override String remaining({required Object time}) => 'Predložte dôkazy podporujúce vaše tvrdenie do ${time}. Po uplynutí lehoty môže koordinátor rozhodnúť v prospech protistrany podľa dostupných dôkazov.';
	@override String get expired => 'Lehota na predloženie dôkazov uplynula. Koordinátor môže teraz rozhodnúť podľa dostupných dôkazov.';
	@override String period({required Object time}) => 'Koordinátor poskytuje na dôkazy najviac ${time} od otvorenia sporu. Odpočítavanie sa začne, keď bude dostupný čas otvorenia sporu.';
}

// Path: disputeChat.tooltips
class _Translations$disputeChat$tooltips$sk extends Translations$disputeChat$tooltips$en {
	_Translations$disputeChat$tooltips$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get refresh => 'Obnoviť správy';
	@override String get attachEvidence => 'Priložiť doklad o platbe';
	@override String get send => 'Odoslať správu';
}

// Path: disputeChat.errors
class _Translations$disputeChat$errors$sk extends Translations$disputeChat$errors$en {
	_Translations$disputeChat$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get accountNotReady => 'Súkromné správy budú dostupné, keď bude váš účet Nostr pripravený.';
	@override String get subscriptionFailed => 'Pripojenie súkromných správ zlyhalo. Obnovte konverzáciu.';
	@override String get decryptFailed => 'Súkromnú správu sa nepodarilo dešifrovať.';
	@override String get operationFailed => 'Operácia súkromných správ zlyhala. Skúste to znova.';
	@override String get nostrNotInitialized => 'Nostr nie je inicializovaný.';
	@override String get attachmentsRequireNip17 => 'Prílohy sú dostupné iba v kanáli NIP-17.';
}

// Path: receivingInvoice.errors
class _Translations$receivingInvoice$errors$sk extends Translations$receivingInvoice$errors$en {
	_Translations$receivingInvoice$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get walletUnavailable => 'Služba peňaženky nie je dostupná.';
	@override String get noBolt11 => 'Peňaženka nevrátila BOLT11 faktúru.';
}

// Path: maker.refundInvoice
class _Translations$maker$refundInvoice$sk extends Translations$maker$refundInvoice$en {
	_Translations$maker$refundInvoice$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Koordinátor rozhodol vo váš prospech';
	@override String instructions({required Object amount}) => 'Vyberte prijímaciu peňaženku alebo vložte Lightning faktúru na presnú sumu ${amount} pre vrátenie platby.';
	@override String get invoiceLabel => 'Faktúra na vrátenie presnej sumy';
	@override String get submit => 'Odoslať faktúru na vrátenie platby';
	@override String get addWallet => 'Pridať novú peňaženku';
	@override String get noReceivingWallet => 'Nie je nastavená žiadna prijímacia peňaženka. Pridajte ju alebo vložte faktúru z inej peňaženky.';
	@override String get paymentFailed => 'Predchádzajúci pokus o vrátenie platby zlyhal. Vyberte inú peňaženku alebo odošlite novú faktúru.';
	@override String submitFailed({required Object details}) => 'Faktúru na vrátenie platby sa nepodarilo odoslať: ${details}';
	@override late final _Translations$maker$refundInvoice$errors$sk errors = _Translations$maker$refundInvoice$errors$sk._(_root);
}

// Path: maker.roleSelection
class _Translations$maker$roleSelection$sk extends Translations$maker$roleSelection$en {
	_Translations$maker$roleSelection$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get button => 'ZAPLATIŤ cez Lightning';
}

// Path: maker.amountForm
class _Translations$maker$amountForm$sk extends Translations$maker$amountForm$en {
	_Translations$maker$amountForm$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$amountForm$progress$sk progress = _Translations$maker$amountForm$progress$sk._(_root);
	@override late final _Translations$maker$amountForm$labels$sk labels = _Translations$maker$amountForm$labels$sk._(_root);
	@override late final _Translations$maker$amountForm$actions$sk actions = _Translations$maker$amountForm$actions$sk._(_root);
	@override late final _Translations$maker$amountForm$bank$sk bank = _Translations$maker$amountForm$bank$sk._(_root);
	@override late final _Translations$maker$amountForm$tooltips$sk tooltips = _Translations$maker$amountForm$tooltips$sk._(_root);
	@override late final _Translations$maker$amountForm$category$sk category = _Translations$maker$amountForm$category$sk._(_root);
	@override late final _Translations$maker$amountForm$onboarding$sk onboarding = _Translations$maker$amountForm$onboarding$sk._(_root);
	@override late final _Translations$maker$amountForm$errors$sk errors = _Translations$maker$amountForm$errors$sk._(_root);
}

// Path: maker.payInvoice
class _Translations$maker$payInvoice$sk extends Translations$maker$payInvoice$en {
	_Translations$maker$payInvoice$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zaplať túto hold faktúru:';
	@override late final _Translations$maker$payInvoice$actions$sk actions = _Translations$maker$payInvoice$actions$sk._(_root);
	@override late final _Translations$maker$payInvoice$feedback$sk feedback = _Translations$maker$payInvoice$feedback$sk._(_root);
	@override late final _Translations$maker$payInvoice$errors$sk errors = _Translations$maker$payInvoice$errors$sk._(_root);
	@override late final _Translations$maker$payInvoice$budgetWarning$sk budgetWarning = _Translations$maker$payInvoice$budgetWarning$sk._(_root);
}

// Path: maker.waitTaker
class _Translations$maker$waitTaker$sk extends Translations$maker$waitTaker$en {
	_Translations$maker$waitTaker$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get message => 'Čaká sa, kým kupujúci rezervuje tvoju ponuku...';
	@override String progressLabel({required Object time}) => 'Čaká sa na kupujúceho: ${time}';
	@override String get errorActiveOfferDetailsLost => 'Chyba: Stratili sa detaily aktívnej ponuky.';
	@override String errorFailedToRetrieveBlik({required Object code}) => 'Chyba: Nepodarilo sa načítať ${code}.';
	@override String errorRetrievingBlik({required Object code, required Object details}) => 'Chyba pri načítaní ${code}: ${details}';
	@override String offerNoLongerAvailable({required Object status}) => 'Ponuka už nie je dostupná (Stav: ${status}).';
	@override String get errorCouldNotIdentifyOffer => 'Chyba: Nepodarilo sa identifikovať ponuku na zrušenie.';
	@override String offerCannotBeCancelled({required Object status}) => 'Ponuku nie je možné zrušiť v aktuálnom stave (${status}).';
	@override String get offerCancelledSuccessfully => 'Ponuka úspešne zrušená.';
	@override String failedToCancelOffer({required Object details}) => 'Nepodarilo sa zrušiť ponuku: ${details}';
	@override String get offerExpiredTitle => 'Ponuka vypršala';
	@override String get offerExpiredMessage => 'Žiadny kupujúci nerezervoval tvoju ponuku načas.';
	@override String get recreateOffer => 'Nová ponuka — rovnaká suma';
}

// Path: maker.waitForBlik
class _Translations$maker$waitForBlik$sk extends Translations$maker$waitForBlik$en {
	_Translations$maker$waitForBlik$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Čaká sa na ${code}';
	@override String get messageInfo => 'Kupujúci rezervoval ponuku!';
	@override String messageWaiting({required Object code}) => 'Čaká sa na poskytnutie ${code}...';
	@override String progressLabel({required Object seconds}) => 'Rezervované: ostáva ${seconds} s';
}

// Path: maker.confirmPayment
class _Translations$maker$confirmPayment$sk extends Translations$maker$confirmPayment$en {
	_Translations$maker$confirmPayment$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} prijatý!';
	@override String retrieving({required Object code}) => 'Načítava sa ${code}...';
	@override String get instructions => 'Zadaj tento kód do platobného terminálu. Keď kupujúci potvrdí platbu vo svojej bankovej aplikácii a platba je úspešná, stlač Potvrdiť nižšie.';
	@override String instruction1({required Object code}) => 'Zadaj kód do platobnej výzvy ${code}.';
	@override String get instruction2 => 'Počkaj, kým kupujúci potvrdí platbu vo svojej aplikácii.';
	@override String get instruction3 => 'Keď je platba úspešná, stlač Potvrdiť nižšie:';
	@override String mbwayAtmInstructions({required Object amount, required Object minutes}) => 'Ak chceš vybrať ${amount} €, choď k najbližšiemu bankomatu MULTIBANCO, stlač zelené tlačidlo a vyber možnosť "Výber hotovosti" ("Levantar Dinheiro"). Zadaj kód. Tento kód je platný ${minutes} minút.';
	@override String cardlessAtmInstructions({required Object amount, required Object currency, required Object bank, required Object minutes}) => 'Ak chceš vybrať ${amount} ${currency}, choď k bankomatu ${bank}, spusti výber bez karty / cez mobil a zadaj kód — karta nie je potrebná. Kód je platný ${minutes} minút.';
	@override String findAtms({required Object bank}) => 'Nájdi bankomaty ${bank} na mape';
	@override String takerChargedWarning({required Object code}) => 'Kupujúci nahlásil, že platba ${code} bola strhnutá z jeho bankového účtu. Ak toto označíš ako neplatné, spôsobí to konflikt.';
	@override String autoConfirmInfo({required Object code}) => 'Ak neoznačíš ${code} ako neplatný, platba sa po uplynutí tohto času automaticky potvrdí a kupujúcemu sa zaplatí.';
	@override String autoConfirmCountdown({required Object time}) => 'Automatické potvrdenie o ${time}';
	@override String expiredTitle({required Object code}) => 'Kód ${code} vypršal';
	@override String expiredWarning({required Object code}) => '${code} vypršal. Musíš manuálne potvrdiť stav platby:';
	@override String expiredInstruction1({required Object code}) => 'Ak bola platba ${code} úspešná a dokončil si nákup, klikni nižšie na "Potvrdiť úspešnú platbu".';
	@override String expiredInstruction2({required Object code}) => 'Ak platba ${code} zlyhala alebo nebola dokončená, klikni nižšie na "Neplatný kód ${code}".';
	@override late final _Translations$maker$confirmPayment$actions$sk actions = _Translations$maker$confirmPayment$actions$sk._(_root);
	@override late final _Translations$maker$confirmPayment$confirmDialog$sk confirmDialog = _Translations$maker$confirmPayment$confirmDialog$sk._(_root);
	@override late final _Translations$maker$confirmPayment$invalidBlikDisputeDialog$sk invalidBlikDisputeDialog = _Translations$maker$confirmPayment$invalidBlikDisputeDialog$sk._(_root);
	@override late final _Translations$maker$confirmPayment$feedback$sk feedback = _Translations$maker$confirmPayment$feedback$sk._(_root);
	@override late final _Translations$maker$confirmPayment$errors$sk errors = _Translations$maker$confirmPayment$errors$sk._(_root);
}

// Path: maker.invalidBlik
class _Translations$maker$invalidBlik$sk extends Translations$maker$invalidBlik$en {
	_Translations$maker$invalidBlik$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Neplatný kód ${code}';
	@override String info({required Object code}) => 'Označil si ${code} ako neplatný. Čaká sa, kým kupujúci poskytne nový kód alebo začne spor.';
}

// Path: maker.conflict
class _Translations$maker$conflict$sk extends Translations$maker$conflict$en {
	_Translations$maker$conflict$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konflikt ponuky';
	@override String get headline => 'Nahlásený konflikt ponuky';
	@override String body({required Object code}) => 'Označil si ${code} ako neplatný, ale kupujúci nahlásil konflikt, čím naznačuje, že podľa neho bola platba úspešná.';
	@override String get instructions => 'Potvrď výsledok pred vypršaním časovača. Ak bola platba úspešná, potvrď ju, aby mohol byť kupujúci vyplatený. Ak zlyhala, otvor spor. Ak nič neurobíš, automaticky sa otvorí formálny spor.';
	@override String timeoutLabel({required Object time}) => 'Formálny spor sa automaticky otvorí o ${time}';
	@override late final _Translations$maker$conflict$actions$sk actions = _Translations$maker$conflict$actions$sk._(_root);
	@override late final _Translations$maker$conflict$disputeDialog$sk disputeDialog = _Translations$maker$conflict$disputeDialog$sk._(_root);
	@override late final _Translations$maker$conflict$feedback$sk feedback = _Translations$maker$conflict$feedback$sk._(_root);
	@override late final _Translations$maker$conflict$errors$sk errors = _Translations$maker$conflict$errors$sk._(_root);
	@override late final _Translations$maker$conflict$nostrContact$sk nostrContact = _Translations$maker$conflict$nostrContact$sk._(_root);
}

// Path: maker.success
class _Translations$maker$success$sk extends Translations$maker$success$en {
	_Translations$maker$success$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ponuka dokončená';
	@override String get headline => 'Platba potvrdená!';
	@override String get subtitle => 'Kupujúcemu sa teraz zaplatí.';
	@override String get detailsTitle => 'Detaily ponuky:';
	@override String duration({required Object time}) => 'Ponuka trvala ${time}!';
}

// Path: taker.roleSelection
class _Translations$taker$roleSelection$sk extends Translations$taker$roleSelection$en {
	_Translations$taker$roleSelection$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String button({required Object code}) => 'PREDAŤ ${code} za satoshi';
}

// Path: taker.progress
class _Translations$taker$progress$sk extends Translations$taker$progress$en {
	_Translations$taker$progress$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String step1({required Object code}) => 'Odoslať ${code}';
	@override String step2({required Object code}) => 'Potvrdiť ${code}';
	@override String get step3 => 'Dostať zaplatené';
}

// Path: taker.submitBlik
class _Translations$taker$submitBlik$sk extends Translations$taker$submitBlik$en {
	_Translations$taker$submitBlik$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object digits, required Object code}) => 'Zadaj ${digits}-miestny ${code}';
	@override String label({required Object code}) => 'Kód ${code}';
	@override String generateInBank({required Object bank}) => 'Vygeneruj kód na výber v aplikácii ${bank}.';
	@override String instruction({required Object code}) => 'Zadaj ${code}, kým vyprší čas...';
	@override String timeLimit({required Object code, required Object seconds}) => 'Zadaj ${code} do: ${seconds} s';
	@override String timeExpired({required Object code}) => 'Čas na zadanie ${code} vypršal.';
	@override late final _Translations$taker$submitBlik$actions$sk actions = _Translations$taker$submitBlik$actions$sk._(_root);
	@override late final _Translations$taker$submitBlik$feedback$sk feedback = _Translations$taker$submitBlik$feedback$sk._(_root);
	@override late final _Translations$taker$submitBlik$validation$sk validation = _Translations$taker$submitBlik$validation$sk._(_root);
	@override late final _Translations$taker$submitBlik$errors$sk errors = _Translations$taker$submitBlik$errors$sk._(_root);
	@override late final _Translations$taker$submitBlik$details$sk details = _Translations$taker$submitBlik$details$sk._(_root);
}

// Path: taker.waitConfirmation
class _Translations$taker$waitConfirmation$sk extends Translations$taker$waitConfirmation$en {
	_Translations$taker$waitConfirmation$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Čaká sa na predávajúceho';
	@override String statusLabel({required Object status}) => 'Stav ponuky: ${status}';
	@override String waitingMaker({required Object seconds}) => 'Čaká sa na potvrdenie predávajúceho: ${seconds} s';
	@override String waitingMakerConfirmation({required Object code, required Object seconds}) => 'Čaká sa, kým predávajúci potvrdí, že ${code} je správny. Zostávajúci čas: ${seconds}s';
	@override String importantNotice({required Object code, required Object amount, required Object currency}) => 'VEĽMI DÔLEŽITÉ: Uisti sa, že prijímaš potvrdenie ${code} iba na ${amount} ${currency}';
	@override String importantBlikAmountConfirmation({required Object code, required Object amount, required Object currency}) => 'VEĽMI DÔLEŽITÉ: V bankovej aplikácii sa uisti, že potvrdzuješ platbu ${code} presne na ${amount} ${currency}.';
	@override String instructions({required Object minutes, required Object code}) => 'Predávajúci ho teraz musí zadať do platobného terminálu do ${minutes} minút. Potom musíš ${code} prijať vo svojej bankovej aplikácii.';
	@override String instructionsNoConfirm({required Object code, required Object minutes}) => 'Predávajúci teraz musí zadať tvoj ${code} do bankomatu do ${minutes} minút.';
	@override late final _Translations$taker$waitConfirmation$categoryReminder$sk categoryReminder = _Translations$taker$waitConfirmation$categoryReminder$sk._(_root);
	@override String waitingForMakerToReceive({required Object code}) => 'Čaká sa, kým predávajúci dostane tvoj ${code}...';
	@override String makerReceivedBlik({required Object code}) => 'Predávajúci dostal tvoj ${code}.';
	@override String timerExpiredMessage({required Object code, required Object minutes}) => 'Čas platnosti ${code} (${minutes}m) uplynul. Čaká sa, kým predávajúci potvrdí alebo označí kód ako neplatný.';
	@override String timerExpiredActions({required Object code, required Object minutes}) => 'Čas platnosti ${code} (${minutes}m) uplynul, ale predávajúci nedostal ${code}. Môžeš poslať nový ${code} alebo zrušiť.';
	@override String resendBlikButton({required Object code}) => 'Poslať nový kód ${code}';
	@override String get navigatedHome => 'Presmerované domov.';
	@override String expiredTitle({required Object code}) => 'Kód ${code} vypršal';
	@override String expiredWarning({required Object code}) => 'Predávajúci nedostal ${code}, takže ho nemohol použiť.';
	@override String get expiredRelistCountdownLabel => 'Rezervácia končí o';
	@override String get expiredSentWarning => 'Predávajúci ešte nepotvrdil platbu. Čo chceš urobiť?';
	@override String expiredInstruction1({required Object code}) => 'Ak to chceš skúsiť znova s novým ${code}, obnov rezerváciu.';
	@override String get expiredInstruction2 => 'Ak už túto transakciu nechceš dokončiť, zruš rezerváciu.';
	@override String expiredInstruction3({required Object code}) => 'Ak bola platba ${code} strhnutá z tvojho bankového účtu, neboj sa, bitcoin je stále bezpečne uzamknutý u koordinátora.';
	@override late final _Translations$taker$waitConfirmation$takerCharged$sk takerCharged = _Translations$taker$waitConfirmation$takerCharged$sk._(_root);
	@override late final _Translations$taker$waitConfirmation$expiredActions$sk expiredActions = _Translations$taker$waitConfirmation$expiredActions$sk._(_root);
	@override late final _Translations$taker$waitConfirmation$feedback$sk feedback = _Translations$taker$waitConfirmation$feedback$sk._(_root);
	@override late final _Translations$taker$waitConfirmation$errors$sk errors = _Translations$taker$waitConfirmation$errors$sk._(_root);
}

// Path: taker.paymentProcess
class _Translations$taker$paymentProcess$sk extends Translations$taker$paymentProcess$en {
	_Translations$taker$paymentProcess$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Priebeh platby';
	@override String get waitingForOfferUpdate => 'Čaká sa na aktualizáciu stavu ponuky...';
	@override late final _Translations$taker$paymentProcess$states$sk states = _Translations$taker$paymentProcess$states$sk._(_root);
	@override late final _Translations$taker$paymentProcess$steps$sk steps = _Translations$taker$paymentProcess$steps$sk._(_root);
	@override late final _Translations$taker$paymentProcess$errors$sk errors = _Translations$taker$paymentProcess$errors$sk._(_root);
	@override late final _Translations$taker$paymentProcess$loading$sk loading = _Translations$taker$paymentProcess$loading$sk._(_root);
	@override late final _Translations$taker$paymentProcess$actions$sk actions = _Translations$taker$paymentProcess$actions$sk._(_root);
}

// Path: taker.paymentFailed
class _Translations$taker$paymentFailed$sk extends Translations$taker$paymentFailed$en {
	_Translations$taker$paymentFailed$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Platba zlyhala';
	@override String instructions({required Object netAmount}) => 'Poskytni novú Lightning faktúru na ${netAmount}';
	@override late final _Translations$taker$paymentFailed$form$sk form = _Translations$taker$paymentFailed$form$sk._(_root);
	@override late final _Translations$taker$paymentFailed$actions$sk actions = _Translations$taker$paymentFailed$actions$sk._(_root);
	@override late final _Translations$taker$paymentFailed$errors$sk errors = _Translations$taker$paymentFailed$errors$sk._(_root);
	@override late final _Translations$taker$paymentFailed$walletSection$sk walletSection = _Translations$taker$paymentFailed$walletSection$sk._(_root);
	@override late final _Translations$taker$paymentFailed$loading$sk loading = _Translations$taker$paymentFailed$loading$sk._(_root);
	@override late final _Translations$taker$paymentFailed$success$sk success = _Translations$taker$paymentFailed$success$sk._(_root);
}

// Path: taker.paymentSuccess
class _Translations$taker$paymentSuccess$sk extends Translations$taker$paymentSuccess$en {
	_Translations$taker$paymentSuccess$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Platba úspešná';
	@override String get message => 'Tvoja platba bola úspešne spracovaná.';
	@override late final _Translations$taker$paymentSuccess$actions$sk actions = _Translations$taker$paymentSuccess$actions$sk._(_root);
}

// Path: taker.criticalCodeDecision
class _Translations$taker$criticalCodeDecision$sk extends Translations$taker$criticalCodeDecision$en {
	_Translations$taker$criticalCodeDecision$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kritické rozhodnutie';
	@override String explanation({required Object code}) => 'Predávajúcemu si už poskytol kód ${code}. Pokračovanie môže tento kód nahradiť, ukončiť tvoju rezerváciu a znovu sprístupniť ponuku iným kupujúcim.';
	@override String get warningTitle => 'MÔŽEŠ PRÍSŤ O SVOJE PROSTRIEDKY';
	@override String warningBody({required Object code}) => 'Ak ti banka strhla platbu ${code}, NEPOKRAČUJ. Predávajúci mohol tvoj kód použiť a po tejto akcii už koordinátor nemusí vedieť zaručiť vyplatenie tvojich bitcoinov.';
	@override late final _Translations$taker$criticalCodeDecision$actions$sk actions = _Translations$taker$criticalCodeDecision$actions$sk._(_root);
}

// Path: taker.invalidBlik
class _Translations$taker$invalidBlik$sk extends Translations$taker$invalidBlik$en {
	_Translations$taker$invalidBlik$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Neplatný kód ${code}';
	@override String message({required Object code}) => 'Predávajúci odmietol kód ${code}';
	@override String explanation({required Object code}) => 'Predávajúci ponuky uviedol, že ${code}, ktorý si poskytol, bol neplatný alebo nefungoval.\n\nČo chceš urobiť?';
	@override String get werentCharged => 'Ak ti NEBOLO nič strhnuté:';
	@override String get wereCharged => 'Ak ti bolo strhnuté:';
	@override late final _Translations$taker$invalidBlik$actions$sk actions = _Translations$taker$invalidBlik$actions$sk._(_root);
	@override late final _Translations$taker$invalidBlik$confirmDialog$sk confirmDialog = _Translations$taker$invalidBlik$confirmDialog$sk._(_root);
	@override late final _Translations$taker$invalidBlik$disputeConfirmDialog$sk disputeConfirmDialog = _Translations$taker$invalidBlik$disputeConfirmDialog$sk._(_root);
	@override late final _Translations$taker$invalidBlik$feedback$sk feedback = _Translations$taker$invalidBlik$feedback$sk._(_root);
	@override late final _Translations$taker$invalidBlik$errors$sk errors = _Translations$taker$invalidBlik$errors$sk._(_root);
}

// Path: taker.conflict
class _Translations$taker$conflict$sk extends Translations$taker$conflict$en {
	_Translations$taker$conflict$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Čaká sa na potvrdenie platby';
	@override String get headline => 'Čaká sa na potvrdenie Makera';
	@override String body({required Object code}) => 'Nahlásil si, že platba ${code} bola zaúčtovaná, ale Maker uviedol, že nebola úspešná. Tieto hlásenia si odporujú.';
	@override String get instructions => 'Maker teraz musí potvrdiť výsledok. Ak potvrdí, že platba bola úspešná, tvoja výplata bude pokračovať. Ak potvrdí neúspech alebo vyprší časovač, ponuka prejde do formálneho sporu a sprístupní sa chat sporu.';
	@override String timeoutLabel({required Object time}) => 'Formálny spor sa automaticky otvorí o ${time}';
	@override late final _Translations$taker$conflict$actions$sk actions = _Translations$taker$conflict$actions$sk._(_root);
	@override late final _Translations$taker$conflict$feedback$sk feedback = _Translations$taker$conflict$feedback$sk._(_root);
	@override late final _Translations$taker$conflict$errors$sk errors = _Translations$taker$conflict$errors$sk._(_root);
	@override late final _Translations$taker$conflict$nostrContact$sk nostrContact = _Translations$taker$conflict$nostrContact$sk._(_root);
}

// Path: taker.dispute
class _Translations$taker$dispute$sk extends Translations$taker$dispute$en {
	_Translations$taker$dispute$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get headline => 'Otvorený formálny spor';
	@override String get body => 'Ponuku teraz posudzuje koordinátor. Pomocou chatu sporu nižšie komunikuj s koordinátorom a poskytni požadované dôkazy.';
}

// Path: blik.instructions
class _Translations$blik$instructions$sk extends Translations$blik$instructions$en {
	_Translations$blik$instructions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String taker({required Object code}) => 'Keď predávajúci zadá ${code}, budeš musieť potvrdiť platbu vo svojej bankovej aplikácii. Pred potvrdením sa uisti, že suma je správna.';
}

// Path: home.notifications
class _Translations$home$notifications$sk extends Translations$home$notifications$en {
	_Translations$home$notifications$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dostávaj upozornenia na nové ponuky cez:';
	@override String get telegram => 'Telegram';
	@override String get simplex => 'SimpleX';
	@override String get matrix => 'Matrix';
	@override String get signal => 'Signal';
	@override String get channelAllBanks => '(všetky banky)';
	@override String get channelForBankPrefix => '(len ponuky pre ';
	@override String get channelForBankSuffix => ')';
	@override String get scopeAllBanks => 'Všetky banky';
	@override String scopeBankOnly({required Object bank}) => 'Len ${bank}';
}

// Path: home.statistics
class _Translations$home$statistics$sk extends Translations$home$statistics$en {
	_Translations$home$statistics$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dokončené ponuky';
	@override String lifetimeCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Všetky: ${count} transakcií\nPriem. čakanie na ${code}: ${avgBlikTime}\nPriem. čas dokončenia: ${avgPaidTime}';
	@override String last7DaysCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Posl. 7 dní: ${count} transakcií\nPriem. čakanie na ${code}: ${avgBlikTime}\nPriem. čas dokončenia: ${avgPaidTime}';
	@override String last7DaysSingleLine({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Posl. 7 dní: ${count} ponúk  |  Priem. rezervácia: ${avgReservationTime}  |  Priem. zaplatené: ${avgPaidTime}';
	@override late final _Translations$home$statistics$errors$sk errors = _Translations$home$statistics$errors$sk._(_root);
}

// Path: generateNewKey.buttons
class _Translations$generateNewKey$buttons$sk extends Translations$generateNewKey$buttons$en {
	_Translations$generateNewKey$buttons$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Vygenerovať';
}

// Path: generateNewKey.errors
class _Translations$generateNewKey$errors$sk extends Translations$generateNewKey$errors$en {
	_Translations$generateNewKey$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get activeOffer => 'Nemôžeš vygenerovať nové Neko, kým máš aktívnu ponuku.';
	@override String get failed => 'Nepodarilo sa vygenerovať nové Neko';
}

// Path: generateNewKey.feedback
class _Translations$generateNewKey$feedback$sk extends Translations$generateNewKey$feedback$en {
	_Translations$generateNewKey$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get success => 'Nové Neko úspešne vygenerované!';
}

// Path: generateNewKey.tooltips
class _Translations$generateNewKey$tooltips$sk extends Translations$generateNewKey$tooltips$en {
	_Translations$generateNewKey$tooltips$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Vygenerovať nové Neko';
}

// Path: backup.feedback
class _Translations$backup$feedback$sk extends Translations$backup$feedback$en {
	_Translations$backup$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Súkromný kľúč skopírovaný do schránky!';
}

// Path: backup.tooltips
class _Translations$backup$tooltips$sk extends Translations$backup$tooltips$en {
	_Translations$backup$tooltips$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get backup => 'Zálohovať Neko';
}

// Path: restore.labels
class _Translations$restore$labels$sk extends Translations$restore$labels$en {
	_Translations$restore$labels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get privateKey => 'Súkromný kľúč';
}

// Path: restore.buttons
class _Translations$restore$buttons$sk extends Translations$restore$buttons$en {
	_Translations$restore$buttons$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Obnoviť';
}

// Path: restore.errors
class _Translations$restore$errors$sk extends Translations$restore$errors$en {
	_Translations$restore$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get invalidKey => 'Musí to byť 64-znakový hex reťazec.';
	@override String get failed => 'Obnovenie zlyhalo';
}

// Path: restore.feedback
class _Translations$restore$feedback$sk extends Translations$restore$feedback$en {
	_Translations$restore$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get success => 'Neko úspešne obnovené! Aplikácia sa reštartuje.';
}

// Path: restore.tooltips
class _Translations$restore$tooltips$sk extends Translations$restore$tooltips$en {
	_Translations$restore$tooltips$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Obnoviť Neko';
}

// Path: system.errors
class _Translations$system$errors$sk extends Translations$system$errors$en {
	_Translations$system$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get generic => 'Vyskytla sa neočakávaná chyba. Skús to znova.';
	@override String get loadingTimeoutConfig => 'Chyba pri načítaní konfigurácie časového limitu.';
	@override String get loadingCoordinatorConfig => 'Chyba pri načítaní konfigurácie koordinátora. Skús to znova.';
	@override String get noPublicKey => 'Tvoj verejný kľúč nie je dostupný. Nedá sa pokračovať.';
	@override String get internalOfferIncomplete => 'Interná chyba: Detaily ponuky sú neúplné. Skús to znova.';
	@override String get loadingPublicKey => 'Chyba pri načítaní tvojho verejného kľúča. Reštartuj aplikáciu.';
}

// Path: system.blik
class _Translations$system$blik$sk extends Translations$system$blik$en {
	_Translations$system$blik$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String copied({required Object code}) => '${code} skopírovaný do schránky';
}

// Path: myOffers.filter
class _Translations$myOffers$filter$sk extends Translations$myOffers$filter$en {
	_Translations$myOffers$filter$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get all => 'Všetky';
	@override String get active => 'Aktívne';
	@override String get completed => 'Dokončené';
	@override String get failed => 'Neúspešné';
}

// Path: myOffers.details
class _Translations$myOffers$details$sk extends Translations$myOffers$details$en {
	_Translations$myOffers$details$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detaily ponuky';
	@override String get notFound => 'Ponuka sa nenašla.';
	@override String get amount => 'Suma';
	@override String get fees => 'Poplatky';
	@override String get sats => 'Satoshi';
	@override String get maker => 'Predávajúci';
	@override String get taker => 'Kupujúci';
	@override String get yourFee => 'Tvoj poplatok';
	@override String get makerFee => 'Poplatok predávajúceho';
	@override String get takerFee => 'Poplatok kupujúceho';
	@override String get coordinator => 'Koordinátor';
	@override String get createdAt => 'Vytvorené';
	@override String get reservedAt => 'Rezervované';
	@override String blikReceivedAt({required Object code}) => '${code} odoslaný';
	@override String get makerConfirmedAt => 'Potvrdené';
	@override String get settledAt => 'Vyrovnané';
	@override String get takerPaidAt => 'Kupujúci zaplatený';
	@override String get id => 'ID ponuky';
	@override String get paymentHash => 'Hash platby';
	@override String get holdInvoice => 'Hold faktúra';
	@override String get continueActiveOffer => 'Pokračovať v aktívnej ponuke';
	@override String after({required Object duration}) => 'po ${duration}';
}

// Path: landing.actions
class _Translations$landing$actions$sk extends Translations$landing$actions$en {
	_Translations$landing$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String payBlik({required Object code}) => 'Zaplatiť ${code}';
	@override String get payBlikSubtitle => 'cez bitcoin';
	@override String get sellBlik => 'Kúpiť bitcoin';
	@override String sellBlikSubtitle({required Object code}) => 'cez ${code}';
	@override String get howItWorks => 'Ako to funguje?';
}

// Path: settings.coordinatorConsole
class _Translations$settings$coordinatorConsole$sk extends Translations$settings$coordinatorConsole$en {
	_Translations$settings$coordinatorConsole$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konzola koordinátora';
	@override String get subtitle => 'Spravujte spory pomocou podpisovača koordinátora';
	@override String get signInTitle => 'Prihlásiť sa ako koordinátor';
	@override String get signInDescription => 'Použite Nostr kľúč, ktorý identifikuje koordinátora, na kontrolu a riešenie sporov.';
	@override String get separateIdentityNote => 'Podpisovač koordinátora používa samostatnú reláciu NDK a nikdy nenahrádza obchodnú identitu Neko.';
	@override String get loginWithSignerApp => 'Prihlásiť sa cez podpisovaciu aplikáciu';
	@override String get loginWithExtension => 'Prihlásiť sa cez rozšírenie prehliadača';
	@override String get loginWithNsec => 'Prihlásiť sa pomocou nsec';
	@override String get nsecDialogTitle => 'Súkromný kľúč koordinátora';
	@override String get nsecFieldLabel => 'Súkromný kľúč';
	@override String get nsecSecurityNote => 'Súkromný kľúč je bezpečne uložený v tomto zariadení a používa ho iba samostatná relácia koordinátora.';
	@override String get unsupportedPlatform => 'Prihlásenie koordinátora je momentálne dostupné v systémoch Android, Linux a na webe.';
	@override String get loginFailed => 'Prihlásenie koordinátora zlyhalo';
	@override String get accountsTitle => 'Účty koordinátorov';
	@override String get savedAccounts => 'Uložené účty koordinátorov';
	@override String get addAccount => 'Pridať účet koordinátora';
	@override String get removeAccount => 'Odstrániť účet koordinátora';
}

// Path: settings.offerCreation
class _Translations$settings$offerCreation$sk extends Translations$settings$offerCreation$en {
	_Translations$settings$offerCreation$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vytváranie ponúk';
	@override String get defaultCategory => 'Predvolená kategória';
	@override String get defaultBank => 'Predvolená banka';
	@override String get defaultBankNone => 'Žiadna (vyber pri každej ponuke)';
	@override String get preferredCoordinator => 'Preferovaný koordinátor';
	@override String get automaticCoordinator => 'Najspoľahlivejší';
	@override String get automaticCoordinatorDescription => 'Vyberie koordinátora s najlepšou históriou, pričom kombinuje tvoje vlastné dokončené ponuky a celkovú aktivitu v sieti.';
	@override String get cheapestCoordinator => 'Najlacnejší';
	@override String get cheapestCoordinatorDescription => 'Pre každú ponuku vyberie dostupného koordinátora s najnižším poplatkom predávajúceho.';
	@override String get enablePremium => 'Zapnúť prémiové ceny';
	@override String get enablePremiumDescription => 'Zobraziť posuvník prémie pri vytváraní ponúk predávajúceho.';
	@override String get defaultPremium => 'Predvolená prémia';
	@override String get defaultPremiumDisabled => 'Zapni prémiové ceny, aby si nastavil predvolenú prémiu.';
	@override String get premiumPerCoordinatorNote => 'Každý koordinátor si nastavuje vlastnú maximálnu prémiu, takže tvoja predvolená hodnota je obmedzená koordinátorom použitým pre ponuku.';
	@override late final _Translations$settings$offerCreation$categoryOptions$sk categoryOptions = _Translations$settings$offerCreation$categoryOptions$sk._(_root);
	@override late final _Translations$settings$offerCreation$dialogs$sk dialogs = _Translations$settings$offerCreation$dialogs$sk._(_root);
}

// Path: settings.display
class _Translations$settings$display$sk extends Translations$settings$display$en {
	_Translations$settings$display$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zobrazenie';
	@override String get bitcoinUnit => 'Jednotka bitcoinu';
	@override String get bitcoinUnitDescription => 'Vyber, ako sa v celej aplikácii zobrazujú sumy v bitcoinoch.';
	@override late final _Translations$settings$display$unitOptions$sk unitOptions = _Translations$settings$display$unitOptions$sk._(_root);
}

// Path: settings.paymentSystem
class _Translations$settings$paymentSystem$sk extends Translations$settings$paymentSystem$en {
	_Translations$settings$paymentSystem$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Krajina / Platobný systém';
	@override String get subtitle => 'Vyber platobný systém svojej krajiny.';
	@override String get dialogTitle => 'Vyber platobný systém';
	@override late final _Translations$settings$paymentSystem$countries$sk countries = _Translations$settings$paymentSystem$countries$sk._(_root);
}

// Path: notificationSettings.newOfferAlerts
class _Translations$notificationSettings$newOfferAlerts$sk extends Translations$notificationSettings$newOfferAlerts$en {
	_Translations$notificationSettings$newOfferAlerts$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get label => 'Upozornenia na nové ponuky';
	@override String description({required Object app}) => 'Keď je zapnuté, ${app} ťa upozorní na nové ponuky dostupné na prijatie od tvojich zapnutých koordinátorov, kým je aplikácia na pozadí. Môže to byť rýchlejšie než externé messengery.';
}

// Path: wallet.missingReceiving
class _Translations$wallet$missingReceiving$sk extends Translations$wallet$missingReceiving$en {
	_Translations$wallet$missingReceiving$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vyžaduje sa peňaženka na prijímanie';
	@override String get message => 'Nie je nakonfigurovaná žiadna peňaženka na prijímanie. Pridaj jednu v nastaveniach peňaženky, aby si mohol prijímať ponuky.';
	@override String get openSettings => 'Nastavenia peňaženky';
}

// Path: wallet.details
class _Translations$wallet$details$sk extends Translations$wallet$details$en {
	_Translations$wallet$details$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detaily peňaženky';
	@override String get pendingTitle => 'Čakajúce transakcie';
	@override String get finishedTitle => 'Dokončené transakcie';
}

// Path: nwc.labels
class _Translations$nwc$labels$sk extends Translations$nwc$labels$en {
	_Translations$nwc$labels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get connectionString => 'NWC pripojovací reťazec';
	@override String get hint => 'nostr+walletconnect://...';
	@override String get status => 'Stav pripojenia';
	@override String get connected => 'Pripojené';
	@override String get disconnected => 'Odpojené';
	@override String get scanQrCode => 'Naskenuj QR kód so svojím NWC pripojením';
	@override String get balance => 'Zostatok';
	@override String get budget => 'Rozpočet';
	@override String get usedBudget => 'Použité';
	@override String get totalBudget => 'Celkom';
	@override String get renewsIn => 'Obnoví sa o';
	@override String get renewalPeriod => 'Obdobie obnovy';
	@override String get relay => 'Relay';
	@override String get relays => 'Relaye';
}

// Path: nwc.prompts
class _Translations$nwc$prompts$sk extends Translations$nwc$prompts$en {
	_Translations$nwc$prompts$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Zadaj svoj NWC pripojovací reťazec';
	@override String get connect => 'Pripojiť peňaženku';
	@override String get disconnect => 'Odpojiť';
	@override String get confirmDisconnect => 'Naozaj chceš odpojiť svoju NWC peňaženku?';
	@override String get pasteConnection => 'Vlož pripojovací reťazec';
	@override String get chooseMethod => 'Vyber, ako pripojiť svoju Lightning peňaženku';
	@override String get howToGet => 'Ešte nemáš NWC pripojenie? Zisti, ako ho získať!';
	@override String get learnMore => 'Zisti viac o NWC';
}

// Path: nwc.actions
class _Translations$nwc$actions$sk extends Translations$nwc$actions$en {
	_Translations$nwc$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get connectAlbyGo => 'Pripojiť cez Alby Go';
	@override String get connectNwc => 'Naskenovať NWC QR kód';
}

// Path: nwc.feedback
class _Translations$nwc$feedback$sk extends Translations$nwc$feedback$en {
	_Translations$nwc$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get connected => 'NWC peňaženka úspešne pripojená!';
	@override String get disconnected => 'NWC peňaženka odpojená';
	@override String get connecting => 'Pripája sa k NWC peňaženke...';
	@override String get loadingWalletInfo => 'Načítavajú sa informácie o peňaženke...';
}

// Path: nwc.errors
class _Translations$nwc$errors$sk extends Translations$nwc$errors$en {
	_Translations$nwc$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String connecting({required Object details}) => 'Chyba pri pripájaní k NWC: ${details}';
	@override String disconnecting({required Object details}) => 'Chyba pri odpájaní NWC: ${details}';
	@override String get invalid => 'Neplatný NWC pripojovací reťazec';
	@override String get required => 'NWC pripojovací reťazec je povinný';
	@override String get loadingBalance => 'Nepodarilo sa načítať zostatok peňaženky';
	@override String get loadingBudget => 'Nepodarilo sa načítať rozpočet peňaženky';
}

// Path: nwc.time
class _Translations$nwc$time$sk extends Translations$nwc$time$en {
	_Translations$nwc$time$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String minutes({required Object count}) => '${count}m';
	@override String hours({required Object count}) => '${count}h';
	@override String days({required Object count}) => '${count}d';
	@override String get justNow => 'práve teraz';
}

// Path: relays.status
class _Translations$relays$status$sk extends Translations$relays$status$en {
	_Translations$relays$status$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Pripojené';
	@override String get connecting => 'Pripája sa';
	@override String get reconnecting => 'Znovu sa pripája';
	@override String get disconnected => 'Odpojené';
}

// Path: relays.popup
class _Translations$relays$popup$sk extends Translations$relays$popup$en {
	_Translations$relays$popup$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object connected, required Object total}) => 'Relaye (pripojené ${connected}/${total})';
	@override String get connectingMessage => 'Pripája sa k relayom...';
}

// Path: offerNotifications.activeService
class _Translations$offerNotifications$activeService$sk extends Translations$offerNotifications$activeService$en {
	_Translations$offerNotifications$activeService$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Čaká sa na nové ponuky';
	@override String body({required Object app}) => 'Nostr služba monitoruje udalosti ponúk ${app}.';
}

// Path: offerNotifications.funded
class _Translations$offerNotifications$funded$sk extends Translations$offerNotifications$funded$en {
	_Translations$offerNotifications$funded$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ponuka financovaná';
	@override String get body => 'Tvoja hold faktúra bola prijatá. Ponuka je teraz aktívna.';
}

// Path: offerNotifications.reserved
class _Translations$offerNotifications$reserved$sk extends Translations$offerNotifications$reserved$en {
	_Translations$offerNotifications$reserved$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ponuka rezervovaná';
	@override String get body => 'Kupujúci rezervoval tvoju ponuku.';
}

// Path: offerNotifications.blikReady
class _Translations$offerNotifications$blikReady$sk extends Translations$offerNotifications$blikReady$en {
	_Translations$offerNotifications$blikReady$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} pripravený';
	@override String body({required Object code}) => 'Tvoj ${code} je pripravený na zobrazenie.';
}

// Path: offerNotifications.newOffer
class _Translations$offerNotifications$newOffer$sk extends Translations$offerNotifications$newOffer$en {
	_Translations$offerNotifications$newOffer$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dostupná nová ponuka';
	@override String body({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}';
	@override String premiumSuffix({required Object percent}) => '+${percent}% prémia';
}

// Path: offerNotifications.categories
class _Translations$offerNotifications$categories$sk extends Translations$offerNotifications$categories$en {
	_Translations$offerNotifications$categories$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Obchod';
	@override String get atm => 'Bankomat';
	@override String get online => 'Online';
}

// Path: offerNotifications.blikPendingReminder
class _Translations$offerNotifications$blikPendingReminder$sk extends Translations$offerNotifications$blikPendingReminder$en {
	_Translations$offerNotifications$blikPendingReminder$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} čaká na tvoju akciu';
	@override String body({required Object code}) => 'Potvrď platbu alebo označ ${code} ako neplatný.';
}

// Path: offerNotifications.takerCharged
class _Translations$offerNotifications$takerCharged$sk extends Translations$offerNotifications$takerCharged$en {
	_Translations$offerNotifications$takerCharged$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} strhnutý';
	@override String body({required Object code}) => 'Kupujúci hlási, že ${code} bol strhnutý. Potvrď alebo označ ako neplatný.';
}

// Path: offerNotifications.invalidBlik
class _Translations$offerNotifications$invalidBlik$sk extends Translations$offerNotifications$invalidBlik$en {
	_Translations$offerNotifications$invalidBlik$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} označený ako neplatný';
	@override String body({required Object code}) => 'Predávajúci označil tvoj ${code} ako neplatný.';
}

// Path: offerNotifications.takerPaid
class _Translations$offerNotifications$takerPaid$sk extends Translations$offerNotifications$takerPaid$en {
	_Translations$offerNotifications$takerPaid$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Platba prijatá';
	@override String get body => 'Tvoja Lightning platba bola odoslaná.';
}

// Path: offers.details.categories
class _Translations$offers$details$categories$sk extends Translations$offers$details$categories$en {
	_Translations$offers$details$categories$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Obchod, kaviareň alebo reštaurácia';
	@override String get atmCashout => 'Výber z bankomatu';
	@override String get onlineService => 'Online služba/produkt';
}

// Path: offers.details.consents
class _Translations$offers$details$consents$sk extends Translations$offers$details$consents$en {
	_Translations$offers$details$consents$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Niektoré bankomaty pripočítajú k sume ponuky ďalší poplatok. Prijatím tejto ponuky súhlasíš s akýmikoľvek dodatočnými bankovými poplatkami, ktoré bankomat vyžaduje.';
	@override String ecommerce({required Object code}) => 'Z rôznych dôvodov — napríklad kvôli vypredanému tovaru, oprave preplatku alebo iným problémom na strane obchodníka — môže online obchodník automaticky poslať peniaze späť na bankový účet spojený s kódom ${code}, ktorý si vygeneroval. Tieto prostriedky pristanú na tvojom účte a nepatria tebe. Ak sa to stane, kontaktuj v dobrej viere koordinátora a dohodni sa na vrátení prostriedkov predávajúcemu. Prijatím tejto ponuky súhlasíš s týmito podmienkami a čestne sľubuješ, že sa v takýchto situáciách zachováš poctivo.';
}

// Path: coordinator.coldStart.phases
class _Translations$coordinator$coldStart$phases$sk extends Translations$coordinator$coldStart$phases$en {
	_Translations$coordinator$coldStart$phases$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get loadingMuteList => 'Načítavajú sa filtre koordinátorov';
	@override String get discovering => 'Vyhľadávanie koordinátorov na Nostr';
	@override String get loadingProfiles => 'Načítavajú sa profily koordinátorov';
	@override String get loadingStats => 'Číta sa história koordinátorov';
	@override String get checkingHealth => 'Kontrola stavu koordinátorov';
	@override String get finalizing => 'Zapínajú sa predvolení koordinátori';
	@override String get completed => 'Hotovo';
}

// Path: maker.refundInvoice.errors
class _Translations$maker$refundInvoice$errors$sk extends Translations$maker$refundInvoice$errors$en {
	_Translations$maker$refundInvoice$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get backendUnavailable => 'Služba platieb Lightning nie je dostupná.';
	@override String get missing => 'Zadajte faktúru na vrátenie platby.';
	@override String get invalid => 'Zadajte platnú BOLT11 faktúru na vrátenie platby.';
	@override String get wrongNetwork => 'Faktúra na vrátenie platby patrí do nesprávnej siete Lightning.';
	@override String get wrongAmount => 'Faktúra musí obsahovať presnú sumu vrátenia platby.';
	@override String get invalidExpiry => 'Faktúra na vrátenie platby má neplatnú dobu platnosti.';
	@override String get futureTimestamp => 'Časová pečiatka faktúry je v budúcnosti.';
	@override String get expired => 'Faktúra na vrátenie platby vypršala. Vytvorte novú.';
	@override String get invalidPaymentHash => 'Faktúra nemá platný hash platby.';
	@override String get reusedInvoice => 'Použite novú faktúru; faktúra ponuky nemôže prijať vrátenie platby.';
	@override String get unsupportedNetwork => 'Táto sieť Lightning nie je podporovaná.';
	@override String get unknown => 'Skontrolujte faktúru a skúste to znova.';
}

// Path: maker.amountForm.progress
class _Translations$maker$amountForm$progress$sk extends Translations$maker$amountForm$progress$en {
	_Translations$maker$amountForm$progress$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Vytvoriť ponuku';
	@override String get step2 => '2. Čakať na kupujúceho';
	@override String step3({required Object code}) => '3. Použiť ${code}';
}

// Path: maker.amountForm.labels
class _Translations$maker$amountForm$labels$sk extends Translations$maker$amountForm$labels$en {
	_Translations$maker$amountForm$labels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get coordinator => 'Koordinátor';
	@override String get category => 'Kategória';
	@override String get exchangeRate => 'Výmenný kurz';
	@override String get fee => 'Poplatok';
	@override String get satoshisToPay => 'Suma na zaplatenie';
	@override String get enterAmount => 'Zadaj sumu';
	@override String get customAmount => 'Vlastná';
	@override String get tapToSelect => 'Ťukni na výber';
	@override String get premium => 'Prémia';
}

// Path: maker.amountForm.actions
class _Translations$maker$amountForm$actions$sk extends Translations$maker$amountForm$actions$en {
	_Translations$maker$amountForm$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get generateInvoice => 'Vygenerovať faktúru';
}

// Path: maker.amountForm.bank
class _Translations$maker$amountForm$bank$sk extends Translations$maker$amountForm$bank$en {
	_Translations$maker$amountForm$bank$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get label => 'Banka';
	@override String get required => 'Vyber si banku';
	@override String shortValidityWarning({required Object minutes}) => 'Kód tejto banky platí len ${minutes} min — buď pri bankomate skôr, než rezervuješ.';
}

// Path: maker.amountForm.tooltips
class _Translations$maker$amountForm$tooltips$sk extends Translations$maker$amountForm$tooltips$en {
	_Translations$maker$amountForm$tooltips$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String feeInfo({required Object feePercent}) => 'Koordinátor si účtuje ${feePercent}% poplatok predávajúceho. Tento poplatok sa odpočíta z tvojej Lightning platby.';
	@override String get payInfo => 'Tento výpočet vychádza z výmenných kurzov načítaných na strane klienta. Koordinátor vypočíta presnú sumu a suma na faktúre bude konečná a presná suma na zaplatenie.';
	@override String get premiumInfo => 'Voliteľná prémia ti umožňuje predať sats nad trhovú cenu. Prémia zníži počet sats uzamknutých v tvojej hold faktúre za rovnakú sumu vo fiate, takže kupujúci platí nad trh a ty si ponecháš rozdiel. Predvolene je vypnutá (0%). Maximálnu prémiu určuje vybraný koordinátor.';
}

// Path: maker.amountForm.category
class _Translations$maker$amountForm$category$sk extends Translations$maker$amountForm$category$en {
	_Translations$maker$amountForm$category$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get label => 'Kategória ponuky';
	@override String unsupportedForSystem({required Object system}) => '${system} nepodporuje túto kategóriu.';
	@override late final _Translations$maker$amountForm$category$options$sk options = _Translations$maker$amountForm$category$options$sk._(_root);
	@override late final _Translations$maker$amountForm$category$shortLabels$sk shortLabels = _Translations$maker$amountForm$category$shortLabels$sk._(_root);
	@override String get atmHint => 'Kupujúci uvidia, že táto ponuka je na výber z bankomatu, a môžu sa jej vyhnúť, ak im banka účtuje ďalšie poplatky za bankomat.';
	@override String physicalShopHint({required Object app, required Object code}) => 'Ideálne miesto na použitie ${app} je samoobslužná pokladňa — keďže čakanie na to, kým kupujúci rezervuje, vygeneruje a potvrdí ${code}, môže trvať pár minút. Skvele funguje v obchodoch, kaviarňach aj reštauráciách. Ak sa cítiš dosť odvážny na to, aby si nechal bežného pokladníka (a ľudí v rade za tebou) čakať tých pár minút, tak nech sa páči.';
	@override String get ecommerceWarningTitle => 'Riziko vrátenia peňazí od online obchodníka';
	@override String ecommerceWarningBody({required Object code}) => 'Z rôznych dôvodov — napríklad kvôli vypredanému tovaru, oprave preplatku alebo iným problémom na strane obchodníka — môže online obchodník automaticky vystaviť vrátenie peňazí na bankový účet spojený s kódom ${code}, čo je účet kupujúceho. Koordinátor nemôže prinútiť kupujúceho, aby ti tieto prostriedky vrátil.';
	@override String get ecommerceConfirmation => 'Rozumiem riziku vrátenia peňazí a k objednávke pridám poznámku, aby obchodník v prípade potreby vrátil peniaze na iný účet.';
	@override String get whyThisIsNeeded => 'prečo je to potrebné?';
}

// Path: maker.amountForm.onboarding
class _Translations$maker$amountForm$onboarding$sk extends Translations$maker$amountForm$onboarding$en {
	_Translations$maker$amountForm$onboarding$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get titlePrefix => 'Nové';
	@override String get title => 'Vyber kategóriu ponuky';
	@override String get body => 'Pred vygenerovaním faktúry vyber kategóriu, ktorá najlepšie zodpovedá tomu, za čo platíš.';
	@override String get showWhy => 'Prečo na tom záleží?';
	@override String get hideWhy => 'Skryť detaily';
	@override String get whyTitle => 'Správna kategória pomáha kupujúcim bezpečne sa rozhodnúť';
	@override String get whyBody => 'Rôzne situácie prinášajú rôzne očakávania a riziká. Výbery z bankomatu môžu zahŕňať ďalšie bankové poplatky a online nákupy môžu zahŕňať okrajové prípady s vrátením peňazí. Označenie správnej kategórie dáva kupujúcim kontext, ktorý potrebujú pred prijatím tvojej ponuky.';
	@override String get cta => 'Rozumiem';
}

// Path: maker.amountForm.errors
class _Translations$maker$amountForm$errors$sk extends Translations$maker$amountForm$errors$en {
	_Translations$maker$amountForm$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String initiating({required Object details}) => 'Chyba pri vytváraní ponuky: ${details}';
	@override String get publicKeyNotLoaded => 'Chyba: Verejný kľúč ešte nie je načítaný.';
	@override String get noCoordinatorMatchesAmount => 'Túto sumu nepodporuje žiadny koordinátor. Skús inú hodnotu.';
	@override String get categoryRequired => 'Vyber kategóriu ponuky.';
	@override String get ecommerceConfirmationRequired => 'Pred pokračovaním potvrď riziko vrátenia peňazí od online obchodníka.';
}

// Path: maker.payInvoice.actions
class _Translations$maker$payInvoice$actions$sk extends Translations$maker$payInvoice$actions$en {
	_Translations$maker$payInvoice$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get copy => 'Kopírovať faktúru';
	@override String get payInWallet => 'Otvoriť v externej peňaženke';
	@override String get connectWallet => 'Pripojiť peňaženku';
	@override String get payWithNwc => 'Zaplatiť';
	@override String get paying => 'Platí sa...';
}

// Path: maker.payInvoice.feedback
class _Translations$maker$payInvoice$feedback$sk extends Translations$maker$payInvoice$feedback$en {
	_Translations$maker$payInvoice$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Faktúra skopírovaná do schránky!';
	@override String get waitingConfirmation => 'Čaká sa na potvrdenie platby...';
	@override String get nwcConnected => 'NWC peňaženka pripojená!';
	@override String get nwcPaymentSuccess => 'Platba úspešná!';
}

// Path: maker.payInvoice.errors
class _Translations$maker$payInvoice$errors$sk extends Translations$maker$payInvoice$errors$en {
	_Translations$maker$payInvoice$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get couldNotOpenApp => 'Nepodarilo sa otvoriť Lightning aplikáciu pre faktúru.';
	@override String openingApp({required Object details}) => 'Chyba pri otváraní Lightning aplikácie: ${details}';
	@override String get publicKeyNotAvailable => 'Verejný kľúč nie je dostupný.';
	@override String get couldNotFetchActive => 'Nepodarilo sa načítať detaily aktívnej ponuky. Mohla vypršať.';
	@override String nwcPaymentFailed({required Object details}) => 'Platba zlyhala: ${details}';
	@override String get nwcNotConnected => 'NWC peňaženka nie je pripojená';
	@override String insufficientBalance({required Object required, required Object available}) => 'Nedostatočný zostatok. Potrebuješ ${required} sats, máš ${available} sats';
	@override String get cancelOfferAlreadyFunded => 'Koordinátor hlási, že táto ponuka je už financovaná. Teraz ju nie je možné zrušiť.';
	@override String cancelFailed({required Object details}) => 'Nepodarilo sa zrušiť ponuku: ${details}';
}

// Path: maker.payInvoice.budgetWarning
class _Translations$maker$payInvoice$budgetWarning$sk extends Translations$maker$payInvoice$budgetWarning$en {
	_Translations$maker$payInvoice$budgetWarning$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Platba môže zlyhať';
	@override String balanceTooLow({required Object name}) => 'Tvoja predvolená peňaženka na platby ${name} nemá dostatočný zostatok na túto platbu.';
	@override String budgetTooLow({required Object name}) => 'Tvoja predvolená peňaženka na platby ${name} nemá dostatočný rozpočet na túto platbu.';
	@override String balanceLine({required Object available}) => 'Zostatok: ${available}';
	@override String budgetLine({required Object remaining}) => 'Zostávajúci NWC rozpočet: ${remaining}';
	@override String requiredLine({required Object required}) => 'Potrebné: ${required}';
	@override String addFundsHint({required Object name}) => 'Dobi ${name}, aby si pokryl túto sumu platby.';
	@override String get increaseBudgetHint => 'Zvýš NWC rozpočet na míňanie pre toto pripojenie v aplikácii svojej peňaženky.';
	@override String get switchWalletLabel => 'Alebo použi inú peňaženku:';
	@override String get walletLowFundsTag => 'Môže zlyhať';
	@override String get payAnyway => 'Skúsiť aj tak';
	@override String get cancel => 'Zrušiť';
	@override String get readyTitle => 'Zaplatiť faktúru';
}

// Path: maker.confirmPayment.actions
class _Translations$maker$confirmPayment$actions$sk extends Translations$maker$confirmPayment$actions$en {
	_Translations$maker$confirmPayment$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Potvrdiť úspešnú platbu';
	@override String markInvalid({required Object code}) => 'Neplatný kód ${code}';
	@override String copyBlik({required Object code}) => 'Kopírovať ${code}';
}

// Path: maker.confirmPayment.confirmDialog
class _Translations$maker$confirmPayment$confirmDialog$sk extends Translations$maker$confirmPayment$confirmDialog$en {
	_Translations$maker$confirmPayment$confirmDialog$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Potvrdiť platbu?';
	@override String content({required Object code}) => 'Táto akcia je nezvratná. Po potvrdení:\n\n• Kupujúci okamžite dostane prostriedky\n• Koordinátor nebude môcť prostriedky spochybniť\n• Túto akciu nemôžeš vrátiť späť\n\nPotvrď iba vtedy, ak bola platba ${code} úspešná.';
	@override String get cancel => 'Zrušiť';
	@override String get confirmButton => 'Áno, potvrdiť platbu';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _Translations$maker$confirmPayment$invalidBlikDisputeDialog$sk extends Translations$maker$confirmPayment$invalidBlikDisputeDialog$en {
	_Translations$maker$confirmPayment$invalidBlikDisputeDialog$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Otvoriť spor?';
	@override String content({required Object code}) => 'Kupujúci nahlásil, že platba ${code} bola strhnutá z jeho účtu.\n\nOznačením ako neplatné okamžite otvoríš SPOR, ktorý vyžaduje zásah koordinátora.\n\n• Ak sa rozhodne v tvoj neprospech, môže byť účtovaný poplatok za spor\n• Hold faktúra sa okamžite vyrovná\n• Bude potrebné manuálne overenie\n\nPokračuj iba vtedy, ak si istý, že platba ${code} NEbola úspešná.';
	@override String get cancel => 'Zrušiť';
	@override String get confirmButton => 'Áno, otvoriť spor';
}

// Path: maker.confirmPayment.feedback
class _Translations$maker$confirmPayment$feedback$sk extends Translations$maker$confirmPayment$feedback$en {
	_Translations$maker$confirmPayment$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Predávajúci potvrdil platbu.';
	@override String get confirmedTakerPaid => 'Platba potvrdená! Kupujúci dostane prostriedky.';
	@override String progressLabel({required Object seconds}) => 'Potvrdzuje sa: ostáva ${seconds} s';
}

// Path: maker.confirmPayment.errors
class _Translations$maker$confirmPayment$errors$sk extends Translations$maker$confirmPayment$errors$en {
	_Translations$maker$confirmPayment$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String failedToRetrieve({required Object code}) => 'Chyba: Nepodarilo sa načítať ${code}.';
	@override String retrieving({required Object code, required Object details}) => 'Chyba pri načítaní ${code}: ${details}';
	@override String get missingHashOrKey => 'Chyba: Chýba hash platby alebo verejný kľúč.';
	@override String incorrectState({required Object status}) => 'Ponuka nie je v správnom stave na potvrdenie (Stav: ${status})';
	@override String confirming({required Object details}) => 'Chyba pri potvrdzovaní platby: ${details}';
	@override String get invalidState => 'Chyba: Prijatý neplatný stav ponuky.';
	@override String get internalIncomplete => 'Interná chyba: Neúplné detaily ponuky.';
	@override String notAwaitingConfirmation({required Object status}) => 'Ponuka už nečaká na potvrdenie (Stav: ${status}).';
	@override String get unexpectedStatus => 'Zo servera prišiel neočakávaný stav ponuky.';
}

// Path: maker.conflict.actions
class _Translations$maker$conflict$actions$sk extends Translations$maker$conflict$actions$en {
	_Translations$maker$conflict$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get back => 'Späť domov';
	@override String confirmPayment({required Object code}) => 'Moja chyba, potvrdiť úspešnú platbu ${code}';
	@override String openDispute({required Object code}) => 'Platba ${code} NEbola úspešná, OTVORIŤ SPOR';
	@override String get submitDispute => 'Odoslať spor';
}

// Path: maker.conflict.disputeDialog
class _Translations$maker$conflict$disputeDialog$sk extends Translations$maker$conflict$disputeDialog$en {
	_Translations$maker$conflict$disputeDialog$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Otvoriť spor?';
	@override String get content => 'Otvorenie sporu vyžaduje manuálne overenie koordinátorom, čo zaberie čas. Ak sa spor rozhodne v tvoj neprospech, odpočíta sa poplatok za spor. Hold faktúra sa vyrovná, aby nevypršala. Ak sa spor rozhodne v tvoj prospech, dostaneš vrátené prostriedky (mínus poplatky) do peňaženky podľa vlastného výberu.';
	@override String get contentDetailed => 'Otvorenie sporu bude vyžadovať manuálny zásah koordinátora, čo zaberie čas a je spojené s poplatkom za spor.\n\nHold faktúra sa okamžite vyrovná, aby nevypršala pred vyriešením sporu.\n\nAk sa spor rozhodne v tvoj prospech, suma satoshi sa vráti do peňaženky podľa tvojho výberu (mínus poplatky). Uisti sa, že máš pripravenú peňaženku na prijatie.';
	@override late final _Translations$maker$conflict$disputeDialog$actions$sk actions = _Translations$maker$conflict$disputeDialog$actions$sk._(_root);
}

// Path: maker.conflict.feedback
class _Translations$maker$conflict$feedback$sk extends Translations$maker$conflict$feedback$en {
	_Translations$maker$conflict$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get disputeOpenedSuccess => 'Spor úspešne otvorený. Koordinátor ho posúdi.';
}

// Path: maker.conflict.errors
class _Translations$maker$conflict$errors$sk extends Translations$maker$conflict$errors$en {
	_Translations$maker$conflict$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String openingDispute({required Object error}) => 'Chyba pri otváraní sporu: ${error}';
}

// Path: maker.conflict.nostrContact
class _Translations$maker$conflict$nostrContact$sk extends Translations$maker$conflict$nostrContact$en {
	_Translations$maker$conflict$nostrContact$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontaktuj koordinátora na Nostr';
	@override String get description => 'Môžeš koordinátorovi napísať priamu správu (DM) a požiadať o pomoc s týmto sporom.';
	@override String get copyNpub => 'Kopírovať npub';
	@override String get openProfile => 'Zobraziť profil';
	@override String get npubCopied => 'Npub koordinátora skopírovaný do schránky!';
	@override String get yourIdentityDescription => 'Ak chceš posielať DM, prihlás sa svojím súkromným kľúčom Neko (nsec) v ľubovoľnom Nostr klientovi, ktorý podporuje priame správy.';
	@override String get manageNekoKeys => 'Spravovať Neko kľúče';
}

// Path: taker.submitBlik.actions
class _Translations$taker$submitBlik$actions$sk extends Translations$taker$submitBlik$actions$en {
	_Translations$taker$submitBlik$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String submit({required Object code}) => 'Odoslať ${code}';
}

// Path: taker.submitBlik.feedback
class _Translations$taker$submitBlik$feedback$sk extends Translations$taker$submitBlik$feedback$en {
	_Translations$taker$submitBlik$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String pasted({required Object code}) => 'Vložený ${code}.';
}

// Path: taker.submitBlik.validation
class _Translations$taker$submitBlik$validation$sk extends Translations$taker$submitBlik$validation$en {
	_Translations$taker$submitBlik$validation$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String invalidFormat({required Object digits, required Object code}) => 'Zadaj platný ${digits}-miestny ${code}.';
}

// Path: taker.submitBlik.errors
class _Translations$taker$submitBlik$errors$sk extends Translations$taker$submitBlik$errors$en {
	_Translations$taker$submitBlik$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String submitting({required Object code, required Object details}) => 'Chyba pri odosielaní ${code}: ${details}';
	@override String clipboardInvalid({required Object digits, required Object code}) => 'Schránka neobsahuje platný ${digits}-miestny ${code}.';
	@override String get stateChanged => 'Chyba: Stav ponuky sa zmenil.';
	@override String get stateNotValid => 'Chyba: Stav ponuky už nie je platný.';
	@override String fetchedIdMismatch({required Object fetchedId, required Object initialId}) => 'Načítané ID aktívnej ponuky (${fetchedId}) sa nezhoduje s pôvodným ID ponuky (${initialId}). Nesúlad stavu?';
	@override String get paymentHashMissing => 'Po načítaní chýba hash platby ponuky.';
}

// Path: taker.submitBlik.details
class _Translations$taker$submitBlik$details$sk extends Translations$taker$submitBlik$details$en {
	_Translations$taker$submitBlik$details$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String requestedAmount({required Object code}) => 'Požadovaná suma ${code}';
	@override String get exchangeRate => 'Výmenný kurz';
	@override String get takerFee => 'Poplatok kupujúceho';
	@override String get status => 'Stav';
	@override String get youllReceive => 'Dostaneš';
}

// Path: taker.waitConfirmation.categoryReminder
class _Translations$taker$waitConfirmation$categoryReminder$sk extends Translations$taker$waitConfirmation$categoryReminder$en {
	_Translations$taker$waitConfirmation$categoryReminder$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Pripomienka k ponuke bankomatu: tvoja banka ťa môže ešte požiadať o schválenie dodatočného poplatku za bankomat nad hlavnú sumu.';
	@override String get ecommerce => 'Pripomienka k online objednávke: ak obchodník pošle automatické vrátenie peňazí na tvoj bankový účet, kontaktuj koordinátora a vráť ich.';
}

// Path: taker.waitConfirmation.takerCharged
class _Translations$taker$waitConfirmation$takerCharged$sk extends Translations$taker$waitConfirmation$takerCharged$en {
	_Translations$taker$waitConfirmation$takerCharged$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Označil si ${code} ako strhnutý';
	@override String message({required Object minutes}) => 'Predávajúci má ${minutes} min na potvrdenie platby alebo jej spochybnenie. Ak neurobí nič, platba sa automaticky potvrdí a ty dostaneš bitcoin.';
}

// Path: taker.waitConfirmation.expiredActions
class _Translations$taker$waitConfirmation$expiredActions$sk extends Translations$taker$waitConfirmation$expiredActions$en {
	_Translations$taker$waitConfirmation$expiredActions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String reportConflict({required Object code}) => '${code} bol strhnutý z môjho bankového účtu';
	@override String renewReservation({required Object code}) => 'Skúsiť znova s novým ${code}';
	@override String get cancelReservation => 'Zrušiť rezerváciu';
}

// Path: taker.waitConfirmation.feedback
class _Translations$taker$waitConfirmation$feedback$sk extends Translations$taker$waitConfirmation$feedback$en {
	_Translations$taker$waitConfirmation$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmed => 'Predávajúci potvrdil platbu.';
	@override String get paymentSuccessful => 'Platba úspešná! Čoskoro dostaneš prostriedky.';
	@override String get conflictReported => 'Konflikt nahlásený. Koordinátor posúdi situáciu.';
}

// Path: taker.waitConfirmation.errors
class _Translations$taker$waitConfirmation$errors$sk extends Translations$taker$waitConfirmation$errors$en {
	_Translations$taker$waitConfirmation$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get invalidOfferStateReceived => 'Prijatá ponuka s neplatným stavom pre túto obrazovku. Resetuje sa.';
	@override String reportingConflict({required Object details}) => 'Chyba pri nahlasovaní konfliktu: ${details}';
}

// Path: taker.paymentProcess.states
class _Translations$taker$paymentProcess$states$sk extends Translations$taker$paymentProcess$states$en {
	_Translations$taker$paymentProcess$states$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get preparing => 'Príprava na odoslanie platby...';
	@override String get sending => 'Odosiela sa platba...';
	@override String get received => 'Platba prijatá!';
	@override String get failed => 'Platba zlyhala';
	@override String get waitingUpdate => 'Čaká sa na aktualizáciu ponuky...';
}

// Path: taker.paymentProcess.steps
class _Translations$taker$paymentProcess$steps$sk extends Translations$taker$paymentProcess$steps$en {
	_Translations$taker$paymentProcess$steps$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String makerConfirmedBlik({required Object code}) => 'Predávajúci potvrdil platbu ${code}';
	@override String get makerInvoiceSettled => 'Hold faktúra predávajúceho vyrovnaná';
	@override String get takerInvoicePaid => 'Platí sa tvoja Lightning faktúra';
	@override String get takerPaymentFailed => 'Platba na tvoju faktúru zlyhala';
}

// Path: taker.paymentProcess.errors
class _Translations$taker$paymentProcess$errors$sk extends Translations$taker$paymentProcess$errors$en {
	_Translations$taker$paymentProcess$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String sending({required Object details}) => 'Chyba pri odosielaní platby: ${details}';
	@override String get notConfirmed => 'Ponuka nebola potvrdená predávajúcim.';
	@override String get expired => 'Ponuka vypršala.';
	@override String get cancelled => 'Ponuka zrušená.';
	@override String get paymentFailed => 'Platba ponuky zlyhala.';
	@override String get unknown => 'Neznáma chyba ponuky.';
	@override String get takerPaymentFailed => 'Platba na tvoju Lightning faktúru zlyhala.';
	@override String get noPublicKey => 'Chyba: Nepodarilo sa načítať tvoj verejný kľúč.';
	@override String get loadingPublicKey => 'Chyba pri načítaní tvojich údajov';
	@override String get missingPaymentHash => 'Chyba: Chýbajú detaily platby.';
}

// Path: taker.paymentProcess.loading
class _Translations$taker$paymentProcess$loading$sk extends Translations$taker$paymentProcess$loading$en {
	_Translations$taker$paymentProcess$loading$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get publicKey => 'Načítavajú sa tvoje údaje...';
}

// Path: taker.paymentProcess.actions
class _Translations$taker$paymentProcess$actions$sk extends Translations$taker$paymentProcess$actions$en {
	_Translations$taker$paymentProcess$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get goToFailureDetails => 'Skúsiť znova s novou faktúrou';
}

// Path: taker.paymentFailed.form
class _Translations$taker$paymentFailed$form$sk extends Translations$taker$paymentFailed$form$en {
	_Translations$taker$paymentFailed$form$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get newInvoiceLabel => 'Nová Lightning faktúra';
	@override String get newInvoiceHint => 'Zadaj svoju BOLT11 faktúru';
}

// Path: taker.paymentFailed.actions
class _Translations$taker$paymentFailed$actions$sk extends Translations$taker$paymentFailed$actions$en {
	_Translations$taker$paymentFailed$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get retryPayment => 'Odoslať novú faktúru';
}

// Path: taker.paymentFailed.errors
class _Translations$taker$paymentFailed$errors$sk extends Translations$taker$paymentFailed$errors$en {
	_Translations$taker$paymentFailed$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get enterValidInvoice => 'Zadaj platnú faktúru';
	@override String updatingInvoice({required Object details}) => 'Chyba pri aktualizácii faktúry: ${details}';
	@override String get paymentRetryFailed => 'Opätovná platba zlyhala. Skontroluj faktúru alebo to skús znova neskôr.';
	@override String get takerPublicKeyNotFound => 'Verejný kľúč kupujúceho sa nenašiel.';
	@override String generateFailed({required Object details}) => 'Nepodarilo sa vygenerovať faktúru: ${details}';
}

// Path: taker.paymentFailed.walletSection
class _Translations$taker$paymentFailed$walletSection$sk extends Translations$taker$paymentFailed$walletSection$en {
	_Translations$taker$paymentFailed$walletSection$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vygenerovať faktúru z peňaženky';
	@override String get defaultLabel => 'predvolená';
	@override String tapToGenerate({required Object amountSats}) => 'Ťukni na vygenerovanie faktúry na ${amountSats}';
}

// Path: taker.paymentFailed.loading
class _Translations$taker$paymentFailed$loading$sk extends Translations$taker$paymentFailed$loading$en {
	_Translations$taker$paymentFailed$loading$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get processingPayment => 'Spracúva sa opätovná platba...';
}

// Path: taker.paymentFailed.success
class _Translations$taker$paymentFailed$success$sk extends Translations$taker$paymentFailed$success$en {
	_Translations$taker$paymentFailed$success$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Platba úspešná';
	@override String get message => 'Tvoja platba bola úspešne spracovaná.';
}

// Path: taker.paymentSuccess.actions
class _Translations$taker$paymentSuccess$actions$sk extends Translations$taker$paymentSuccess$actions$en {
	_Translations$taker$paymentSuccess$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get goHome => 'Prejsť domov';
}

// Path: taker.criticalCodeDecision.actions
class _Translations$taker$criticalCodeDecision$actions$sk extends Translations$taker$criticalCodeDecision$actions$en {
	_Translations$taker$criticalCodeDecision$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Späť a skontrolovať banku';
	@override String get proceed => 'NEBOLO mi strhnuté — pokračovať';
}

// Path: taker.invalidBlik.actions
class _Translations$taker$invalidBlik$actions$sk extends Translations$taker$invalidBlik$actions$en {
	_Translations$taker$invalidBlik$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String retry({required Object code}) => 'Poslať nový ${code}';
	@override String get cancelReservation => 'Zrušiť transakciu';
	@override String get reportConflict => 'Začať spor';
	@override String get returnHome => 'Vrátiť sa domov';
}

// Path: taker.invalidBlik.confirmDialog
class _Translations$taker$invalidBlik$confirmDialog$sk extends Translations$taker$invalidBlik$confirmDialog$en {
	_Translations$taker$invalidBlik$confirmDialog$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Naozaj?';
	@override String get content => 'Keď na to ťukneš, niet cesty späť.\n\nAk ti suma naozaj BOLA strhnutá z bankového účtu, koordinátor NEbude môcť zaručiť, že dostaneš bitcoin, a môžeš prísť o svoje prostriedky.\n\nAk si nie si istý, je najlepšie chvíľu počkať a potvrdiť si, že ti NEbolo strhnuté, skôr než budeš pokračovať.';
	@override late final _Translations$taker$invalidBlik$confirmDialog$actions$sk actions = _Translations$taker$invalidBlik$confirmDialog$actions$sk._(_root);
}

// Path: taker.invalidBlik.disputeConfirmDialog
class _Translations$taker$invalidBlik$disputeConfirmDialog$sk extends Translations$taker$invalidBlik$disputeConfirmDialog$en {
	_Translations$taker$invalidBlik$disputeConfirmDialog$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Začať spor?';
	@override String get content => 'Spor začni iba vtedy, ak ti suma BOLA strhnutá z bankového účtu.\n\nKoordinátor manuálne posúdi tvoj prípad, čo zaberie čas. Budeš musieť poskytnúť dôkaz o platbe.';
	@override late final _Translations$taker$invalidBlik$disputeConfirmDialog$actions$sk actions = _Translations$taker$invalidBlik$disputeConfirmDialog$actions$sk._(_root);
}

// Path: taker.invalidBlik.feedback
class _Translations$taker$invalidBlik$feedback$sk extends Translations$taker$invalidBlik$feedback$en {
	_Translations$taker$invalidBlik$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get conflictReportedSuccess => 'Konflikt nahlásený. Koordinátor ho posúdi.';
}

// Path: taker.invalidBlik.errors
class _Translations$taker$invalidBlik$errors$sk extends Translations$taker$invalidBlik$errors$en {
	_Translations$taker$invalidBlik$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get reservationFailed => 'Nepodarilo sa znova rezervovať ponuku';
	@override String conflictReport({required Object details}) => 'Chyba pri nahlasovaní konfliktu: ${details}';
}

// Path: taker.conflict.actions
class _Translations$taker$conflict$actions$sk extends Translations$taker$conflict$actions$en {
	_Translations$taker$conflict$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get back => 'Späť domov';
}

// Path: taker.conflict.feedback
class _Translations$taker$conflict$feedback$sk extends Translations$taker$conflict$feedback$en {
	_Translations$taker$conflict$feedback$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get reported => 'Nahlásený konflikt platby. Čaká sa na potvrdenie Makera.';
}

// Path: taker.conflict.errors
class _Translations$taker$conflict$errors$sk extends Translations$taker$conflict$errors$en {
	_Translations$taker$conflict$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String reporting({required Object details}) => 'Chyba pri nahlasovaní konfliktu: ${details}';
}

// Path: taker.conflict.nostrContact
class _Translations$taker$conflict$nostrContact$sk extends Translations$taker$conflict$nostrContact$en {
	_Translations$taker$conflict$nostrContact$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontaktuj koordinátora na Nostr';
	@override String get description => 'Môžeš koordinátorovi napísať priamu správu (DM) a požiadať o pomoc s týmto sporom.';
	@override String get copyNpub => 'Kopírovať npub';
	@override String get openProfile => 'Zobraziť profil';
	@override String get npubCopied => 'Npub koordinátora skopírovaný do schránky!';
	@override String get yourIdentityDescription => 'Ak chceš posielať DM, prihlás sa svojím súkromným kľúčom Neko (nsec) v ľubovoľnom Nostr klientovi, ktorý podporuje priame správy.';
	@override String get manageNekoKeys => 'Spravovať Neko kľúče';
}

// Path: home.statistics.errors
class _Translations$home$statistics$errors$sk extends Translations$home$statistics$errors$en {
	_Translations$home$statistics$errors$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String loading({required Object error}) => 'Chyba pri načítaní štatistík: ${error}';
}

// Path: settings.offerCreation.categoryOptions
class _Translations$settings$offerCreation$categoryOptions$sk extends Translations$settings$offerCreation$categoryOptions$en {
	_Translations$settings$offerCreation$categoryOptions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Obchod, kaviareň alebo reštaurácia';
	@override String get atm => 'Výber z bankomatu';
	@override String get online => 'Online služba/produkt';
}

// Path: settings.offerCreation.dialogs
class _Translations$settings$offerCreation$dialogs$sk extends Translations$settings$offerCreation$dialogs$en {
	_Translations$settings$offerCreation$dialogs$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get selectCategory => 'Vyber predvolenú kategóriu';
	@override String get selectBank => 'Vyber predvolenú banku';
	@override String get selectCoordinator => 'Vyber preferovaného koordinátora';
	@override String get premiumHint => 'Zadaj percento, napríklad 1.5. Hodnoty sa zaokrúhľujú na kroky po 0.5%.';
	@override String get premiumHelper => 'Uplatní sa, keď sú zapnuté prémiové ceny, a je obmedzená maximom vybraného koordinátora.';
}

// Path: settings.display.unitOptions
class _Translations$settings$display$unitOptions$sk extends Translations$settings$display$unitOptions$en {
	_Translations$settings$display$unitOptions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get sats => 'sats';
	@override String get bitcoin => '₿ (BIP-177)';
}

// Path: settings.paymentSystem.countries
class _Translations$settings$paymentSystem$countries$sk extends Translations$settings$paymentSystem$countries$en {
	_Translations$settings$paymentSystem$countries$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get PL => 'Poľsko';
	@override String get PT => 'Portugalsko';
	@override String get CH => 'Švajčiarsko';
	@override String get SK => 'Slovensko';
}

// Path: maker.amountForm.category.options
class _Translations$maker$amountForm$category$options$sk extends Translations$maker$amountForm$category$options$en {
	_Translations$maker$amountForm$category$options$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Obchod, kaviareň alebo reštaurácia';
	@override String get atmCashout => 'Výber z bankomatu';
	@override String get onlineService => 'Online služba/produkt';
}

// Path: maker.amountForm.category.shortLabels
class _Translations$maker$amountForm$category$shortLabels$sk extends Translations$maker$amountForm$category$shortLabels$en {
	_Translations$maker$amountForm$category$shortLabels$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Obchod';
	@override String get atm => 'Bankomat';
	@override String get online => 'Online';
}

// Path: maker.conflict.disputeDialog.actions
class _Translations$maker$conflict$disputeDialog$actions$sk extends Translations$maker$conflict$disputeDialog$actions$en {
	_Translations$maker$conflict$disputeDialog$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Otvoriť spor';
	@override String get cancel => 'Zrušiť';
}

// Path: taker.invalidBlik.confirmDialog.actions
class _Translations$taker$invalidBlik$confirmDialog$actions$sk extends Translations$taker$invalidBlik$confirmDialog$actions$en {
	_Translations$taker$invalidBlik$confirmDialog$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Som si istý, pokračovať';
	@override String get cancel => 'Zrušiť';
}

// Path: taker.invalidBlik.disputeConfirmDialog.actions
class _Translations$taker$invalidBlik$disputeConfirmDialog$actions$sk extends Translations$taker$invalidBlik$disputeConfirmDialog$actions$en {
	_Translations$taker$invalidBlik$disputeConfirmDialog$actions$sk._(TranslationsSk root) : this._root = root, super.internal(root);

	final TranslationsSk _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Áno, bolo mi strhnuté';
	@override String get cancel => 'Zrušiť';
}

/// The flat map containing all translations for locale <sk>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsSk {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => ({required Object app}) => '${app}',
			'app.greeting' => 'Ahoj!',
			'app.changelog' => 'Zoznam zmien',
			'common.code' => 'kód',
			'common.buttons.cancel' => 'Zrušiť',
			'common.buttons.save' => 'Uložiť',
			'common.buttons.done' => 'Hotovo',
			'common.buttons.retry' => 'Skúsiť znova',
			'common.buttons.goHome' => 'Domov',
			'common.buttons.saveAndContinue' => 'Uložiť a pokračovať',
			'common.buttons.reveal' => 'Zobraziť',
			'common.buttons.hide' => 'Skryť',
			'common.buttons.copy' => 'Kopírovať',
			'common.buttons.close' => 'Zavrieť',
			'common.buttons.restore' => 'Obnoviť',
			'common.buttons.faq' => 'FAQ',
			'common.labels.amount' => ({required Object currency}) => 'Suma (${currency})',
			'common.labels.status' => ({required Object status}) => 'Stav: ${status}',
			'common.labels.role' => ({required Object role}) => 'Rola: ${role}',
			'common.notifications.success' => 'Hotovo',
			'common.notifications.error' => 'Chyba',
			'common.notifications.loading' => 'Načítava sa...',
			'common.clipboard.copyToClipboard' => 'Kopírovať do schránky',
			'common.clipboard.pasteFromClipboard' => 'Vložiť zo schránky',
			'common.clipboard.copied' => 'Skopírované do schránky!',
			'common.actions.cancelAndReturnToOffers' => 'Zrušiť a vrátiť sa k ponukám',
			'common.actions.cancelAndReturnHome' => 'Zrušiť a vrátiť sa domov',
			'lightningAddress.labels.address' => 'Lightning adresa (LNURL)',
			'lightningAddress.labels.hint' => 'pouzivatel@domena.com',
			'lightningAddress.labels.short' => ({required Object address}) => 'Lightning adresa: ${address}',
			'lightningAddress.labels.receivingAddress' => 'Tvoja adresa na prijímanie:',
			'lightningAddress.prompts.enter' => 'Zadaj svoju Lightning adresu a pokračuj',
			'lightningAddress.prompts.edit' => 'Upraviť',
			'lightningAddress.prompts.invalid' => 'Zadaj platnú Lightning adresu',
			'lightningAddress.prompts.required' => 'Lightning adresa je povinná.',
			'lightningAddress.prompts.enterToTakeOffer' => 'Na prijatie ponuky musíš nastaviť Lightning adresu.',
			'lightningAddress.prompts.missing' => 'Chýba Lightning adresa. Pridaj ju, aby si mohol prijímať ponuky.',
			'lightningAddress.prompts.add' => 'Pridať',
			'lightningAddress.prompts.delete' => 'Odstrániť',
			'lightningAddress.prompts.confirmDelete' => 'Naozaj chceš odstrániť svoju Lightning adresu?',
			'lightningAddress.prompts.howToGet' => 'Ešte nemáš Lightning adresu? Zisti, ako ju získať!',
			'lightningAddress.prompts.learnMore' => 'Zisti viac o Lightning adrese',
			'lightningAddress.feedback.saved' => 'Lightning adresa uložená!',
			'lightningAddress.feedback.updated' => 'Lightning adresa aktualizovaná!',
			'lightningAddress.feedback.valid' => 'Platná Lightning adresa',
			'lightningAddress.errors.saving' => ({required Object details}) => 'Chyba pri ukladaní adresy: ${details}',
			'lightningAddress.errors.loading' => ({required Object details}) => 'Chyba pri načítaní Lightning adresy: ${details}',
			'offers.details.yourOffer' => 'Tvoja ponuka:',
			'offers.details.selectedOffer' => 'Ponuka:',
			'offers.details.activeOffer' => 'Máš aktívnu ponuku:',
			'offers.details.finishedOffers' => 'Dokončené ponuky',
			'offers.details.noAvailable' => 'Žiadne dostupné ponuky.',
			'offers.details.noAvailableTip' => ({required Object app}) => 'Tip: zdieľaj ${app} vo svojej komunite a medzi priateľmi, aby si zvýšil počet objednávok v ${app}.',
			'offers.details.noSuccessfulTrades' => 'Žiadne úspešné obchody.',
			'offers.details.loadingDetails' => 'Načítavajú sa detaily ponuky...',
			'offers.details.amount' => ({required Object amount}) => 'Suma: ${amount} satoshi',
			'offers.details.amountWithCurrency' => ({required Object amount, required Object currency}) => '${amount} ${currency}',
			'offers.details.makerFee' => ({required Object fee}) => 'Poplatok: ${fee} sats',
			'offers.details.takerFee' => ({required Object fee}) => 'Poplatok: ${fee} sats',
			'offers.details.subtitle' => ({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (poplatok) satoshi\nStav: ${status}',
			'offers.details.subtitleWithDate' => ({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (poplatok) satoshi\nStav: ${status}\nZaplatené: ${date}',
			'offers.details.activeSubtitle' => ({required Object status, required Object amount}) => 'Stav: ${status}\nSuma: ${amount} satoshi',
			'offers.details.id' => ({required Object id}) => 'ID ponuky: ${id}...',
			'offers.details.created' => ({required Object dateTime}) => 'Vytvorené: ${dateTime}',
			'offers.details.takenAfter' => ({required Object duration}) => 'Prijaté po: ${duration}',
			'offers.details.paidAfter' => ({required Object duration}) => 'Zaplatené po: ${duration}',
			'offers.details.exchangeRate' => 'Výmenný kurz',
			'offers.details.amountLabel' => 'Suma',
			'offers.details.makerFeeLabel' => 'Poplatok predávajúceho',
			'offers.details.takerFeeLabel' => 'Poplatok kupujúceho',
			'offers.details.feeLabel' => 'Poplatok',
			'offers.details.statusLabel' => 'Stav',
			'offers.details.youllReceive' => 'Dostaneš',
			'offers.details.coordinator' => 'Koordinátor',
			'offers.details.categoryLabel' => 'Kategória',
			'offers.details.categories.physicalShop' => 'Obchod, kaviareň alebo reštaurácia',
			'offers.details.categories.atmCashout' => 'Výber z bankomatu',
			'offers.details.categories.onlineService' => 'Online služba/produkt',
			'offers.details.consents.atm' => 'Niektoré bankomaty pripočítajú k sume ponuky ďalší poplatok. Prijatím tejto ponuky súhlasíš s akýmikoľvek dodatočnými bankovými poplatkami, ktoré bankomat vyžaduje.',
			'offers.details.consents.ecommerce' => ({required Object code}) => 'Z rôznych dôvodov — napríklad kvôli vypredanému tovaru, oprave preplatku alebo iným problémom na strane obchodníka — môže online obchodník automaticky poslať peniaze späť na bankový účet spojený s kódom ${code}, ktorý si vygeneroval. Tieto prostriedky pristanú na tvojom účte a nepatria tebe. Ak sa to stane, kontaktuj v dobrej viere koordinátora a dohodni sa na vrátení prostriedkov predávajúcemu. Prijatím tejto ponuky súhlasíš s týmito podmienkami a čestne sľubuješ, že sa v takýchto situáciách zachováš poctivo.',
			'offers.labels.premium' => 'Prémia',
			'offers.labels.premiumBadge' => ({required Object percent}) => '+${percent}% prémia',
			'offers.tooltips.takerFeeInfo' => ({required Object feePercent}) => 'Koordinátor si účtuje ${feePercent}% poplatok kupujúceho. Ten zahŕňa smerovacie poplatky Lightning a odpočíta sa zo sumy, ktorú dostaneš.',
			'offers.tooltips.premiumInfoTaker' => 'Prémia znamená, že táto ponuka je ocenená nad trhovou cenou. Za rovnakú sumu vo fiate predávajúci uzamkne menej sats v hold faktúre, takže platíš nad trh a dostaneš menej sats než pri trhovom kurze. Maximálnu prémiu určuje koordinátor.',
			'offers.tooltips.ratesFetchedAt' => 'Načítané o',
			'offers.tooltips.ratesSources' => 'Zdroje priem. kurzu',
			'offers.actions.take' => 'PRIJAŤ',
			'offers.actions.takeOffer' => 'Prijať ponuku',
			'offers.actions.resume' => ({required Object code}) => 'ZADAŤ ${code}',
			'offers.actions.cancel' => 'Zrušiť ponuku',
			'offers.actions.view' => 'Zobraziť detaily',
			'offers.status.created' => 'Vytvorená',
			'offers.status.funded' => 'Financovaná',
			'offers.status.expired' => 'Vypršaná',
			'offers.status.cancelled' => 'Zrušená',
			'offers.status.reserved' => 'Rezervovaná',
			'offers.status.blikReceived' => ({required Object code}) => '${code} odoslaný',
			'offers.status.blikSentToMaker' => ({required Object code}) => '${code} prijatý',
			'offers.status.expiredBlik' => ({required Object code}) => '${code} vypršal',
			'offers.status.expiredSentBlik' => ({required Object code}) => '${code} vypršal',
			'offers.status.takerCharged' => 'Kupujúci zaťažený',
			'offers.status.invalidBlik' => ({required Object code}) => 'Neplatný ${code}',
			'offers.status.conflict' => 'Konflikt',
			'offers.status.dispute' => 'Spor',
			'offers.status.refundedMaker' => 'Makerovi boli vrátené prostriedky',
			'offers.status.refundingMaker' => 'Vrátenie platby makerovi',
			'offers.status.makerConfirmed' => 'Potvrdená',
			'offers.status.settled' => 'Vyrovnaná',
			'offers.status.payingTaker' => 'Platí sa kupujúcemu',
			'offers.status.takerPaymentFailed' => 'Platba kupujúcemu zlyhala',
			'offers.status.takerPaid' => 'Kupujúci zaplatený',
			'offers.status.unknownStatus' => 'Neznámy',
			'offers.statusMessages.reserved' => 'Ponuku rezervoval kupujúci!',
			'offers.statusMessages.cancelled' => 'Ponuka úspešne zrušená.',
			'offers.statusMessages.cancelledOrExpired' => 'Ponuka bola zrušená alebo vypršala.',
			'offers.statusMessages.noLongerAvailable' => ({required Object status}) => 'Ponuka už nie je dostupná (Stav: ${status}).',
			'offers.progress.waitingForTaker' => ({required Object time}) => 'Čaká sa na kupujúceho: ${time}',
			'offers.progress.reserved' => ({required Object seconds}) => 'Rezervované: ostáva ${seconds} s',
			'offers.progress.confirming' => ({required Object seconds}) => 'Potvrdzuje sa: ostáva ${seconds} s',
			'offers.errors.loading' => ({required Object details}) => 'Chyba pri načítaní ponúk: ${details}',
			'offers.errors.loadingDetails' => ({required Object details}) => 'Chyba pri načítaní detailov ponuky: ${details}',
			'offers.errors.detailsMissing' => 'Chyba: Detaily ponuky chýbajú alebo sú neplatné.',
			'offers.errors.detailsNotLoaded' => 'Nepodarilo sa načítať detaily ponuky.',
			'offers.errors.notFound' => 'Chyba: Ponuka sa nenašla.',
			'offers.errors.unexpectedState' => 'Chyba: Ponuka je v neočakávanom stave.',
			'offers.errors.unexpectedStateWithStatus' => ({required Object status}) => 'Ponuka je v neočakávanom stave (${status}). Skús to znova alebo kontaktuj podporu.',
			'offers.errors.invalidStatus' => 'Ponuka má neplatný stav.',
			'offers.errors.couldNotIdentify' => 'Chyba: Nepodarilo sa identifikovať ponuku na zrušenie.',
			'offers.errors.cannotBeCancelled' => ({required Object status}) => 'Ponuku nie je možné zrušiť v aktuálnom stave (${status}).',
			'offers.errors.failedToCancel' => ({required Object details}) => 'Nepodarilo sa zrušiť ponuku: ${details}',
			'offers.errors.activeDetailsLost' => 'Chyba: Stratili sa detaily aktívnej ponuky.',
			'offers.errors.checkingActive' => ({required Object details}) => 'Chyba pri kontrole aktívnych ponúk: ${details}',
			'offers.errors.cannotResume' => ({required Object status}) => 'Ponuku nie je možné obnoviť v stave: ${status}',
			'offers.errors.cannotResumeTaker' => ({required Object status}) => 'Ponuku kupujúceho nie je možné obnoviť v stave: ${status}',
			'offers.errors.resuming' => ({required Object details}) => 'Chyba pri obnovovaní ponuky: ${details}',
			'offers.errors.makerPublicKeyNotFound' => 'Verejný kľúč predávajúceho sa nenašiel',
			'offers.errors.takerPublicKeyNotFound' => 'Verejný kľúč kupujúceho sa nenašiel.',
			'offers.errors.atmConsentRequired' => 'Pred prijatím tejto ponuky prijmi podmienku dodatočného poplatku bankomatu.',
			'offers.errors.ecommerceConsentRequired' => 'Pred prijatím tejto ponuky prijmi podmienku vrátenia peňazí pri e-commerce.',
			'offers.errors.cannotTakeOwnOffer' => 'Nemôžeš prijať vlastnú ponuku.',
			'offers.success.title' => 'Ponuka dokončená',
			'offers.success.headline' => 'Platba potvrdená!',
			'offers.success.subtitle' => 'Kupujúcemu sa teraz zaplatí.',
			'offers.success.detailsTitle' => 'Detaily ponuky:',
			'offers.success.duration' => ({required Object time}) => 'Dokončenie ponuky trvalo ${time}.',
			'reservations.actions.cancel' => 'Zrušiť rezerváciu',
			'reservations.feedback.cancelled' => 'Rezervácia zrušená.',
			'reservations.errors.cancelling' => ({required Object error}) => 'Nepodarilo sa zrušiť rezerváciu: ${error}',
			'reservations.errors.failedToReserve' => ({required Object details}) => 'Nepodarilo sa rezervovať ponuku: ${details}',
			'reservations.errors.failedNoTimestamp' => 'Nepodarilo sa rezervovať ponuku (chýba časová značka).',
			'reservations.errors.timestampMissing' => 'Chýba časová značka rezervácie ponuky.',
			'reservations.errors.notReserved' => ({required Object status}) => 'Ponuka už nie je v rezervovanom stave (${status}).',
			'exchange.labels.enterAmount' => ({required Object currency}) => 'Zadaj sumu (${currency}) na zaplatenie:',
			'exchange.labels.equivalent' => ({required Object sats}) => '≈ ${sats} satoshi',
			'exchange.labels.rate' => ({required Object rate, required Object currency}) => 'Výmenný kurz ≈ ${rate} ${currency}/BTC',
			'exchange.feedback.fetching' => 'Načítava sa výmenný kurz...',
			'exchange.errors.fetchingRate' => 'Nepodarilo sa načítať výmenný kurz.',
			'exchange.errors.invalidFormat' => 'Neplatný formát čísla',
			'exchange.errors.mustBePositive' => 'Suma musí byť kladná',
			'exchange.errors.invalidFeePercentage' => 'Neplatné percento poplatku',
			'exchange.errors.tooLowFiat' => ({required Object minAmount, required Object currency}) => 'Suma je príliš nízka. Minimum je ${minAmount} ${currency}.',
			'exchange.errors.tooHighFiat' => ({required Object maxAmount, required Object currency}) => 'Suma je príliš vysoká. Maximum je ${maxAmount} ${currency}.',
			'exchange.errors.atmNotDispensable' => ({required Object notes}) => 'Bankomat nedokáže vydať túto sumu. Použi kombináciu bankoviek: ${notes}.',
			'exchange.errors.atmOverBankLimit' => ({required Object bank, required Object limit, required Object currency}) => '${bank} vydá na jeden výber najviac ${limit} ${currency}.',
			'coordinator.title' => 'Koordinátori',
			'coordinator.info.fee' => 'poplatok',
			'coordinator.info.rangeDisplay' => ({required Object minAmount, required Object maxAmount, required Object currency}) => 'Suma: ${minAmount}-${maxAmount} ${currency}',
			'coordinator.info.feeDisplay' => ({required Object fee}) => '${fee}% poplatok',
			'coordinator.selector.loading' => 'Načítavajú sa koordinátori...',
			'coordinator.selector.errorLoading' => 'Chyba pri načítaní koordinátorov',
			'coordinator.selector.choose' => 'Vyber koordinátora',
			'coordinator.selector.viewNostrProfile' => 'Zobraziť Nostr profil',
			'coordinator.selector.unresponsive' => 'Tento koordinátor neodpovedá',
			'coordinator.selector.waitingResponse' => 'Čaká sa na odpoveď koordinátora',
			'coordinator.selector.termsAccept' => 'Súhlasím s ',
			'coordinator.selector.termsOfUsage' => 'podmienkami používania',
			'coordinator.dialog.makerFee' => 'Poplatok predávajúceho',
			'coordinator.dialog.takerFee' => 'Poplatok kupujúceho',
			'coordinator.dialog.amountRange' => 'Rozsah sumy',
			'coordinator.dialog.reservationTime' => 'Čas rezervácie',
			'coordinator.dialog.currencies' => 'Meny',
			'coordinator.dialog.viewTerms' => 'Zobraziť podmienky',
			'coordinator.details.title' => 'Koordinátor',
			'coordinator.details.relaysInUse' => 'Používané relaye',
			'coordinator.details.relaysInUseHint' => 'Všetka komunikácia s týmto koordinátorom prebieha cez tieto relaye (z jeho zoznamu NIP-65).',
			'coordinator.details.noRelays' => 'Zatiaľ nie sú známe žiadne relaye',
			'coordinator.details.makerFee' => 'Poplatok predávajúceho',
			'coordinator.details.takerFee' => 'Poplatok kupujúceho',
			'coordinator.details.amountRange' => 'Rozsah sumy',
			'coordinator.details.maxPremium' => 'Max. prémia',
			'coordinator.details.maxPremiumInfoTitle' => 'Prémia',
			'coordinator.details.maxPremiumInfoBody' => 'Prémia je voliteľná prirážka nad trhový kurz, ktorú môže predávajúci nastaviť na ponuke. S prémiou predávajúci uzamkne menej sats za rovnakú sumu vo fiate, takže kupujúci platí nad trh a predávajúci si ponechá rozdiel. Táto hodnota je najvyššia prémia, ktorú tento koordinátor na svojich ponukách povoľuje.',
			'coordinator.details.reservationTime' => 'Čas rezervácie',
			'coordinator.details.currencies' => 'Meny',
			'coordinator.details.paymentSystem' => 'Platobný systém',
			'coordinator.details.version' => 'Verzia',
			'coordinator.details.yourOffers' => 'Tvoje ponuky',
			'coordinator.details.successfulOffers' => 'Úspešné ponuky (30d)',
			'coordinator.details.statusOnline' => 'Online',
			'coordinator.details.statusOffline' => 'Offline',
			'coordinator.details.statusUnknown' => 'Neznámy',
			'coordinator.details.openNostrProfile' => 'Otvoriť Nostr profil',
			'coordinator.details.termsOfUsage' => 'Podmienky používania',
			'coordinator.coldStart.title' => 'Vyhľadávanie koordinátorov',
			'coordinator.coldStart.body' => ({required Object app}) => '${app} hľadá verejných koordinátorov, kontroluje, ktorí sú dostupní, a zapne pre teba malú predvolenú skupinu.',
			'coordinator.coldStart.settingsHint' => 'Zapnutých koordinátorov môžeš neskôr zmeniť v Nastaveniach.',
			'coordinator.coldStart.ok' => 'OK',
			'coordinator.coldStart.discovered' => 'Nájdení',
			'coordinator.coldStart.candidates' => 'Kandidáti',
			'coordinator.coldStart.enabled' => 'Zapnutí',
			'coordinator.coldStart.recordsTitle' => 'Aktuálni koordinátori',
			'coordinator.coldStart.recordEnabled' => 'Zapnutý',
			'coordinator.coldStart.recordHealthyCandidate' => 'Zdravý kandidát',
			'coordinator.coldStart.recordOfflineCandidate' => 'Kandidát offline',
			'coordinator.coldStart.recordChecking' => 'Kontroluje sa',
			'coordinator.coldStart.recordDiscovered' => 'Nájdený',
			'coordinator.coldStart.phases.loadingMuteList' => 'Načítavajú sa filtre koordinátorov',
			'coordinator.coldStart.phases.discovering' => 'Vyhľadávanie koordinátorov na Nostr',
			'coordinator.coldStart.phases.loadingProfiles' => 'Načítavajú sa profily koordinátorov',
			'coordinator.coldStart.phases.loadingStats' => 'Číta sa história koordinátorov',
			'coordinator.coldStart.phases.checkingHealth' => 'Kontrola stavu koordinátorov',
			'coordinator.coldStart.phases.finalizing' => 'Zapínajú sa predvolení koordinátori',
			'coordinator.coldStart.phases.completed' => 'Hotovo',
			'coordinator.management.title' => 'Správa koordinátorov',
			'coordinator.management.availableCoordinators' => 'Koordinátori',
			'coordinator.management.noCoordinators' => 'Zatiaľ neboli nájdení žiadni koordinátori.',
			'coordinator.management.online' => 'Online',
			'coordinator.management.unknownOffline' => 'Neznámy/Offline',
			'coordinator.management.openNostrProfile' => 'Otvoriť Nostr profil',
			'coordinator.management.enable' => 'Zapnúť',
			'coordinator.management.remove' => 'Odstrániť',
			'coordinator.management.addCustomWhitelist' => 'Pridať koordinátora',
			'coordinator.management.addCustomWhitelistHint' => 'npub1...',
			'coordinator.management.add' => 'Pridať',
			'coordinator.management.coordinatorDisabled' => 'Koordinátor vypnutý',
			'coordinator.management.coordinatorEnabled' => 'Koordinátor zapnutý',
			'coordinator.management.coordinatorAdded' => 'Koordinátor pridaný do vlastného zoznamu',
			'coordinator.management.coordinatorRemoved' => 'Koordinátor odstránený z vlastného zoznamu',
			'coordinator.management.coordinatorAddInfoUnavailable' => 'Na relayoch sa nenašli žiadne informácie o koordinátorovi. Koordinátor nebol pridaný.',
			'coordinator.management.pleaseEnterNpub' => 'Zadaj npub',
			'coordinator.management.error' => 'Chyba',
			'coordinator.management.metricYourOffers' => 'Tvoje ponuky',
			'coordinator.management.metricYourOffersTooltip' => 'Počet ponúk, ktoré si úspešne dokončil s týmto koordinátorom.',
			'coordinator.management.metricNetworkOffers' => 'Ponuky (30d)',
			'coordinator.management.metricNetworkOffersTooltip' => 'Úspešné ponuky vyrovnané týmto koordinátorom naprieč všetkými používateľmi za posledných 30 dní.',
			'disputeChat.viewHistory' => 'Zobraziť históriu sporu',
			'disputeChat.historyTitle' => 'História sporu',
			'disputeChat.ruledForMaker' => 'Rozhodnuté v prospech Makera',
			'disputeChat.ruledForTaker' => 'Rozhodnuté v prospech Takera',
			'disputeChat.legacyChannel' => 'Starší kompatibilný kanál NIP-04',
			'disputeChat.privateConversation' => 'Súkromná konverzácia s koordinátorom',
			'disputeChat.noMessages' => 'Zatiaľ žiadne správy.',
			'disputeChat.replyHint' => 'Odpovedzte tu',
			'disputeChat.readOnly' => 'História tohto vyriešeného sporu je iba na čítanie.',
			'disputeChat.evidenceDeadline.title' => 'Lehota na predloženie dôkazov',
			'disputeChat.evidenceDeadline.remaining' => ({required Object time}) => 'Predložte dôkazy podporujúce vaše tvrdenie do ${time}. Po uplynutí lehoty môže koordinátor rozhodnúť v prospech protistrany podľa dostupných dôkazov.',
			'disputeChat.evidenceDeadline.expired' => 'Lehota na predloženie dôkazov uplynula. Koordinátor môže teraz rozhodnúť podľa dostupných dôkazov.',
			'disputeChat.evidenceDeadline.period' => ({required Object time}) => 'Koordinátor poskytuje na dôkazy najviac ${time} od otvorenia sporu. Odpočítavanie sa začne, keď bude dostupný čas otvorenia sporu.',
			'disputeChat.tooltips.refresh' => 'Obnoviť správy',
			'disputeChat.tooltips.attachEvidence' => 'Priložiť doklad o platbe',
			'disputeChat.tooltips.send' => 'Odoslať správu',
			'disputeChat.errors.accountNotReady' => 'Súkromné správy budú dostupné, keď bude váš účet Nostr pripravený.',
			'disputeChat.errors.subscriptionFailed' => 'Pripojenie súkromných správ zlyhalo. Obnovte konverzáciu.',
			'disputeChat.errors.decryptFailed' => 'Súkromnú správu sa nepodarilo dešifrovať.',
			'disputeChat.errors.operationFailed' => 'Operácia súkromných správ zlyhala. Skúste to znova.',
			'disputeChat.errors.nostrNotInitialized' => 'Nostr nie je inicializovaný.',
			'disputeChat.errors.attachmentsRequireNip17' => 'Prílohy sú dostupné iba v kanáli NIP-17.',
			'receivingInvoice.errors.walletUnavailable' => 'Služba peňaženky nie je dostupná.',
			'receivingInvoice.errors.noBolt11' => 'Peňaženka nevrátila BOLT11 faktúru.',
			'maker.refundInvoice.title' => 'Koordinátor rozhodol vo váš prospech',
			'maker.refundInvoice.instructions' => ({required Object amount}) => 'Vyberte prijímaciu peňaženku alebo vložte Lightning faktúru na presnú sumu ${amount} pre vrátenie platby.',
			'maker.refundInvoice.invoiceLabel' => 'Faktúra na vrátenie presnej sumy',
			'maker.refundInvoice.submit' => 'Odoslať faktúru na vrátenie platby',
			'maker.refundInvoice.addWallet' => 'Pridať novú peňaženku',
			'maker.refundInvoice.noReceivingWallet' => 'Nie je nastavená žiadna prijímacia peňaženka. Pridajte ju alebo vložte faktúru z inej peňaženky.',
			'maker.refundInvoice.paymentFailed' => 'Predchádzajúci pokus o vrátenie platby zlyhal. Vyberte inú peňaženku alebo odošlite novú faktúru.',
			'maker.refundInvoice.submitFailed' => ({required Object details}) => 'Faktúru na vrátenie platby sa nepodarilo odoslať: ${details}',
			'maker.refundInvoice.errors.backendUnavailable' => 'Služba platieb Lightning nie je dostupná.',
			'maker.refundInvoice.errors.missing' => 'Zadajte faktúru na vrátenie platby.',
			'maker.refundInvoice.errors.invalid' => 'Zadajte platnú BOLT11 faktúru na vrátenie platby.',
			'maker.refundInvoice.errors.wrongNetwork' => 'Faktúra na vrátenie platby patrí do nesprávnej siete Lightning.',
			'maker.refundInvoice.errors.wrongAmount' => 'Faktúra musí obsahovať presnú sumu vrátenia platby.',
			'maker.refundInvoice.errors.invalidExpiry' => 'Faktúra na vrátenie platby má neplatnú dobu platnosti.',
			'maker.refundInvoice.errors.futureTimestamp' => 'Časová pečiatka faktúry je v budúcnosti.',
			'maker.refundInvoice.errors.expired' => 'Faktúra na vrátenie platby vypršala. Vytvorte novú.',
			'maker.refundInvoice.errors.invalidPaymentHash' => 'Faktúra nemá platný hash platby.',
			'maker.refundInvoice.errors.reusedInvoice' => 'Použite novú faktúru; faktúra ponuky nemôže prijať vrátenie platby.',
			'maker.refundInvoice.errors.unsupportedNetwork' => 'Táto sieť Lightning nie je podporovaná.',
			'maker.refundInvoice.errors.unknown' => 'Skontrolujte faktúru a skúste to znova.',
			'maker.roleSelection.button' => 'ZAPLATIŤ cez Lightning',
			'maker.amountForm.progress.step1' => '1. Vytvoriť ponuku',
			'maker.amountForm.progress.step2' => '2. Čakať na kupujúceho',
			'maker.amountForm.progress.step3' => ({required Object code}) => '3. Použiť ${code}',
			'maker.amountForm.labels.coordinator' => 'Koordinátor',
			'maker.amountForm.labels.category' => 'Kategória',
			'maker.amountForm.labels.exchangeRate' => 'Výmenný kurz',
			'maker.amountForm.labels.fee' => 'Poplatok',
			'maker.amountForm.labels.satoshisToPay' => 'Suma na zaplatenie',
			'maker.amountForm.labels.enterAmount' => 'Zadaj sumu',
			'maker.amountForm.labels.customAmount' => 'Vlastná',
			'maker.amountForm.labels.tapToSelect' => 'Ťukni na výber',
			'maker.amountForm.labels.premium' => 'Prémia',
			'maker.amountForm.actions.generateInvoice' => 'Vygenerovať faktúru',
			'maker.amountForm.bank.label' => 'Banka',
			'maker.amountForm.bank.required' => 'Vyber si banku',
			'maker.amountForm.bank.shortValidityWarning' => ({required Object minutes}) => 'Kód tejto banky platí len ${minutes} min — buď pri bankomate skôr, než rezervuješ.',
			'maker.amountForm.tooltips.feeInfo' => ({required Object feePercent}) => 'Koordinátor si účtuje ${feePercent}% poplatok predávajúceho. Tento poplatok sa odpočíta z tvojej Lightning platby.',
			'maker.amountForm.tooltips.payInfo' => 'Tento výpočet vychádza z výmenných kurzov načítaných na strane klienta. Koordinátor vypočíta presnú sumu a suma na faktúre bude konečná a presná suma na zaplatenie.',
			'maker.amountForm.tooltips.premiumInfo' => 'Voliteľná prémia ti umožňuje predať sats nad trhovú cenu. Prémia zníži počet sats uzamknutých v tvojej hold faktúre za rovnakú sumu vo fiate, takže kupujúci platí nad trh a ty si ponecháš rozdiel. Predvolene je vypnutá (0%). Maximálnu prémiu určuje vybraný koordinátor.',
			'maker.amountForm.category.label' => 'Kategória ponuky',
			'maker.amountForm.category.unsupportedForSystem' => ({required Object system}) => '${system} nepodporuje túto kategóriu.',
			'maker.amountForm.category.options.physicalShop' => 'Obchod, kaviareň alebo reštaurácia',
			'maker.amountForm.category.options.atmCashout' => 'Výber z bankomatu',
			'maker.amountForm.category.options.onlineService' => 'Online služba/produkt',
			'maker.amountForm.category.shortLabels.shop' => 'Obchod',
			'maker.amountForm.category.shortLabels.atm' => 'Bankomat',
			'maker.amountForm.category.shortLabels.online' => 'Online',
			'maker.amountForm.category.atmHint' => 'Kupujúci uvidia, že táto ponuka je na výber z bankomatu, a môžu sa jej vyhnúť, ak im banka účtuje ďalšie poplatky za bankomat.',
			'maker.amountForm.category.physicalShopHint' => ({required Object app, required Object code}) => 'Ideálne miesto na použitie ${app} je samoobslužná pokladňa — keďže čakanie na to, kým kupujúci rezervuje, vygeneruje a potvrdí ${code}, môže trvať pár minút. Skvele funguje v obchodoch, kaviarňach aj reštauráciách. Ak sa cítiš dosť odvážny na to, aby si nechal bežného pokladníka (a ľudí v rade za tebou) čakať tých pár minút, tak nech sa páči.',
			'maker.amountForm.category.ecommerceWarningTitle' => 'Riziko vrátenia peňazí od online obchodníka',
			'maker.amountForm.category.ecommerceWarningBody' => ({required Object code}) => 'Z rôznych dôvodov — napríklad kvôli vypredanému tovaru, oprave preplatku alebo iným problémom na strane obchodníka — môže online obchodník automaticky vystaviť vrátenie peňazí na bankový účet spojený s kódom ${code}, čo je účet kupujúceho. Koordinátor nemôže prinútiť kupujúceho, aby ti tieto prostriedky vrátil.',
			'maker.amountForm.category.ecommerceConfirmation' => 'Rozumiem riziku vrátenia peňazí a k objednávke pridám poznámku, aby obchodník v prípade potreby vrátil peniaze na iný účet.',
			'maker.amountForm.category.whyThisIsNeeded' => 'prečo je to potrebné?',
			'maker.amountForm.onboarding.titlePrefix' => 'Nové',
			'maker.amountForm.onboarding.title' => 'Vyber kategóriu ponuky',
			'maker.amountForm.onboarding.body' => 'Pred vygenerovaním faktúry vyber kategóriu, ktorá najlepšie zodpovedá tomu, za čo platíš.',
			'maker.amountForm.onboarding.showWhy' => 'Prečo na tom záleží?',
			'maker.amountForm.onboarding.hideWhy' => 'Skryť detaily',
			'maker.amountForm.onboarding.whyTitle' => 'Správna kategória pomáha kupujúcim bezpečne sa rozhodnúť',
			'maker.amountForm.onboarding.whyBody' => 'Rôzne situácie prinášajú rôzne očakávania a riziká. Výbery z bankomatu môžu zahŕňať ďalšie bankové poplatky a online nákupy môžu zahŕňať okrajové prípady s vrátením peňazí. Označenie správnej kategórie dáva kupujúcim kontext, ktorý potrebujú pred prijatím tvojej ponuky.',
			'maker.amountForm.onboarding.cta' => 'Rozumiem',
			'maker.amountForm.errors.initiating' => ({required Object details}) => 'Chyba pri vytváraní ponuky: ${details}',
			'maker.amountForm.errors.publicKeyNotLoaded' => 'Chyba: Verejný kľúč ešte nie je načítaný.',
			'maker.amountForm.errors.noCoordinatorMatchesAmount' => 'Túto sumu nepodporuje žiadny koordinátor. Skús inú hodnotu.',
			'maker.amountForm.errors.categoryRequired' => 'Vyber kategóriu ponuky.',
			'maker.amountForm.errors.ecommerceConfirmationRequired' => 'Pred pokračovaním potvrď riziko vrátenia peňazí od online obchodníka.',
			'maker.payInvoice.title' => 'Zaplať túto hold faktúru:',
			'maker.payInvoice.actions.copy' => 'Kopírovať faktúru',
			'maker.payInvoice.actions.payInWallet' => 'Otvoriť v externej peňaženke',
			'maker.payInvoice.actions.connectWallet' => 'Pripojiť peňaženku',
			'maker.payInvoice.actions.payWithNwc' => 'Zaplatiť',
			'maker.payInvoice.actions.paying' => 'Platí sa...',
			'maker.payInvoice.feedback.copied' => 'Faktúra skopírovaná do schránky!',
			'maker.payInvoice.feedback.waitingConfirmation' => 'Čaká sa na potvrdenie platby...',
			'maker.payInvoice.feedback.nwcConnected' => 'NWC peňaženka pripojená!',
			'maker.payInvoice.feedback.nwcPaymentSuccess' => 'Platba úspešná!',
			'maker.payInvoice.errors.couldNotOpenApp' => 'Nepodarilo sa otvoriť Lightning aplikáciu pre faktúru.',
			'maker.payInvoice.errors.openingApp' => ({required Object details}) => 'Chyba pri otváraní Lightning aplikácie: ${details}',
			'maker.payInvoice.errors.publicKeyNotAvailable' => 'Verejný kľúč nie je dostupný.',
			'maker.payInvoice.errors.couldNotFetchActive' => 'Nepodarilo sa načítať detaily aktívnej ponuky. Mohla vypršať.',
			'maker.payInvoice.errors.nwcPaymentFailed' => ({required Object details}) => 'Platba zlyhala: ${details}',
			'maker.payInvoice.errors.nwcNotConnected' => 'NWC peňaženka nie je pripojená',
			'maker.payInvoice.errors.insufficientBalance' => ({required Object required, required Object available}) => 'Nedostatočný zostatok. Potrebuješ ${required} sats, máš ${available} sats',
			'maker.payInvoice.errors.cancelOfferAlreadyFunded' => 'Koordinátor hlási, že táto ponuka je už financovaná. Teraz ju nie je možné zrušiť.',
			'maker.payInvoice.errors.cancelFailed' => ({required Object details}) => 'Nepodarilo sa zrušiť ponuku: ${details}',
			'maker.payInvoice.budgetWarning.title' => 'Platba môže zlyhať',
			'maker.payInvoice.budgetWarning.balanceTooLow' => ({required Object name}) => 'Tvoja predvolená peňaženka na platby ${name} nemá dostatočný zostatok na túto platbu.',
			'maker.payInvoice.budgetWarning.budgetTooLow' => ({required Object name}) => 'Tvoja predvolená peňaženka na platby ${name} nemá dostatočný rozpočet na túto platbu.',
			'maker.payInvoice.budgetWarning.balanceLine' => ({required Object available}) => 'Zostatok: ${available}',
			'maker.payInvoice.budgetWarning.budgetLine' => ({required Object remaining}) => 'Zostávajúci NWC rozpočet: ${remaining}',
			'maker.payInvoice.budgetWarning.requiredLine' => ({required Object required}) => 'Potrebné: ${required}',
			'maker.payInvoice.budgetWarning.addFundsHint' => ({required Object name}) => 'Dobi ${name}, aby si pokryl túto sumu platby.',
			'maker.payInvoice.budgetWarning.increaseBudgetHint' => 'Zvýš NWC rozpočet na míňanie pre toto pripojenie v aplikácii svojej peňaženky.',
			'maker.payInvoice.budgetWarning.switchWalletLabel' => 'Alebo použi inú peňaženku:',
			'maker.payInvoice.budgetWarning.walletLowFundsTag' => 'Môže zlyhať',
			'maker.payInvoice.budgetWarning.payAnyway' => 'Skúsiť aj tak',
			'maker.payInvoice.budgetWarning.cancel' => 'Zrušiť',
			'maker.payInvoice.budgetWarning.readyTitle' => 'Zaplatiť faktúru',
			'maker.waitTaker.message' => 'Čaká sa, kým kupujúci rezervuje tvoju ponuku...',
			'maker.waitTaker.progressLabel' => ({required Object time}) => 'Čaká sa na kupujúceho: ${time}',
			'maker.waitTaker.errorActiveOfferDetailsLost' => 'Chyba: Stratili sa detaily aktívnej ponuky.',
			'maker.waitTaker.errorFailedToRetrieveBlik' => ({required Object code}) => 'Chyba: Nepodarilo sa načítať ${code}.',
			'maker.waitTaker.errorRetrievingBlik' => ({required Object code, required Object details}) => 'Chyba pri načítaní ${code}: ${details}',
			'maker.waitTaker.offerNoLongerAvailable' => ({required Object status}) => 'Ponuka už nie je dostupná (Stav: ${status}).',
			'maker.waitTaker.errorCouldNotIdentifyOffer' => 'Chyba: Nepodarilo sa identifikovať ponuku na zrušenie.',
			'maker.waitTaker.offerCannotBeCancelled' => ({required Object status}) => 'Ponuku nie je možné zrušiť v aktuálnom stave (${status}).',
			'maker.waitTaker.offerCancelledSuccessfully' => 'Ponuka úspešne zrušená.',
			'maker.waitTaker.failedToCancelOffer' => ({required Object details}) => 'Nepodarilo sa zrušiť ponuku: ${details}',
			'maker.waitTaker.offerExpiredTitle' => 'Ponuka vypršala',
			'maker.waitTaker.offerExpiredMessage' => 'Žiadny kupujúci nerezervoval tvoju ponuku načas.',
			'maker.waitTaker.recreateOffer' => 'Nová ponuka — rovnaká suma',
			'maker.waitForBlik.title' => ({required Object code}) => 'Čaká sa na ${code}',
			'maker.waitForBlik.messageInfo' => 'Kupujúci rezervoval ponuku!',
			'maker.waitForBlik.messageWaiting' => ({required Object code}) => 'Čaká sa na poskytnutie ${code}...',
			'maker.waitForBlik.progressLabel' => ({required Object seconds}) => 'Rezervované: ostáva ${seconds} s',
			'maker.confirmPayment.title' => ({required Object code}) => '${code} prijatý!',
			'maker.confirmPayment.retrieving' => ({required Object code}) => 'Načítava sa ${code}...',
			'maker.confirmPayment.instructions' => 'Zadaj tento kód do platobného terminálu. Keď kupujúci potvrdí platbu vo svojej bankovej aplikácii a platba je úspešná, stlač Potvrdiť nižšie.',
			'maker.confirmPayment.instruction1' => ({required Object code}) => 'Zadaj kód do platobnej výzvy ${code}.',
			'maker.confirmPayment.instruction2' => 'Počkaj, kým kupujúci potvrdí platbu vo svojej aplikácii.',
			'maker.confirmPayment.instruction3' => 'Keď je platba úspešná, stlač Potvrdiť nižšie:',
			'maker.confirmPayment.mbwayAtmInstructions' => ({required Object amount, required Object minutes}) => 'Ak chceš vybrať ${amount} €, choď k najbližšiemu bankomatu MULTIBANCO, stlač zelené tlačidlo a vyber možnosť "Výber hotovosti" ("Levantar Dinheiro"). Zadaj kód. Tento kód je platný ${minutes} minút.',
			'maker.confirmPayment.cardlessAtmInstructions' => ({required Object amount, required Object currency, required Object bank, required Object minutes}) => 'Ak chceš vybrať ${amount} ${currency}, choď k bankomatu ${bank}, spusti výber bez karty / cez mobil a zadaj kód — karta nie je potrebná. Kód je platný ${minutes} minút.',
			'maker.confirmPayment.findAtms' => ({required Object bank}) => 'Nájdi bankomaty ${bank} na mape',
			'maker.confirmPayment.takerChargedWarning' => ({required Object code}) => 'Kupujúci nahlásil, že platba ${code} bola strhnutá z jeho bankového účtu. Ak toto označíš ako neplatné, spôsobí to konflikt.',
			'maker.confirmPayment.autoConfirmInfo' => ({required Object code}) => 'Ak neoznačíš ${code} ako neplatný, platba sa po uplynutí tohto času automaticky potvrdí a kupujúcemu sa zaplatí.',
			'maker.confirmPayment.autoConfirmCountdown' => ({required Object time}) => 'Automatické potvrdenie o ${time}',
			'maker.confirmPayment.expiredTitle' => ({required Object code}) => 'Kód ${code} vypršal',
			'maker.confirmPayment.expiredWarning' => ({required Object code}) => '${code} vypršal. Musíš manuálne potvrdiť stav platby:',
			'maker.confirmPayment.expiredInstruction1' => ({required Object code}) => 'Ak bola platba ${code} úspešná a dokončil si nákup, klikni nižšie na "Potvrdiť úspešnú platbu".',
			'maker.confirmPayment.expiredInstruction2' => ({required Object code}) => 'Ak platba ${code} zlyhala alebo nebola dokončená, klikni nižšie na "Neplatný kód ${code}".',
			'maker.confirmPayment.actions.confirm' => 'Potvrdiť úspešnú platbu',
			'maker.confirmPayment.actions.markInvalid' => ({required Object code}) => 'Neplatný kód ${code}',
			'maker.confirmPayment.actions.copyBlik' => ({required Object code}) => 'Kopírovať ${code}',
			'maker.confirmPayment.confirmDialog.title' => 'Potvrdiť platbu?',
			'maker.confirmPayment.confirmDialog.content' => ({required Object code}) => 'Táto akcia je nezvratná. Po potvrdení:\n\n• Kupujúci okamžite dostane prostriedky\n• Koordinátor nebude môcť prostriedky spochybniť\n• Túto akciu nemôžeš vrátiť späť\n\nPotvrď iba vtedy, ak bola platba ${code} úspešná.',
			'maker.confirmPayment.confirmDialog.cancel' => 'Zrušiť',
			'maker.confirmPayment.confirmDialog.confirmButton' => 'Áno, potvrdiť platbu',
			'maker.confirmPayment.invalidBlikDisputeDialog.title' => 'Otvoriť spor?',
			'maker.confirmPayment.invalidBlikDisputeDialog.content' => ({required Object code}) => 'Kupujúci nahlásil, že platba ${code} bola strhnutá z jeho účtu.\n\nOznačením ako neplatné okamžite otvoríš SPOR, ktorý vyžaduje zásah koordinátora.\n\n• Ak sa rozhodne v tvoj neprospech, môže byť účtovaný poplatok za spor\n• Hold faktúra sa okamžite vyrovná\n• Bude potrebné manuálne overenie\n\nPokračuj iba vtedy, ak si istý, že platba ${code} NEbola úspešná.',
			'maker.confirmPayment.invalidBlikDisputeDialog.cancel' => 'Zrušiť',
			'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton' => 'Áno, otvoriť spor',
			'maker.confirmPayment.feedback.confirmed' => 'Predávajúci potvrdil platbu.',
			'maker.confirmPayment.feedback.confirmedTakerPaid' => 'Platba potvrdená! Kupujúci dostane prostriedky.',
			'maker.confirmPayment.feedback.progressLabel' => ({required Object seconds}) => 'Potvrdzuje sa: ostáva ${seconds} s',
			'maker.confirmPayment.errors.failedToRetrieve' => ({required Object code}) => 'Chyba: Nepodarilo sa načítať ${code}.',
			'maker.confirmPayment.errors.retrieving' => ({required Object code, required Object details}) => 'Chyba pri načítaní ${code}: ${details}',
			'maker.confirmPayment.errors.missingHashOrKey' => 'Chyba: Chýba hash platby alebo verejný kľúč.',
			'maker.confirmPayment.errors.incorrectState' => ({required Object status}) => 'Ponuka nie je v správnom stave na potvrdenie (Stav: ${status})',
			'maker.confirmPayment.errors.confirming' => ({required Object details}) => 'Chyba pri potvrdzovaní platby: ${details}',
			'maker.confirmPayment.errors.invalidState' => 'Chyba: Prijatý neplatný stav ponuky.',
			'maker.confirmPayment.errors.internalIncomplete' => 'Interná chyba: Neúplné detaily ponuky.',
			'maker.confirmPayment.errors.notAwaitingConfirmation' => ({required Object status}) => 'Ponuka už nečaká na potvrdenie (Stav: ${status}).',
			'maker.confirmPayment.errors.unexpectedStatus' => 'Zo servera prišiel neočakávaný stav ponuky.',
			'maker.invalidBlik.title' => ({required Object code}) => 'Neplatný kód ${code}',
			'maker.invalidBlik.info' => ({required Object code}) => 'Označil si ${code} ako neplatný. Čaká sa, kým kupujúci poskytne nový kód alebo začne spor.',
			'maker.conflict.title' => 'Konflikt ponuky',
			'maker.conflict.headline' => 'Nahlásený konflikt ponuky',
			'maker.conflict.body' => ({required Object code}) => 'Označil si ${code} ako neplatný, ale kupujúci nahlásil konflikt, čím naznačuje, že podľa neho bola platba úspešná.',
			'maker.conflict.instructions' => 'Potvrď výsledok pred vypršaním časovača. Ak bola platba úspešná, potvrď ju, aby mohol byť kupujúci vyplatený. Ak zlyhala, otvor spor. Ak nič neurobíš, automaticky sa otvorí formálny spor.',
			'maker.conflict.timeoutLabel' => ({required Object time}) => 'Formálny spor sa automaticky otvorí o ${time}',
			'maker.conflict.actions.back' => 'Späť domov',
			'maker.conflict.actions.confirmPayment' => ({required Object code}) => 'Moja chyba, potvrdiť úspešnú platbu ${code}',
			'maker.conflict.actions.openDispute' => ({required Object code}) => 'Platba ${code} NEbola úspešná, OTVORIŤ SPOR',
			'maker.conflict.actions.submitDispute' => 'Odoslať spor',
			'maker.conflict.disputeDialog.title' => 'Otvoriť spor?',
			'maker.conflict.disputeDialog.content' => 'Otvorenie sporu vyžaduje manuálne overenie koordinátorom, čo zaberie čas. Ak sa spor rozhodne v tvoj neprospech, odpočíta sa poplatok za spor. Hold faktúra sa vyrovná, aby nevypršala. Ak sa spor rozhodne v tvoj prospech, dostaneš vrátené prostriedky (mínus poplatky) do peňaženky podľa vlastného výberu.',
			'maker.conflict.disputeDialog.contentDetailed' => 'Otvorenie sporu bude vyžadovať manuálny zásah koordinátora, čo zaberie čas a je spojené s poplatkom za spor.\n\nHold faktúra sa okamžite vyrovná, aby nevypršala pred vyriešením sporu.\n\nAk sa spor rozhodne v tvoj prospech, suma satoshi sa vráti do peňaženky podľa tvojho výberu (mínus poplatky). Uisti sa, že máš pripravenú peňaženku na prijatie.',
			'maker.conflict.disputeDialog.actions.confirm' => 'Otvoriť spor',
			'maker.conflict.disputeDialog.actions.cancel' => 'Zrušiť',
			'maker.conflict.feedback.disputeOpenedSuccess' => 'Spor úspešne otvorený. Koordinátor ho posúdi.',
			'maker.conflict.errors.openingDispute' => ({required Object error}) => 'Chyba pri otváraní sporu: ${error}',
			'maker.conflict.nostrContact.title' => 'Kontaktuj koordinátora na Nostr',
			'maker.conflict.nostrContact.description' => 'Môžeš koordinátorovi napísať priamu správu (DM) a požiadať o pomoc s týmto sporom.',
			'maker.conflict.nostrContact.copyNpub' => 'Kopírovať npub',
			'maker.conflict.nostrContact.openProfile' => 'Zobraziť profil',
			'maker.conflict.nostrContact.npubCopied' => 'Npub koordinátora skopírovaný do schránky!',
			'maker.conflict.nostrContact.yourIdentityDescription' => 'Ak chceš posielať DM, prihlás sa svojím súkromným kľúčom Neko (nsec) v ľubovoľnom Nostr klientovi, ktorý podporuje priame správy.',
			'maker.conflict.nostrContact.manageNekoKeys' => 'Spravovať Neko kľúče',
			'maker.success.title' => 'Ponuka dokončená',
			'maker.success.headline' => 'Platba potvrdená!',
			'maker.success.subtitle' => 'Kupujúcemu sa teraz zaplatí.',
			'maker.success.detailsTitle' => 'Detaily ponuky:',
			'maker.success.duration' => ({required Object time}) => 'Ponuka trvala ${time}!',
			'taker.roleSelection.button' => ({required Object code}) => 'PREDAŤ ${code} za satoshi',
			'taker.progress.step1' => ({required Object code}) => 'Odoslať ${code}',
			'taker.progress.step2' => ({required Object code}) => 'Potvrdiť ${code}',
			'taker.progress.step3' => 'Dostať zaplatené',
			'taker.submitBlik.title' => ({required Object digits, required Object code}) => 'Zadaj ${digits}-miestny ${code}',
			'taker.submitBlik.label' => ({required Object code}) => 'Kód ${code}',
			'taker.submitBlik.generateInBank' => ({required Object bank}) => 'Vygeneruj kód na výber v aplikácii ${bank}.',
			'taker.submitBlik.instruction' => ({required Object code}) => 'Zadaj ${code}, kým vyprší čas...',
			'taker.submitBlik.timeLimit' => ({required Object code, required Object seconds}) => 'Zadaj ${code} do: ${seconds} s',
			'taker.submitBlik.timeExpired' => ({required Object code}) => 'Čas na zadanie ${code} vypršal.',
			'taker.submitBlik.actions.submit' => ({required Object code}) => 'Odoslať ${code}',
			'taker.submitBlik.feedback.pasted' => ({required Object code}) => 'Vložený ${code}.',
			'taker.submitBlik.validation.invalidFormat' => ({required Object digits, required Object code}) => 'Zadaj platný ${digits}-miestny ${code}.',
			'taker.submitBlik.errors.submitting' => ({required Object code, required Object details}) => 'Chyba pri odosielaní ${code}: ${details}',
			'taker.submitBlik.errors.clipboardInvalid' => ({required Object digits, required Object code}) => 'Schránka neobsahuje platný ${digits}-miestny ${code}.',
			'taker.submitBlik.errors.stateChanged' => 'Chyba: Stav ponuky sa zmenil.',
			'taker.submitBlik.errors.stateNotValid' => 'Chyba: Stav ponuky už nie je platný.',
			'taker.submitBlik.errors.fetchedIdMismatch' => ({required Object fetchedId, required Object initialId}) => 'Načítané ID aktívnej ponuky (${fetchedId}) sa nezhoduje s pôvodným ID ponuky (${initialId}). Nesúlad stavu?',
			'taker.submitBlik.errors.paymentHashMissing' => 'Po načítaní chýba hash platby ponuky.',
			'taker.submitBlik.details.requestedAmount' => ({required Object code}) => 'Požadovaná suma ${code}',
			'taker.submitBlik.details.exchangeRate' => 'Výmenný kurz',
			'taker.submitBlik.details.takerFee' => 'Poplatok kupujúceho',
			'taker.submitBlik.details.status' => 'Stav',
			'taker.submitBlik.details.youllReceive' => 'Dostaneš',
			'taker.waitConfirmation.title' => 'Čaká sa na predávajúceho',
			'taker.waitConfirmation.statusLabel' => ({required Object status}) => 'Stav ponuky: ${status}',
			'taker.waitConfirmation.waitingMaker' => ({required Object seconds}) => 'Čaká sa na potvrdenie predávajúceho: ${seconds} s',
			'taker.waitConfirmation.waitingMakerConfirmation' => ({required Object code, required Object seconds}) => 'Čaká sa, kým predávajúci potvrdí, že ${code} je správny. Zostávajúci čas: ${seconds}s',
			'taker.waitConfirmation.importantNotice' => ({required Object code, required Object amount, required Object currency}) => 'VEĽMI DÔLEŽITÉ: Uisti sa, že prijímaš potvrdenie ${code} iba na ${amount} ${currency}',
			'taker.waitConfirmation.importantBlikAmountConfirmation' => ({required Object code, required Object amount, required Object currency}) => 'VEĽMI DÔLEŽITÉ: V bankovej aplikácii sa uisti, že potvrdzuješ platbu ${code} presne na ${amount} ${currency}.',
			'taker.waitConfirmation.instructions' => ({required Object minutes, required Object code}) => 'Predávajúci ho teraz musí zadať do platobného terminálu do ${minutes} minút. Potom musíš ${code} prijať vo svojej bankovej aplikácii.',
			'taker.waitConfirmation.instructionsNoConfirm' => ({required Object code, required Object minutes}) => 'Predávajúci teraz musí zadať tvoj ${code} do bankomatu do ${minutes} minút.',
			'taker.waitConfirmation.categoryReminder.atm' => 'Pripomienka k ponuke bankomatu: tvoja banka ťa môže ešte požiadať o schválenie dodatočného poplatku za bankomat nad hlavnú sumu.',
			'taker.waitConfirmation.categoryReminder.ecommerce' => 'Pripomienka k online objednávke: ak obchodník pošle automatické vrátenie peňazí na tvoj bankový účet, kontaktuj koordinátora a vráť ich.',
			'taker.waitConfirmation.waitingForMakerToReceive' => ({required Object code}) => 'Čaká sa, kým predávajúci dostane tvoj ${code}...',
			'taker.waitConfirmation.makerReceivedBlik' => ({required Object code}) => 'Predávajúci dostal tvoj ${code}.',
			'taker.waitConfirmation.timerExpiredMessage' => ({required Object code, required Object minutes}) => 'Čas platnosti ${code} (${minutes}m) uplynul. Čaká sa, kým predávajúci potvrdí alebo označí kód ako neplatný.',
			'taker.waitConfirmation.timerExpiredActions' => ({required Object code, required Object minutes}) => 'Čas platnosti ${code} (${minutes}m) uplynul, ale predávajúci nedostal ${code}. Môžeš poslať nový ${code} alebo zrušiť.',
			'taker.waitConfirmation.resendBlikButton' => ({required Object code}) => 'Poslať nový kód ${code}',
			'taker.waitConfirmation.navigatedHome' => 'Presmerované domov.',
			'taker.waitConfirmation.expiredTitle' => ({required Object code}) => 'Kód ${code} vypršal',
			'taker.waitConfirmation.expiredWarning' => ({required Object code}) => 'Predávajúci nedostal ${code}, takže ho nemohol použiť.',
			'taker.waitConfirmation.expiredRelistCountdownLabel' => 'Rezervácia končí o',
			'taker.waitConfirmation.expiredSentWarning' => 'Predávajúci ešte nepotvrdil platbu. Čo chceš urobiť?',
			'taker.waitConfirmation.expiredInstruction1' => ({required Object code}) => 'Ak to chceš skúsiť znova s novým ${code}, obnov rezerváciu.',
			'taker.waitConfirmation.expiredInstruction2' => 'Ak už túto transakciu nechceš dokončiť, zruš rezerváciu.',
			'taker.waitConfirmation.expiredInstruction3' => ({required Object code}) => 'Ak bola platba ${code} strhnutá z tvojho bankového účtu, neboj sa, bitcoin je stále bezpečne uzamknutý u koordinátora.',
			'taker.waitConfirmation.takerCharged.title' => ({required Object code}) => 'Označil si ${code} ako strhnutý',
			'taker.waitConfirmation.takerCharged.message' => ({required Object minutes}) => 'Predávajúci má ${minutes} min na potvrdenie platby alebo jej spochybnenie. Ak neurobí nič, platba sa automaticky potvrdí a ty dostaneš bitcoin.',
			'taker.waitConfirmation.expiredActions.reportConflict' => ({required Object code}) => '${code} bol strhnutý z môjho bankového účtu',
			'taker.waitConfirmation.expiredActions.renewReservation' => ({required Object code}) => 'Skúsiť znova s novým ${code}',
			'taker.waitConfirmation.expiredActions.cancelReservation' => 'Zrušiť rezerváciu',
			'taker.waitConfirmation.feedback.makerConfirmed' => 'Predávajúci potvrdil platbu.',
			'taker.waitConfirmation.feedback.paymentSuccessful' => 'Platba úspešná! Čoskoro dostaneš prostriedky.',
			'taker.waitConfirmation.feedback.conflictReported' => 'Konflikt nahlásený. Koordinátor posúdi situáciu.',
			'taker.waitConfirmation.errors.invalidOfferStateReceived' => 'Prijatá ponuka s neplatným stavom pre túto obrazovku. Resetuje sa.',
			'taker.waitConfirmation.errors.reportingConflict' => ({required Object details}) => 'Chyba pri nahlasovaní konfliktu: ${details}',
			'taker.paymentProcess.title' => 'Priebeh platby',
			_ => null,
		} ?? switch (path) {
			'taker.paymentProcess.waitingForOfferUpdate' => 'Čaká sa na aktualizáciu stavu ponuky...',
			'taker.paymentProcess.states.preparing' => 'Príprava na odoslanie platby...',
			'taker.paymentProcess.states.sending' => 'Odosiela sa platba...',
			'taker.paymentProcess.states.received' => 'Platba prijatá!',
			'taker.paymentProcess.states.failed' => 'Platba zlyhala',
			'taker.paymentProcess.states.waitingUpdate' => 'Čaká sa na aktualizáciu ponuky...',
			'taker.paymentProcess.steps.makerConfirmedBlik' => ({required Object code}) => 'Predávajúci potvrdil platbu ${code}',
			'taker.paymentProcess.steps.makerInvoiceSettled' => 'Hold faktúra predávajúceho vyrovnaná',
			'taker.paymentProcess.steps.takerInvoicePaid' => 'Platí sa tvoja Lightning faktúra',
			'taker.paymentProcess.steps.takerPaymentFailed' => 'Platba na tvoju faktúru zlyhala',
			'taker.paymentProcess.errors.sending' => ({required Object details}) => 'Chyba pri odosielaní platby: ${details}',
			'taker.paymentProcess.errors.notConfirmed' => 'Ponuka nebola potvrdená predávajúcim.',
			'taker.paymentProcess.errors.expired' => 'Ponuka vypršala.',
			'taker.paymentProcess.errors.cancelled' => 'Ponuka zrušená.',
			'taker.paymentProcess.errors.paymentFailed' => 'Platba ponuky zlyhala.',
			'taker.paymentProcess.errors.unknown' => 'Neznáma chyba ponuky.',
			'taker.paymentProcess.errors.takerPaymentFailed' => 'Platba na tvoju Lightning faktúru zlyhala.',
			'taker.paymentProcess.errors.noPublicKey' => 'Chyba: Nepodarilo sa načítať tvoj verejný kľúč.',
			'taker.paymentProcess.errors.loadingPublicKey' => 'Chyba pri načítaní tvojich údajov',
			'taker.paymentProcess.errors.missingPaymentHash' => 'Chyba: Chýbajú detaily platby.',
			'taker.paymentProcess.loading.publicKey' => 'Načítavajú sa tvoje údaje...',
			'taker.paymentProcess.actions.goToFailureDetails' => 'Skúsiť znova s novou faktúrou',
			'taker.paymentFailed.title' => 'Platba zlyhala',
			'taker.paymentFailed.instructions' => ({required Object netAmount}) => 'Poskytni novú Lightning faktúru na ${netAmount}',
			'taker.paymentFailed.form.newInvoiceLabel' => 'Nová Lightning faktúra',
			'taker.paymentFailed.form.newInvoiceHint' => 'Zadaj svoju BOLT11 faktúru',
			'taker.paymentFailed.actions.retryPayment' => 'Odoslať novú faktúru',
			'taker.paymentFailed.errors.enterValidInvoice' => 'Zadaj platnú faktúru',
			'taker.paymentFailed.errors.updatingInvoice' => ({required Object details}) => 'Chyba pri aktualizácii faktúry: ${details}',
			'taker.paymentFailed.errors.paymentRetryFailed' => 'Opätovná platba zlyhala. Skontroluj faktúru alebo to skús znova neskôr.',
			'taker.paymentFailed.errors.takerPublicKeyNotFound' => 'Verejný kľúč kupujúceho sa nenašiel.',
			'taker.paymentFailed.errors.generateFailed' => ({required Object details}) => 'Nepodarilo sa vygenerovať faktúru: ${details}',
			'taker.paymentFailed.walletSection.title' => 'Vygenerovať faktúru z peňaženky',
			'taker.paymentFailed.walletSection.defaultLabel' => 'predvolená',
			'taker.paymentFailed.walletSection.tapToGenerate' => ({required Object amountSats}) => 'Ťukni na vygenerovanie faktúry na ${amountSats}',
			'taker.paymentFailed.loading.processingPayment' => 'Spracúva sa opätovná platba...',
			'taker.paymentFailed.success.title' => 'Platba úspešná',
			'taker.paymentFailed.success.message' => 'Tvoja platba bola úspešne spracovaná.',
			'taker.paymentSuccess.title' => 'Platba úspešná',
			'taker.paymentSuccess.message' => 'Tvoja platba bola úspešne spracovaná.',
			'taker.paymentSuccess.actions.goHome' => 'Prejsť domov',
			'taker.criticalCodeDecision.title' => 'Kritické rozhodnutie',
			'taker.criticalCodeDecision.explanation' => ({required Object code}) => 'Predávajúcemu si už poskytol kód ${code}. Pokračovanie môže tento kód nahradiť, ukončiť tvoju rezerváciu a znovu sprístupniť ponuku iným kupujúcim.',
			'taker.criticalCodeDecision.warningTitle' => 'MÔŽEŠ PRÍSŤ O SVOJE PROSTRIEDKY',
			'taker.criticalCodeDecision.warningBody' => ({required Object code}) => 'Ak ti banka strhla platbu ${code}, NEPOKRAČUJ. Predávajúci mohol tvoj kód použiť a po tejto akcii už koordinátor nemusí vedieť zaručiť vyplatenie tvojich bitcoinov.',
			'taker.criticalCodeDecision.actions.cancel' => 'Späť a skontrolovať banku',
			'taker.criticalCodeDecision.actions.proceed' => 'NEBOLO mi strhnuté — pokračovať',
			'taker.invalidBlik.title' => ({required Object code}) => 'Neplatný kód ${code}',
			'taker.invalidBlik.message' => ({required Object code}) => 'Predávajúci odmietol kód ${code}',
			'taker.invalidBlik.explanation' => ({required Object code}) => 'Predávajúci ponuky uviedol, že ${code}, ktorý si poskytol, bol neplatný alebo nefungoval.\n\nČo chceš urobiť?',
			'taker.invalidBlik.werentCharged' => 'Ak ti NEBOLO nič strhnuté:',
			'taker.invalidBlik.wereCharged' => 'Ak ti bolo strhnuté:',
			'taker.invalidBlik.actions.retry' => ({required Object code}) => 'Poslať nový ${code}',
			'taker.invalidBlik.actions.cancelReservation' => 'Zrušiť transakciu',
			'taker.invalidBlik.actions.reportConflict' => 'Začať spor',
			'taker.invalidBlik.actions.returnHome' => 'Vrátiť sa domov',
			'taker.invalidBlik.confirmDialog.title' => 'Naozaj?',
			'taker.invalidBlik.confirmDialog.content' => 'Keď na to ťukneš, niet cesty späť.\n\nAk ti suma naozaj BOLA strhnutá z bankového účtu, koordinátor NEbude môcť zaručiť, že dostaneš bitcoin, a môžeš prísť o svoje prostriedky.\n\nAk si nie si istý, je najlepšie chvíľu počkať a potvrdiť si, že ti NEbolo strhnuté, skôr než budeš pokračovať.',
			'taker.invalidBlik.confirmDialog.actions.proceed' => 'Som si istý, pokračovať',
			'taker.invalidBlik.confirmDialog.actions.cancel' => 'Zrušiť',
			'taker.invalidBlik.disputeConfirmDialog.title' => 'Začať spor?',
			'taker.invalidBlik.disputeConfirmDialog.content' => 'Spor začni iba vtedy, ak ti suma BOLA strhnutá z bankového účtu.\n\nKoordinátor manuálne posúdi tvoj prípad, čo zaberie čas. Budeš musieť poskytnúť dôkaz o platbe.',
			'taker.invalidBlik.disputeConfirmDialog.actions.proceed' => 'Áno, bolo mi strhnuté',
			'taker.invalidBlik.disputeConfirmDialog.actions.cancel' => 'Zrušiť',
			'taker.invalidBlik.feedback.conflictReportedSuccess' => 'Konflikt nahlásený. Koordinátor ho posúdi.',
			'taker.invalidBlik.errors.reservationFailed' => 'Nepodarilo sa znova rezervovať ponuku',
			'taker.invalidBlik.errors.conflictReport' => ({required Object details}) => 'Chyba pri nahlasovaní konfliktu: ${details}',
			'taker.conflict.title' => 'Čaká sa na potvrdenie platby',
			'taker.conflict.headline' => 'Čaká sa na potvrdenie Makera',
			'taker.conflict.body' => ({required Object code}) => 'Nahlásil si, že platba ${code} bola zaúčtovaná, ale Maker uviedol, že nebola úspešná. Tieto hlásenia si odporujú.',
			'taker.conflict.instructions' => 'Maker teraz musí potvrdiť výsledok. Ak potvrdí, že platba bola úspešná, tvoja výplata bude pokračovať. Ak potvrdí neúspech alebo vyprší časovač, ponuka prejde do formálneho sporu a sprístupní sa chat sporu.',
			'taker.conflict.timeoutLabel' => ({required Object time}) => 'Formálny spor sa automaticky otvorí o ${time}',
			'taker.conflict.actions.back' => 'Späť domov',
			'taker.conflict.feedback.reported' => 'Nahlásený konflikt platby. Čaká sa na potvrdenie Makera.',
			'taker.conflict.errors.reporting' => ({required Object details}) => 'Chyba pri nahlasovaní konfliktu: ${details}',
			'taker.conflict.nostrContact.title' => 'Kontaktuj koordinátora na Nostr',
			'taker.conflict.nostrContact.description' => 'Môžeš koordinátorovi napísať priamu správu (DM) a požiadať o pomoc s týmto sporom.',
			'taker.conflict.nostrContact.copyNpub' => 'Kopírovať npub',
			'taker.conflict.nostrContact.openProfile' => 'Zobraziť profil',
			'taker.conflict.nostrContact.npubCopied' => 'Npub koordinátora skopírovaný do schránky!',
			'taker.conflict.nostrContact.yourIdentityDescription' => 'Ak chceš posielať DM, prihlás sa svojím súkromným kľúčom Neko (nsec) v ľubovoľnom Nostr klientovi, ktorý podporuje priame správy.',
			'taker.conflict.nostrContact.manageNekoKeys' => 'Spravovať Neko kľúče',
			'taker.dispute.headline' => 'Otvorený formálny spor',
			'taker.dispute.body' => 'Ponuku teraz posudzuje koordinátor. Pomocou chatu sporu nižšie komunikuj s koordinátorom a poskytni požadované dôkazy.',
			'blik.instructions.taker' => ({required Object code}) => 'Keď predávajúci zadá ${code}, budeš musieť potvrdiť platbu vo svojej bankovej aplikácii. Pred potvrdením sa uisti, že suma je správna.',
			'home.notifications.title' => 'Dostávaj upozornenia na nové ponuky cez:',
			'home.notifications.telegram' => 'Telegram',
			'home.notifications.simplex' => 'SimpleX',
			'home.notifications.matrix' => 'Matrix',
			'home.notifications.signal' => 'Signal',
			'home.notifications.channelAllBanks' => '(všetky banky)',
			'home.notifications.channelForBankPrefix' => '(len ponuky pre ',
			'home.notifications.channelForBankSuffix' => ')',
			'home.notifications.scopeAllBanks' => 'Všetky banky',
			'home.notifications.scopeBankOnly' => ({required Object bank}) => 'Len ${bank}',
			'home.statistics.title' => 'Dokončené ponuky',
			'home.statistics.lifetimeCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Všetky: ${count} transakcií\nPriem. čakanie na ${code}: ${avgBlikTime}\nPriem. čas dokončenia: ${avgPaidTime}',
			'home.statistics.last7DaysCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Posl. 7 dní: ${count} transakcií\nPriem. čakanie na ${code}: ${avgBlikTime}\nPriem. čas dokončenia: ${avgPaidTime}',
			'home.statistics.last7DaysSingleLine' => ({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Posl. 7 dní: ${count} ponúk  |  Priem. rezervácia: ${avgReservationTime}  |  Priem. zaplatené: ${avgPaidTime}',
			'home.statistics.errors.loading' => ({required Object error}) => 'Chyba pri načítaní štatistík: ${error}',
			'onboarding.title' => 'Vyber si trh',
			'onboarding.subtitle' => 'Vyber krajinu a platobný systém, ktorý budeš používať. Môžeš to kedykoľvek zmeniť v Nastaveniach.',
			'nekoInfo.title' => 'Čo je Neko?',
			'nekoInfo.description' => ({required Object app}) => 'Tvoje Neko je tvoja identita na používanie ${app}. Skladá sa zo súkromného a verejného kľúča, aby zaručilo kryptograficky bezpečnú komunikáciu s koordinátorom.\n\nPre väčšiu anonymitu sa odporúča použiť pre každú ponuku nové, čerstvé Neko.\n\n⚠️ DÔLEŽITÉ: Tvoj súkromný kľúč je uložený iba na tvojom zariadení (na strane klienta). Je mimoriadne dôležité si súkromný kľúč zálohovať, pretože strata prístupu k nemu ti môže znemožniť riešenie sporov a obnovu tvojich prostriedkov.',
			'nekoInfo.backupWarning' => 'Nezabudni si zálohovať svoje Neko',
			'generateNewKey.title' => 'Nové',
			'generateNewKey.description' => 'Naozaj chceš vygenerovať nové Neko? Tvoje súčasné sa navždy stratí, ak si ho nezálohoval.',
			'generateNewKey.buttons.generate' => 'Vygenerovať',
			'generateNewKey.errors.activeOffer' => 'Nemôžeš vygenerovať nové Neko, kým máš aktívnu ponuku.',
			'generateNewKey.errors.failed' => 'Nepodarilo sa vygenerovať nové Neko',
			'generateNewKey.feedback.success' => 'Nové Neko úspešne vygenerované!',
			'generateNewKey.tooltips.generate' => 'Vygenerovať nové Neko',
			'backup.title' => 'Záloha',
			'backup.description' => 'Toto je tvoj súkromný kľúč. Zabezpečuje komunikáciu s koordinátorom. Nikdy ho nikomu neprezraď. Zálohuj ho na bezpečnom mieste, aby si predišiel problémom počas sporov.',
			'backup.feedback.copied' => 'Súkromný kľúč skopírovaný do schránky!',
			'backup.tooltips.backup' => 'Zálohovať Neko',
			'restore.title' => 'Obnoviť',
			'restore.labels.privateKey' => 'Súkromný kľúč',
			'restore.buttons.restore' => 'Obnoviť',
			'restore.errors.invalidKey' => 'Musí to byť 64-znakový hex reťazec.',
			'restore.errors.failed' => 'Obnovenie zlyhalo',
			'restore.feedback.success' => 'Neko úspešne obnovené! Aplikácia sa reštartuje.',
			'restore.tooltips.restore' => 'Obnoviť Neko',
			'system.loadingPublicKey' => 'Načítava sa tvoj verejný kľúč...',
			'system.errors.generic' => 'Vyskytla sa neočakávaná chyba. Skús to znova.',
			'system.errors.loadingTimeoutConfig' => 'Chyba pri načítaní konfigurácie časového limitu.',
			'system.errors.loadingCoordinatorConfig' => 'Chyba pri načítaní konfigurácie koordinátora. Skús to znova.',
			'system.errors.noPublicKey' => 'Tvoj verejný kľúč nie je dostupný. Nedá sa pokračovať.',
			'system.errors.internalOfferIncomplete' => 'Interná chyba: Detaily ponuky sú neúplné. Skús to znova.',
			'system.errors.loadingPublicKey' => 'Chyba pri načítaní tvojho verejného kľúča. Reštartuj aplikáciu.',
			'system.blik.copied' => ({required Object code}) => '${code} skopírovaný do schránky',
			'myOffers.title' => 'Moje ponuky',
			'myOffers.empty' => 'Zatiaľ žiadne ponuky.',
			'myOffers.unknownCoordinator' => 'Neznámy koordinátor',
			'myOffers.menuLabel' => 'Moje ponuky',
			'myOffers.filter.all' => 'Všetky',
			'myOffers.filter.active' => 'Aktívne',
			'myOffers.filter.completed' => 'Dokončené',
			'myOffers.filter.failed' => 'Neúspešné',
			'myOffers.details.title' => 'Detaily ponuky',
			'myOffers.details.notFound' => 'Ponuka sa nenašla.',
			'myOffers.details.amount' => 'Suma',
			'myOffers.details.fees' => 'Poplatky',
			'myOffers.details.sats' => 'Satoshi',
			'myOffers.details.maker' => 'Predávajúci',
			'myOffers.details.taker' => 'Kupujúci',
			'myOffers.details.yourFee' => 'Tvoj poplatok',
			'myOffers.details.makerFee' => 'Poplatok predávajúceho',
			'myOffers.details.takerFee' => 'Poplatok kupujúceho',
			'myOffers.details.coordinator' => 'Koordinátor',
			'myOffers.details.createdAt' => 'Vytvorené',
			'myOffers.details.reservedAt' => 'Rezervované',
			'myOffers.details.blikReceivedAt' => ({required Object code}) => '${code} odoslaný',
			'myOffers.details.makerConfirmedAt' => 'Potvrdené',
			'myOffers.details.settledAt' => 'Vyrovnané',
			'myOffers.details.takerPaidAt' => 'Kupujúci zaplatený',
			'myOffers.details.id' => 'ID ponuky',
			'myOffers.details.paymentHash' => 'Hash platby',
			'myOffers.details.holdInvoice' => 'Hold faktúra',
			'myOffers.details.continueActiveOffer' => 'Pokračovať v aktívnej ponuke',
			'myOffers.details.after' => ({required Object duration}) => 'po ${duration}',
			'landing.mainTitle' => ({required Object code}) => 'Tvoj most ${code} ⇄ bitcoin',
			'landing.subtitle' => ({required Object code}) => 'Zaplať alebo predaj svoj ${code} za bitcoin',
			'landing.partnership' => 'partnerstvo',
			'landing.actions.payBlik' => ({required Object code}) => 'Zaplatiť ${code}',
			'landing.actions.payBlikSubtitle' => 'cez bitcoin',
			'landing.actions.sellBlik' => 'Kúpiť bitcoin',
			'landing.actions.sellBlikSubtitle' => ({required Object code}) => 'cez ${code}',
			'landing.actions.howItWorks' => 'Ako to funguje?',
			'faq.screenTitle' => 'FAQ',
			'faq.tooltip' => 'FAQ',
			'settings.title' => 'Nastavenia',
			'settings.coordinatorConsole.title' => 'Konzola koordinátora',
			'settings.coordinatorConsole.subtitle' => 'Spravujte spory pomocou podpisovača koordinátora',
			'settings.coordinatorConsole.signInTitle' => 'Prihlásiť sa ako koordinátor',
			'settings.coordinatorConsole.signInDescription' => 'Použite Nostr kľúč, ktorý identifikuje koordinátora, na kontrolu a riešenie sporov.',
			'settings.coordinatorConsole.separateIdentityNote' => 'Podpisovač koordinátora používa samostatnú reláciu NDK a nikdy nenahrádza obchodnú identitu Neko.',
			'settings.coordinatorConsole.loginWithSignerApp' => 'Prihlásiť sa cez podpisovaciu aplikáciu',
			'settings.coordinatorConsole.loginWithExtension' => 'Prihlásiť sa cez rozšírenie prehliadača',
			'settings.coordinatorConsole.loginWithNsec' => 'Prihlásiť sa pomocou nsec',
			'settings.coordinatorConsole.nsecDialogTitle' => 'Súkromný kľúč koordinátora',
			'settings.coordinatorConsole.nsecFieldLabel' => 'Súkromný kľúč',
			'settings.coordinatorConsole.nsecSecurityNote' => 'Súkromný kľúč je bezpečne uložený v tomto zariadení a používa ho iba samostatná relácia koordinátora.',
			'settings.coordinatorConsole.unsupportedPlatform' => 'Prihlásenie koordinátora je momentálne dostupné v systémoch Android, Linux a na webe.',
			'settings.coordinatorConsole.loginFailed' => 'Prihlásenie koordinátora zlyhalo',
			'settings.coordinatorConsole.accountsTitle' => 'Účty koordinátorov',
			'settings.coordinatorConsole.savedAccounts' => 'Uložené účty koordinátorov',
			'settings.coordinatorConsole.addAccount' => 'Pridať účet koordinátora',
			'settings.coordinatorConsole.removeAccount' => 'Odstrániť účet koordinátora',
			'settings.offerCreation.title' => 'Vytváranie ponúk',
			'settings.offerCreation.defaultCategory' => 'Predvolená kategória',
			'settings.offerCreation.defaultBank' => 'Predvolená banka',
			'settings.offerCreation.defaultBankNone' => 'Žiadna (vyber pri každej ponuke)',
			'settings.offerCreation.preferredCoordinator' => 'Preferovaný koordinátor',
			'settings.offerCreation.automaticCoordinator' => 'Najspoľahlivejší',
			'settings.offerCreation.automaticCoordinatorDescription' => 'Vyberie koordinátora s najlepšou históriou, pričom kombinuje tvoje vlastné dokončené ponuky a celkovú aktivitu v sieti.',
			'settings.offerCreation.cheapestCoordinator' => 'Najlacnejší',
			'settings.offerCreation.cheapestCoordinatorDescription' => 'Pre každú ponuku vyberie dostupného koordinátora s najnižším poplatkom predávajúceho.',
			'settings.offerCreation.enablePremium' => 'Zapnúť prémiové ceny',
			'settings.offerCreation.enablePremiumDescription' => 'Zobraziť posuvník prémie pri vytváraní ponúk predávajúceho.',
			'settings.offerCreation.defaultPremium' => 'Predvolená prémia',
			'settings.offerCreation.defaultPremiumDisabled' => 'Zapni prémiové ceny, aby si nastavil predvolenú prémiu.',
			'settings.offerCreation.premiumPerCoordinatorNote' => 'Každý koordinátor si nastavuje vlastnú maximálnu prémiu, takže tvoja predvolená hodnota je obmedzená koordinátorom použitým pre ponuku.',
			'settings.offerCreation.categoryOptions.shop' => 'Obchod, kaviareň alebo reštaurácia',
			'settings.offerCreation.categoryOptions.atm' => 'Výber z bankomatu',
			'settings.offerCreation.categoryOptions.online' => 'Online služba/produkt',
			'settings.offerCreation.dialogs.selectCategory' => 'Vyber predvolenú kategóriu',
			'settings.offerCreation.dialogs.selectBank' => 'Vyber predvolenú banku',
			'settings.offerCreation.dialogs.selectCoordinator' => 'Vyber preferovaného koordinátora',
			'settings.offerCreation.dialogs.premiumHint' => 'Zadaj percento, napríklad 1.5. Hodnoty sa zaokrúhľujú na kroky po 0.5%.',
			'settings.offerCreation.dialogs.premiumHelper' => 'Uplatní sa, keď sú zapnuté prémiové ceny, a je obmedzená maximom vybraného koordinátora.',
			'settings.display.title' => 'Zobrazenie',
			'settings.display.bitcoinUnit' => 'Jednotka bitcoinu',
			'settings.display.bitcoinUnitDescription' => 'Vyber, ako sa v celej aplikácii zobrazujú sumy v bitcoinoch.',
			'settings.display.unitOptions.sats' => 'sats',
			'settings.display.unitOptions.bitcoin' => '₿ (BIP-177)',
			'settings.paymentSystem.title' => 'Krajina / Platobný systém',
			'settings.paymentSystem.subtitle' => 'Vyber platobný systém svojej krajiny.',
			'settings.paymentSystem.dialogTitle' => 'Vyber platobný systém',
			'settings.paymentSystem.countries.PL' => 'Poľsko',
			'settings.paymentSystem.countries.PT' => 'Portugalsko',
			'settings.paymentSystem.countries.CH' => 'Švajčiarsko',
			'settings.paymentSystem.countries.SK' => 'Slovensko',
			'notificationSettings.title' => 'Notifikácie',
			'notificationSettings.androidOnly' => 'Notifikácie na pozadí sú momentálne podporované iba na Androide.',
			'notificationSettings.newOfferAlerts.label' => 'Upozornenia na nové ponuky',
			'notificationSettings.newOfferAlerts.description' => ({required Object app}) => 'Keď je zapnuté, ${app} ťa upozorní na nové ponuky dostupné na prijatie od tvojich zapnutých koordinátorov, kým je aplikácia na pozadí. Môže to byť rýchlejšie než externé messengery.',
			'wallet.title' => 'Peňaženka',
			'wallet.description' => 'Spravuj nastavenia svojej Lightning peňaženky',
			'wallet.missingReceiving.title' => 'Vyžaduje sa peňaženka na prijímanie',
			'wallet.missingReceiving.message' => 'Nie je nakonfigurovaná žiadna peňaženka na prijímanie. Pridaj jednu v nastaveniach peňaženky, aby si mohol prijímať ponuky.',
			'wallet.missingReceiving.openSettings' => 'Nastavenia peňaženky',
			'wallet.details.title' => 'Detaily peňaženky',
			'wallet.details.pendingTitle' => 'Čakajúce transakcie',
			'wallet.details.finishedTitle' => 'Dokončené transakcie',
			'nwc.title' => 'Nostr Wallet Connect (NWC)',
			'nwc.description' => 'Pripoj svoju Lightning peňaženku cez NWC',
			'nwc.labels.connectionString' => 'NWC pripojovací reťazec',
			'nwc.labels.hint' => 'nostr+walletconnect://...',
			'nwc.labels.status' => 'Stav pripojenia',
			'nwc.labels.connected' => 'Pripojené',
			'nwc.labels.disconnected' => 'Odpojené',
			'nwc.labels.scanQrCode' => 'Naskenuj QR kód so svojím NWC pripojením',
			'nwc.labels.balance' => 'Zostatok',
			'nwc.labels.budget' => 'Rozpočet',
			'nwc.labels.usedBudget' => 'Použité',
			'nwc.labels.totalBudget' => 'Celkom',
			'nwc.labels.renewsIn' => 'Obnoví sa o',
			'nwc.labels.renewalPeriod' => 'Obdobie obnovy',
			'nwc.labels.relay' => 'Relay',
			'nwc.labels.relays' => 'Relaye',
			'nwc.prompts.enter' => 'Zadaj svoj NWC pripojovací reťazec',
			'nwc.prompts.connect' => 'Pripojiť peňaženku',
			'nwc.prompts.disconnect' => 'Odpojiť',
			'nwc.prompts.confirmDisconnect' => 'Naozaj chceš odpojiť svoju NWC peňaženku?',
			'nwc.prompts.pasteConnection' => 'Vlož pripojovací reťazec',
			'nwc.prompts.chooseMethod' => 'Vyber, ako pripojiť svoju Lightning peňaženku',
			'nwc.prompts.howToGet' => 'Ešte nemáš NWC pripojenie? Zisti, ako ho získať!',
			'nwc.prompts.learnMore' => 'Zisti viac o NWC',
			'nwc.actions.connectAlbyGo' => 'Pripojiť cez Alby Go',
			'nwc.actions.connectNwc' => 'Naskenovať NWC QR kód',
			'nwc.feedback.connected' => 'NWC peňaženka úspešne pripojená!',
			'nwc.feedback.disconnected' => 'NWC peňaženka odpojená',
			'nwc.feedback.connecting' => 'Pripája sa k NWC peňaženke...',
			'nwc.feedback.loadingWalletInfo' => 'Načítavajú sa informácie o peňaženke...',
			'nwc.errors.connecting' => ({required Object details}) => 'Chyba pri pripájaní k NWC: ${details}',
			'nwc.errors.disconnecting' => ({required Object details}) => 'Chyba pri odpájaní NWC: ${details}',
			'nwc.errors.invalid' => 'Neplatný NWC pripojovací reťazec',
			'nwc.errors.required' => 'NWC pripojovací reťazec je povinný',
			'nwc.errors.loadingBalance' => 'Nepodarilo sa načítať zostatok peňaženky',
			'nwc.errors.loadingBudget' => 'Nepodarilo sa načítať rozpočet peňaženky',
			'nwc.time.minutes' => ({required Object count}) => '${count}m',
			'nwc.time.hours' => ({required Object count}) => '${count}h',
			'nwc.time.days' => ({required Object count}) => '${count}d',
			'nwc.time.justNow' => 'práve teraz',
			'nekoManagement.title' => 'Neko',
			'relays.title' => 'Relaye',
			'relays.coordinatorRelays' => 'Relaye koordinátora',
			'relays.discoveryRelays' => 'Relaye na vyhľadávanie',
			'relays.status.connected' => 'Pripojené',
			'relays.status.connecting' => 'Pripája sa',
			'relays.status.reconnecting' => 'Znovu sa pripája',
			'relays.status.disconnected' => 'Odpojené',
			'relays.popup.title' => ({required Object connected, required Object total}) => 'Relaye (pripojené ${connected}/${total})',
			'relays.popup.connectingMessage' => 'Pripája sa k relayom...',
			'offerNotifications.activeService.title' => 'Čaká sa na nové ponuky',
			'offerNotifications.activeService.body' => ({required Object app}) => 'Nostr služba monitoruje udalosti ponúk ${app}.',
			'offerNotifications.funded.title' => 'Ponuka financovaná',
			'offerNotifications.funded.body' => 'Tvoja hold faktúra bola prijatá. Ponuka je teraz aktívna.',
			'offerNotifications.reserved.title' => 'Ponuka rezervovaná',
			'offerNotifications.reserved.body' => 'Kupujúci rezervoval tvoju ponuku.',
			'offerNotifications.blikReady.title' => ({required Object code}) => '${code} pripravený',
			'offerNotifications.blikReady.body' => ({required Object code}) => 'Tvoj ${code} je pripravený na zobrazenie.',
			'offerNotifications.newOffer.title' => 'Dostupná nová ponuka',
			'offerNotifications.newOffer.body' => ({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}',
			'offerNotifications.newOffer.premiumSuffix' => ({required Object percent}) => '+${percent}% prémia',
			'offerNotifications.categories.shop' => 'Obchod',
			'offerNotifications.categories.atm' => 'Bankomat',
			'offerNotifications.categories.online' => 'Online',
			'offerNotifications.blikPendingReminder.title' => ({required Object code}) => '${code} čaká na tvoju akciu',
			'offerNotifications.blikPendingReminder.body' => ({required Object code}) => 'Potvrď platbu alebo označ ${code} ako neplatný.',
			'offerNotifications.takerCharged.title' => ({required Object code}) => '${code} strhnutý',
			'offerNotifications.takerCharged.body' => ({required Object code}) => 'Kupujúci hlási, že ${code} bol strhnutý. Potvrď alebo označ ako neplatný.',
			'offerNotifications.invalidBlik.title' => ({required Object code}) => '${code} označený ako neplatný',
			'offerNotifications.invalidBlik.body' => ({required Object code}) => 'Predávajúci označil tvoj ${code} ako neplatný.',
			'offerNotifications.takerPaid.title' => 'Platba prijatá',
			'offerNotifications.takerPaid.body' => 'Tvoja Lightning platba bola odoslaná.',
			'altstore.dialogTitle' => 'AltStore nie je nainštalovaný',
			'altstore.step1Title' => 'Stiahni a nainštaluj AltStore PAL',
			'altstore.step1Button' => 'altstore.io/download',
			'altstore.step1Warning' => 'Na inštaláciu AltStore PAL potrebuješ Safari!',
			'altstore.step2Title' => ({required Object app}) => 'Nainštaluj ${app}',
			'altstore.step2Button' => ({required Object app}) => 'Nainštalovať ${app}',
			'altstore.step2Fallback' => 'Stále to nefunguje? Vlož zdroj do AltStore',
			_ => null,
		};
	}
}
