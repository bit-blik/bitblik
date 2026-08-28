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
class TranslationsPt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsPt _root = this; // ignore: unused_field

	@override 
	TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$pt app = _Translations$app$pt._(_root);
	@override late final _Translations$common$pt common = _Translations$common$pt._(_root);
	@override late final _Translations$lightningAddress$pt lightningAddress = _Translations$lightningAddress$pt._(_root);
	@override late final _Translations$nfc$pt nfc = _Translations$nfc$pt._(_root);
	@override late final _Translations$offers$pt offers = _Translations$offers$pt._(_root);
	@override late final _Translations$reservations$pt reservations = _Translations$reservations$pt._(_root);
	@override late final _Translations$exchange$pt exchange = _Translations$exchange$pt._(_root);
	@override late final _Translations$coordinator$pt coordinator = _Translations$coordinator$pt._(_root);
	@override late final _Translations$maker$pt maker = _Translations$maker$pt._(_root);
	@override late final _Translations$taker$pt taker = _Translations$taker$pt._(_root);
	@override late final _Translations$twint$pt twint = _Translations$twint$pt._(_root);
	@override late final _Translations$blik$pt blik = _Translations$blik$pt._(_root);
	@override late final _Translations$home$pt home = _Translations$home$pt._(_root);
	@override late final _Translations$onboarding$pt onboarding = _Translations$onboarding$pt._(_root);
	@override late final _Translations$nekoInfo$pt nekoInfo = _Translations$nekoInfo$pt._(_root);
	@override late final _Translations$generateNewKey$pt generateNewKey = _Translations$generateNewKey$pt._(_root);
	@override late final _Translations$backup$pt backup = _Translations$backup$pt._(_root);
	@override late final _Translations$restore$pt restore = _Translations$restore$pt._(_root);
	@override late final _Translations$system$pt system = _Translations$system$pt._(_root);
	@override late final _Translations$myOffers$pt myOffers = _Translations$myOffers$pt._(_root);
	@override late final _Translations$landing$pt landing = _Translations$landing$pt._(_root);
	@override late final _Translations$faq$pt faq = _Translations$faq$pt._(_root);
	@override late final _Translations$settings$pt settings = _Translations$settings$pt._(_root);
	@override late final _Translations$notificationSettings$pt notificationSettings = _Translations$notificationSettings$pt._(_root);
	@override late final _Translations$wallet$pt wallet = _Translations$wallet$pt._(_root);
	@override late final _Translations$nwc$pt nwc = _Translations$nwc$pt._(_root);
	@override late final _Translations$nekoManagement$pt nekoManagement = _Translations$nekoManagement$pt._(_root);
	@override late final _Translations$relays$pt relays = _Translations$relays$pt._(_root);
	@override late final _Translations$offerNotifications$pt offerNotifications = _Translations$offerNotifications$pt._(_root);
	@override late final _Translations$altstore$pt altstore = _Translations$altstore$pt._(_root);
}

// Path: app
class _Translations$app$pt extends Translations$app$en {
	_Translations$app$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object app}) => '${app}';
	@override String get greeting => 'Olá!';
	@override String get changelog => 'Registo de alterações';
}

// Path: common
class _Translations$common$pt extends Translations$common$en {
	_Translations$common$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get code => 'código';
	@override late final _Translations$common$buttons$pt buttons = _Translations$common$buttons$pt._(_root);
	@override late final _Translations$common$labels$pt labels = _Translations$common$labels$pt._(_root);
	@override late final _Translations$common$notifications$pt notifications = _Translations$common$notifications$pt._(_root);
	@override late final _Translations$common$clipboard$pt clipboard = _Translations$common$clipboard$pt._(_root);
	@override late final _Translations$common$actions$pt actions = _Translations$common$actions$pt._(_root);
}

// Path: lightningAddress
class _Translations$lightningAddress$pt extends Translations$lightningAddress$en {
	_Translations$lightningAddress$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$lightningAddress$labels$pt labels = _Translations$lightningAddress$labels$pt._(_root);
	@override late final _Translations$lightningAddress$prompts$pt prompts = _Translations$lightningAddress$prompts$pt._(_root);
	@override late final _Translations$lightningAddress$feedback$pt feedback = _Translations$lightningAddress$feedback$pt._(_root);
	@override late final _Translations$lightningAddress$errors$pt errors = _Translations$lightningAddress$errors$pt._(_root);
}

// Path: nfc
class _Translations$nfc$pt extends Translations$nfc$en {
	_Translations$nfc$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$nfc$actions$pt actions = _Translations$nfc$actions$pt._(_root);
	@override late final _Translations$nfc$prompts$pt prompts = _Translations$nfc$prompts$pt._(_root);
	@override late final _Translations$nfc$feedback$pt feedback = _Translations$nfc$feedback$pt._(_root);
	@override late final _Translations$nfc$errors$pt errors = _Translations$nfc$errors$pt._(_root);
}

// Path: offers
class _Translations$offers$pt extends Translations$offers$en {
	_Translations$offers$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offers$details$pt details = _Translations$offers$details$pt._(_root);
	@override late final _Translations$offers$labels$pt labels = _Translations$offers$labels$pt._(_root);
	@override late final _Translations$offers$tooltips$pt tooltips = _Translations$offers$tooltips$pt._(_root);
	@override late final _Translations$offers$actions$pt actions = _Translations$offers$actions$pt._(_root);
	@override late final _Translations$offers$status$pt status = _Translations$offers$status$pt._(_root);
	@override late final _Translations$offers$statusMessages$pt statusMessages = _Translations$offers$statusMessages$pt._(_root);
	@override late final _Translations$offers$progress$pt progress = _Translations$offers$progress$pt._(_root);
	@override late final _Translations$offers$errors$pt errors = _Translations$offers$errors$pt._(_root);
	@override late final _Translations$offers$success$pt success = _Translations$offers$success$pt._(_root);
}

// Path: reservations
class _Translations$reservations$pt extends Translations$reservations$en {
	_Translations$reservations$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reservations$actions$pt actions = _Translations$reservations$actions$pt._(_root);
	@override late final _Translations$reservations$feedback$pt feedback = _Translations$reservations$feedback$pt._(_root);
	@override late final _Translations$reservations$errors$pt errors = _Translations$reservations$errors$pt._(_root);
}

// Path: exchange
class _Translations$exchange$pt extends Translations$exchange$en {
	_Translations$exchange$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$exchange$labels$pt labels = _Translations$exchange$labels$pt._(_root);
	@override late final _Translations$exchange$feedback$pt feedback = _Translations$exchange$feedback$pt._(_root);
	@override late final _Translations$exchange$errors$pt errors = _Translations$exchange$errors$pt._(_root);
}

// Path: coordinator
class _Translations$coordinator$pt extends Translations$coordinator$en {
	_Translations$coordinator$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Coordenadores';
	@override late final _Translations$coordinator$info$pt info = _Translations$coordinator$info$pt._(_root);
	@override late final _Translations$coordinator$selector$pt selector = _Translations$coordinator$selector$pt._(_root);
	@override late final _Translations$coordinator$dialog$pt dialog = _Translations$coordinator$dialog$pt._(_root);
	@override late final _Translations$coordinator$details$pt details = _Translations$coordinator$details$pt._(_root);
	@override late final _Translations$coordinator$coldStart$pt coldStart = _Translations$coordinator$coldStart$pt._(_root);
	@override late final _Translations$coordinator$management$pt management = _Translations$coordinator$management$pt._(_root);
}

// Path: maker
class _Translations$maker$pt extends Translations$maker$en {
	_Translations$maker$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$roleSelection$pt roleSelection = _Translations$maker$roleSelection$pt._(_root);
	@override late final _Translations$maker$amountForm$pt amountForm = _Translations$maker$amountForm$pt._(_root);
	@override late final _Translations$maker$payInvoice$pt payInvoice = _Translations$maker$payInvoice$pt._(_root);
	@override late final _Translations$maker$waitTaker$pt waitTaker = _Translations$maker$waitTaker$pt._(_root);
	@override late final _Translations$maker$waitForBlik$pt waitForBlik = _Translations$maker$waitForBlik$pt._(_root);
	@override late final _Translations$maker$confirmPayment$pt confirmPayment = _Translations$maker$confirmPayment$pt._(_root);
	@override late final _Translations$maker$invalidBlik$pt invalidBlik = _Translations$maker$invalidBlik$pt._(_root);
	@override late final _Translations$maker$conflict$pt conflict = _Translations$maker$conflict$pt._(_root);
	@override late final _Translations$maker$success$pt success = _Translations$maker$success$pt._(_root);
}

// Path: taker
class _Translations$taker$pt extends Translations$taker$en {
	_Translations$taker$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$taker$roleSelection$pt roleSelection = _Translations$taker$roleSelection$pt._(_root);
	@override late final _Translations$taker$progress$pt progress = _Translations$taker$progress$pt._(_root);
	@override late final _Translations$taker$submitBlik$pt submitBlik = _Translations$taker$submitBlik$pt._(_root);
	@override late final _Translations$taker$criticalCodeDecision$pt criticalCodeDecision = _Translations$taker$criticalCodeDecision$pt._(_root);
}

// Path: twint
class _Translations$twint$pt extends Translations$twint$en {
	_Translations$twint$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$twint$scanner$pt scanner = _Translations$twint$scanner$pt._(_root);
	@override late final _Translations$twint$flow$pt flow = _Translations$twint$flow$pt._(_root);
	@override late final _Translations$twint$waitConfirmation$pt waitConfirmation = _Translations$twint$waitConfirmation$pt._(_root);
	@override late final _Translations$twint$paymentProcess$pt paymentProcess = _Translations$twint$paymentProcess$pt._(_root);
	@override late final _Translations$twint$paymentFailed$pt paymentFailed = _Translations$twint$paymentFailed$pt._(_root);
	@override late final _Translations$twint$paymentSuccess$pt paymentSuccess = _Translations$twint$paymentSuccess$pt._(_root);
	@override late final _Translations$twint$invalidBlik$pt invalidBlik = _Translations$twint$invalidBlik$pt._(_root);
	@override late final _Translations$twint$conflict$pt conflict = _Translations$twint$conflict$pt._(_root);
}

// Path: blik
class _Translations$blik$pt extends Translations$blik$en {
	_Translations$blik$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$blik$instructions$pt instructions = _Translations$blik$instructions$pt._(_root);
}

// Path: home
class _Translations$home$pt extends Translations$home$en {
	_Translations$home$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$home$notifications$pt notifications = _Translations$home$notifications$pt._(_root);
	@override late final _Translations$home$statistics$pt statistics = _Translations$home$statistics$pt._(_root);
}

// Path: onboarding
class _Translations$onboarding$pt extends Translations$onboarding$en {
	_Translations$onboarding$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Escolha o seu mercado';
	@override String get subtitle => 'Selecione o país e o sistema de pagamento que vai usar. Pode alterá-lo a qualquer momento nas Definições.';
}

// Path: nekoInfo
class _Translations$nekoInfo$pt extends Translations$nekoInfo$en {
	_Translations$nekoInfo$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O que é um Neko?';
	@override String description({required Object app}) => 'O seu Neko é a sua identidade para usar o ${app}. É composto por uma chave privada e uma chave pública para garantir uma comunicação criptograficamente segura com o coordenador.\n\nPara garantir maior anonimato, recomenda-se usar um Neko novo para cada oferta.\n\n⚠️ IMPORTANTE: A sua chave privada é guardada apenas no seu dispositivo (no cliente). É de importância crítica fazer uma cópia de segurança da sua chave privada, já que perder o acesso a ela pode impedi-lo de resolver disputas e de recuperar os seus fundos.';
	@override String get backupWarning => 'Lembre-se de fazer uma cópia de segurança do seu Neko';
}

// Path: generateNewKey
class _Translations$generateNewKey$pt extends Translations$generateNewKey$en {
	_Translations$generateNewKey$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Novo';
	@override String get description => 'Tem a certeza de que quer gerar um novo Neko? O atual será perdido para sempre se não tiver feito uma cópia de segurança.';
	@override late final _Translations$generateNewKey$buttons$pt buttons = _Translations$generateNewKey$buttons$pt._(_root);
	@override late final _Translations$generateNewKey$errors$pt errors = _Translations$generateNewKey$errors$pt._(_root);
	@override late final _Translations$generateNewKey$feedback$pt feedback = _Translations$generateNewKey$feedback$pt._(_root);
	@override late final _Translations$generateNewKey$tooltips$pt tooltips = _Translations$generateNewKey$tooltips$pt._(_root);
}

// Path: backup
class _Translations$backup$pt extends Translations$backup$en {
	_Translations$backup$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cópia de segurança';
	@override String get description => 'Esta é a sua chave privada. Protege a comunicação com o coordenador. Nunca a revele a ninguém. Guarde-a num local seguro para evitar problemas durante disputas.';
	@override late final _Translations$backup$feedback$pt feedback = _Translations$backup$feedback$pt._(_root);
	@override late final _Translations$backup$tooltips$pt tooltips = _Translations$backup$tooltips$pt._(_root);
}

// Path: restore
class _Translations$restore$pt extends Translations$restore$en {
	_Translations$restore$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Restaurar';
	@override late final _Translations$restore$labels$pt labels = _Translations$restore$labels$pt._(_root);
	@override late final _Translations$restore$buttons$pt buttons = _Translations$restore$buttons$pt._(_root);
	@override late final _Translations$restore$errors$pt errors = _Translations$restore$errors$pt._(_root);
	@override late final _Translations$restore$feedback$pt feedback = _Translations$restore$feedback$pt._(_root);
	@override late final _Translations$restore$tooltips$pt tooltips = _Translations$restore$tooltips$pt._(_root);
}

// Path: system
class _Translations$system$pt extends Translations$system$en {
	_Translations$system$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get loadingPublicKey => 'A carregar a sua chave pública...';
	@override late final _Translations$system$errors$pt errors = _Translations$system$errors$pt._(_root);
	@override late final _Translations$system$blik$pt blik = _Translations$system$blik$pt._(_root);
}

// Path: myOffers
class _Translations$myOffers$pt extends Translations$myOffers$en {
	_Translations$myOffers$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'As minhas ofertas';
	@override String get empty => 'Ainda não há ofertas.';
	@override String get unknownCoordinator => 'Coordenador desconhecido';
	@override String get menuLabel => 'As minhas ofertas';
	@override late final _Translations$myOffers$filter$pt filter = _Translations$myOffers$filter$pt._(_root);
	@override late final _Translations$myOffers$details$pt details = _Translations$myOffers$details$pt._(_root);
}

// Path: landing
class _Translations$landing$pt extends Translations$landing$en {
	_Translations$landing$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String mainTitle({required Object code}) => 'A sua ponte ${code} ⇄ bitcoin';
	@override String subtitle({required Object code}) => 'Pague ou venda o seu código ${code} com bitcoin';
	@override String get partnership => 'parceria';
	@override late final _Translations$landing$actions$pt actions = _Translations$landing$actions$pt._(_root);
}

// Path: faq
class _Translations$faq$pt extends Translations$faq$en {
	_Translations$faq$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'FAQ';
	@override String get tooltip => 'FAQ';
}

// Path: settings
class _Translations$settings$pt extends Translations$settings$en {
	_Translations$settings$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Definições';
	@override late final _Translations$settings$offerCreation$pt offerCreation = _Translations$settings$offerCreation$pt._(_root);
	@override late final _Translations$settings$display$pt display = _Translations$settings$display$pt._(_root);
	@override late final _Translations$settings$paymentSystem$pt paymentSystem = _Translations$settings$paymentSystem$pt._(_root);
}

// Path: notificationSettings
class _Translations$notificationSettings$pt extends Translations$notificationSettings$en {
	_Translations$notificationSettings$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notificações';
	@override String get androidOnly => 'As notificações em segundo plano são atualmente suportadas apenas no Android.';
	@override late final _Translations$notificationSettings$newOfferAlerts$pt newOfferAlerts = _Translations$notificationSettings$newOfferAlerts$pt._(_root);
}

// Path: wallet
class _Translations$wallet$pt extends Translations$wallet$en {
	_Translations$wallet$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Carteira';
	@override String get description => 'Faça a gestão das definições da sua carteira Lightning';
	@override late final _Translations$wallet$missingReceiving$pt missingReceiving = _Translations$wallet$missingReceiving$pt._(_root);
	@override late final _Translations$wallet$incompatibleReceiving$pt incompatibleReceiving = _Translations$wallet$incompatibleReceiving$pt._(_root);
	@override late final _Translations$wallet$details$pt details = _Translations$wallet$details$pt._(_root);
}

// Path: nwc
class _Translations$nwc$pt extends Translations$nwc$en {
	_Translations$nwc$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nostr Wallet Connect (NWC)';
	@override String get description => 'Ligue a sua carteira Lightning via NWC';
	@override late final _Translations$nwc$labels$pt labels = _Translations$nwc$labels$pt._(_root);
	@override late final _Translations$nwc$prompts$pt prompts = _Translations$nwc$prompts$pt._(_root);
	@override late final _Translations$nwc$actions$pt actions = _Translations$nwc$actions$pt._(_root);
	@override late final _Translations$nwc$feedback$pt feedback = _Translations$nwc$feedback$pt._(_root);
	@override late final _Translations$nwc$errors$pt errors = _Translations$nwc$errors$pt._(_root);
	@override late final _Translations$nwc$time$pt time = _Translations$nwc$time$pt._(_root);
}

// Path: nekoManagement
class _Translations$nekoManagement$pt extends Translations$nekoManagement$en {
	_Translations$nekoManagement$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neko';
}

// Path: relays
class _Translations$relays$pt extends Translations$relays$en {
	_Translations$relays$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Relays';
	@override String get coordinatorRelays => 'Relays do coordenador';
	@override String get discoveryRelays => 'Relays de descoberta';
	@override late final _Translations$relays$status$pt status = _Translations$relays$status$pt._(_root);
	@override late final _Translations$relays$popup$pt popup = _Translations$relays$popup$pt._(_root);
}

// Path: offerNotifications
class _Translations$offerNotifications$pt extends Translations$offerNotifications$en {
	_Translations$offerNotifications$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$offerNotifications$activeService$pt activeService = _Translations$offerNotifications$activeService$pt._(_root);
	@override late final _Translations$offerNotifications$funded$pt funded = _Translations$offerNotifications$funded$pt._(_root);
	@override late final _Translations$offerNotifications$reserved$pt reserved = _Translations$offerNotifications$reserved$pt._(_root);
	@override late final _Translations$offerNotifications$blikReady$pt blikReady = _Translations$offerNotifications$blikReady$pt._(_root);
	@override late final _Translations$offerNotifications$newOffer$pt newOffer = _Translations$offerNotifications$newOffer$pt._(_root);
	@override late final _Translations$offerNotifications$categories$pt categories = _Translations$offerNotifications$categories$pt._(_root);
	@override late final _Translations$offerNotifications$blikPendingReminder$pt blikPendingReminder = _Translations$offerNotifications$blikPendingReminder$pt._(_root);
	@override late final _Translations$offerNotifications$takerCharged$pt takerCharged = _Translations$offerNotifications$takerCharged$pt._(_root);
	@override late final _Translations$offerNotifications$invalidBlik$pt invalidBlik = _Translations$offerNotifications$invalidBlik$pt._(_root);
	@override late final _Translations$offerNotifications$takerPaid$pt takerPaid = _Translations$offerNotifications$takerPaid$pt._(_root);
}

// Path: altstore
class _Translations$altstore$pt extends Translations$altstore$en {
	_Translations$altstore$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'AltStore não instalada';
	@override String get step1Title => 'Descarregue e instale a AltStore PAL';
	@override String get step1Button => 'altstore.io/download';
	@override String get step1Warning => 'Precisa do Safari para instalar a AltStore PAL!';
	@override String step2Title({required Object app}) => 'Instalar o ${app}';
	@override String step2Button({required Object app}) => 'Instalar o ${app}';
	@override String get step2Fallback => 'Continua sem funcionar? Cole a fonte na AltStore';
}

// Path: common.buttons
class _Translations$common$buttons$pt extends Translations$common$buttons$en {
	_Translations$common$buttons$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get done => 'Concluído';
	@override String get retry => 'Tentar novamente';
	@override String get goHome => 'Ir para o início';
	@override String get saveAndContinue => 'Guardar e continuar';
	@override String get reveal => 'Mostrar';
	@override String get hide => 'Ocultar';
	@override String get copy => 'Copiar';
	@override String get close => 'Fechar';
	@override String get restore => 'Restaurar';
	@override String get faq => 'FAQ';
}

// Path: common.labels
class _Translations$common$labels$pt extends Translations$common$labels$en {
	_Translations$common$labels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String amount({required Object currency}) => 'Montante (${currency})';
	@override String status({required Object status}) => 'Estado: ${status}';
	@override String role({required Object role}) => 'Função: ${role}';
}

// Path: common.notifications
class _Translations$common$notifications$pt extends Translations$common$notifications$en {
	_Translations$common$notifications$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get success => 'Sucesso';
	@override String get error => 'Erro';
	@override String get loading => 'A carregar...';
}

// Path: common.clipboard
class _Translations$common$clipboard$pt extends Translations$common$clipboard$en {
	_Translations$common$clipboard$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get copyToClipboard => 'Copiar para a área de transferência';
	@override String get pasteFromClipboard => 'Colar da área de transferência';
	@override String get copied => 'Copiado para a área de transferência!';
}

// Path: common.actions
class _Translations$common$actions$pt extends Translations$common$actions$en {
	_Translations$common$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get cancelAndReturnToOffers => 'Cancelar e voltar às ofertas';
	@override String get cancelAndReturnHome => 'Cancelar e voltar ao início';
}

// Path: lightningAddress.labels
class _Translations$lightningAddress$labels$pt extends Translations$lightningAddress$labels$en {
	_Translations$lightningAddress$labels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get address => 'Lightning Address (LNURL)';
	@override String get hint => 'utilizador@dominio.com';
	@override String short({required Object address}) => 'Lightning Address: ${address}';
	@override String get receivingAddress => 'O seu endereço de receção:';
}

// Path: lightningAddress.prompts
class _Translations$lightningAddress$prompts$pt extends Translations$lightningAddress$prompts$en {
	_Translations$lightningAddress$prompts$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Introduza o seu Lightning Address para continuar';
	@override String get edit => 'Editar';
	@override String get invalid => 'Introduza um Lightning Address válido';
	@override String get required => 'O Lightning Address é obrigatório.';
	@override String get enterToTakeOffer => 'Tem de definir um Lightning Address para aceitar uma oferta.';
	@override String get missing => 'O Lightning Address está em falta. Adicione um para poder aceitar ofertas.';
	@override String get add => 'Adicionar';
	@override String get delete => 'Eliminar';
	@override String get confirmDelete => 'Tem a certeza de que quer eliminar o seu Lightning Address?';
	@override String get howToGet => 'Ainda não tem um Lightning Address? Saiba como obter um!';
	@override String get learnMore => 'Saiba mais sobre o Lightning Address';
}

// Path: lightningAddress.feedback
class _Translations$lightningAddress$feedback$pt extends Translations$lightningAddress$feedback$en {
	_Translations$lightningAddress$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Lightning Address guardado!';
	@override String get updated => 'Lightning Address atualizado!';
	@override String get valid => 'Lightning Address válido';
}

// Path: lightningAddress.errors
class _Translations$lightningAddress$errors$pt extends Translations$lightningAddress$errors$en {
	_Translations$lightningAddress$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String saving({required Object details}) => 'Erro ao guardar o endereço: ${details}';
	@override String loading({required Object details}) => 'Erro ao carregar o Lightning Address: ${details}';
}

// Path: nfc.actions
class _Translations$nfc$actions$pt extends Translations$nfc$actions$en {
	_Translations$nfc$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get scan => 'Ler NFC';
	@override String get addWallet => 'Adicionar carteira';
}

// Path: nfc.prompts
class _Translations$nfc$prompts$pt extends Translations$nfc$prompts$en {
	_Translations$nfc$prompts$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Adicionar carteira Lightning?';
	@override String addMessage({required Object address}) => 'Foi encontrado este Lightning Address numa tag NFC: ${address}\n\nPretende adicioná-lo como carteira LNURL?';
}

// Path: nfc.feedback
class _Translations$nfc$feedback$pt extends Translations$nfc$feedback$en {
	_Translations$nfc$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get readyToScan => 'Aproxime o telemóvel da tag NFC';
	@override String get alreadyScanning => 'A leitura NFC já está em curso';
	@override String get alreadyAdded => 'Este Lightning Address já está configurado';
	@override String get walletAdded => 'Carteira Lightning adicionada a partir da tag NFC';
}

// Path: nfc.errors
class _Translations$nfc$errors$pt extends Translations$nfc$errors$en {
	_Translations$nfc$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get disabled => 'O NFC está desligado neste dispositivo';
	@override String get unsupported => 'O NFC não está disponível neste dispositivo';
	@override String reading({required Object details}) => 'Falha na leitura NFC: ${details}';
}

// Path: offers.details
class _Translations$offers$details$pt extends Translations$offers$details$en {
	_Translations$offers$details$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get yourOffer => 'A sua oferta:';
	@override String get selectedOffer => 'Oferta:';
	@override String get activeOffer => 'Tem uma oferta ativa:';
	@override String get finishedOffers => 'Ofertas concluídas';
	@override String get noAvailable => 'Não há ofertas disponíveis.';
	@override String noAvailableTip({required Object app}) => 'Dica: partilhe o ${app} na sua comunidade e entre amigos para aumentar as ordens no ${app}.';
	@override String get noSuccessfulTrades => 'Não há transações bem-sucedidas.';
	@override String get loadingDetails => 'A carregar detalhes da oferta...';
	@override String amount({required Object amount}) => 'Montante: ${amount} satoshi';
	@override String amountWithCurrency({required Object amount, required Object currency}) => '${amount} ${currency}';
	@override String makerFee({required Object fee}) => 'Taxa: ${fee} sats';
	@override String takerFee({required Object fee}) => 'Taxa: ${fee} sats';
	@override String subtitle({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (taxa) satoshi\nEstado: ${status}';
	@override String subtitleWithDate({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (taxa) satoshi\nEstado: ${status}\nPago: ${date}';
	@override String activeSubtitle({required Object status, required Object amount}) => 'Estado: ${status}\nMontante: ${amount} satoshi';
	@override String id({required Object id}) => 'ID da oferta: ${id}...';
	@override String created({required Object dateTime}) => 'Criada: ${dateTime}';
	@override String takenAfter({required Object duration}) => 'Aceite após: ${duration}';
	@override String paidAfter({required Object duration}) => 'Pago após: ${duration}';
	@override String get exchangeRate => 'Taxa de câmbio';
	@override String get amountLabel => 'Montante';
	@override String get makerFeeLabel => 'Taxa do maker';
	@override String get takerFeeLabel => 'Taxa do taker';
	@override String get feeLabel => 'Taxa';
	@override String get statusLabel => 'Estado';
	@override String get youllReceive => 'Vai receber';
	@override String get coordinator => 'Coordenador';
	@override String get categoryLabel => 'Categoria';
	@override late final _Translations$offers$details$categories$pt categories = _Translations$offers$details$categories$pt._(_root);
	@override late final _Translations$offers$details$consents$pt consents = _Translations$offers$details$consents$pt._(_root);
}

// Path: offers.labels
class _Translations$offers$labels$pt extends Translations$offers$labels$en {
	_Translations$offers$labels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get premium => 'Premium';
	@override String premiumBadge({required Object percent}) => '+${percent}% premium';
}

// Path: offers.tooltips
class _Translations$offers$tooltips$pt extends Translations$offers$tooltips$en {
	_Translations$offers$tooltips$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String takerFeeInfo({required Object feePercent}) => 'O coordenador cobra uma taxa de taker de ${feePercent}%. Inclui as taxas de encaminhamento da Lightning e é deduzida do montante que recebe.';
	@override String get premiumInfoTaker => 'Um premium significa que esta oferta está acima do preço de mercado. Para o mesmo montante em fiat, o maker bloqueia menos sats na hold invoice, por isso paga acima do mercado e recebe menos sats do que à taxa de mercado. O premium máximo é definido pelo coordenador.';
	@override String get ratesFetchedAt => 'Obtido em';
	@override String get ratesSources => 'Fontes da taxa média';
}

// Path: offers.actions
class _Translations$offers$actions$pt extends Translations$offers$actions$en {
	_Translations$offers$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get take => 'ACEITAR';
	@override String get takeOffer => 'Aceitar oferta';
	@override String resume({required Object code}) => 'INTRODUZIR ${code}';
	@override String get cancel => 'Cancelar oferta';
	@override String get view => 'Ver detalhes';
}

// Path: offers.status
class _Translations$offers$status$pt extends Translations$offers$status$en {
	_Translations$offers$status$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get created => 'Criada';
	@override String get funded => 'Financiada';
	@override String get expired => 'Expirada';
	@override String get cancelled => 'Cancelada';
	@override String get reserved => 'Reservada';
	@override String blikReceived({required Object code}) => '${code} enviado';
	@override String blikSentToMaker({required Object code}) => '${code} recebido';
	@override String expiredBlik({required Object code}) => '${code} expirado';
	@override String expiredSentBlik({required Object code}) => '${code} expirado';
	@override String get takerCharged => 'Taker cobrado';
	@override String invalidBlik({required Object code}) => '${code} inválido';
	@override String get conflict => 'Conflito';
	@override String get dispute => 'Disputa';
	@override String get makerConfirmed => 'Confirmada';
	@override String get settled => 'Liquidada';
	@override String get payingTaker => 'A pagar ao taker';
	@override String get takerPaymentFailed => 'Pagamento ao taker falhou';
	@override String get takerPaid => 'Taker pago';
	@override String get unknownStatus => 'Desconhecido';
}

// Path: offers.statusMessages
class _Translations$offers$statusMessages$pt extends Translations$offers$statusMessages$en {
	_Translations$offers$statusMessages$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get reserved => 'Oferta reservada pelo taker!';
	@override String get cancelled => 'Oferta cancelada com sucesso.';
	@override String get cancelledOrExpired => 'A oferta foi cancelada ou expirou.';
	@override String noLongerAvailable({required Object status}) => 'A oferta já não está disponível (Estado: ${status}).';
}

// Path: offers.progress
class _Translations$offers$progress$pt extends Translations$offers$progress$en {
	_Translations$offers$progress$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String waitingForTaker({required Object time}) => 'À espera do taker: ${time}';
	@override String reserved({required Object seconds}) => 'Reservada: faltam ${seconds} s';
	@override String confirming({required Object seconds}) => 'A confirmar: faltam ${seconds} s';
}

// Path: offers.errors
class _Translations$offers$errors$pt extends Translations$offers$errors$en {
	_Translations$offers$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String loading({required Object details}) => 'Erro ao carregar ofertas: ${details}';
	@override String loadingDetails({required Object details}) => 'Erro ao carregar detalhes da oferta: ${details}';
	@override String get detailsMissing => 'Erro: detalhes da oferta em falta ou inválidos.';
	@override String get detailsNotLoaded => 'Não foi possível carregar os detalhes da oferta.';
	@override String get notFound => 'Erro: oferta não encontrada.';
	@override String get unexpectedState => 'Erro: a oferta está num estado inesperado.';
	@override String unexpectedStateWithStatus({required Object status}) => 'A oferta está num estado inesperado (${status}). Tente novamente ou contacte o suporte.';
	@override String get invalidStatus => 'A oferta tem um estado inválido.';
	@override String get couldNotIdentify => 'Erro: não foi possível identificar a oferta a cancelar.';
	@override String cannotBeCancelled({required Object status}) => 'A oferta não pode ser cancelada no estado atual (${status}).';
	@override String failedToCancel({required Object details}) => 'Falha ao cancelar a oferta: ${details}';
	@override String get activeDetailsLost => 'Erro: detalhes da oferta ativa perdidos.';
	@override String checkingActive({required Object details}) => 'Erro ao verificar ofertas ativas: ${details}';
	@override String cannotResume({required Object status}) => 'Não é possível retomar a oferta no estado: ${status}';
	@override String cannotResumeTaker({required Object status}) => 'Não é possível retomar a oferta do taker no estado: ${status}';
	@override String resuming({required Object details}) => 'Erro ao retomar a oferta: ${details}';
	@override String get makerPublicKeyNotFound => 'Chave pública do maker não encontrada';
	@override String get takerPublicKeyNotFound => 'Chave pública do taker não encontrada.';
	@override String get atmConsentRequired => 'Aceite a condição da taxa extra do multibanco antes de aceitar esta oferta.';
	@override String get ecommerceConsentRequired => 'Aceite a condição de devolução de reembolso de e-commerce antes de aceitar esta oferta.';
	@override String get cannotTakeOwnOffer => 'Não pode aceitar a sua própria oferta.';
}

// Path: offers.success
class _Translations$offers$success$pt extends Translations$offers$success$en {
	_Translations$offers$success$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta concluída';
	@override String get headline => 'Pagamento confirmado!';
	@override String get subtitle => 'O taker vai ser pago agora.';
	@override String get detailsTitle => 'Detalhes da oferta:';
	@override String duration({required Object time}) => 'A oferta demorou ${time} a concluir.';
}

// Path: reservations.actions
class _Translations$reservations$actions$pt extends Translations$reservations$actions$en {
	_Translations$reservations$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar reserva';
}

// Path: reservations.feedback
class _Translations$reservations$feedback$pt extends Translations$reservations$feedback$en {
	_Translations$reservations$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get cancelled => 'Reserva cancelada.';
}

// Path: reservations.errors
class _Translations$reservations$errors$pt extends Translations$reservations$errors$en {
	_Translations$reservations$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String cancelling({required Object error}) => 'Falha ao cancelar a reserva: ${error}';
	@override String failedToReserve({required Object details}) => 'Falha ao reservar a oferta: ${details}';
	@override String get failedNoTimestamp => 'Falha ao reservar a oferta (sem timestamp).';
	@override String get timestampMissing => 'Timestamp da reserva da oferta em falta.';
	@override String notReserved({required Object status}) => 'A oferta já não está reservada (${status}).';
}

// Path: exchange.labels
class _Translations$exchange$labels$pt extends Translations$exchange$labels$en {
	_Translations$exchange$labels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String enterAmount({required Object currency}) => 'Introduza o montante (${currency}) a pagar:';
	@override String equivalent({required Object sats}) => '≈ ${sats} satoshi';
	@override String rate({required Object rate, required Object currency}) => 'Taxa de câmbio ≈ ${rate} ${currency}/BTC';
}

// Path: exchange.feedback
class _Translations$exchange$feedback$pt extends Translations$exchange$feedback$en {
	_Translations$exchange$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get fetching => 'A obter a taxa de câmbio...';
}

// Path: exchange.errors
class _Translations$exchange$errors$pt extends Translations$exchange$errors$en {
	_Translations$exchange$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get fetchingRate => 'Falha ao obter a taxa de câmbio.';
	@override String get invalidFormat => 'Formato de número inválido';
	@override String get mustBePositive => 'O montante tem de ser positivo';
	@override String get invalidFeePercentage => 'Percentagem de taxa inválida';
	@override String tooLowFiat({required Object minAmount, required Object currency}) => 'O montante é demasiado baixo. O mínimo é ${minAmount} ${currency}.';
	@override String tooHighFiat({required Object maxAmount, required Object currency}) => 'O montante é demasiado alto. O máximo é ${maxAmount} ${currency}.';
	@override String atmNotDispensable({required Object notes}) => 'O multibanco não consegue dispensar este montante. Use uma combinação de notas: ${notes}.';
	@override String atmOverBankLimit({required Object bank, required Object limit, required Object currency}) => '${bank} entrega no máximo ${limit} ${currency} por levantamento.';
}

// Path: coordinator.info
class _Translations$coordinator$info$pt extends Translations$coordinator$info$en {
	_Translations$coordinator$info$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get fee => 'taxa';
	@override String rangeDisplay({required Object minAmount, required Object maxAmount, required Object currency}) => 'Montante: ${minAmount}-${maxAmount} ${currency}';
	@override String feeDisplay({required Object fee}) => '${fee}% de taxa';
}

// Path: coordinator.selector
class _Translations$coordinator$selector$pt extends Translations$coordinator$selector$en {
	_Translations$coordinator$selector$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get loading => 'A carregar coordenadores...';
	@override String get errorLoading => 'Erro ao carregar coordenadores';
	@override String get choose => 'Escolher coordenador';
	@override String get viewNostrProfile => 'Ver perfil Nostr';
	@override String get unresponsive => 'Este coordenador não está a responder';
	@override String get waitingResponse => 'À espera da resposta do coordenador';
	@override String get termsAccept => 'Aceito os ';
	@override String get termsOfUsage => 'Termos de utilização do coordenador';
}

// Path: coordinator.dialog
class _Translations$coordinator$dialog$pt extends Translations$coordinator$dialog$en {
	_Translations$coordinator$dialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get makerFee => 'Taxa do maker';
	@override String get takerFee => 'Taxa do taker';
	@override String get amountRange => 'Intervalo de montantes';
	@override String get reservationTime => 'Tempo de reserva';
	@override String get currencies => 'Moedas';
	@override String get viewTerms => 'Ver termos';
}

// Path: coordinator.details
class _Translations$coordinator$details$pt extends Translations$coordinator$details$en {
	_Translations$coordinator$details$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Coordenador';
	@override String get relaysInUse => 'Relays em uso';
	@override String get relaysInUseHint => 'Toda a comunicação com este coordenador é encaminhada para estes relays (da sua lista NIP-65).';
	@override String get noRelays => 'Ainda não há relays conhecidos';
	@override String get makerFee => 'Taxa do maker';
	@override String get takerFee => 'Taxa do taker';
	@override String get amountRange => 'Intervalo de montantes';
	@override String get maxPremium => 'Premium máximo';
	@override String get maxPremiumInfoTitle => 'Premium';
	@override String get maxPremiumInfoBody => 'Um premium é uma majoração de preço opcional acima da taxa de mercado que um maker pode definir numa oferta. Com um premium, o maker bloqueia menos sats para o mesmo montante em fiat, por isso o taker paga acima do mercado e o maker fica com a diferença. Este valor é o premium máximo que este coordenador permite nas suas ofertas.';
	@override String get reservationTime => 'Tempo de reserva';
	@override String get currencies => 'Moedas';
	@override String get paymentSystem => 'Sistema de pagamento';
	@override String get version => 'Versão';
	@override String get yourOffers => 'As suas ofertas';
	@override String get successfulOffers => 'Ofertas bem-sucedidas (30d)';
	@override String get statusOnline => 'Online';
	@override String get statusOffline => 'Offline';
	@override String get statusUnknown => 'Desconhecido';
	@override String get openNostrProfile => 'Abrir perfil Nostr';
	@override String get termsOfUsage => 'Termos de utilização';
}

// Path: coordinator.coldStart
class _Translations$coordinator$coldStart$pt extends Translations$coordinator$coldStart$en {
	_Translations$coordinator$coldStart$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'A descobrir coordenadores';
	@override String body({required Object app}) => 'O ${app} está a encontrar coordenadores públicos, a verificar quais estão acessíveis e a ativar um pequeno conjunto predefinido para si.';
	@override String get settingsHint => 'Pode alterar os coordenadores ativados mais tarde nas Definições.';
	@override String get ok => 'OK';
	@override String get discovered => 'Descobertos';
	@override String get candidates => 'Candidatos';
	@override String get enabled => 'Ativados';
	@override String get recordsTitle => 'Coordenadores atuais';
	@override String get recordEnabled => 'Ativado';
	@override String get recordHealthyCandidate => 'Candidato saudável';
	@override String get recordOfflineCandidate => 'Candidato offline';
	@override String get recordChecking => 'A verificar';
	@override String get recordDiscovered => 'Descoberto';
	@override late final _Translations$coordinator$coldStart$phases$pt phases = _Translations$coordinator$coldStart$phases$pt._(_root);
}

// Path: coordinator.management
class _Translations$coordinator$management$pt extends Translations$coordinator$management$en {
	_Translations$coordinator$management$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gestão de coordenadores';
	@override String get availableCoordinators => 'Coordenadores';
	@override String get noCoordinators => 'Ainda não foram descobertos coordenadores.';
	@override String get online => 'Online';
	@override String get unknownOffline => 'Desconhecido/Offline';
	@override String get openNostrProfile => 'Abrir perfil Nostr';
	@override String get enable => 'Ativar';
	@override String get remove => 'Remover';
	@override String get addCustomWhitelist => 'Adicionar coordenador personalizado';
	@override String get addCustomWhitelistHint => 'npub1...';
	@override String get add => 'Adicionar';
	@override String get coordinatorDisabled => 'Coordenador desativado';
	@override String get coordinatorEnabled => 'Coordenador ativado';
	@override String get coordinatorAdded => 'Coordenador adicionado à whitelist personalizada';
	@override String get coordinatorRemoved => 'Coordenador removido da whitelist personalizada';
	@override String get coordinatorAddInfoUnavailable => 'Não foi encontrada informação do coordenador nos relays. Coordenador não adicionado.';
	@override String get pleaseEnterNpub => 'Introduza um npub';
	@override String get error => 'Erro';
	@override String get metricYourOffers => 'As suas ofertas';
	@override String get metricYourOffersTooltip => 'Número de ofertas que concluiu com sucesso com este coordenador.';
	@override String get metricNetworkOffers => 'Ofertas (30d)';
	@override String get metricNetworkOffersTooltip => 'Ofertas bem-sucedidas liquidadas por este coordenador entre todos os utilizadores nos últimos 30 dias.';
}

// Path: maker.roleSelection
class _Translations$maker$roleSelection$pt extends Translations$maker$roleSelection$en {
	_Translations$maker$roleSelection$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get button => 'PAGAR com Lightning';
}

// Path: maker.amountForm
class _Translations$maker$amountForm$pt extends Translations$maker$amountForm$en {
	_Translations$maker$amountForm$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$maker$amountForm$progress$pt progress = _Translations$maker$amountForm$progress$pt._(_root);
	@override late final _Translations$maker$amountForm$labels$pt labels = _Translations$maker$amountForm$labels$pt._(_root);
	@override late final _Translations$maker$amountForm$actions$pt actions = _Translations$maker$amountForm$actions$pt._(_root);
	@override late final _Translations$maker$amountForm$bank$pt bank = _Translations$maker$amountForm$bank$pt._(_root);
	@override late final _Translations$maker$amountForm$twintScan$pt twintScan = _Translations$maker$amountForm$twintScan$pt._(_root);
	@override late final _Translations$maker$amountForm$tooltips$pt tooltips = _Translations$maker$amountForm$tooltips$pt._(_root);
	@override late final _Translations$maker$amountForm$category$pt category = _Translations$maker$amountForm$category$pt._(_root);
	@override late final _Translations$maker$amountForm$onboarding$pt onboarding = _Translations$maker$amountForm$onboarding$pt._(_root);
	@override late final _Translations$maker$amountForm$errors$pt errors = _Translations$maker$amountForm$errors$pt._(_root);
}

// Path: maker.payInvoice
class _Translations$maker$payInvoice$pt extends Translations$maker$payInvoice$en {
	_Translations$maker$payInvoice$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pague esta hold invoice:';
	@override late final _Translations$maker$payInvoice$actions$pt actions = _Translations$maker$payInvoice$actions$pt._(_root);
	@override late final _Translations$maker$payInvoice$feedback$pt feedback = _Translations$maker$payInvoice$feedback$pt._(_root);
	@override late final _Translations$maker$payInvoice$errors$pt errors = _Translations$maker$payInvoice$errors$pt._(_root);
	@override late final _Translations$maker$payInvoice$budgetWarning$pt budgetWarning = _Translations$maker$payInvoice$budgetWarning$pt._(_root);
}

// Path: maker.waitTaker
class _Translations$maker$waitTaker$pt extends Translations$maker$waitTaker$en {
	_Translations$maker$waitTaker$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get message => 'À espera que um taker reserve a sua oferta...';
	@override String progressLabel({required Object time}) => 'À espera do taker: ${time}';
	@override String get errorActiveOfferDetailsLost => 'Erro: detalhes da oferta ativa perdidos.';
	@override String errorFailedToRetrieveBlik({required Object code}) => 'Erro: falha ao obter o código ${code}.';
	@override String errorRetrievingBlik({required Object code, required Object details}) => 'Erro ao obter o código ${code}: ${details}';
	@override String offerNoLongerAvailable({required Object status}) => 'A oferta já não está disponível (Estado: ${status}).';
	@override String get errorCouldNotIdentifyOffer => 'Erro: não foi possível identificar a oferta a cancelar.';
	@override String offerCannotBeCancelled({required Object status}) => 'A oferta não pode ser cancelada no estado atual (${status}).';
	@override String get offerCancelledSuccessfully => 'Oferta cancelada com sucesso.';
	@override String failedToCancelOffer({required Object details}) => 'Falha ao cancelar a oferta: ${details}';
	@override String get offerExpiredTitle => 'Oferta expirada';
	@override String get offerExpiredMessage => 'Nenhum taker reservou a sua oferta a tempo.';
	@override String get recreateOffer => 'Nova oferta — mesmo montante';
}

// Path: maker.waitForBlik
class _Translations$maker$waitForBlik$pt extends Translations$maker$waitForBlik$en {
	_Translations$maker$waitForBlik$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'À espera do ${code}';
	@override String get messageInfo => 'O taker reservou a oferta!';
	@override String messageWaiting({required Object code}) => 'À espera de fornecer o código ${code}...';
	@override String progressLabel({required Object seconds}) => 'Reservada: faltam ${seconds} s';
}

// Path: maker.confirmPayment
class _Translations$maker$confirmPayment$pt extends Translations$maker$confirmPayment$en {
	_Translations$maker$confirmPayment$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Código ${code} recebido!';
	@override String retrieving({required Object code}) => 'A obter o código ${code}...';
	@override String get instructions => 'Introduza este código no terminal de pagamento. Quando o taker confirmar na app do banco e o pagamento for bem-sucedido, prima Confirmar abaixo.';
	@override String instruction1({required Object code}) => 'Introduza o código no pedido de pagamento ${code}.';
	@override String get instruction2 => 'Aguarde até o taker confirmar o pagamento na app dele.';
	@override String get instruction3 => 'Quando o pagamento for bem-sucedido, prima Confirmar abaixo:';
	@override String mbwayAtmInstructions({required Object amount, required Object minutes}) => 'Para levantar ${amount} €, dirija-se ao MULTIBANCO mais próximo, carregue na tecla verde e escolha a opção "Levantar Dinheiro". Introduza o código. Este código é válido por ${minutes} minutos.';
	@override String takerChargedWarning({required Object code}) => 'O taker reportou que o pagamento ${code} foi cobrado da conta bancária dele. Se marcar isto como inválido, vai causar um conflito.';
	@override String autoConfirmInfo({required Object code}) => 'A menos que marque o ${code} como inválido, o pagamento será confirmado automaticamente e o taker pago quando este temporizador terminar.';
	@override String autoConfirmCountdown({required Object time}) => 'Confirmação automática em ${time}';
	@override String expiredTitle({required Object code}) => 'Código ${code} expirado';
	@override String expiredWarning({required Object code}) => 'O código ${code} expirou. Tem de confirmar manualmente o estado do pagamento:';
	@override String expiredInstruction1({required Object code}) => 'Se o pagamento ${code} foi bem-sucedido e concluiu a sua compra, clique em "Confirmar pagamento bem-sucedido" abaixo.';
	@override String expiredInstruction2({required Object code}) => 'Se o pagamento ${code} falhou ou não foi concluído, clique em "Código ${code} inválido" abaixo.';
	@override late final _Translations$maker$confirmPayment$actions$pt actions = _Translations$maker$confirmPayment$actions$pt._(_root);
	@override late final _Translations$maker$confirmPayment$confirmDialog$pt confirmDialog = _Translations$maker$confirmPayment$confirmDialog$pt._(_root);
	@override late final _Translations$maker$confirmPayment$invalidBlikDisputeDialog$pt invalidBlikDisputeDialog = _Translations$maker$confirmPayment$invalidBlikDisputeDialog$pt._(_root);
	@override late final _Translations$maker$confirmPayment$feedback$pt feedback = _Translations$maker$confirmPayment$feedback$pt._(_root);
	@override late final _Translations$maker$confirmPayment$errors$pt errors = _Translations$maker$confirmPayment$errors$pt._(_root);
}

// Path: maker.invalidBlik
class _Translations$maker$invalidBlik$pt extends Translations$maker$invalidBlik$en {
	_Translations$maker$invalidBlik$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Código ${code} inválido';
	@override String info({required Object code}) => 'Marcou o código ${code} como inválido. À espera que o taker forneça um novo código ou inicie uma disputa.';
}

// Path: maker.conflict
class _Translations$maker$conflict$pt extends Translations$maker$conflict$en {
	_Translations$maker$conflict$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conflito na oferta';
	@override String get headline => 'Conflito na oferta reportado';
	@override String body({required Object code}) => 'Marcou o código ${code} como inválido, mas o taker reportou um conflito, indicando que acredita que o pagamento foi bem-sucedido.';
	@override String get instructions => 'Aguarde que o coordenador analise a situação. Poderão pedir-lhe mais detalhes. Volte mais tarde ou contacte o suporte se necessário.';
	@override late final _Translations$maker$conflict$actions$pt actions = _Translations$maker$conflict$actions$pt._(_root);
	@override late final _Translations$maker$conflict$disputeDialog$pt disputeDialog = _Translations$maker$conflict$disputeDialog$pt._(_root);
	@override late final _Translations$maker$conflict$feedback$pt feedback = _Translations$maker$conflict$feedback$pt._(_root);
	@override late final _Translations$maker$conflict$errors$pt errors = _Translations$maker$conflict$errors$pt._(_root);
	@override late final _Translations$maker$conflict$nostrContact$pt nostrContact = _Translations$maker$conflict$nostrContact$pt._(_root);
}

// Path: maker.success
class _Translations$maker$success$pt extends Translations$maker$success$en {
	_Translations$maker$success$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta concluída';
	@override String get headline => 'Pagamento confirmado!';
	@override String get subtitle => 'O taker vai ser pago agora.';
	@override String get detailsTitle => 'Detalhes da oferta:';
	@override String duration({required Object time}) => 'A oferta demorou ${time}!';
}

// Path: taker.roleSelection
class _Translations$taker$roleSelection$pt extends Translations$taker$roleSelection$en {
	_Translations$taker$roleSelection$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String button({required Object code}) => 'VENDER código ${code} por satoshi';
}

// Path: taker.progress
class _Translations$taker$progress$pt extends Translations$taker$progress$en {
	_Translations$taker$progress$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String step1({required Object code}) => 'Submeter ${code}';
	@override String step2({required Object code}) => 'Confirmar ${code}';
	@override String get step3 => 'Receber pagamento';
}

// Path: taker.submitBlik
class _Translations$taker$submitBlik$pt extends Translations$taker$submitBlik$en {
	_Translations$taker$submitBlik$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String generateInBank({required Object bank}) => 'Gera o código de levantamento na app ${bank}.';
	@override String title({required Object code, required Object digits}) => 'Introduza o ${code} de ${digits} dígitos';
	@override String label({required Object code}) => 'Código ${code}';
	@override String instruction({required Object code}) => 'Introduza o ${code} antes de o tempo terminar...';
	@override String timeLimit({required Object code, required Object seconds}) => 'Introduza o ${code} dentro de: ${seconds} s';
	@override String timeExpired({required Object code}) => 'O tempo para introduzir o código ${code} expirou.';
	@override late final _Translations$taker$submitBlik$actions$pt actions = _Translations$taker$submitBlik$actions$pt._(_root);
	@override late final _Translations$taker$submitBlik$feedback$pt feedback = _Translations$taker$submitBlik$feedback$pt._(_root);
	@override late final _Translations$taker$submitBlik$validation$pt validation = _Translations$taker$submitBlik$validation$pt._(_root);
	@override late final _Translations$taker$submitBlik$errors$pt errors = _Translations$taker$submitBlik$errors$pt._(_root);
	@override late final _Translations$taker$submitBlik$details$pt details = _Translations$taker$submitBlik$details$pt._(_root);
}

// Path: taker.criticalCodeDecision
class _Translations$taker$criticalCodeDecision$pt extends Translations$taker$criticalCodeDecision$en {
	_Translations$taker$criticalCodeDecision$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Decisão crítica';
	@override String explanation({required Object code}) => 'Já partilhou um código ${code} com o maker. Continuar pode substituir esse código, terminar a sua reserva e reabrir a oferta a outros takers.';
	@override String get warningTitle => 'PODE PERDER OS SEUS FUNDOS';
	@override String warningBody({required Object code}) => 'Se o seu banco debitou o pagamento ${code}, NÃO continue. O maker pode ter usado o seu código e, após esta ação, o coordenador poderá já não conseguir garantir o pagamento dos seus bitcoins.';
	@override late final _Translations$taker$criticalCodeDecision$actions$pt actions = _Translations$taker$criticalCodeDecision$actions$pt._(_root);
}

// Path: twint.scanner
class _Translations$twint$scanner$pt extends Translations$twint$scanner$en {
	_Translations$twint$scanner$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Ler código ${code}';
	@override late final _Translations$twint$scanner$status$pt status = _Translations$twint$scanner$status$pt._(_root);
}

// Path: twint.flow
class _Translations$twint$flow$pt extends Translations$twint$flow$en {
	_Translations$twint$flow$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$twint$flow$progress$pt progress = _Translations$twint$flow$progress$pt._(_root);
	@override late final _Translations$twint$flow$takerProgress$pt takerProgress = _Translations$twint$flow$takerProgress$pt._(_root);
	@override late final _Translations$twint$flow$makerWait$pt makerWait = _Translations$twint$flow$makerWait$pt._(_root);
	@override late final _Translations$twint$flow$makerExpired$pt makerExpired = _Translations$twint$flow$makerExpired$pt._(_root);
	@override late final _Translations$twint$flow$makerVerify$pt makerVerify = _Translations$twint$flow$makerVerify$pt._(_root);
	@override late final _Translations$twint$flow$makerRecode$pt makerRecode = _Translations$twint$flow$makerRecode$pt._(_root);
	@override late final _Translations$twint$flow$takerPay$pt takerPay = _Translations$twint$flow$takerPay$pt._(_root);
	@override late final _Translations$twint$flow$takerWait$pt takerWait = _Translations$twint$flow$takerWait$pt._(_root);
	@override late final _Translations$twint$flow$takerExpired$pt takerExpired = _Translations$twint$flow$takerExpired$pt._(_root);
}

// Path: twint.waitConfirmation
class _Translations$twint$waitConfirmation$pt extends Translations$twint$waitConfirmation$en {
	_Translations$twint$waitConfirmation$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'À espera do maker';
	@override String statusLabel({required Object status}) => 'Estado da oferta: ${status}';
	@override String waitingMaker({required Object seconds}) => 'À espera da confirmação do maker: ${seconds} s';
	@override String waitingMakerConfirmation({required Object code, required Object seconds}) => 'À espera que o maker confirme que o ${code} está correto. Tempo restante: ${seconds}s';
	@override String importantNotice({required Object code, required Object amount, required Object currency}) => 'MUITO IMPORTANTE: certifique-se de que só aceita a confirmação ${code} para ${amount} ${currency}';
	@override String importantBlikAmountConfirmation({required Object code, required Object amount, required Object currency}) => 'MUITO IMPORTANTE: na app do seu banco, certifique-se de que está a confirmar um pagamento ${code} de exatamente ${amount} ${currency}.';
	@override String instructions({required Object minutes, required Object code}) => 'O maker tem agora de o introduzir no terminal de pagamento dentro de ${minutes} minutos. Depois tem de aceitar o código ${code} na app do seu banco.';
	@override String instructionsNoConfirm({required Object code, required Object minutes}) => 'O maker tem agora de introduzir o seu código ${code} no multibanco dentro de ${minutes} minutos.';
	@override late final _Translations$twint$waitConfirmation$categoryReminder$pt categoryReminder = _Translations$twint$waitConfirmation$categoryReminder$pt._(_root);
	@override String waitingForMakerToReceive({required Object code}) => 'À espera que o maker receba o seu código ${code}...';
	@override String makerReceivedBlik({required Object code}) => 'O maker recebeu o seu código ${code}.';
	@override String timerExpiredMessage({required Object minutes, required Object code}) => 'O tempo de expiração de ${minutes}m do ${code} passou. À espera que o maker confirme ou marque o código como inválido.';
	@override String timerExpiredActions({required Object minutes, required Object code}) => 'O tempo de expiração de ${minutes}m do ${code} passou mas o maker não recebeu o código ${code}. Pode reenviar um novo código ${code} ou cancelar.';
	@override String resendBlikButton({required Object code}) => 'Reenviar novo código ${code}';
	@override String get navigatedHome => 'Voltou ao início.';
	@override String expiredTitle({required Object code}) => 'Código ${code} expirado';
	@override String expiredWarning({required Object code}) => 'O maker não recebeu o código ${code}, por isso não o pôde ter usado.';
	@override String get expiredRelistCountdownLabel => 'A reserva termina em';
	@override String get expiredSentWarning => 'O maker ainda não confirmou o pagamento. O que pretende fazer?';
	@override String expiredInstruction1({required Object code}) => 'Se quiser tentar novamente com um novo código ${code}, renove a reserva.';
	@override String get expiredInstruction2 => 'Se já não quiser concluir esta transação, cancele a reserva.';
	@override String expiredInstruction3({required Object code}) => 'Se o pagamento ${code} foi cobrado da sua conta bancária, não se preocupe, o bitcoin continua seguro e bloqueado com o coordenador.';
	@override late final _Translations$twint$waitConfirmation$takerCharged$pt takerCharged = _Translations$twint$waitConfirmation$takerCharged$pt._(_root);
	@override late final _Translations$twint$waitConfirmation$expiredActions$pt expiredActions = _Translations$twint$waitConfirmation$expiredActions$pt._(_root);
	@override late final _Translations$twint$waitConfirmation$feedback$pt feedback = _Translations$twint$waitConfirmation$feedback$pt._(_root);
	@override late final _Translations$twint$waitConfirmation$errors$pt errors = _Translations$twint$waitConfirmation$errors$pt._(_root);
}

// Path: twint.paymentProcess
class _Translations$twint$paymentProcess$pt extends Translations$twint$paymentProcess$en {
	_Translations$twint$paymentProcess$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Processo de pagamento';
	@override String get waitingForOfferUpdate => 'À espera da atualização do estado da oferta...';
	@override late final _Translations$twint$paymentProcess$states$pt states = _Translations$twint$paymentProcess$states$pt._(_root);
	@override late final _Translations$twint$paymentProcess$steps$pt steps = _Translations$twint$paymentProcess$steps$pt._(_root);
	@override late final _Translations$twint$paymentProcess$errors$pt errors = _Translations$twint$paymentProcess$errors$pt._(_root);
	@override late final _Translations$twint$paymentProcess$loading$pt loading = _Translations$twint$paymentProcess$loading$pt._(_root);
	@override late final _Translations$twint$paymentProcess$actions$pt actions = _Translations$twint$paymentProcess$actions$pt._(_root);
}

// Path: twint.paymentFailed
class _Translations$twint$paymentFailed$pt extends Translations$twint$paymentFailed$en {
	_Translations$twint$paymentFailed$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento falhou';
	@override String instructions({required Object netAmount}) => 'Forneça uma nova invoice Lightning para ${netAmount}';
	@override late final _Translations$twint$paymentFailed$form$pt form = _Translations$twint$paymentFailed$form$pt._(_root);
	@override late final _Translations$twint$paymentFailed$actions$pt actions = _Translations$twint$paymentFailed$actions$pt._(_root);
	@override late final _Translations$twint$paymentFailed$errors$pt errors = _Translations$twint$paymentFailed$errors$pt._(_root);
	@override late final _Translations$twint$paymentFailed$walletSection$pt walletSection = _Translations$twint$paymentFailed$walletSection$pt._(_root);
	@override late final _Translations$twint$paymentFailed$loading$pt loading = _Translations$twint$paymentFailed$loading$pt._(_root);
	@override late final _Translations$twint$paymentFailed$success$pt success = _Translations$twint$paymentFailed$success$pt._(_root);
}

// Path: twint.paymentSuccess
class _Translations$twint$paymentSuccess$pt extends Translations$twint$paymentSuccess$en {
	_Translations$twint$paymentSuccess$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento bem-sucedido';
	@override String get message => 'O seu pagamento foi processado com sucesso.';
	@override late final _Translations$twint$paymentSuccess$actions$pt actions = _Translations$twint$paymentSuccess$actions$pt._(_root);
}

// Path: twint.invalidBlik
class _Translations$twint$invalidBlik$pt extends Translations$twint$invalidBlik$en {
	_Translations$twint$invalidBlik$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Código ${code} inválido';
	@override String message({required Object code}) => 'O maker rejeitou o código ${code}';
	@override String explanation({required Object code}) => 'O maker da oferta indicou que o código ${code} que forneceu era inválido ou não funcionou.\n\nO que pretende fazer?';
	@override String get werentCharged => 'Se NÃO foi cobrado:';
	@override String get wereCharged => 'Se foi cobrado:';
	@override late final _Translations$twint$invalidBlik$actions$pt actions = _Translations$twint$invalidBlik$actions$pt._(_root);
	@override late final _Translations$twint$invalidBlik$confirmDialog$pt confirmDialog = _Translations$twint$invalidBlik$confirmDialog$pt._(_root);
	@override late final _Translations$twint$invalidBlik$disputeConfirmDialog$pt disputeConfirmDialog = _Translations$twint$invalidBlik$disputeConfirmDialog$pt._(_root);
	@override late final _Translations$twint$invalidBlik$feedback$pt feedback = _Translations$twint$invalidBlik$feedback$pt._(_root);
	@override late final _Translations$twint$invalidBlik$errors$pt errors = _Translations$twint$invalidBlik$errors$pt._(_root);
}

// Path: twint.conflict
class _Translations$twint$conflict$pt extends Translations$twint$conflict$en {
	_Translations$twint$conflict$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conflito na oferta';
	@override String get headline => 'Conflito na oferta reportado';
	@override String body({required Object code}) => 'O maker marcou o código ${code} como inválido, mas reportou um conflito, indicando que acredita que o pagamento foi bem-sucedido.';
	@override String get instructions => 'Aguarde que o coordenador analise a situação. Poderão pedir-lhe mais detalhes. Volte mais tarde ou contacte o suporte se necessário.';
	@override late final _Translations$twint$conflict$actions$pt actions = _Translations$twint$conflict$actions$pt._(_root);
	@override late final _Translations$twint$conflict$feedback$pt feedback = _Translations$twint$conflict$feedback$pt._(_root);
	@override late final _Translations$twint$conflict$errors$pt errors = _Translations$twint$conflict$errors$pt._(_root);
	@override late final _Translations$twint$conflict$nostrContact$pt nostrContact = _Translations$twint$conflict$nostrContact$pt._(_root);
}

// Path: blik.instructions
class _Translations$blik$instructions$pt extends Translations$blik$instructions$en {
	_Translations$blik$instructions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String taker({required Object code}) => 'Assim que o maker introduzir o código ${code}, terá de confirmar o pagamento na app do seu banco. Certifique-se de que o montante está correto antes de confirmar.';
}

// Path: home.notifications
class _Translations$home$notifications$pt extends Translations$home$notifications$en {
	_Translations$home$notifications$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seja notificado sobre novas ofertas através de:';
	@override String get telegram => 'Telegram';
	@override String get simplex => 'SimpleX';
	@override String get matrix => 'Matrix';
	@override String get signal => 'Signal';
	@override String get channelAllBanks => '(todos os bancos)';
	@override String get channelForBankPrefix => '(apenas ofertas para ';
	@override String get channelForBankSuffix => ')';
	@override String get scopeAllBanks => 'Todos os bancos';
	@override String scopeBankOnly({required Object bank}) => 'Apenas ${bank}';
}

// Path: home.statistics
class _Translations$home$statistics$pt extends Translations$home$statistics$en {
	_Translations$home$statistics$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ofertas concluídas';
	@override String lifetimeCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Total: ${count} transações\nEspera média pelo ${code}: ${avgBlikTime}\nTempo médio de conclusão: ${avgPaidTime}';
	@override String last7DaysCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Últimos 7d: ${count} transações\nEspera média pelo ${code}: ${avgBlikTime}\nTempo médio de conclusão: ${avgPaidTime}';
	@override String last7DaysSingleLine({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Últimos 7d: ${count} ofertas  |  Reserva méd.: ${avgReservationTime}  |  Pago méd.: ${avgPaidTime}';
	@override late final _Translations$home$statistics$errors$pt errors = _Translations$home$statistics$errors$pt._(_root);
}

// Path: generateNewKey.buttons
class _Translations$generateNewKey$buttons$pt extends Translations$generateNewKey$buttons$en {
	_Translations$generateNewKey$buttons$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Gerar';
}

// Path: generateNewKey.errors
class _Translations$generateNewKey$errors$pt extends Translations$generateNewKey$errors$en {
	_Translations$generateNewKey$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get activeOffer => 'Não pode gerar um novo Neko enquanto tiver uma oferta ativa.';
	@override String get failed => 'Falha ao gerar um novo Neko';
}

// Path: generateNewKey.feedback
class _Translations$generateNewKey$feedback$pt extends Translations$generateNewKey$feedback$en {
	_Translations$generateNewKey$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get success => 'Novo Neko gerado com sucesso!';
}

// Path: generateNewKey.tooltips
class _Translations$generateNewKey$tooltips$pt extends Translations$generateNewKey$tooltips$en {
	_Translations$generateNewKey$tooltips$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get generate => 'Gerar novo Neko';
}

// Path: backup.feedback
class _Translations$backup$feedback$pt extends Translations$backup$feedback$en {
	_Translations$backup$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Chave privada copiada para a área de transferência!';
}

// Path: backup.tooltips
class _Translations$backup$tooltips$pt extends Translations$backup$tooltips$en {
	_Translations$backup$tooltips$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get backup => 'Cópia de segurança do Neko';
}

// Path: restore.labels
class _Translations$restore$labels$pt extends Translations$restore$labels$en {
	_Translations$restore$labels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get privateKey => 'Chave privada';
}

// Path: restore.buttons
class _Translations$restore$buttons$pt extends Translations$restore$buttons$en {
	_Translations$restore$buttons$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Restaurar';
}

// Path: restore.errors
class _Translations$restore$errors$pt extends Translations$restore$errors$en {
	_Translations$restore$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get invalidKey => 'Tem de ser uma string hexadecimal de 64 caracteres.';
	@override String get failed => 'Restauro falhou';
}

// Path: restore.feedback
class _Translations$restore$feedback$pt extends Translations$restore$feedback$en {
	_Translations$restore$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get success => 'Neko restaurado com sucesso! A app vai reiniciar.';
}

// Path: restore.tooltips
class _Translations$restore$tooltips$pt extends Translations$restore$tooltips$en {
	_Translations$restore$tooltips$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get restore => 'Restaurar Neko';
}

// Path: system.errors
class _Translations$system$errors$pt extends Translations$system$errors$en {
	_Translations$system$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get generic => 'Ocorreu um erro inesperado. Tente novamente.';
	@override String get loadingTimeoutConfig => 'Erro ao carregar a configuração de timeout.';
	@override String get loadingCoordinatorConfig => 'Erro ao carregar a configuração do coordenador. Tente novamente.';
	@override String get noPublicKey => 'A sua chave pública não está disponível. Não é possível prosseguir.';
	@override String get internalOfferIncomplete => 'Erro interno: os detalhes da oferta estão incompletos. Tente novamente.';
	@override String get loadingPublicKey => 'Erro ao carregar a sua chave pública. Reinicie a app.';
}

// Path: system.blik
class _Translations$system$blik$pt extends Translations$system$blik$en {
	_Translations$system$blik$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String copied({required Object code}) => 'Código ${code} copiado para a área de transferência';
}

// Path: myOffers.filter
class _Translations$myOffers$filter$pt extends Translations$myOffers$filter$en {
	_Translations$myOffers$filter$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todas';
	@override String get active => 'Ativas';
	@override String get completed => 'Concluídas';
	@override String get failed => 'Falhadas';
}

// Path: myOffers.details
class _Translations$myOffers$details$pt extends Translations$myOffers$details$en {
	_Translations$myOffers$details$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalhes da oferta';
	@override String get notFound => 'Oferta não encontrada.';
	@override String get amount => 'Montante';
	@override String get fees => 'Taxas';
	@override String get sats => 'Satoshis';
	@override String get maker => 'Maker';
	@override String get taker => 'Taker';
	@override String get yourFee => 'A sua taxa';
	@override String get makerFee => 'Taxa do maker';
	@override String get takerFee => 'Taxa do taker';
	@override String get coordinator => 'Coordenador';
	@override String get createdAt => 'Criada';
	@override String get reservedAt => 'Reservada';
	@override String blikReceivedAt({required Object code}) => '${code} submetido';
	@override String get makerConfirmedAt => 'Confirmada';
	@override String get settledAt => 'Liquidada';
	@override String get takerPaidAt => 'Taker pago';
	@override String get id => 'ID da oferta';
	@override String get paymentHash => 'Payment Hash';
	@override String get holdInvoice => 'Hold invoice';
	@override String get continueActiveOffer => 'Continuar oferta ativa';
	@override String after({required Object duration}) => 'após ${duration}';
}

// Path: landing.actions
class _Translations$landing$actions$pt extends Translations$landing$actions$en {
	_Translations$landing$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String payBlik({required Object code}) => 'Pagar ${code}';
	@override String get payBlikSubtitle => 'com bitcoin';
	@override String get sellBlik => 'Comprar bitcoin';
	@override String sellBlikSubtitle({required Object code}) => 'com ${code}';
	@override String get howItWorks => 'Como funciona?';
}

// Path: settings.offerCreation
class _Translations$settings$offerCreation$pt extends Translations$settings$offerCreation$en {
	_Translations$settings$offerCreation$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Criação de ofertas';
	@override String get defaultCategory => 'Categoria predefinida';
	@override String get defaultBank => 'Banco predefinido';
	@override String get defaultBankNone => 'Nenhum (escolher por oferta)';
	@override String get preferredCoordinator => 'Coordenador preferido';
	@override String get automaticCoordinator => 'Mais fiável';
	@override String get automaticCoordinatorDescription => 'Escolhe o coordenador com o melhor historial, combinando as suas próprias ofertas concluídas e a atividade global da rede.';
	@override String get cheapestCoordinator => 'Mais barato';
	@override String get cheapestCoordinatorDescription => 'Escolhe o coordenador disponível com a taxa de maker mais baixa para cada oferta.';
	@override String get enablePremium => 'Ativar preços premium';
	@override String get enablePremiumDescription => 'Mostrar o seletor de premium ao criar ofertas como maker.';
	@override String get defaultPremium => 'Premium predefinido';
	@override String get defaultPremiumDisabled => 'Ative os preços premium para definir um premium predefinido.';
	@override String get premiumPerCoordinatorNote => 'Cada coordenador define o seu próprio premium máximo, por isso o seu valor predefinido é limitado pelo coordenador usado na oferta.';
	@override late final _Translations$settings$offerCreation$categoryOptions$pt categoryOptions = _Translations$settings$offerCreation$categoryOptions$pt._(_root);
	@override late final _Translations$settings$offerCreation$dialogs$pt dialogs = _Translations$settings$offerCreation$dialogs$pt._(_root);
}

// Path: settings.display
class _Translations$settings$display$pt extends Translations$settings$display$en {
	_Translations$settings$display$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Visualização';
	@override String get bitcoinUnit => 'Unidade de bitcoin';
	@override String get bitcoinUnitDescription => 'Escolha como os montantes de bitcoin são mostrados em toda a app.';
	@override late final _Translations$settings$display$unitOptions$pt unitOptions = _Translations$settings$display$unitOptions$pt._(_root);
}

// Path: settings.paymentSystem
class _Translations$settings$paymentSystem$pt extends Translations$settings$paymentSystem$en {
	_Translations$settings$paymentSystem$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'País / Sistema de pagamento';
	@override String get subtitle => 'Escolha o sistema de pagamento do seu país.';
	@override String get dialogTitle => 'Selecionar sistema de pagamento';
	@override late final _Translations$settings$paymentSystem$countries$pt countries = _Translations$settings$paymentSystem$countries$pt._(_root);
}

// Path: notificationSettings.newOfferAlerts
class _Translations$notificationSettings$newOfferAlerts$pt extends Translations$notificationSettings$newOfferAlerts$en {
	_Translations$notificationSettings$newOfferAlerts$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Alertas de novas ofertas';
	@override String description({required Object app}) => 'Quando ativado, o ${app} notifica-o sobre novas ofertas disponíveis para aceitar dos seus coordenadores ativos enquanto a app está em segundo plano. Isto pode ser mais rápido do que os messengers externos.';
}

// Path: wallet.missingReceiving
class _Translations$wallet$missingReceiving$pt extends Translations$wallet$missingReceiving$en {
	_Translations$wallet$missingReceiving$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Carteira de receção necessária';
	@override String get message => 'Nenhuma carteira configurada para receber. Adicione uma nas definições da Carteira para aceitar ofertas.';
	@override String get openSettings => 'Definições da carteira';
}

// Path: wallet.incompatibleReceiving
class _Translations$wallet$incompatibleReceiving$pt extends Translations$wallet$incompatibleReceiving$en {
	_Translations$wallet$incompatibleReceiving$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Carteira BOLT11 necessária';
	@override String get message => 'Este coordenador só pode pagar esta oferta através de BOLT11.';
	@override String get explanation => 'A sua carteira de receção suporta ofertas BOLT12, mas não consegue criar a fatura BOLT11 necessária. Adicione uma carteira de receção compatível com BOLT11.';
}

// Path: wallet.details
class _Translations$wallet$details$pt extends Translations$wallet$details$en {
	_Translations$wallet$details$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalhes da carteira';
	@override String get pendingTitle => 'Transações pendentes';
	@override String get finishedTitle => 'Transações concluídas';
}

// Path: nwc.labels
class _Translations$nwc$labels$pt extends Translations$nwc$labels$en {
	_Translations$nwc$labels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get connectionString => 'String de ligação NWC';
	@override String get hint => 'nostr+walletconnect://...';
	@override String get status => 'Estado da ligação';
	@override String get connected => 'Ligada';
	@override String get disconnected => 'Desligada';
	@override String get scanQrCode => 'Leia o QR code com a sua ligação NWC';
	@override String get balance => 'Saldo';
	@override String get budget => 'Orçamento';
	@override String get usedBudget => 'Usado';
	@override String get totalBudget => 'Total';
	@override String get renewsIn => 'Renova em';
	@override String get renewalPeriod => 'Período de renovação';
	@override String get relay => 'Relay';
	@override String get relays => 'Relays';
}

// Path: nwc.prompts
class _Translations$nwc$prompts$pt extends Translations$nwc$prompts$en {
	_Translations$nwc$prompts$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get enter => 'Introduza a sua string de ligação NWC';
	@override String get connect => 'Ligar carteira';
	@override String get disconnect => 'Desligar';
	@override String get confirmDisconnect => 'Tem a certeza de que quer desligar a sua carteira NWC?';
	@override String get pasteConnection => 'Colar string de ligação';
	@override String get chooseMethod => 'Escolha como ligar a sua carteira Lightning';
	@override String get howToGet => 'Ainda não tem uma ligação NWC? Saiba como obter uma!';
	@override String get learnMore => 'Saiba mais sobre o NWC';
}

// Path: nwc.actions
class _Translations$nwc$actions$pt extends Translations$nwc$actions$en {
	_Translations$nwc$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get connectAlbyGo => 'Ligar com Alby Go';
	@override String get connectNwc => 'Ler QR code NWC';
}

// Path: nwc.feedback
class _Translations$nwc$feedback$pt extends Translations$nwc$feedback$en {
	_Translations$nwc$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Carteira NWC ligada com sucesso!';
	@override String get disconnected => 'Carteira NWC desligada';
	@override String get connecting => 'A ligar à carteira NWC...';
	@override String get loadingWalletInfo => 'A carregar informação da carteira...';
}

// Path: nwc.errors
class _Translations$nwc$errors$pt extends Translations$nwc$errors$en {
	_Translations$nwc$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String connecting({required Object details}) => 'Erro ao ligar ao NWC: ${details}';
	@override String disconnecting({required Object details}) => 'Erro ao desligar o NWC: ${details}';
	@override String get invalid => 'String de ligação NWC inválida';
	@override String get required => 'A string de ligação NWC é obrigatória';
	@override String get loadingBalance => 'Falha ao carregar o saldo da carteira';
	@override String get loadingBudget => 'Falha ao carregar o orçamento da carteira';
}

// Path: nwc.time
class _Translations$nwc$time$pt extends Translations$nwc$time$en {
	_Translations$nwc$time$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String minutes({required Object count}) => '${count}m';
	@override String hours({required Object count}) => '${count}h';
	@override String days({required Object count}) => '${count}d';
	@override String get justNow => 'agora mesmo';
}

// Path: relays.status
class _Translations$relays$status$pt extends Translations$relays$status$en {
	_Translations$relays$status$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Ligado';
	@override String get connecting => 'A ligar';
	@override String get reconnecting => 'A religar';
	@override String get disconnected => 'Desligado';
}

// Path: relays.popup
class _Translations$relays$popup$pt extends Translations$relays$popup$en {
	_Translations$relays$popup$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object connected, required Object total}) => 'Relays (${connected}/${total} ligados)';
	@override String get connectingMessage => 'A ligar aos relays...';
}

// Path: offerNotifications.activeService
class _Translations$offerNotifications$activeService$pt extends Translations$offerNotifications$activeService$en {
	_Translations$offerNotifications$activeService$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'À espera de novas ofertas';
	@override String body({required Object app}) => 'O serviço Nostr está a monitorizar eventos de ofertas do ${app}.';
}

// Path: offerNotifications.funded
class _Translations$offerNotifications$funded$pt extends Translations$offerNotifications$funded$en {
	_Translations$offerNotifications$funded$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta financiada';
	@override String get body => 'A sua hold invoice foi aceite. A oferta está agora ativa.';
}

// Path: offerNotifications.reserved
class _Translations$offerNotifications$reserved$pt extends Translations$offerNotifications$reserved$en {
	_Translations$offerNotifications$reserved$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta reservada';
	@override String get body => 'Um taker reservou a sua oferta.';
}

// Path: offerNotifications.blikReady
class _Translations$offerNotifications$blikReady$pt extends Translations$offerNotifications$blikReady$en {
	_Translations$offerNotifications$blikReady$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Código ${code} pronto';
	@override String body({required Object code}) => 'O seu código ${code} está pronto para ver.';
}

// Path: offerNotifications.newOffer
class _Translations$offerNotifications$newOffer$pt extends Translations$offerNotifications$newOffer$en {
	_Translations$offerNotifications$newOffer$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nova oferta disponível';
	@override String body({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}';
	@override String premiumSuffix({required Object percent}) => '+${percent}% premium';
}

// Path: offerNotifications.categories
class _Translations$offerNotifications$categories$pt extends Translations$offerNotifications$categories$en {
	_Translations$offerNotifications$categories$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Loja';
	@override String get atm => 'Multibanco';
	@override String get online => 'Online';
}

// Path: offerNotifications.blikPendingReminder
class _Translations$offerNotifications$blikPendingReminder$pt extends Translations$offerNotifications$blikPendingReminder$en {
	_Translations$offerNotifications$blikPendingReminder$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} à espera da sua ação';
	@override String body({required Object code}) => 'Confirme o pagamento ou marque o código ${code} como inválido.';
}

// Path: offerNotifications.takerCharged
class _Translations$offerNotifications$takerCharged$pt extends Translations$offerNotifications$takerCharged$en {
	_Translations$offerNotifications$takerCharged$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} cobrado';
	@override String body({required Object code}) => 'O taker reporta que o ${code} foi cobrado. Confirme ou marque como inválido.';
}

// Path: offerNotifications.invalidBlik
class _Translations$offerNotifications$invalidBlik$pt extends Translations$offerNotifications$invalidBlik$en {
	_Translations$offerNotifications$invalidBlik$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} marcado como inválido';
	@override String body({required Object code}) => 'O maker marcou o seu código ${code} como inválido.';
}

// Path: offerNotifications.takerPaid
class _Translations$offerNotifications$takerPaid$pt extends Translations$offerNotifications$takerPaid$en {
	_Translations$offerNotifications$takerPaid$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento recebido';
	@override String get body => 'O seu pagamento Lightning foi enviado.';
}

// Path: offers.details.categories
class _Translations$offers$details$categories$pt extends Translations$offers$details$categories$en {
	_Translations$offers$details$categories$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Loja, café ou restaurante';
	@override String get atmCashout => 'Levantamento em multibanco';
	@override String get onlineService => 'Serviço/produto online';
}

// Path: offers.details.consents
class _Translations$offers$details$consents$pt extends Translations$offers$details$consents$en {
	_Translations$offers$details$consents$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Alguns multibancos cobram uma taxa extra para além do montante da oferta. Ao aceitar esta oferta, aceita quaisquer encargos bancários adicionais exigidos pelo multibanco.';
	@override String ecommerce({required Object code}) => 'Por vários motivos — como um artigo esgotado, uma correção de pagamento em excesso, ou outros problemas do lado do comerciante — o comerciante online pode enviar automaticamente dinheiro de volta para a conta bancária associada ao ${code} que gerou. Esses fundos chegam à sua conta e não lhe pertencem. Se isto acontecer, contacte o coordenador de boa-fé e combine devolver os fundos ao maker. Ao aceitar esta oferta, aceita estes termos e compromete-se honradamente a agir com honestidade nestas situações.';
}

// Path: coordinator.coldStart.phases
class _Translations$coordinator$coldStart$phases$pt extends Translations$coordinator$coldStart$phases$en {
	_Translations$coordinator$coldStart$phases$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get loadingMuteList => 'A carregar filtros de coordenadores';
	@override String get discovering => 'A descobrir coordenadores no Nostr';
	@override String get loadingProfiles => 'A carregar perfis dos coordenadores';
	@override String get loadingStats => 'A ler o histórico dos coordenadores';
	@override String get checkingHealth => 'A verificar a saúde dos coordenadores';
	@override String get finalizing => 'A ativar coordenadores predefinidos';
	@override String get completed => 'Concluído';
}

// Path: maker.amountForm.progress
class _Translations$maker$amountForm$progress$pt extends Translations$maker$amountForm$progress$en {
	_Translations$maker$amountForm$progress$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Criar oferta';
	@override String get step2 => '2. Esperar pelo taker';
	@override String step3({required Object code}) => '3. Usar ${code}';
}

// Path: maker.amountForm.labels
class _Translations$maker$amountForm$labels$pt extends Translations$maker$amountForm$labels$en {
	_Translations$maker$amountForm$labels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get coordinator => 'Coordenador';
	@override String get category => 'Categoria';
	@override String get exchangeRate => 'Taxa de câmbio';
	@override String get fee => 'Taxa';
	@override String get satoshisToPay => 'Montante a pagar';
	@override String get enterAmount => 'Introduzir montante';
	@override String get customAmount => 'Personalizado';
	@override String get tapToSelect => 'Toque para selecionar';
	@override String get premium => 'Premium';
}

// Path: maker.amountForm.actions
class _Translations$maker$amountForm$actions$pt extends Translations$maker$amountForm$actions$en {
	_Translations$maker$amountForm$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get generateInvoice => 'Gerar invoice';
}

// Path: maker.amountForm.bank
class _Translations$maker$amountForm$bank$pt extends Translations$maker$amountForm$bank$en {
	_Translations$maker$amountForm$bank$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Banco';
	@override String get required => 'Escolhe um banco';
	@override String shortValidityWarning({required Object minutes}) => 'O código deste banco é válido apenas ${minutes} min — está no multibanco antes de reservar.';
}

// Path: maker.amountForm.twintScan
class _Translations$maker$amountForm$twintScan$pt extends Translations$maker$amountForm$twintScan$en {
	_Translations$maker$amountForm$twintScan$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String cardTitle({required Object code}) => 'Ler QR ${code} e montante';
	@override String get cardBody => 'Aponte a câmara para o ecrã de pagamento. A app preencherá automaticamente o código e, quando visível, o montante.';
	@override String get scanButton => 'Ler com a câmara';
	@override String get manualButton => 'Introduzir manualmente';
	@override String codeLabel({required Object code}) => 'Código ${code}';
	@override String get rescan => 'Ler novamente';
	@override String helperFilled({required Object code}) => 'O taker verá este código e introduzi-lo-á em ${code}.';
	@override String helperEmpty({required Object digits}) => 'Leia para preencher isto automaticamente ou introduza manualmente o código de ${digits} dígitos.';
}

// Path: maker.amountForm.tooltips
class _Translations$maker$amountForm$tooltips$pt extends Translations$maker$amountForm$tooltips$en {
	_Translations$maker$amountForm$tooltips$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String feeInfo({required Object feePercent}) => 'O coordenador cobra uma taxa de maker de ${feePercent}%. Esta taxa é deduzida do seu pagamento Lightning.';
	@override String get payInfo => 'Este cálculo baseia-se em taxas de câmbio obtidas no cliente. O coordenador calculará o montante exato, e o montante da invoice será o valor final e exato a pagar.';
	@override String get premiumInfo => 'Um premium opcional permite vender os seus sats acima do preço de mercado. O premium reduz os sats bloqueados na sua hold invoice para o mesmo montante em fiat, por isso o taker paga acima do mercado e o maker fica com a diferença. Por predefinição está desligado (0%). O premium máximo é definido pelo coordenador selecionado.';
}

// Path: maker.amountForm.category
class _Translations$maker$amountForm$category$pt extends Translations$maker$amountForm$category$en {
	_Translations$maker$amountForm$category$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Categoria da oferta';
	@override String unsupportedForSystem({required Object system}) => 'O ${system} não suporta esta categoria.';
	@override late final _Translations$maker$amountForm$category$options$pt options = _Translations$maker$amountForm$category$options$pt._(_root);
	@override late final _Translations$maker$amountForm$category$shortLabels$pt shortLabels = _Translations$maker$amountForm$category$shortLabels$pt._(_root);
	@override String get atmHint => 'Os takers verão que esta oferta é para levantamento em multibanco e podem evitá-la se o banco deles cobrar taxas extra de multibanco.';
	@override String physicalShopHint({required Object app, required Object code}) => 'O sítio ideal para usar o ${app} é um terminal de self-checkout — já que esperar que um taker reserve, gere e confirme um código ${code} pode demorar alguns minutos. Funciona muito bem em lojas, cafés e restaurantes. Se for corajoso o suficiente para fazer um caixa (e as pessoas na fila atrás de si) esperar esses minutos, parabéns.';
	@override String get ecommerceWarningTitle => 'Risco de reembolso do comerciante online';
	@override String ecommerceWarningBody({required Object code}) => 'Por vários motivos — como um artigo esgotado, uma correção de pagamento em excesso, ou outros problemas do lado do comerciante — o comerciante online pode emitir automaticamente um reembolso para a conta bancária associada ao ${code}, que é a conta do taker. O coordenador não pode obrigar o taker a devolver-lhe esses fundos.';
	@override String get ecommerceConfirmation => 'Compreendo o risco de reembolso e vou adicionar uma nota à encomenda a instruir o comerciante a reembolsar uma conta diferente caso um reembolso se torne necessário.';
	@override String get whyThisIsNeeded => 'porque é que isto é necessário?';
}

// Path: maker.amountForm.onboarding
class _Translations$maker$amountForm$onboarding$pt extends Translations$maker$amountForm$onboarding$en {
	_Translations$maker$amountForm$onboarding$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get titlePrefix => 'Novo';
	@override String get title => 'Escolha a categoria da oferta';
	@override String get body => 'Escolha a categoria que melhor corresponde àquilo que está a pagar antes de gerar a invoice.';
	@override String get showWhy => 'Porque é que isto importa?';
	@override String get hideWhy => 'Ocultar detalhes';
	@override String get whyTitle => 'Escolher a categoria certa ajuda os takers a decidir em segurança';
	@override String get whyBody => 'Situações diferentes têm expectativas e riscos diferentes. Os levantamentos em multibanco podem incluir taxas bancárias extra, e as compras online podem envolver casos limite de reembolso. Marcar a categoria certa dá aos takers o contexto de que precisam antes de aceitar a sua oferta.';
	@override String get cta => 'Entendido';
}

// Path: maker.amountForm.errors
class _Translations$maker$amountForm$errors$pt extends Translations$maker$amountForm$errors$en {
	_Translations$maker$amountForm$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String initiating({required Object details}) => 'Erro ao iniciar a oferta: ${details}';
	@override String get publicKeyNotLoaded => 'Erro: chave pública ainda não carregada.';
	@override String get noCoordinatorMatchesAmount => 'Nenhum coordenador suporta este montante. Tente outro valor.';
	@override String get categoryRequired => 'Selecione uma categoria de oferta.';
	@override String get ecommerceConfirmationRequired => 'Confirme o risco de reembolso do comerciante online antes de continuar.';
}

// Path: maker.payInvoice.actions
class _Translations$maker$payInvoice$actions$pt extends Translations$maker$payInvoice$actions$en {
	_Translations$maker$payInvoice$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get copy => 'Copiar invoice';
	@override String get payInWallet => 'Abrir em carteira externa';
	@override String get connectWallet => 'Ligar carteira';
	@override String get payWithNwc => 'Pagar';
	@override String get paying => 'A pagar...';
}

// Path: maker.payInvoice.feedback
class _Translations$maker$payInvoice$feedback$pt extends Translations$maker$payInvoice$feedback$en {
	_Translations$maker$payInvoice$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get copied => 'Invoice copiada para a área de transferência!';
	@override String get waitingConfirmation => 'À espera da confirmação do pagamento...';
	@override String get nwcConnected => 'Carteira NWC ligada!';
	@override String get nwcPaymentSuccess => 'Pagamento efetuado com sucesso!';
}

// Path: maker.payInvoice.errors
class _Translations$maker$payInvoice$errors$pt extends Translations$maker$payInvoice$errors$en {
	_Translations$maker$payInvoice$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get couldNotOpenApp => 'Não foi possível abrir a app Lightning para a invoice.';
	@override String openingApp({required Object details}) => 'Erro ao abrir a app Lightning: ${details}';
	@override String get publicKeyNotAvailable => 'A chave pública não está disponível.';
	@override String get couldNotFetchActive => 'Não foi possível obter os detalhes da oferta ativa. Pode ter expirado.';
	@override String nwcPaymentFailed({required Object details}) => 'Pagamento falhou: ${details}';
	@override String get nwcNotConnected => 'Carteira NWC não ligada';
	@override String insufficientBalance({required Object required, required Object available}) => 'Saldo insuficiente. Precisa de ${required} sats, tem ${available} sats';
	@override String get cancelOfferAlreadyFunded => 'O coordenador indica que esta oferta já está financiada. Já não pode ser cancelada.';
	@override String cancelFailed({required Object details}) => 'Não foi possível cancelar a oferta: ${details}';
}

// Path: maker.payInvoice.budgetWarning
class _Translations$maker$payInvoice$budgetWarning$pt extends Translations$maker$payInvoice$budgetWarning$en {
	_Translations$maker$payInvoice$budgetWarning$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O pagamento pode falhar';
	@override String balanceTooLow({required Object name}) => 'A sua carteira de gastos predefinida ${name} não tem saldo suficiente para este pagamento.';
	@override String budgetTooLow({required Object name}) => 'A sua carteira de gastos predefinida ${name} não tem orçamento suficiente para este pagamento.';
	@override String balanceLine({required Object available}) => 'Saldo: ${available}';
	@override String budgetLine({required Object remaining}) => 'Orçamento NWC restante: ${remaining}';
	@override String requiredLine({required Object required}) => 'Necessário: ${required}';
	@override String addFundsHint({required Object name}) => 'Adicione fundos a ${name} para cobrir este montante.';
	@override String get increaseBudgetHint => 'Aumente o orçamento de gastos NWC para esta ligação na app da sua carteira.';
	@override String get switchWalletLabel => 'Ou use outra carteira:';
	@override String get walletLowFundsTag => 'Pode falhar';
	@override String get payAnyway => 'Tentar mesmo assim';
	@override String get cancel => 'Cancelar';
	@override String get readyTitle => 'Pagar invoice';
}

// Path: maker.confirmPayment.actions
class _Translations$maker$confirmPayment$actions$pt extends Translations$maker$confirmPayment$actions$en {
	_Translations$maker$confirmPayment$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Confirmar pagamento bem-sucedido';
	@override String markInvalid({required Object code}) => 'Código ${code} inválido';
	@override String copyBlik({required Object code}) => 'Copiar ${code}';
}

// Path: maker.confirmPayment.confirmDialog
class _Translations$maker$confirmPayment$confirmDialog$pt extends Translations$maker$confirmPayment$confirmDialog$en {
	_Translations$maker$confirmPayment$confirmDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmar pagamento?';
	@override String content({required Object code}) => 'Esta ação é irreversível. Após confirmar:\n\n• O taker receberá os fundos imediatamente\n• O coordenador não poderá disputar os fundos\n• Não pode anular esta ação\n\nConfirme apenas se o pagamento ${code} foi bem-sucedido.';
	@override String get cancel => 'Cancelar';
	@override String get confirmButton => 'Sim, confirmar pagamento';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class _Translations$maker$confirmPayment$invalidBlikDisputeDialog$pt extends Translations$maker$confirmPayment$invalidBlikDisputeDialog$en {
	_Translations$maker$confirmPayment$invalidBlikDisputeDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abrir disputa?';
	@override String content({required Object code}) => 'O taker reportou que o pagamento ${code} foi cobrado da conta dele.\n\nMarcar isto como inválido abrirá imediatamente uma DISPUTA que requer intervenção do coordenador.\n\n• Pode ser cobrada uma taxa de disputa se a decisão for contra si\n• A hold invoice será liquidada imediatamente\n• Será necessária verificação manual\n\nProssiga apenas se tiver a certeza de que o pagamento ${code} NÃO foi bem-sucedido.';
	@override String get cancel => 'Cancelar';
	@override String get confirmButton => 'Sim, abrir disputa';
}

// Path: maker.confirmPayment.feedback
class _Translations$maker$confirmPayment$feedback$pt extends Translations$maker$confirmPayment$feedback$en {
	_Translations$maker$confirmPayment$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'O maker confirmou o pagamento.';
	@override String get confirmedTakerPaid => 'Pagamento confirmado! O taker vai receber os fundos.';
	@override String progressLabel({required Object seconds}) => 'A confirmar: faltam ${seconds} s';
}

// Path: maker.confirmPayment.errors
class _Translations$maker$confirmPayment$errors$pt extends Translations$maker$confirmPayment$errors$en {
	_Translations$maker$confirmPayment$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String failedToRetrieve({required Object code}) => 'Erro: falha ao obter o código ${code}.';
	@override String retrieving({required Object code, required Object details}) => 'Erro ao obter o código ${code}: ${details}';
	@override String get missingHashOrKey => 'Erro: payment hash ou chave pública em falta.';
	@override String incorrectState({required Object status}) => 'A oferta não está no estado correto para confirmação (Estado: ${status})';
	@override String confirming({required Object details}) => 'Erro ao confirmar o pagamento: ${details}';
	@override String get invalidState => 'Erro: estado da oferta inválido recebido.';
	@override String get internalIncomplete => 'Erro interno: detalhes da oferta incompletos.';
	@override String notAwaitingConfirmation({required Object status}) => 'A oferta já não está à espera de confirmação (Estado: ${status}).';
	@override String get unexpectedStatus => 'Estado de oferta inesperado recebido do servidor.';
}

// Path: maker.conflict.actions
class _Translations$maker$conflict$actions$pt extends Translations$maker$conflict$actions$en {
	_Translations$maker$conflict$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get back => 'Voltar ao início';
	@override String confirmPayment({required Object code}) => 'Foi engano meu, confirmar o sucesso do pagamento ${code}';
	@override String openDispute({required Object code}) => 'O pagamento ${code} NÃO foi bem-sucedido, ABRIR DISPUTA';
	@override String get submitDispute => 'Submeter disputa';
}

// Path: maker.conflict.disputeDialog
class _Translations$maker$conflict$disputeDialog$pt extends Translations$maker$conflict$disputeDialog$en {
	_Translations$maker$conflict$disputeDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abrir disputa?';
	@override String get content => 'Abrir uma disputa requer verificação manual pelo coordenador, o que demora tempo. Será deduzida uma taxa de disputa se a decisão for contra si. A hold invoice será liquidada para evitar que expire. Se a disputa for decidida a seu favor, receberá um reembolso (menos taxas) numa carteira à sua escolha.';
	@override String get contentDetailed => 'Abrir uma disputa requer intervenção manual do coordenador, o que demora tempo e implica uma taxa de disputa.\n\nA hold invoice será liquidada imediatamente para evitar que expire antes de a disputa ser resolvida.\n\nSe a disputa for decidida a seu favor, o montante em satoshi será reembolsado numa carteira à sua escolha (menos taxas). Certifique-se de que tem uma carteira pronta para receber.';
	@override late final _Translations$maker$conflict$disputeDialog$actions$pt actions = _Translations$maker$conflict$disputeDialog$actions$pt._(_root);
}

// Path: maker.conflict.feedback
class _Translations$maker$conflict$feedback$pt extends Translations$maker$conflict$feedback$en {
	_Translations$maker$conflict$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get disputeOpenedSuccess => 'Disputa aberta com sucesso. O coordenador vai analisar.';
}

// Path: maker.conflict.errors
class _Translations$maker$conflict$errors$pt extends Translations$maker$conflict$errors$en {
	_Translations$maker$conflict$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String openingDispute({required Object error}) => 'Erro ao abrir a disputa: ${error}';
}

// Path: maker.conflict.nostrContact
class _Translations$maker$conflict$nostrContact$pt extends Translations$maker$conflict$nostrContact$en {
	_Translations$maker$conflict$nostrContact$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contactar o coordenador no Nostr';
	@override String get description => 'Pode enviar uma DM diretamente ao coordenador para obter ajuda com esta disputa.';
	@override String get copyNpub => 'Copiar npub';
	@override String get openProfile => 'Ver perfil';
	@override String get npubCopied => 'npub do coordenador copiado para a área de transferência!';
	@override String get yourIdentityDescription => 'Para enviar DMs, inicie sessão com a sua chave privada Neko (nsec) em qualquer cliente Nostr que suporte mensagens diretas.';
	@override String get manageNekoKeys => 'Gerir chaves Neko';
}

// Path: taker.submitBlik.actions
class _Translations$taker$submitBlik$actions$pt extends Translations$taker$submitBlik$actions$en {
	_Translations$taker$submitBlik$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String submit({required Object code}) => 'Submeter ${code}';
}

// Path: taker.submitBlik.feedback
class _Translations$taker$submitBlik$feedback$pt extends Translations$taker$submitBlik$feedback$en {
	_Translations$taker$submitBlik$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String pasted({required Object code}) => 'Código ${code} colado.';
}

// Path: taker.submitBlik.validation
class _Translations$taker$submitBlik$validation$pt extends Translations$taker$submitBlik$validation$en {
	_Translations$taker$submitBlik$validation$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String invalidFormat({required Object code, required Object digits}) => 'Introduza um código ${code} válido de ${digits} dígitos.';
}

// Path: taker.submitBlik.errors
class _Translations$taker$submitBlik$errors$pt extends Translations$taker$submitBlik$errors$en {
	_Translations$taker$submitBlik$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String submitting({required Object code, required Object details}) => 'Erro ao submeter o código ${code}: ${details}';
	@override String clipboardInvalid({required Object code, required Object digits}) => 'A área de transferência não contém um código ${code} válido de ${digits} dígitos.';
	@override String get stateChanged => 'Erro: o estado da oferta mudou.';
	@override String get stateNotValid => 'Erro: o estado da oferta já não é válido.';
	@override String fetchedIdMismatch({required Object fetchedId, required Object initialId}) => 'O ID da oferta ativa obtido (${fetchedId}) não corresponde ao ID inicial da oferta (${initialId}). Estado inconsistente?';
	@override String get paymentHashMissing => 'Payment hash da oferta em falta após obtenção.';
}

// Path: taker.submitBlik.details
class _Translations$taker$submitBlik$details$pt extends Translations$taker$submitBlik$details$en {
	_Translations$taker$submitBlik$details$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String requestedAmount({required Object code}) => 'Montante ${code} pedido';
	@override String get exchangeRate => 'Taxa de câmbio';
	@override String get takerFee => 'Taxa do taker';
	@override String get status => 'Estado';
	@override String get youllReceive => 'Vai receber';
}

// Path: taker.criticalCodeDecision.actions
class _Translations$taker$criticalCodeDecision$actions$pt extends Translations$taker$criticalCodeDecision$actions$en {
	_Translations$taker$criticalCodeDecision$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Voltar e verificar o banco';
	@override String get proceed => 'NÃO fui debitado — continuar';
}

// Path: twint.scanner.status
class _Translations$twint$scanner$status$pt extends Translations$twint$scanner$status$en {
	_Translations$twint$scanner$status$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String align({required Object code}) => 'Alinhe o QR ${code} e o texto do montante dentro da moldura da câmara.';
	@override String notRecognized({required Object code}) => 'O código ${code} ainda não foi reconhecido. Mantenha o QR e o montante visíveis ou preencha o formulário manualmente.';
	@override String get amountFailed => 'A leitura pela câmara não conseguiu extrair o montante. Ainda pode usar o resultado do QR e corrigir os campos manualmente.';
}

// Path: twint.flow.progress
class _Translations$twint$flow$progress$pt extends Translations$twint$flow$progress$en {
	_Translations$twint$flow$progress$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get step1 => '1. Criar oferta';
	@override String get step2 => '2. Esperar pelo taker';
	@override String get step3 => '3. Confirmar';
}

// Path: twint.flow.takerProgress
class _Translations$twint$flow$takerProgress$pt extends Translations$twint$flow$takerProgress$en {
	_Translations$twint$flow$takerProgress$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String step1({required Object code}) => '1. Pagar ${code}';
	@override String get step2 => '2. Receber sats';
}

// Path: twint.flow.makerWait
class _Translations$twint$flow$makerWait$pt extends Translations$twint$flow$makerWait$en {
	_Translations$twint$flow$makerWait$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get takerPaying => 'O taker está a pagar';
	@override String yourCode({required Object code}) => 'O seu código ${code}';
	@override String offerExpires({required Object code}) => 'O ${code} expira';
	@override String get autoExpires => 'Expira automaticamente';
	@override String codeExpiresIn({required Object code}) => '${code} expira em...';
	@override String get cancelOffer => 'Cancelar oferta';
	@override String reservedInfo({required Object code}) => 'Um taker reservou a sua oferta e está agora a pagar o seu código ${code} na app do banco. Quando o pagamento chegar ao seu comerciante, confirme-o abaixo.';
	@override String get confirmReceived => 'Confirmar pagamento recebido';
	@override late final _Translations$twint$flow$makerWait$confirmDialog$pt confirmDialog = _Translations$twint$flow$makerWait$confirmDialog$pt._(_root);
}

// Path: twint.flow.makerExpired
class _Translations$twint$flow$makerExpired$pt extends Translations$twint$flow$makerExpired$en {
	_Translations$twint$flow$makerExpired$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} provavelmente expirado';
	@override String warning({required Object code}) => 'O código ${code} provavelmente já expirou — mas o taker ainda pode ter conseguido pagá-lo. Verifique o seu comerciante: tem o tempo abaixo para confirmar o pagamento.';
	@override String get timerCaption => 'Tempo para confirmar';
	@override String get disputeHint => 'Também pode deixar o temporizador terminar. Se o taker declarar que pagou, isto torna-se um conflito/disputa em que ambas as partes terão de fornecer provas ao coordenador para resolver a questão.';
}

// Path: twint.flow.makerVerify
class _Translations$twint$flow$makerVerify$pt extends Translations$twint$flow$makerVerify$en {
	_Translations$twint$flow$makerVerify$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Recebeu o pagamento?';
	@override String body({required Object amount, required Object code}) => 'O taker indica que pagou ${amount} para o seu código ${code}.';
	@override String get hint => 'Verifique o estado do pagamento com o seu comerciante (terminal da loja ou transação online). Em caso de dúvida, aguarde e verifique novamente mais tarde antes de decidir.';
	@override String get autoConfirms => 'Confirma automaticamente';
	@override String get confirmReceived => 'Confirmar receção';
	@override String get openDispute => 'Abrir disputa';
}

// Path: twint.flow.makerRecode
class _Translations$twint$flow$makerRecode$pt extends Translations$twint$flow$makerRecode$en {
	_Translations$twint$flow$makerRecode$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oferta expirada';
	@override String body({required Object code}) => 'Nenhum taker concluiu a troca. Introduza um novo código ${code} para voltar a publicar esta oferta, ou cancele-a.';
	@override String scanCardTitle({required Object code}) => 'Digitalizar novo QR ${code}';
	@override String get scanCardBody => 'Aponte a câmara para o ecrã de pagamento. A app preencherá o novo código — o montante mantém-se.';
	@override String fieldLabel({required Object code}) => 'Novo código ${code}';
	@override String get autoCancels => 'Cancela automaticamente';
	@override String get relist => 'Publicar novamente com novo código';
	@override String get cancelOffer => 'Cancelar oferta';
}

// Path: twint.flow.takerPay
class _Translations$twint$flow$takerPay$pt extends Translations$twint$flow$takerPay$en {
	_Translations$twint$flow$takerPay$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Pagar com ${code}';
	@override String body({required Object code, required Object amount}) => 'Abra a sua app ${code} e pague ${amount} usando:';
	@override String get codeExpires => 'O código expira';
	@override String get paid => 'Já paguei';
	@override String get cancel => 'Cancelar';
}

// Path: twint.flow.takerWait
class _Translations$twint$flow$takerWait$pt extends Translations$twint$flow$takerWait$en {
	_Translations$twint$flow$takerWait$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'À espera do maker';
	@override String body({required Object code}) => 'O maker está a verificar se o seu pagamento ${code} chegou ao seu comerciante. Ele tem de confirmar a receção ou abrir uma disputa.';
	@override String get info => 'Se o maker não tomar nenhuma decisão antes do tempo expirar, o pagamento confirma-se automaticamente e receberá os seus sats.';
	@override String get autoConfirms => 'Confirma automaticamente';
}

// Path: twint.flow.takerExpired
class _Translations$twint$flow$takerExpired$pt extends Translations$twint$flow$takerExpired$en {
	_Translations$twint$flow$takerExpired$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => '${code} provavelmente expirado';
	@override String warning({required Object code}) => 'O código ${code} provavelmente já expirou. Tem agora de tomar uma decisão importante — escolha com cuidado.';
	@override String optionPaid({required Object code}) => 'Se PAGOU o código ${code} na app do seu banco, marque-o como pago. Isso compromete-o com essa declaração: o maker terá de confirmar para desbloquear o bitcoin, ou abrir uma disputa em que ambas as partes fornecem provas ao coordenador.';
	@override String get optionCancel => 'Se NÃO pagou, cancele a reserva. É irreversível — se o pagamento tiver de facto passado, o coordenador deixa de poder garantir os seus sats.';
	@override String noDecision({required Object code}) => 'Se não tomar nenhuma decisão antes de o temporizador terminar, o coordenador assumirá que NÃO pagou o código ${code}. O maker poderá então cancelar a oferta — cancelando a hold invoice — e depois disso o coordenador já não poderá liquidar os sats para si, mesmo que tenha pago.';
	@override String get timerCaption => 'Tempo para decidir';
	@override String markPaid({required Object code}) => 'Paguei o código ${code}';
	@override String get cancel => 'Cancelar reserva';
	@override late final _Translations$twint$flow$takerExpired$markPaidDialog$pt markPaidDialog = _Translations$twint$flow$takerExpired$markPaidDialog$pt._(_root);
	@override late final _Translations$twint$flow$takerExpired$cancelDialog$pt cancelDialog = _Translations$twint$flow$takerExpired$cancelDialog$pt._(_root);
}

// Path: twint.waitConfirmation.categoryReminder
class _Translations$twint$waitConfirmation$categoryReminder$pt extends Translations$twint$waitConfirmation$categoryReminder$en {
	_Translations$twint$waitConfirmation$categoryReminder$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get atm => 'Lembrete da oferta de multibanco: o seu banco pode ainda pedir-lhe para aprovar uma taxa extra de multibanco para além do montante principal.';
	@override String get ecommerce => 'Lembrete da encomenda online: se o comerciante enviar um reembolso automático para a sua conta bancária, contacte o coordenador e devolva-o.';
}

// Path: twint.waitConfirmation.takerCharged
class _Translations$twint$waitConfirmation$takerCharged$pt extends Translations$twint$waitConfirmation$takerCharged$en {
	_Translations$twint$waitConfirmation$takerCharged$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String title({required Object code}) => 'Marcou o ${code} como cobrado';
	@override String message({required Object minutes}) => 'O maker tem ${minutes}min para confirmar o pagamento ou abrir disputa. Se nada fizer, o pagamento será confirmado automaticamente e receberá o bitcoin.';
}

// Path: twint.waitConfirmation.expiredActions
class _Translations$twint$waitConfirmation$expiredActions$pt extends Translations$twint$waitConfirmation$expiredActions$en {
	_Translations$twint$waitConfirmation$expiredActions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String reportConflict({required Object code}) => 'O ${code} foi cobrado da minha conta bancária';
	@override String renewReservation({required Object code}) => 'Tentar novamente com novo código ${code}';
	@override String get cancelReservation => 'Cancelar reserva';
}

// Path: twint.waitConfirmation.feedback
class _Translations$twint$waitConfirmation$feedback$pt extends Translations$twint$waitConfirmation$feedback$en {
	_Translations$twint$waitConfirmation$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get makerConfirmed => 'O maker confirmou o pagamento.';
	@override String get paymentSuccessful => 'Pagamento bem-sucedido! Vai receber os fundos em breve.';
	@override String get conflictReported => 'Conflito reportado. O coordenador vai analisar a situação.';
}

// Path: twint.waitConfirmation.errors
class _Translations$twint$waitConfirmation$errors$pt extends Translations$twint$waitConfirmation$errors$en {
	_Translations$twint$waitConfirmation$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get invalidOfferStateReceived => 'Recebida uma oferta com um estado inválido para este ecrã. A reiniciar.';
	@override String reportingConflict({required Object details}) => 'Erro ao reportar o conflito: ${details}';
}

// Path: twint.paymentProcess.states
class _Translations$twint$paymentProcess$states$pt extends Translations$twint$paymentProcess$states$en {
	_Translations$twint$paymentProcess$states$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get preparing => 'A preparar o envio do pagamento...';
	@override String get sending => 'A enviar o pagamento...';
	@override String get received => 'Pagamento recebido!';
	@override String get failed => 'Pagamento falhou';
	@override String get waitingUpdate => 'À espera da atualização da oferta...';
}

// Path: twint.paymentProcess.steps
class _Translations$twint$paymentProcess$steps$pt extends Translations$twint$paymentProcess$steps$en {
	_Translations$twint$paymentProcess$steps$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String makerConfirmedBlik({required Object code}) => 'O maker confirmou o pagamento ${code}';
	@override String get makerInvoiceSettled => 'Hold invoice do maker liquidada';
	@override String get takerInvoicePaid => 'A pagar a sua invoice Lightning';
	@override String get takerPaymentFailed => 'O pagamento à sua invoice falhou';
}

// Path: twint.paymentProcess.errors
class _Translations$twint$paymentProcess$errors$pt extends Translations$twint$paymentProcess$errors$en {
	_Translations$twint$paymentProcess$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String sending({required Object details}) => 'Erro ao enviar o pagamento: ${details}';
	@override String get notConfirmed => 'Oferta não confirmada pelo maker.';
	@override String get expired => 'Oferta expirada.';
	@override String get cancelled => 'Oferta cancelada.';
	@override String get paymentFailed => 'Pagamento da oferta falhou.';
	@override String get unknown => 'Erro desconhecido na oferta.';
	@override String get takerPaymentFailed => 'O pagamento à sua invoice Lightning falhou.';
	@override String get noPublicKey => 'Erro: não é possível obter a sua chave pública.';
	@override String get loadingPublicKey => 'Erro ao carregar os seus dados';
	@override String get missingPaymentHash => 'Erro: detalhes do pagamento em falta.';
}

// Path: twint.paymentProcess.loading
class _Translations$twint$paymentProcess$loading$pt extends Translations$twint$paymentProcess$loading$en {
	_Translations$twint$paymentProcess$loading$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get publicKey => 'A carregar os seus dados...';
}

// Path: twint.paymentProcess.actions
class _Translations$twint$paymentProcess$actions$pt extends Translations$twint$paymentProcess$actions$en {
	_Translations$twint$paymentProcess$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get goToFailureDetails => 'Tentar de novo com nova invoice';
}

// Path: twint.paymentFailed.form
class _Translations$twint$paymentFailed$form$pt extends Translations$twint$paymentFailed$form$en {
	_Translations$twint$paymentFailed$form$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get newInvoiceLabel => 'Nova invoice Lightning';
	@override String get newInvoiceHint => 'Introduza a sua invoice BOLT11';
}

// Path: twint.paymentFailed.actions
class _Translations$twint$paymentFailed$actions$pt extends Translations$twint$paymentFailed$actions$en {
	_Translations$twint$paymentFailed$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get retryPayment => 'Submeter nova invoice';
}

// Path: twint.paymentFailed.errors
class _Translations$twint$paymentFailed$errors$pt extends Translations$twint$paymentFailed$errors$en {
	_Translations$twint$paymentFailed$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get enterValidInvoice => 'Introduza uma invoice válida';
	@override String updatingInvoice({required Object details}) => 'Erro ao atualizar a invoice: ${details}';
	@override String get paymentRetryFailed => 'A nova tentativa de pagamento falhou. Verifique a invoice ou tente mais tarde.';
	@override String get takerPublicKeyNotFound => 'Chave pública do taker não encontrada.';
	@override String generateFailed({required Object details}) => 'Falha ao gerar a invoice: ${details}';
}

// Path: twint.paymentFailed.walletSection
class _Translations$twint$paymentFailed$walletSection$pt extends Translations$twint$paymentFailed$walletSection$en {
	_Translations$twint$paymentFailed$walletSection$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gerar invoice a partir da carteira';
	@override String get defaultLabel => 'predefinida';
	@override String tapToGenerate({required Object amountSats}) => 'Toque para gerar a invoice para ${amountSats}';
}

// Path: twint.paymentFailed.loading
class _Translations$twint$paymentFailed$loading$pt extends Translations$twint$paymentFailed$loading$en {
	_Translations$twint$paymentFailed$loading$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get processingPayment => 'A processar a nova tentativa de pagamento...';
}

// Path: twint.paymentFailed.success
class _Translations$twint$paymentFailed$success$pt extends Translations$twint$paymentFailed$success$en {
	_Translations$twint$paymentFailed$success$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pagamento bem-sucedido';
	@override String get message => 'O seu pagamento foi processado com sucesso.';
}

// Path: twint.paymentSuccess.actions
class _Translations$twint$paymentSuccess$actions$pt extends Translations$twint$paymentSuccess$actions$en {
	_Translations$twint$paymentSuccess$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get goHome => 'Ir para o início';
}

// Path: twint.invalidBlik.actions
class _Translations$twint$invalidBlik$actions$pt extends Translations$twint$invalidBlik$actions$en {
	_Translations$twint$invalidBlik$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String retry({required Object code}) => 'Enviar novo código ${code}';
	@override String get cancelReservation => 'Cancelar transação';
	@override String get reportConflict => 'Iniciar disputa';
	@override String get returnHome => 'Voltar ao início';
}

// Path: twint.invalidBlik.confirmDialog
class _Translations$twint$invalidBlik$confirmDialog$pt extends Translations$twint$invalidBlik$confirmDialog$en {
	_Translations$twint$invalidBlik$confirmDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tem a certeza?';
	@override String get content => 'Depois de clicar isto, não há como voltar atrás.\n\nSe o valor FOI de facto cobrado da sua conta bancária, o coordenador NÃO poderá garantir que você receba o bitcoin e poderá perder os seus fundos.\n\nSe não tem a certeza, é melhor esperar um pouco e confirmar que NÃO foi cobrado antes de continuar.';
	@override late final _Translations$twint$invalidBlik$confirmDialog$actions$pt actions = _Translations$twint$invalidBlik$confirmDialog$actions$pt._(_root);
}

// Path: twint.invalidBlik.disputeConfirmDialog
class _Translations$twint$invalidBlik$disputeConfirmDialog$pt extends Translations$twint$invalidBlik$disputeConfirmDialog$en {
	_Translations$twint$invalidBlik$disputeConfirmDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abrir uma disputa?';
	@override String get content => 'Só abra uma disputa se o valor FOI cobrado da sua conta bancária.\n\nO coordenador irá analisar manualmente o seu caso, o que leva tempo. Você terá de fornecer um comprovativo de pagamento.';
	@override late final _Translations$twint$invalidBlik$disputeConfirmDialog$actions$pt actions = _Translations$twint$invalidBlik$disputeConfirmDialog$actions$pt._(_root);
}

// Path: twint.invalidBlik.feedback
class _Translations$twint$invalidBlik$feedback$pt extends Translations$twint$invalidBlik$feedback$en {
	_Translations$twint$invalidBlik$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get conflictReportedSuccess => 'Conflito reportado. O coordenador vai analisar.';
}

// Path: twint.invalidBlik.errors
class _Translations$twint$invalidBlik$errors$pt extends Translations$twint$invalidBlik$errors$en {
	_Translations$twint$invalidBlik$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get reservationFailed => 'Falha ao reservar a oferta novamente';
	@override String conflictReport({required Object details}) => 'Erro ao reportar o conflito: ${details}';
}

// Path: twint.conflict.actions
class _Translations$twint$conflict$actions$pt extends Translations$twint$conflict$actions$en {
	_Translations$twint$conflict$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get back => 'Voltar ao início';
}

// Path: twint.conflict.feedback
class _Translations$twint$conflict$feedback$pt extends Translations$twint$conflict$feedback$en {
	_Translations$twint$conflict$feedback$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get reported => 'Conflito reportado. O coordenador vai analisar.';
}

// Path: twint.conflict.errors
class _Translations$twint$conflict$errors$pt extends Translations$twint$conflict$errors$en {
	_Translations$twint$conflict$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String reporting({required Object details}) => 'Erro ao reportar o conflito: ${details}';
}

// Path: twint.conflict.nostrContact
class _Translations$twint$conflict$nostrContact$pt extends Translations$twint$conflict$nostrContact$en {
	_Translations$twint$conflict$nostrContact$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contactar o coordenador no Nostr';
	@override String get description => 'Pode enviar uma DM diretamente ao coordenador para obter ajuda com esta disputa.';
	@override String get copyNpub => 'Copiar npub';
	@override String get openProfile => 'Ver perfil';
	@override String get npubCopied => 'npub do coordenador copiado para a área de transferência!';
	@override String get yourIdentityDescription => 'Para enviar DMs, inicie sessão com a sua chave privada Neko (nsec) em qualquer cliente Nostr que suporte mensagens diretas.';
	@override String get manageNekoKeys => 'Gerir chaves Neko';
}

// Path: home.statistics.errors
class _Translations$home$statistics$errors$pt extends Translations$home$statistics$errors$en {
	_Translations$home$statistics$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String loading({required Object error}) => 'Erro ao carregar estatísticas: ${error}';
}

// Path: settings.offerCreation.categoryOptions
class _Translations$settings$offerCreation$categoryOptions$pt extends Translations$settings$offerCreation$categoryOptions$en {
	_Translations$settings$offerCreation$categoryOptions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Loja, café ou restaurante';
	@override String get atm => 'Levantamento em multibanco';
	@override String get online => 'Serviço/produto online';
}

// Path: settings.offerCreation.dialogs
class _Translations$settings$offerCreation$dialogs$pt extends Translations$settings$offerCreation$dialogs$en {
	_Translations$settings$offerCreation$dialogs$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get selectCategory => 'Selecionar categoria predefinida';
	@override String get selectBank => 'Selecionar banco predefinido';
	@override String get selectCoordinator => 'Selecionar coordenador preferido';
	@override String get premiumHint => 'Introduza uma percentagem como 1,5. Os valores são arredondados a passos de 0,5%.';
	@override String get premiumHelper => 'Aplicado quando os preços premium estão ativados e limitado pelo máximo do coordenador selecionado.';
}

// Path: settings.display.unitOptions
class _Translations$settings$display$unitOptions$pt extends Translations$settings$display$unitOptions$en {
	_Translations$settings$display$unitOptions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get sats => 'sats';
	@override String get bitcoin => '₿ (BIP-177)';
}

// Path: settings.paymentSystem.countries
class _Translations$settings$paymentSystem$countries$pt extends Translations$settings$paymentSystem$countries$en {
	_Translations$settings$paymentSystem$countries$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get PL => 'Polónia';
	@override String get PT => 'Portugal';
	@override String get CH => 'Suíça';
	@override String get SK => 'Eslováquia';
}

// Path: maker.amountForm.category.options
class _Translations$maker$amountForm$category$options$pt extends Translations$maker$amountForm$category$options$en {
	_Translations$maker$amountForm$category$options$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get physicalShop => 'Loja, café ou restaurante';
	@override String get atmCashout => 'Levantamento em multibanco';
	@override String get onlineService => 'Serviço/produto online';
}

// Path: maker.amountForm.category.shortLabels
class _Translations$maker$amountForm$category$shortLabels$pt extends Translations$maker$amountForm$category$shortLabels$en {
	_Translations$maker$amountForm$category$shortLabels$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get shop => 'Loja';
	@override String get atm => 'Multibanco';
	@override String get online => 'Online';
}

// Path: maker.conflict.disputeDialog.actions
class _Translations$maker$conflict$disputeDialog$actions$pt extends Translations$maker$conflict$disputeDialog$actions$en {
	_Translations$maker$conflict$disputeDialog$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get confirm => 'Abrir disputa';
	@override String get cancel => 'Cancelar';
}

// Path: twint.flow.makerWait.confirmDialog
class _Translations$twint$flow$makerWait$confirmDialog$pt extends Translations$twint$flow$makerWait$confirmDialog$en {
	_Translations$twint$flow$makerWait$confirmDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmar pagamento recebido?';
	@override String content({required Object code}) => 'Confirme apenas se tiver a certeza ABSOLUTA de que o pagamento ${code} foi recebido com sucesso no seu comerciante.\n\nA confirmação liquida a hold invoice Lightning e envia imediatamente os sats ao taker — não pode ser desfeito.';
	@override String get cancel => 'Cancelar';
	@override String get confirmButton => 'Sim, pagamento recebido';
}

// Path: twint.flow.takerExpired.markPaidDialog
class _Translations$twint$flow$takerExpired$markPaidDialog$pt extends Translations$twint$flow$takerExpired$markPaidDialog$en {
	_Translations$twint$flow$takerExpired$markPaidDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirma que pagou?';
	@override String content({required Object code}) => 'Continue apenas se tiver a certeza de que o pagamento ${code} foi debitado na app do seu banco.\n\nO maker será convidado a confirmar a receção para desbloquear o bitcoin. Se negar, é aberta uma disputa e ambas as partes terão de fornecer provas ao coordenador.';
	@override String get cancel => 'Voltar';
	@override String get confirmButton => 'Sim, paguei';
}

// Path: twint.flow.takerExpired.cancelDialog
class _Translations$twint$flow$takerExpired$cancelDialog$pt extends Translations$twint$flow$takerExpired$cancelDialog$en {
	_Translations$twint$flow$takerExpired$cancelDialog$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cancelar a reserva?';
	@override String content({required Object code}) => 'Cancele apenas se NÃO pagou o código ${code}.\n\nNão pode ser desfeito: se o pagamento tiver de facto passado, o coordenador NÃO poderá garantir que recebe os sats.';
	@override String get cancel => 'Voltar';
	@override String get confirmButton => 'Sim, cancelar';
}

// Path: twint.invalidBlik.confirmDialog.actions
class _Translations$twint$invalidBlik$confirmDialog$actions$pt extends Translations$twint$invalidBlik$confirmDialog$actions$en {
	_Translations$twint$invalidBlik$confirmDialog$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Tenho a certeza, continuar';
	@override String get cancel => 'Cancelar';
}

// Path: twint.invalidBlik.disputeConfirmDialog.actions
class _Translations$twint$invalidBlik$disputeConfirmDialog$actions$pt extends Translations$twint$invalidBlik$disputeConfirmDialog$actions$en {
	_Translations$twint$invalidBlik$disputeConfirmDialog$actions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'Sim, fui cobrado';
	@override String get cancel => 'Cancelar';
}

/// The flat map containing all translations for locale <pt>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => ({required Object app}) => '${app}',
			'app.greeting' => 'Olá!',
			'app.changelog' => 'Registo de alterações',
			'common.code' => 'código',
			'common.buttons.cancel' => 'Cancelar',
			'common.buttons.save' => 'Guardar',
			'common.buttons.done' => 'Concluído',
			'common.buttons.retry' => 'Tentar novamente',
			'common.buttons.goHome' => 'Ir para o início',
			'common.buttons.saveAndContinue' => 'Guardar e continuar',
			'common.buttons.reveal' => 'Mostrar',
			'common.buttons.hide' => 'Ocultar',
			'common.buttons.copy' => 'Copiar',
			'common.buttons.close' => 'Fechar',
			'common.buttons.restore' => 'Restaurar',
			'common.buttons.faq' => 'FAQ',
			'common.labels.amount' => ({required Object currency}) => 'Montante (${currency})',
			'common.labels.status' => ({required Object status}) => 'Estado: ${status}',
			'common.labels.role' => ({required Object role}) => 'Função: ${role}',
			'common.notifications.success' => 'Sucesso',
			'common.notifications.error' => 'Erro',
			'common.notifications.loading' => 'A carregar...',
			'common.clipboard.copyToClipboard' => 'Copiar para a área de transferência',
			'common.clipboard.pasteFromClipboard' => 'Colar da área de transferência',
			'common.clipboard.copied' => 'Copiado para a área de transferência!',
			'common.actions.cancelAndReturnToOffers' => 'Cancelar e voltar às ofertas',
			'common.actions.cancelAndReturnHome' => 'Cancelar e voltar ao início',
			'lightningAddress.labels.address' => 'Lightning Address (LNURL)',
			'lightningAddress.labels.hint' => 'utilizador@dominio.com',
			'lightningAddress.labels.short' => ({required Object address}) => 'Lightning Address: ${address}',
			'lightningAddress.labels.receivingAddress' => 'O seu endereço de receção:',
			'lightningAddress.prompts.enter' => 'Introduza o seu Lightning Address para continuar',
			'lightningAddress.prompts.edit' => 'Editar',
			'lightningAddress.prompts.invalid' => 'Introduza um Lightning Address válido',
			'lightningAddress.prompts.required' => 'O Lightning Address é obrigatório.',
			'lightningAddress.prompts.enterToTakeOffer' => 'Tem de definir um Lightning Address para aceitar uma oferta.',
			'lightningAddress.prompts.missing' => 'O Lightning Address está em falta. Adicione um para poder aceitar ofertas.',
			'lightningAddress.prompts.add' => 'Adicionar',
			'lightningAddress.prompts.delete' => 'Eliminar',
			'lightningAddress.prompts.confirmDelete' => 'Tem a certeza de que quer eliminar o seu Lightning Address?',
			'lightningAddress.prompts.howToGet' => 'Ainda não tem um Lightning Address? Saiba como obter um!',
			'lightningAddress.prompts.learnMore' => 'Saiba mais sobre o Lightning Address',
			'lightningAddress.feedback.saved' => 'Lightning Address guardado!',
			'lightningAddress.feedback.updated' => 'Lightning Address atualizado!',
			'lightningAddress.feedback.valid' => 'Lightning Address válido',
			'lightningAddress.errors.saving' => ({required Object details}) => 'Erro ao guardar o endereço: ${details}',
			'lightningAddress.errors.loading' => ({required Object details}) => 'Erro ao carregar o Lightning Address: ${details}',
			'nfc.actions.scan' => 'Ler NFC',
			'nfc.actions.addWallet' => 'Adicionar carteira',
			'nfc.prompts.addTitle' => 'Adicionar carteira Lightning?',
			'nfc.prompts.addMessage' => ({required Object address}) => 'Foi encontrado este Lightning Address numa tag NFC: ${address}\n\nPretende adicioná-lo como carteira LNURL?',
			'nfc.feedback.readyToScan' => 'Aproxime o telemóvel da tag NFC',
			'nfc.feedback.alreadyScanning' => 'A leitura NFC já está em curso',
			'nfc.feedback.alreadyAdded' => 'Este Lightning Address já está configurado',
			'nfc.feedback.walletAdded' => 'Carteira Lightning adicionada a partir da tag NFC',
			'nfc.errors.disabled' => 'O NFC está desligado neste dispositivo',
			'nfc.errors.unsupported' => 'O NFC não está disponível neste dispositivo',
			'nfc.errors.reading' => ({required Object details}) => 'Falha na leitura NFC: ${details}',
			'offers.details.yourOffer' => 'A sua oferta:',
			'offers.details.selectedOffer' => 'Oferta:',
			'offers.details.activeOffer' => 'Tem uma oferta ativa:',
			'offers.details.finishedOffers' => 'Ofertas concluídas',
			'offers.details.noAvailable' => 'Não há ofertas disponíveis.',
			'offers.details.noAvailableTip' => ({required Object app}) => 'Dica: partilhe o ${app} na sua comunidade e entre amigos para aumentar as ordens no ${app}.',
			'offers.details.noSuccessfulTrades' => 'Não há transações bem-sucedidas.',
			'offers.details.loadingDetails' => 'A carregar detalhes da oferta...',
			'offers.details.amount' => ({required Object amount}) => 'Montante: ${amount} satoshi',
			'offers.details.amountWithCurrency' => ({required Object amount, required Object currency}) => '${amount} ${currency}',
			'offers.details.makerFee' => ({required Object fee}) => 'Taxa: ${fee} sats',
			'offers.details.takerFee' => ({required Object fee}) => 'Taxa: ${fee} sats',
			'offers.details.subtitle' => ({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (taxa) satoshi\nEstado: ${status}',
			'offers.details.subtitleWithDate' => ({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (taxa) satoshi\nEstado: ${status}\nPago: ${date}',
			'offers.details.activeSubtitle' => ({required Object status, required Object amount}) => 'Estado: ${status}\nMontante: ${amount} satoshi',
			'offers.details.id' => ({required Object id}) => 'ID da oferta: ${id}...',
			'offers.details.created' => ({required Object dateTime}) => 'Criada: ${dateTime}',
			'offers.details.takenAfter' => ({required Object duration}) => 'Aceite após: ${duration}',
			'offers.details.paidAfter' => ({required Object duration}) => 'Pago após: ${duration}',
			'offers.details.exchangeRate' => 'Taxa de câmbio',
			'offers.details.amountLabel' => 'Montante',
			'offers.details.makerFeeLabel' => 'Taxa do maker',
			'offers.details.takerFeeLabel' => 'Taxa do taker',
			'offers.details.feeLabel' => 'Taxa',
			'offers.details.statusLabel' => 'Estado',
			'offers.details.youllReceive' => 'Vai receber',
			'offers.details.coordinator' => 'Coordenador',
			'offers.details.categoryLabel' => 'Categoria',
			'offers.details.categories.physicalShop' => 'Loja, café ou restaurante',
			'offers.details.categories.atmCashout' => 'Levantamento em multibanco',
			'offers.details.categories.onlineService' => 'Serviço/produto online',
			'offers.details.consents.atm' => 'Alguns multibancos cobram uma taxa extra para além do montante da oferta. Ao aceitar esta oferta, aceita quaisquer encargos bancários adicionais exigidos pelo multibanco.',
			'offers.details.consents.ecommerce' => ({required Object code}) => 'Por vários motivos — como um artigo esgotado, uma correção de pagamento em excesso, ou outros problemas do lado do comerciante — o comerciante online pode enviar automaticamente dinheiro de volta para a conta bancária associada ao ${code} que gerou. Esses fundos chegam à sua conta e não lhe pertencem. Se isto acontecer, contacte o coordenador de boa-fé e combine devolver os fundos ao maker. Ao aceitar esta oferta, aceita estes termos e compromete-se honradamente a agir com honestidade nestas situações.',
			'offers.labels.premium' => 'Premium',
			'offers.labels.premiumBadge' => ({required Object percent}) => '+${percent}% premium',
			'offers.tooltips.takerFeeInfo' => ({required Object feePercent}) => 'O coordenador cobra uma taxa de taker de ${feePercent}%. Inclui as taxas de encaminhamento da Lightning e é deduzida do montante que recebe.',
			'offers.tooltips.premiumInfoTaker' => 'Um premium significa que esta oferta está acima do preço de mercado. Para o mesmo montante em fiat, o maker bloqueia menos sats na hold invoice, por isso paga acima do mercado e recebe menos sats do que à taxa de mercado. O premium máximo é definido pelo coordenador.',
			'offers.tooltips.ratesFetchedAt' => 'Obtido em',
			'offers.tooltips.ratesSources' => 'Fontes da taxa média',
			'offers.actions.take' => 'ACEITAR',
			'offers.actions.takeOffer' => 'Aceitar oferta',
			'offers.actions.resume' => ({required Object code}) => 'INTRODUZIR ${code}',
			'offers.actions.cancel' => 'Cancelar oferta',
			'offers.actions.view' => 'Ver detalhes',
			'offers.status.created' => 'Criada',
			'offers.status.funded' => 'Financiada',
			'offers.status.expired' => 'Expirada',
			'offers.status.cancelled' => 'Cancelada',
			'offers.status.reserved' => 'Reservada',
			'offers.status.blikReceived' => ({required Object code}) => '${code} enviado',
			'offers.status.blikSentToMaker' => ({required Object code}) => '${code} recebido',
			'offers.status.expiredBlik' => ({required Object code}) => '${code} expirado',
			'offers.status.expiredSentBlik' => ({required Object code}) => '${code} expirado',
			'offers.status.takerCharged' => 'Taker cobrado',
			'offers.status.invalidBlik' => ({required Object code}) => '${code} inválido',
			'offers.status.conflict' => 'Conflito',
			'offers.status.dispute' => 'Disputa',
			'offers.status.makerConfirmed' => 'Confirmada',
			'offers.status.settled' => 'Liquidada',
			'offers.status.payingTaker' => 'A pagar ao taker',
			'offers.status.takerPaymentFailed' => 'Pagamento ao taker falhou',
			'offers.status.takerPaid' => 'Taker pago',
			'offers.status.unknownStatus' => 'Desconhecido',
			'offers.statusMessages.reserved' => 'Oferta reservada pelo taker!',
			'offers.statusMessages.cancelled' => 'Oferta cancelada com sucesso.',
			'offers.statusMessages.cancelledOrExpired' => 'A oferta foi cancelada ou expirou.',
			'offers.statusMessages.noLongerAvailable' => ({required Object status}) => 'A oferta já não está disponível (Estado: ${status}).',
			'offers.progress.waitingForTaker' => ({required Object time}) => 'À espera do taker: ${time}',
			'offers.progress.reserved' => ({required Object seconds}) => 'Reservada: faltam ${seconds} s',
			'offers.progress.confirming' => ({required Object seconds}) => 'A confirmar: faltam ${seconds} s',
			'offers.errors.loading' => ({required Object details}) => 'Erro ao carregar ofertas: ${details}',
			'offers.errors.loadingDetails' => ({required Object details}) => 'Erro ao carregar detalhes da oferta: ${details}',
			'offers.errors.detailsMissing' => 'Erro: detalhes da oferta em falta ou inválidos.',
			'offers.errors.detailsNotLoaded' => 'Não foi possível carregar os detalhes da oferta.',
			'offers.errors.notFound' => 'Erro: oferta não encontrada.',
			'offers.errors.unexpectedState' => 'Erro: a oferta está num estado inesperado.',
			'offers.errors.unexpectedStateWithStatus' => ({required Object status}) => 'A oferta está num estado inesperado (${status}). Tente novamente ou contacte o suporte.',
			'offers.errors.invalidStatus' => 'A oferta tem um estado inválido.',
			'offers.errors.couldNotIdentify' => 'Erro: não foi possível identificar a oferta a cancelar.',
			'offers.errors.cannotBeCancelled' => ({required Object status}) => 'A oferta não pode ser cancelada no estado atual (${status}).',
			'offers.errors.failedToCancel' => ({required Object details}) => 'Falha ao cancelar a oferta: ${details}',
			'offers.errors.activeDetailsLost' => 'Erro: detalhes da oferta ativa perdidos.',
			'offers.errors.checkingActive' => ({required Object details}) => 'Erro ao verificar ofertas ativas: ${details}',
			'offers.errors.cannotResume' => ({required Object status}) => 'Não é possível retomar a oferta no estado: ${status}',
			'offers.errors.cannotResumeTaker' => ({required Object status}) => 'Não é possível retomar a oferta do taker no estado: ${status}',
			'offers.errors.resuming' => ({required Object details}) => 'Erro ao retomar a oferta: ${details}',
			'offers.errors.makerPublicKeyNotFound' => 'Chave pública do maker não encontrada',
			'offers.errors.takerPublicKeyNotFound' => 'Chave pública do taker não encontrada.',
			'offers.errors.atmConsentRequired' => 'Aceite a condição da taxa extra do multibanco antes de aceitar esta oferta.',
			'offers.errors.ecommerceConsentRequired' => 'Aceite a condição de devolução de reembolso de e-commerce antes de aceitar esta oferta.',
			'offers.errors.cannotTakeOwnOffer' => 'Não pode aceitar a sua própria oferta.',
			'offers.success.title' => 'Oferta concluída',
			'offers.success.headline' => 'Pagamento confirmado!',
			'offers.success.subtitle' => 'O taker vai ser pago agora.',
			'offers.success.detailsTitle' => 'Detalhes da oferta:',
			'offers.success.duration' => ({required Object time}) => 'A oferta demorou ${time} a concluir.',
			'reservations.actions.cancel' => 'Cancelar reserva',
			'reservations.feedback.cancelled' => 'Reserva cancelada.',
			'reservations.errors.cancelling' => ({required Object error}) => 'Falha ao cancelar a reserva: ${error}',
			'reservations.errors.failedToReserve' => ({required Object details}) => 'Falha ao reservar a oferta: ${details}',
			'reservations.errors.failedNoTimestamp' => 'Falha ao reservar a oferta (sem timestamp).',
			'reservations.errors.timestampMissing' => 'Timestamp da reserva da oferta em falta.',
			'reservations.errors.notReserved' => ({required Object status}) => 'A oferta já não está reservada (${status}).',
			'exchange.labels.enterAmount' => ({required Object currency}) => 'Introduza o montante (${currency}) a pagar:',
			'exchange.labels.equivalent' => ({required Object sats}) => '≈ ${sats} satoshi',
			'exchange.labels.rate' => ({required Object rate, required Object currency}) => 'Taxa de câmbio ≈ ${rate} ${currency}/BTC',
			'exchange.feedback.fetching' => 'A obter a taxa de câmbio...',
			'exchange.errors.fetchingRate' => 'Falha ao obter a taxa de câmbio.',
			'exchange.errors.invalidFormat' => 'Formato de número inválido',
			'exchange.errors.mustBePositive' => 'O montante tem de ser positivo',
			'exchange.errors.invalidFeePercentage' => 'Percentagem de taxa inválida',
			'exchange.errors.tooLowFiat' => ({required Object minAmount, required Object currency}) => 'O montante é demasiado baixo. O mínimo é ${minAmount} ${currency}.',
			'exchange.errors.tooHighFiat' => ({required Object maxAmount, required Object currency}) => 'O montante é demasiado alto. O máximo é ${maxAmount} ${currency}.',
			'exchange.errors.atmNotDispensable' => ({required Object notes}) => 'O multibanco não consegue dispensar este montante. Use uma combinação de notas: ${notes}.',
			'exchange.errors.atmOverBankLimit' => ({required Object bank, required Object limit, required Object currency}) => '${bank} entrega no máximo ${limit} ${currency} por levantamento.',
			'coordinator.title' => 'Coordenadores',
			'coordinator.info.fee' => 'taxa',
			'coordinator.info.rangeDisplay' => ({required Object minAmount, required Object maxAmount, required Object currency}) => 'Montante: ${minAmount}-${maxAmount} ${currency}',
			'coordinator.info.feeDisplay' => ({required Object fee}) => '${fee}% de taxa',
			'coordinator.selector.loading' => 'A carregar coordenadores...',
			'coordinator.selector.errorLoading' => 'Erro ao carregar coordenadores',
			'coordinator.selector.choose' => 'Escolher coordenador',
			'coordinator.selector.viewNostrProfile' => 'Ver perfil Nostr',
			'coordinator.selector.unresponsive' => 'Este coordenador não está a responder',
			'coordinator.selector.waitingResponse' => 'À espera da resposta do coordenador',
			'coordinator.selector.termsAccept' => 'Aceito os ',
			'coordinator.selector.termsOfUsage' => 'Termos de utilização do coordenador',
			'coordinator.dialog.makerFee' => 'Taxa do maker',
			'coordinator.dialog.takerFee' => 'Taxa do taker',
			'coordinator.dialog.amountRange' => 'Intervalo de montantes',
			'coordinator.dialog.reservationTime' => 'Tempo de reserva',
			'coordinator.dialog.currencies' => 'Moedas',
			'coordinator.dialog.viewTerms' => 'Ver termos',
			'coordinator.details.title' => 'Coordenador',
			'coordinator.details.relaysInUse' => 'Relays em uso',
			'coordinator.details.relaysInUseHint' => 'Toda a comunicação com este coordenador é encaminhada para estes relays (da sua lista NIP-65).',
			'coordinator.details.noRelays' => 'Ainda não há relays conhecidos',
			'coordinator.details.makerFee' => 'Taxa do maker',
			'coordinator.details.takerFee' => 'Taxa do taker',
			'coordinator.details.amountRange' => 'Intervalo de montantes',
			'coordinator.details.maxPremium' => 'Premium máximo',
			'coordinator.details.maxPremiumInfoTitle' => 'Premium',
			'coordinator.details.maxPremiumInfoBody' => 'Um premium é uma majoração de preço opcional acima da taxa de mercado que um maker pode definir numa oferta. Com um premium, o maker bloqueia menos sats para o mesmo montante em fiat, por isso o taker paga acima do mercado e o maker fica com a diferença. Este valor é o premium máximo que este coordenador permite nas suas ofertas.',
			'coordinator.details.reservationTime' => 'Tempo de reserva',
			'coordinator.details.currencies' => 'Moedas',
			'coordinator.details.paymentSystem' => 'Sistema de pagamento',
			'coordinator.details.version' => 'Versão',
			'coordinator.details.yourOffers' => 'As suas ofertas',
			'coordinator.details.successfulOffers' => 'Ofertas bem-sucedidas (30d)',
			'coordinator.details.statusOnline' => 'Online',
			'coordinator.details.statusOffline' => 'Offline',
			'coordinator.details.statusUnknown' => 'Desconhecido',
			'coordinator.details.openNostrProfile' => 'Abrir perfil Nostr',
			'coordinator.details.termsOfUsage' => 'Termos de utilização',
			'coordinator.coldStart.title' => 'A descobrir coordenadores',
			'coordinator.coldStart.body' => ({required Object app}) => 'O ${app} está a encontrar coordenadores públicos, a verificar quais estão acessíveis e a ativar um pequeno conjunto predefinido para si.',
			'coordinator.coldStart.settingsHint' => 'Pode alterar os coordenadores ativados mais tarde nas Definições.',
			'coordinator.coldStart.ok' => 'OK',
			'coordinator.coldStart.discovered' => 'Descobertos',
			'coordinator.coldStart.candidates' => 'Candidatos',
			'coordinator.coldStart.enabled' => 'Ativados',
			'coordinator.coldStart.recordsTitle' => 'Coordenadores atuais',
			'coordinator.coldStart.recordEnabled' => 'Ativado',
			'coordinator.coldStart.recordHealthyCandidate' => 'Candidato saudável',
			'coordinator.coldStart.recordOfflineCandidate' => 'Candidato offline',
			'coordinator.coldStart.recordChecking' => 'A verificar',
			'coordinator.coldStart.recordDiscovered' => 'Descoberto',
			'coordinator.coldStart.phases.loadingMuteList' => 'A carregar filtros de coordenadores',
			'coordinator.coldStart.phases.discovering' => 'A descobrir coordenadores no Nostr',
			'coordinator.coldStart.phases.loadingProfiles' => 'A carregar perfis dos coordenadores',
			'coordinator.coldStart.phases.loadingStats' => 'A ler o histórico dos coordenadores',
			'coordinator.coldStart.phases.checkingHealth' => 'A verificar a saúde dos coordenadores',
			'coordinator.coldStart.phases.finalizing' => 'A ativar coordenadores predefinidos',
			'coordinator.coldStart.phases.completed' => 'Concluído',
			'coordinator.management.title' => 'Gestão de coordenadores',
			'coordinator.management.availableCoordinators' => 'Coordenadores',
			'coordinator.management.noCoordinators' => 'Ainda não foram descobertos coordenadores.',
			'coordinator.management.online' => 'Online',
			'coordinator.management.unknownOffline' => 'Desconhecido/Offline',
			'coordinator.management.openNostrProfile' => 'Abrir perfil Nostr',
			'coordinator.management.enable' => 'Ativar',
			'coordinator.management.remove' => 'Remover',
			'coordinator.management.addCustomWhitelist' => 'Adicionar coordenador personalizado',
			'coordinator.management.addCustomWhitelistHint' => 'npub1...',
			'coordinator.management.add' => 'Adicionar',
			'coordinator.management.coordinatorDisabled' => 'Coordenador desativado',
			'coordinator.management.coordinatorEnabled' => 'Coordenador ativado',
			'coordinator.management.coordinatorAdded' => 'Coordenador adicionado à whitelist personalizada',
			'coordinator.management.coordinatorRemoved' => 'Coordenador removido da whitelist personalizada',
			'coordinator.management.coordinatorAddInfoUnavailable' => 'Não foi encontrada informação do coordenador nos relays. Coordenador não adicionado.',
			'coordinator.management.pleaseEnterNpub' => 'Introduza um npub',
			'coordinator.management.error' => 'Erro',
			'coordinator.management.metricYourOffers' => 'As suas ofertas',
			'coordinator.management.metricYourOffersTooltip' => 'Número de ofertas que concluiu com sucesso com este coordenador.',
			'coordinator.management.metricNetworkOffers' => 'Ofertas (30d)',
			'coordinator.management.metricNetworkOffersTooltip' => 'Ofertas bem-sucedidas liquidadas por este coordenador entre todos os utilizadores nos últimos 30 dias.',
			'maker.roleSelection.button' => 'PAGAR com Lightning',
			'maker.amountForm.progress.step1' => '1. Criar oferta',
			'maker.amountForm.progress.step2' => '2. Esperar pelo taker',
			'maker.amountForm.progress.step3' => ({required Object code}) => '3. Usar ${code}',
			'maker.amountForm.labels.coordinator' => 'Coordenador',
			'maker.amountForm.labels.category' => 'Categoria',
			'maker.amountForm.labels.exchangeRate' => 'Taxa de câmbio',
			'maker.amountForm.labels.fee' => 'Taxa',
			'maker.amountForm.labels.satoshisToPay' => 'Montante a pagar',
			'maker.amountForm.labels.enterAmount' => 'Introduzir montante',
			'maker.amountForm.labels.customAmount' => 'Personalizado',
			'maker.amountForm.labels.tapToSelect' => 'Toque para selecionar',
			'maker.amountForm.labels.premium' => 'Premium',
			'maker.amountForm.actions.generateInvoice' => 'Gerar invoice',
			'maker.amountForm.bank.label' => 'Banco',
			'maker.amountForm.bank.required' => 'Escolhe um banco',
			'maker.amountForm.bank.shortValidityWarning' => ({required Object minutes}) => 'O código deste banco é válido apenas ${minutes} min — está no multibanco antes de reservar.',
			'maker.amountForm.twintScan.cardTitle' => ({required Object code}) => 'Ler QR ${code} e montante',
			'maker.amountForm.twintScan.cardBody' => 'Aponte a câmara para o ecrã de pagamento. A app preencherá automaticamente o código e, quando visível, o montante.',
			'maker.amountForm.twintScan.scanButton' => 'Ler com a câmara',
			'maker.amountForm.twintScan.manualButton' => 'Introduzir manualmente',
			'maker.amountForm.twintScan.codeLabel' => ({required Object code}) => 'Código ${code}',
			'maker.amountForm.twintScan.rescan' => 'Ler novamente',
			'maker.amountForm.twintScan.helperFilled' => ({required Object code}) => 'O taker verá este código e introduzi-lo-á em ${code}.',
			'maker.amountForm.twintScan.helperEmpty' => ({required Object digits}) => 'Leia para preencher isto automaticamente ou introduza manualmente o código de ${digits} dígitos.',
			'maker.amountForm.tooltips.feeInfo' => ({required Object feePercent}) => 'O coordenador cobra uma taxa de maker de ${feePercent}%. Esta taxa é deduzida do seu pagamento Lightning.',
			'maker.amountForm.tooltips.payInfo' => 'Este cálculo baseia-se em taxas de câmbio obtidas no cliente. O coordenador calculará o montante exato, e o montante da invoice será o valor final e exato a pagar.',
			'maker.amountForm.tooltips.premiumInfo' => 'Um premium opcional permite vender os seus sats acima do preço de mercado. O premium reduz os sats bloqueados na sua hold invoice para o mesmo montante em fiat, por isso o taker paga acima do mercado e o maker fica com a diferença. Por predefinição está desligado (0%). O premium máximo é definido pelo coordenador selecionado.',
			'maker.amountForm.category.label' => 'Categoria da oferta',
			'maker.amountForm.category.unsupportedForSystem' => ({required Object system}) => 'O ${system} não suporta esta categoria.',
			'maker.amountForm.category.options.physicalShop' => 'Loja, café ou restaurante',
			'maker.amountForm.category.options.atmCashout' => 'Levantamento em multibanco',
			'maker.amountForm.category.options.onlineService' => 'Serviço/produto online',
			'maker.amountForm.category.shortLabels.shop' => 'Loja',
			'maker.amountForm.category.shortLabels.atm' => 'Multibanco',
			'maker.amountForm.category.shortLabels.online' => 'Online',
			'maker.amountForm.category.atmHint' => 'Os takers verão que esta oferta é para levantamento em multibanco e podem evitá-la se o banco deles cobrar taxas extra de multibanco.',
			'maker.amountForm.category.physicalShopHint' => ({required Object app, required Object code}) => 'O sítio ideal para usar o ${app} é um terminal de self-checkout — já que esperar que um taker reserve, gere e confirme um código ${code} pode demorar alguns minutos. Funciona muito bem em lojas, cafés e restaurantes. Se for corajoso o suficiente para fazer um caixa (e as pessoas na fila atrás de si) esperar esses minutos, parabéns.',
			'maker.amountForm.category.ecommerceWarningTitle' => 'Risco de reembolso do comerciante online',
			'maker.amountForm.category.ecommerceWarningBody' => ({required Object code}) => 'Por vários motivos — como um artigo esgotado, uma correção de pagamento em excesso, ou outros problemas do lado do comerciante — o comerciante online pode emitir automaticamente um reembolso para a conta bancária associada ao ${code}, que é a conta do taker. O coordenador não pode obrigar o taker a devolver-lhe esses fundos.',
			'maker.amountForm.category.ecommerceConfirmation' => 'Compreendo o risco de reembolso e vou adicionar uma nota à encomenda a instruir o comerciante a reembolsar uma conta diferente caso um reembolso se torne necessário.',
			'maker.amountForm.category.whyThisIsNeeded' => 'porque é que isto é necessário?',
			'maker.amountForm.onboarding.titlePrefix' => 'Novo',
			'maker.amountForm.onboarding.title' => 'Escolha a categoria da oferta',
			'maker.amountForm.onboarding.body' => 'Escolha a categoria que melhor corresponde àquilo que está a pagar antes de gerar a invoice.',
			'maker.amountForm.onboarding.showWhy' => 'Porque é que isto importa?',
			'maker.amountForm.onboarding.hideWhy' => 'Ocultar detalhes',
			'maker.amountForm.onboarding.whyTitle' => 'Escolher a categoria certa ajuda os takers a decidir em segurança',
			'maker.amountForm.onboarding.whyBody' => 'Situações diferentes têm expectativas e riscos diferentes. Os levantamentos em multibanco podem incluir taxas bancárias extra, e as compras online podem envolver casos limite de reembolso. Marcar a categoria certa dá aos takers o contexto de que precisam antes de aceitar a sua oferta.',
			'maker.amountForm.onboarding.cta' => 'Entendido',
			'maker.amountForm.errors.initiating' => ({required Object details}) => 'Erro ao iniciar a oferta: ${details}',
			'maker.amountForm.errors.publicKeyNotLoaded' => 'Erro: chave pública ainda não carregada.',
			'maker.amountForm.errors.noCoordinatorMatchesAmount' => 'Nenhum coordenador suporta este montante. Tente outro valor.',
			'maker.amountForm.errors.categoryRequired' => 'Selecione uma categoria de oferta.',
			'maker.amountForm.errors.ecommerceConfirmationRequired' => 'Confirme o risco de reembolso do comerciante online antes de continuar.',
			'maker.payInvoice.title' => 'Pague esta hold invoice:',
			'maker.payInvoice.actions.copy' => 'Copiar invoice',
			'maker.payInvoice.actions.payInWallet' => 'Abrir em carteira externa',
			'maker.payInvoice.actions.connectWallet' => 'Ligar carteira',
			'maker.payInvoice.actions.payWithNwc' => 'Pagar',
			'maker.payInvoice.actions.paying' => 'A pagar...',
			'maker.payInvoice.feedback.copied' => 'Invoice copiada para a área de transferência!',
			'maker.payInvoice.feedback.waitingConfirmation' => 'À espera da confirmação do pagamento...',
			'maker.payInvoice.feedback.nwcConnected' => 'Carteira NWC ligada!',
			'maker.payInvoice.feedback.nwcPaymentSuccess' => 'Pagamento efetuado com sucesso!',
			'maker.payInvoice.errors.couldNotOpenApp' => 'Não foi possível abrir a app Lightning para a invoice.',
			'maker.payInvoice.errors.openingApp' => ({required Object details}) => 'Erro ao abrir a app Lightning: ${details}',
			'maker.payInvoice.errors.publicKeyNotAvailable' => 'A chave pública não está disponível.',
			'maker.payInvoice.errors.couldNotFetchActive' => 'Não foi possível obter os detalhes da oferta ativa. Pode ter expirado.',
			'maker.payInvoice.errors.nwcPaymentFailed' => ({required Object details}) => 'Pagamento falhou: ${details}',
			'maker.payInvoice.errors.nwcNotConnected' => 'Carteira NWC não ligada',
			'maker.payInvoice.errors.insufficientBalance' => ({required Object required, required Object available}) => 'Saldo insuficiente. Precisa de ${required} sats, tem ${available} sats',
			'maker.payInvoice.errors.cancelOfferAlreadyFunded' => 'O coordenador indica que esta oferta já está financiada. Já não pode ser cancelada.',
			'maker.payInvoice.errors.cancelFailed' => ({required Object details}) => 'Não foi possível cancelar a oferta: ${details}',
			'maker.payInvoice.budgetWarning.title' => 'O pagamento pode falhar',
			'maker.payInvoice.budgetWarning.balanceTooLow' => ({required Object name}) => 'A sua carteira de gastos predefinida ${name} não tem saldo suficiente para este pagamento.',
			'maker.payInvoice.budgetWarning.budgetTooLow' => ({required Object name}) => 'A sua carteira de gastos predefinida ${name} não tem orçamento suficiente para este pagamento.',
			'maker.payInvoice.budgetWarning.balanceLine' => ({required Object available}) => 'Saldo: ${available}',
			'maker.payInvoice.budgetWarning.budgetLine' => ({required Object remaining}) => 'Orçamento NWC restante: ${remaining}',
			'maker.payInvoice.budgetWarning.requiredLine' => ({required Object required}) => 'Necessário: ${required}',
			'maker.payInvoice.budgetWarning.addFundsHint' => ({required Object name}) => 'Adicione fundos a ${name} para cobrir este montante.',
			'maker.payInvoice.budgetWarning.increaseBudgetHint' => 'Aumente o orçamento de gastos NWC para esta ligação na app da sua carteira.',
			'maker.payInvoice.budgetWarning.switchWalletLabel' => 'Ou use outra carteira:',
			'maker.payInvoice.budgetWarning.walletLowFundsTag' => 'Pode falhar',
			'maker.payInvoice.budgetWarning.payAnyway' => 'Tentar mesmo assim',
			'maker.payInvoice.budgetWarning.cancel' => 'Cancelar',
			'maker.payInvoice.budgetWarning.readyTitle' => 'Pagar invoice',
			'maker.waitTaker.message' => 'À espera que um taker reserve a sua oferta...',
			'maker.waitTaker.progressLabel' => ({required Object time}) => 'À espera do taker: ${time}',
			'maker.waitTaker.errorActiveOfferDetailsLost' => 'Erro: detalhes da oferta ativa perdidos.',
			'maker.waitTaker.errorFailedToRetrieveBlik' => ({required Object code}) => 'Erro: falha ao obter o código ${code}.',
			'maker.waitTaker.errorRetrievingBlik' => ({required Object code, required Object details}) => 'Erro ao obter o código ${code}: ${details}',
			'maker.waitTaker.offerNoLongerAvailable' => ({required Object status}) => 'A oferta já não está disponível (Estado: ${status}).',
			'maker.waitTaker.errorCouldNotIdentifyOffer' => 'Erro: não foi possível identificar a oferta a cancelar.',
			'maker.waitTaker.offerCannotBeCancelled' => ({required Object status}) => 'A oferta não pode ser cancelada no estado atual (${status}).',
			'maker.waitTaker.offerCancelledSuccessfully' => 'Oferta cancelada com sucesso.',
			'maker.waitTaker.failedToCancelOffer' => ({required Object details}) => 'Falha ao cancelar a oferta: ${details}',
			'maker.waitTaker.offerExpiredTitle' => 'Oferta expirada',
			'maker.waitTaker.offerExpiredMessage' => 'Nenhum taker reservou a sua oferta a tempo.',
			'maker.waitTaker.recreateOffer' => 'Nova oferta — mesmo montante',
			'maker.waitForBlik.title' => ({required Object code}) => 'À espera do ${code}',
			'maker.waitForBlik.messageInfo' => 'O taker reservou a oferta!',
			'maker.waitForBlik.messageWaiting' => ({required Object code}) => 'À espera de fornecer o código ${code}...',
			'maker.waitForBlik.progressLabel' => ({required Object seconds}) => 'Reservada: faltam ${seconds} s',
			'maker.confirmPayment.title' => ({required Object code}) => 'Código ${code} recebido!',
			'maker.confirmPayment.retrieving' => ({required Object code}) => 'A obter o código ${code}...',
			'maker.confirmPayment.instructions' => 'Introduza este código no terminal de pagamento. Quando o taker confirmar na app do banco e o pagamento for bem-sucedido, prima Confirmar abaixo.',
			'maker.confirmPayment.instruction1' => ({required Object code}) => 'Introduza o código no pedido de pagamento ${code}.',
			'maker.confirmPayment.instruction2' => 'Aguarde até o taker confirmar o pagamento na app dele.',
			'maker.confirmPayment.instruction3' => 'Quando o pagamento for bem-sucedido, prima Confirmar abaixo:',
			'maker.confirmPayment.mbwayAtmInstructions' => ({required Object amount, required Object minutes}) => 'Para levantar ${amount} €, dirija-se ao MULTIBANCO mais próximo, carregue na tecla verde e escolha a opção "Levantar Dinheiro". Introduza o código. Este código é válido por ${minutes} minutos.',
			'maker.confirmPayment.takerChargedWarning' => ({required Object code}) => 'O taker reportou que o pagamento ${code} foi cobrado da conta bancária dele. Se marcar isto como inválido, vai causar um conflito.',
			'maker.confirmPayment.autoConfirmInfo' => ({required Object code}) => 'A menos que marque o ${code} como inválido, o pagamento será confirmado automaticamente e o taker pago quando este temporizador terminar.',
			'maker.confirmPayment.autoConfirmCountdown' => ({required Object time}) => 'Confirmação automática em ${time}',
			'maker.confirmPayment.expiredTitle' => ({required Object code}) => 'Código ${code} expirado',
			'maker.confirmPayment.expiredWarning' => ({required Object code}) => 'O código ${code} expirou. Tem de confirmar manualmente o estado do pagamento:',
			'maker.confirmPayment.expiredInstruction1' => ({required Object code}) => 'Se o pagamento ${code} foi bem-sucedido e concluiu a sua compra, clique em "Confirmar pagamento bem-sucedido" abaixo.',
			'maker.confirmPayment.expiredInstruction2' => ({required Object code}) => 'Se o pagamento ${code} falhou ou não foi concluído, clique em "Código ${code} inválido" abaixo.',
			'maker.confirmPayment.actions.confirm' => 'Confirmar pagamento bem-sucedido',
			'maker.confirmPayment.actions.markInvalid' => ({required Object code}) => 'Código ${code} inválido',
			'maker.confirmPayment.actions.copyBlik' => ({required Object code}) => 'Copiar ${code}',
			'maker.confirmPayment.confirmDialog.title' => 'Confirmar pagamento?',
			'maker.confirmPayment.confirmDialog.content' => ({required Object code}) => 'Esta ação é irreversível. Após confirmar:\n\n• O taker receberá os fundos imediatamente\n• O coordenador não poderá disputar os fundos\n• Não pode anular esta ação\n\nConfirme apenas se o pagamento ${code} foi bem-sucedido.',
			'maker.confirmPayment.confirmDialog.cancel' => 'Cancelar',
			'maker.confirmPayment.confirmDialog.confirmButton' => 'Sim, confirmar pagamento',
			'maker.confirmPayment.invalidBlikDisputeDialog.title' => 'Abrir disputa?',
			'maker.confirmPayment.invalidBlikDisputeDialog.content' => ({required Object code}) => 'O taker reportou que o pagamento ${code} foi cobrado da conta dele.\n\nMarcar isto como inválido abrirá imediatamente uma DISPUTA que requer intervenção do coordenador.\n\n• Pode ser cobrada uma taxa de disputa se a decisão for contra si\n• A hold invoice será liquidada imediatamente\n• Será necessária verificação manual\n\nProssiga apenas se tiver a certeza de que o pagamento ${code} NÃO foi bem-sucedido.',
			'maker.confirmPayment.invalidBlikDisputeDialog.cancel' => 'Cancelar',
			'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton' => 'Sim, abrir disputa',
			'maker.confirmPayment.feedback.confirmed' => 'O maker confirmou o pagamento.',
			'maker.confirmPayment.feedback.confirmedTakerPaid' => 'Pagamento confirmado! O taker vai receber os fundos.',
			'maker.confirmPayment.feedback.progressLabel' => ({required Object seconds}) => 'A confirmar: faltam ${seconds} s',
			'maker.confirmPayment.errors.failedToRetrieve' => ({required Object code}) => 'Erro: falha ao obter o código ${code}.',
			'maker.confirmPayment.errors.retrieving' => ({required Object code, required Object details}) => 'Erro ao obter o código ${code}: ${details}',
			'maker.confirmPayment.errors.missingHashOrKey' => 'Erro: payment hash ou chave pública em falta.',
			'maker.confirmPayment.errors.incorrectState' => ({required Object status}) => 'A oferta não está no estado correto para confirmação (Estado: ${status})',
			'maker.confirmPayment.errors.confirming' => ({required Object details}) => 'Erro ao confirmar o pagamento: ${details}',
			'maker.confirmPayment.errors.invalidState' => 'Erro: estado da oferta inválido recebido.',
			'maker.confirmPayment.errors.internalIncomplete' => 'Erro interno: detalhes da oferta incompletos.',
			'maker.confirmPayment.errors.notAwaitingConfirmation' => ({required Object status}) => 'A oferta já não está à espera de confirmação (Estado: ${status}).',
			'maker.confirmPayment.errors.unexpectedStatus' => 'Estado de oferta inesperado recebido do servidor.',
			'maker.invalidBlik.title' => ({required Object code}) => 'Código ${code} inválido',
			'maker.invalidBlik.info' => ({required Object code}) => 'Marcou o código ${code} como inválido. À espera que o taker forneça um novo código ou inicie uma disputa.',
			'maker.conflict.title' => 'Conflito na oferta',
			'maker.conflict.headline' => 'Conflito na oferta reportado',
			'maker.conflict.body' => ({required Object code}) => 'Marcou o código ${code} como inválido, mas o taker reportou um conflito, indicando que acredita que o pagamento foi bem-sucedido.',
			'maker.conflict.instructions' => 'Aguarde que o coordenador analise a situação. Poderão pedir-lhe mais detalhes. Volte mais tarde ou contacte o suporte se necessário.',
			'maker.conflict.actions.back' => 'Voltar ao início',
			'maker.conflict.actions.confirmPayment' => ({required Object code}) => 'Foi engano meu, confirmar o sucesso do pagamento ${code}',
			'maker.conflict.actions.openDispute' => ({required Object code}) => 'O pagamento ${code} NÃO foi bem-sucedido, ABRIR DISPUTA',
			'maker.conflict.actions.submitDispute' => 'Submeter disputa',
			'maker.conflict.disputeDialog.title' => 'Abrir disputa?',
			'maker.conflict.disputeDialog.content' => 'Abrir uma disputa requer verificação manual pelo coordenador, o que demora tempo. Será deduzida uma taxa de disputa se a decisão for contra si. A hold invoice será liquidada para evitar que expire. Se a disputa for decidida a seu favor, receberá um reembolso (menos taxas) numa carteira à sua escolha.',
			'maker.conflict.disputeDialog.contentDetailed' => 'Abrir uma disputa requer intervenção manual do coordenador, o que demora tempo e implica uma taxa de disputa.\n\nA hold invoice será liquidada imediatamente para evitar que expire antes de a disputa ser resolvida.\n\nSe a disputa for decidida a seu favor, o montante em satoshi será reembolsado numa carteira à sua escolha (menos taxas). Certifique-se de que tem uma carteira pronta para receber.',
			'maker.conflict.disputeDialog.actions.confirm' => 'Abrir disputa',
			'maker.conflict.disputeDialog.actions.cancel' => 'Cancelar',
			'maker.conflict.feedback.disputeOpenedSuccess' => 'Disputa aberta com sucesso. O coordenador vai analisar.',
			'maker.conflict.errors.openingDispute' => ({required Object error}) => 'Erro ao abrir a disputa: ${error}',
			'maker.conflict.nostrContact.title' => 'Contactar o coordenador no Nostr',
			'maker.conflict.nostrContact.description' => 'Pode enviar uma DM diretamente ao coordenador para obter ajuda com esta disputa.',
			'maker.conflict.nostrContact.copyNpub' => 'Copiar npub',
			'maker.conflict.nostrContact.openProfile' => 'Ver perfil',
			'maker.conflict.nostrContact.npubCopied' => 'npub do coordenador copiado para a área de transferência!',
			'maker.conflict.nostrContact.yourIdentityDescription' => 'Para enviar DMs, inicie sessão com a sua chave privada Neko (nsec) em qualquer cliente Nostr que suporte mensagens diretas.',
			'maker.conflict.nostrContact.manageNekoKeys' => 'Gerir chaves Neko',
			'maker.success.title' => 'Oferta concluída',
			'maker.success.headline' => 'Pagamento confirmado!',
			'maker.success.subtitle' => 'O taker vai ser pago agora.',
			'maker.success.detailsTitle' => 'Detalhes da oferta:',
			'maker.success.duration' => ({required Object time}) => 'A oferta demorou ${time}!',
			'taker.roleSelection.button' => ({required Object code}) => 'VENDER código ${code} por satoshi',
			'taker.progress.step1' => ({required Object code}) => 'Submeter ${code}',
			'taker.progress.step2' => ({required Object code}) => 'Confirmar ${code}',
			'taker.progress.step3' => 'Receber pagamento',
			'taker.submitBlik.generateInBank' => ({required Object bank}) => 'Gera o código de levantamento na app ${bank}.',
			'taker.submitBlik.title' => ({required Object code, required Object digits}) => 'Introduza o ${code} de ${digits} dígitos',
			'taker.submitBlik.label' => ({required Object code}) => 'Código ${code}',
			'taker.submitBlik.instruction' => ({required Object code}) => 'Introduza o ${code} antes de o tempo terminar...',
			'taker.submitBlik.timeLimit' => ({required Object code, required Object seconds}) => 'Introduza o ${code} dentro de: ${seconds} s',
			'taker.submitBlik.timeExpired' => ({required Object code}) => 'O tempo para introduzir o código ${code} expirou.',
			'taker.submitBlik.actions.submit' => ({required Object code}) => 'Submeter ${code}',
			'taker.submitBlik.feedback.pasted' => ({required Object code}) => 'Código ${code} colado.',
			'taker.submitBlik.validation.invalidFormat' => ({required Object code, required Object digits}) => 'Introduza um código ${code} válido de ${digits} dígitos.',
			'taker.submitBlik.errors.submitting' => ({required Object code, required Object details}) => 'Erro ao submeter o código ${code}: ${details}',
			'taker.submitBlik.errors.clipboardInvalid' => ({required Object code, required Object digits}) => 'A área de transferência não contém um código ${code} válido de ${digits} dígitos.',
			'taker.submitBlik.errors.stateChanged' => 'Erro: o estado da oferta mudou.',
			'taker.submitBlik.errors.stateNotValid' => 'Erro: o estado da oferta já não é válido.',
			'taker.submitBlik.errors.fetchedIdMismatch' => ({required Object fetchedId, required Object initialId}) => 'O ID da oferta ativa obtido (${fetchedId}) não corresponde ao ID inicial da oferta (${initialId}). Estado inconsistente?',
			'taker.submitBlik.errors.paymentHashMissing' => 'Payment hash da oferta em falta após obtenção.',
			'taker.submitBlik.details.requestedAmount' => ({required Object code}) => 'Montante ${code} pedido',
			'taker.submitBlik.details.exchangeRate' => 'Taxa de câmbio',
			'taker.submitBlik.details.takerFee' => 'Taxa do taker',
			'taker.submitBlik.details.status' => 'Estado',
			'taker.submitBlik.details.youllReceive' => 'Vai receber',
			'taker.criticalCodeDecision.title' => 'Decisão crítica',
			'taker.criticalCodeDecision.explanation' => ({required Object code}) => 'Já partilhou um código ${code} com o maker. Continuar pode substituir esse código, terminar a sua reserva e reabrir a oferta a outros takers.',
			'taker.criticalCodeDecision.warningTitle' => 'PODE PERDER OS SEUS FUNDOS',
			'taker.criticalCodeDecision.warningBody' => ({required Object code}) => 'Se o seu banco debitou o pagamento ${code}, NÃO continue. O maker pode ter usado o seu código e, após esta ação, o coordenador poderá já não conseguir garantir o pagamento dos seus bitcoins.',
			'taker.criticalCodeDecision.actions.cancel' => 'Voltar e verificar o banco',
			'taker.criticalCodeDecision.actions.proceed' => 'NÃO fui debitado — continuar',
			'twint.scanner.title' => ({required Object code}) => 'Ler código ${code}',
			'twint.scanner.status.align' => ({required Object code}) => 'Alinhe o QR ${code} e o texto do montante dentro da moldura da câmara.',
			'twint.scanner.status.notRecognized' => ({required Object code}) => 'O código ${code} ainda não foi reconhecido. Mantenha o QR e o montante visíveis ou preencha o formulário manualmente.',
			'twint.scanner.status.amountFailed' => 'A leitura pela câmara não conseguiu extrair o montante. Ainda pode usar o resultado do QR e corrigir os campos manualmente.',
			'twint.flow.progress.step1' => '1. Criar oferta',
			'twint.flow.progress.step2' => '2. Esperar pelo taker',
			'twint.flow.progress.step3' => '3. Confirmar',
			'twint.flow.takerProgress.step1' => ({required Object code}) => '1. Pagar ${code}',
			'twint.flow.takerProgress.step2' => '2. Receber sats',
			'twint.flow.makerWait.takerPaying' => 'O taker está a pagar',
			'twint.flow.makerWait.yourCode' => ({required Object code}) => 'O seu código ${code}',
			'twint.flow.makerWait.offerExpires' => ({required Object code}) => 'O ${code} expira',
			'twint.flow.makerWait.autoExpires' => 'Expira automaticamente',
			'twint.flow.makerWait.codeExpiresIn' => ({required Object code}) => '${code} expira em...',
			'twint.flow.makerWait.cancelOffer' => 'Cancelar oferta',
			'twint.flow.makerWait.reservedInfo' => ({required Object code}) => 'Um taker reservou a sua oferta e está agora a pagar o seu código ${code} na app do banco. Quando o pagamento chegar ao seu comerciante, confirme-o abaixo.',
			'twint.flow.makerWait.confirmReceived' => 'Confirmar pagamento recebido',
			'twint.flow.makerWait.confirmDialog.title' => 'Confirmar pagamento recebido?',
			'twint.flow.makerWait.confirmDialog.content' => ({required Object code}) => 'Confirme apenas se tiver a certeza ABSOLUTA de que o pagamento ${code} foi recebido com sucesso no seu comerciante.\n\nA confirmação liquida a hold invoice Lightning e envia imediatamente os sats ao taker — não pode ser desfeito.',
			'twint.flow.makerWait.confirmDialog.cancel' => 'Cancelar',
			'twint.flow.makerWait.confirmDialog.confirmButton' => 'Sim, pagamento recebido',
			'twint.flow.makerExpired.title' => ({required Object code}) => '${code} provavelmente expirado',
			'twint.flow.makerExpired.warning' => ({required Object code}) => 'O código ${code} provavelmente já expirou — mas o taker ainda pode ter conseguido pagá-lo. Verifique o seu comerciante: tem o tempo abaixo para confirmar o pagamento.',
			'twint.flow.makerExpired.timerCaption' => 'Tempo para confirmar',
			'twint.flow.makerExpired.disputeHint' => 'Também pode deixar o temporizador terminar. Se o taker declarar que pagou, isto torna-se um conflito/disputa em que ambas as partes terão de fornecer provas ao coordenador para resolver a questão.',
			'twint.flow.makerVerify.title' => 'Recebeu o pagamento?',
			'twint.flow.makerVerify.body' => ({required Object amount, required Object code}) => 'O taker indica que pagou ${amount} para o seu código ${code}.',
			'twint.flow.makerVerify.hint' => 'Verifique o estado do pagamento com o seu comerciante (terminal da loja ou transação online). Em caso de dúvida, aguarde e verifique novamente mais tarde antes de decidir.',
			'twint.flow.makerVerify.autoConfirms' => 'Confirma automaticamente',
			'twint.flow.makerVerify.confirmReceived' => 'Confirmar receção',
			'twint.flow.makerVerify.openDispute' => 'Abrir disputa',
			'twint.flow.makerRecode.title' => 'Oferta expirada',
			'twint.flow.makerRecode.body' => ({required Object code}) => 'Nenhum taker concluiu a troca. Introduza um novo código ${code} para voltar a publicar esta oferta, ou cancele-a.',
			'twint.flow.makerRecode.scanCardTitle' => ({required Object code}) => 'Digitalizar novo QR ${code}',
			'twint.flow.makerRecode.scanCardBody' => 'Aponte a câmara para o ecrã de pagamento. A app preencherá o novo código — o montante mantém-se.',
			'twint.flow.makerRecode.fieldLabel' => ({required Object code}) => 'Novo código ${code}',
			'twint.flow.makerRecode.autoCancels' => 'Cancela automaticamente',
			'twint.flow.makerRecode.relist' => 'Publicar novamente com novo código',
			'twint.flow.makerRecode.cancelOffer' => 'Cancelar oferta',
			'twint.flow.takerPay.title' => ({required Object code}) => 'Pagar com ${code}',
			'twint.flow.takerPay.body' => ({required Object code, required Object amount}) => 'Abra a sua app ${code} e pague ${amount} usando:',
			'twint.flow.takerPay.codeExpires' => 'O código expira',
			'twint.flow.takerPay.paid' => 'Já paguei',
			'twint.flow.takerPay.cancel' => 'Cancelar',
			'twint.flow.takerWait.title' => 'À espera do maker',
			'twint.flow.takerWait.body' => ({required Object code}) => 'O maker está a verificar se o seu pagamento ${code} chegou ao seu comerciante. Ele tem de confirmar a receção ou abrir uma disputa.',
			'twint.flow.takerWait.info' => 'Se o maker não tomar nenhuma decisão antes do tempo expirar, o pagamento confirma-se automaticamente e receberá os seus sats.',
			'twint.flow.takerWait.autoConfirms' => 'Confirma automaticamente',
			'twint.flow.takerExpired.title' => ({required Object code}) => '${code} provavelmente expirado',
			'twint.flow.takerExpired.warning' => ({required Object code}) => 'O código ${code} provavelmente já expirou. Tem agora de tomar uma decisão importante — escolha com cuidado.',
			'twint.flow.takerExpired.optionPaid' => ({required Object code}) => 'Se PAGOU o código ${code} na app do seu banco, marque-o como pago. Isso compromete-o com essa declaração: o maker terá de confirmar para desbloquear o bitcoin, ou abrir uma disputa em que ambas as partes fornecem provas ao coordenador.',
			'twint.flow.takerExpired.optionCancel' => 'Se NÃO pagou, cancele a reserva. É irreversível — se o pagamento tiver de facto passado, o coordenador deixa de poder garantir os seus sats.',
			'twint.flow.takerExpired.noDecision' => ({required Object code}) => 'Se não tomar nenhuma decisão antes de o temporizador terminar, o coordenador assumirá que NÃO pagou o código ${code}. O maker poderá então cancelar a oferta — cancelando a hold invoice — e depois disso o coordenador já não poderá liquidar os sats para si, mesmo que tenha pago.',
			'twint.flow.takerExpired.timerCaption' => 'Tempo para decidir',
			'twint.flow.takerExpired.markPaid' => ({required Object code}) => 'Paguei o código ${code}',
			'twint.flow.takerExpired.cancel' => 'Cancelar reserva',
			'twint.flow.takerExpired.markPaidDialog.title' => 'Confirma que pagou?',
			'twint.flow.takerExpired.markPaidDialog.content' => ({required Object code}) => 'Continue apenas se tiver a certeza de que o pagamento ${code} foi debitado na app do seu banco.\n\nO maker será convidado a confirmar a receção para desbloquear o bitcoin. Se negar, é aberta uma disputa e ambas as partes terão de fornecer provas ao coordenador.',
			_ => null,
		} ?? switch (path) {
			'twint.flow.takerExpired.markPaidDialog.cancel' => 'Voltar',
			'twint.flow.takerExpired.markPaidDialog.confirmButton' => 'Sim, paguei',
			'twint.flow.takerExpired.cancelDialog.title' => 'Cancelar a reserva?',
			'twint.flow.takerExpired.cancelDialog.content' => ({required Object code}) => 'Cancele apenas se NÃO pagou o código ${code}.\n\nNão pode ser desfeito: se o pagamento tiver de facto passado, o coordenador NÃO poderá garantir que recebe os sats.',
			'twint.flow.takerExpired.cancelDialog.cancel' => 'Voltar',
			'twint.flow.takerExpired.cancelDialog.confirmButton' => 'Sim, cancelar',
			'twint.waitConfirmation.title' => 'À espera do maker',
			'twint.waitConfirmation.statusLabel' => ({required Object status}) => 'Estado da oferta: ${status}',
			'twint.waitConfirmation.waitingMaker' => ({required Object seconds}) => 'À espera da confirmação do maker: ${seconds} s',
			'twint.waitConfirmation.waitingMakerConfirmation' => ({required Object code, required Object seconds}) => 'À espera que o maker confirme que o ${code} está correto. Tempo restante: ${seconds}s',
			'twint.waitConfirmation.importantNotice' => ({required Object code, required Object amount, required Object currency}) => 'MUITO IMPORTANTE: certifique-se de que só aceita a confirmação ${code} para ${amount} ${currency}',
			'twint.waitConfirmation.importantBlikAmountConfirmation' => ({required Object code, required Object amount, required Object currency}) => 'MUITO IMPORTANTE: na app do seu banco, certifique-se de que está a confirmar um pagamento ${code} de exatamente ${amount} ${currency}.',
			'twint.waitConfirmation.instructions' => ({required Object minutes, required Object code}) => 'O maker tem agora de o introduzir no terminal de pagamento dentro de ${minutes} minutos. Depois tem de aceitar o código ${code} na app do seu banco.',
			'twint.waitConfirmation.instructionsNoConfirm' => ({required Object code, required Object minutes}) => 'O maker tem agora de introduzir o seu código ${code} no multibanco dentro de ${minutes} minutos.',
			'twint.waitConfirmation.categoryReminder.atm' => 'Lembrete da oferta de multibanco: o seu banco pode ainda pedir-lhe para aprovar uma taxa extra de multibanco para além do montante principal.',
			'twint.waitConfirmation.categoryReminder.ecommerce' => 'Lembrete da encomenda online: se o comerciante enviar um reembolso automático para a sua conta bancária, contacte o coordenador e devolva-o.',
			'twint.waitConfirmation.waitingForMakerToReceive' => ({required Object code}) => 'À espera que o maker receba o seu código ${code}...',
			'twint.waitConfirmation.makerReceivedBlik' => ({required Object code}) => 'O maker recebeu o seu código ${code}.',
			'twint.waitConfirmation.timerExpiredMessage' => ({required Object minutes, required Object code}) => 'O tempo de expiração de ${minutes}m do ${code} passou. À espera que o maker confirme ou marque o código como inválido.',
			'twint.waitConfirmation.timerExpiredActions' => ({required Object minutes, required Object code}) => 'O tempo de expiração de ${minutes}m do ${code} passou mas o maker não recebeu o código ${code}. Pode reenviar um novo código ${code} ou cancelar.',
			'twint.waitConfirmation.resendBlikButton' => ({required Object code}) => 'Reenviar novo código ${code}',
			'twint.waitConfirmation.navigatedHome' => 'Voltou ao início.',
			'twint.waitConfirmation.expiredTitle' => ({required Object code}) => 'Código ${code} expirado',
			'twint.waitConfirmation.expiredWarning' => ({required Object code}) => 'O maker não recebeu o código ${code}, por isso não o pôde ter usado.',
			'twint.waitConfirmation.expiredRelistCountdownLabel' => 'A reserva termina em',
			'twint.waitConfirmation.expiredSentWarning' => 'O maker ainda não confirmou o pagamento. O que pretende fazer?',
			'twint.waitConfirmation.expiredInstruction1' => ({required Object code}) => 'Se quiser tentar novamente com um novo código ${code}, renove a reserva.',
			'twint.waitConfirmation.expiredInstruction2' => 'Se já não quiser concluir esta transação, cancele a reserva.',
			'twint.waitConfirmation.expiredInstruction3' => ({required Object code}) => 'Se o pagamento ${code} foi cobrado da sua conta bancária, não se preocupe, o bitcoin continua seguro e bloqueado com o coordenador.',
			'twint.waitConfirmation.takerCharged.title' => ({required Object code}) => 'Marcou o ${code} como cobrado',
			'twint.waitConfirmation.takerCharged.message' => ({required Object minutes}) => 'O maker tem ${minutes}min para confirmar o pagamento ou abrir disputa. Se nada fizer, o pagamento será confirmado automaticamente e receberá o bitcoin.',
			'twint.waitConfirmation.expiredActions.reportConflict' => ({required Object code}) => 'O ${code} foi cobrado da minha conta bancária',
			'twint.waitConfirmation.expiredActions.renewReservation' => ({required Object code}) => 'Tentar novamente com novo código ${code}',
			'twint.waitConfirmation.expiredActions.cancelReservation' => 'Cancelar reserva',
			'twint.waitConfirmation.feedback.makerConfirmed' => 'O maker confirmou o pagamento.',
			'twint.waitConfirmation.feedback.paymentSuccessful' => 'Pagamento bem-sucedido! Vai receber os fundos em breve.',
			'twint.waitConfirmation.feedback.conflictReported' => 'Conflito reportado. O coordenador vai analisar a situação.',
			'twint.waitConfirmation.errors.invalidOfferStateReceived' => 'Recebida uma oferta com um estado inválido para este ecrã. A reiniciar.',
			'twint.waitConfirmation.errors.reportingConflict' => ({required Object details}) => 'Erro ao reportar o conflito: ${details}',
			'twint.paymentProcess.title' => 'Processo de pagamento',
			'twint.paymentProcess.waitingForOfferUpdate' => 'À espera da atualização do estado da oferta...',
			'twint.paymentProcess.states.preparing' => 'A preparar o envio do pagamento...',
			'twint.paymentProcess.states.sending' => 'A enviar o pagamento...',
			'twint.paymentProcess.states.received' => 'Pagamento recebido!',
			'twint.paymentProcess.states.failed' => 'Pagamento falhou',
			'twint.paymentProcess.states.waitingUpdate' => 'À espera da atualização da oferta...',
			'twint.paymentProcess.steps.makerConfirmedBlik' => ({required Object code}) => 'O maker confirmou o pagamento ${code}',
			'twint.paymentProcess.steps.makerInvoiceSettled' => 'Hold invoice do maker liquidada',
			'twint.paymentProcess.steps.takerInvoicePaid' => 'A pagar a sua invoice Lightning',
			'twint.paymentProcess.steps.takerPaymentFailed' => 'O pagamento à sua invoice falhou',
			'twint.paymentProcess.errors.sending' => ({required Object details}) => 'Erro ao enviar o pagamento: ${details}',
			'twint.paymentProcess.errors.notConfirmed' => 'Oferta não confirmada pelo maker.',
			'twint.paymentProcess.errors.expired' => 'Oferta expirada.',
			'twint.paymentProcess.errors.cancelled' => 'Oferta cancelada.',
			'twint.paymentProcess.errors.paymentFailed' => 'Pagamento da oferta falhou.',
			'twint.paymentProcess.errors.unknown' => 'Erro desconhecido na oferta.',
			'twint.paymentProcess.errors.takerPaymentFailed' => 'O pagamento à sua invoice Lightning falhou.',
			'twint.paymentProcess.errors.noPublicKey' => 'Erro: não é possível obter a sua chave pública.',
			'twint.paymentProcess.errors.loadingPublicKey' => 'Erro ao carregar os seus dados',
			'twint.paymentProcess.errors.missingPaymentHash' => 'Erro: detalhes do pagamento em falta.',
			'twint.paymentProcess.loading.publicKey' => 'A carregar os seus dados...',
			'twint.paymentProcess.actions.goToFailureDetails' => 'Tentar de novo com nova invoice',
			'twint.paymentFailed.title' => 'Pagamento falhou',
			'twint.paymentFailed.instructions' => ({required Object netAmount}) => 'Forneça uma nova invoice Lightning para ${netAmount}',
			'twint.paymentFailed.form.newInvoiceLabel' => 'Nova invoice Lightning',
			'twint.paymentFailed.form.newInvoiceHint' => 'Introduza a sua invoice BOLT11',
			'twint.paymentFailed.actions.retryPayment' => 'Submeter nova invoice',
			'twint.paymentFailed.errors.enterValidInvoice' => 'Introduza uma invoice válida',
			'twint.paymentFailed.errors.updatingInvoice' => ({required Object details}) => 'Erro ao atualizar a invoice: ${details}',
			'twint.paymentFailed.errors.paymentRetryFailed' => 'A nova tentativa de pagamento falhou. Verifique a invoice ou tente mais tarde.',
			'twint.paymentFailed.errors.takerPublicKeyNotFound' => 'Chave pública do taker não encontrada.',
			'twint.paymentFailed.errors.generateFailed' => ({required Object details}) => 'Falha ao gerar a invoice: ${details}',
			'twint.paymentFailed.walletSection.title' => 'Gerar invoice a partir da carteira',
			'twint.paymentFailed.walletSection.defaultLabel' => 'predefinida',
			'twint.paymentFailed.walletSection.tapToGenerate' => ({required Object amountSats}) => 'Toque para gerar a invoice para ${amountSats}',
			'twint.paymentFailed.loading.processingPayment' => 'A processar a nova tentativa de pagamento...',
			'twint.paymentFailed.success.title' => 'Pagamento bem-sucedido',
			'twint.paymentFailed.success.message' => 'O seu pagamento foi processado com sucesso.',
			'twint.paymentSuccess.title' => 'Pagamento bem-sucedido',
			'twint.paymentSuccess.message' => 'O seu pagamento foi processado com sucesso.',
			'twint.paymentSuccess.actions.goHome' => 'Ir para o início',
			'twint.invalidBlik.title' => ({required Object code}) => 'Código ${code} inválido',
			'twint.invalidBlik.message' => ({required Object code}) => 'O maker rejeitou o código ${code}',
			'twint.invalidBlik.explanation' => ({required Object code}) => 'O maker da oferta indicou que o código ${code} que forneceu era inválido ou não funcionou.\n\nO que pretende fazer?',
			'twint.invalidBlik.werentCharged' => 'Se NÃO foi cobrado:',
			'twint.invalidBlik.wereCharged' => 'Se foi cobrado:',
			'twint.invalidBlik.actions.retry' => ({required Object code}) => 'Enviar novo código ${code}',
			'twint.invalidBlik.actions.cancelReservation' => 'Cancelar transação',
			'twint.invalidBlik.actions.reportConflict' => 'Iniciar disputa',
			'twint.invalidBlik.actions.returnHome' => 'Voltar ao início',
			'twint.invalidBlik.confirmDialog.title' => 'Tem a certeza?',
			'twint.invalidBlik.confirmDialog.content' => 'Depois de clicar isto, não há como voltar atrás.\n\nSe o valor FOI de facto cobrado da sua conta bancária, o coordenador NÃO poderá garantir que você receba o bitcoin e poderá perder os seus fundos.\n\nSe não tem a certeza, é melhor esperar um pouco e confirmar que NÃO foi cobrado antes de continuar.',
			'twint.invalidBlik.confirmDialog.actions.proceed' => 'Tenho a certeza, continuar',
			'twint.invalidBlik.confirmDialog.actions.cancel' => 'Cancelar',
			'twint.invalidBlik.disputeConfirmDialog.title' => 'Abrir uma disputa?',
			'twint.invalidBlik.disputeConfirmDialog.content' => 'Só abra uma disputa se o valor FOI cobrado da sua conta bancária.\n\nO coordenador irá analisar manualmente o seu caso, o que leva tempo. Você terá de fornecer um comprovativo de pagamento.',
			'twint.invalidBlik.disputeConfirmDialog.actions.proceed' => 'Sim, fui cobrado',
			'twint.invalidBlik.disputeConfirmDialog.actions.cancel' => 'Cancelar',
			'twint.invalidBlik.feedback.conflictReportedSuccess' => 'Conflito reportado. O coordenador vai analisar.',
			'twint.invalidBlik.errors.reservationFailed' => 'Falha ao reservar a oferta novamente',
			'twint.invalidBlik.errors.conflictReport' => ({required Object details}) => 'Erro ao reportar o conflito: ${details}',
			'twint.conflict.title' => 'Conflito na oferta',
			'twint.conflict.headline' => 'Conflito na oferta reportado',
			'twint.conflict.body' => ({required Object code}) => 'O maker marcou o código ${code} como inválido, mas reportou um conflito, indicando que acredita que o pagamento foi bem-sucedido.',
			'twint.conflict.instructions' => 'Aguarde que o coordenador analise a situação. Poderão pedir-lhe mais detalhes. Volte mais tarde ou contacte o suporte se necessário.',
			'twint.conflict.actions.back' => 'Voltar ao início',
			'twint.conflict.feedback.reported' => 'Conflito reportado. O coordenador vai analisar.',
			'twint.conflict.errors.reporting' => ({required Object details}) => 'Erro ao reportar o conflito: ${details}',
			'twint.conflict.nostrContact.title' => 'Contactar o coordenador no Nostr',
			'twint.conflict.nostrContact.description' => 'Pode enviar uma DM diretamente ao coordenador para obter ajuda com esta disputa.',
			'twint.conflict.nostrContact.copyNpub' => 'Copiar npub',
			'twint.conflict.nostrContact.openProfile' => 'Ver perfil',
			'twint.conflict.nostrContact.npubCopied' => 'npub do coordenador copiado para a área de transferência!',
			'twint.conflict.nostrContact.yourIdentityDescription' => 'Para enviar DMs, inicie sessão com a sua chave privada Neko (nsec) em qualquer cliente Nostr que suporte mensagens diretas.',
			'twint.conflict.nostrContact.manageNekoKeys' => 'Gerir chaves Neko',
			'blik.instructions.taker' => ({required Object code}) => 'Assim que o maker introduzir o código ${code}, terá de confirmar o pagamento na app do seu banco. Certifique-se de que o montante está correto antes de confirmar.',
			'home.notifications.title' => 'Seja notificado sobre novas ofertas através de:',
			'home.notifications.telegram' => 'Telegram',
			'home.notifications.simplex' => 'SimpleX',
			'home.notifications.matrix' => 'Matrix',
			'home.notifications.signal' => 'Signal',
			'home.notifications.channelAllBanks' => '(todos os bancos)',
			'home.notifications.channelForBankPrefix' => '(apenas ofertas para ',
			'home.notifications.channelForBankSuffix' => ')',
			'home.notifications.scopeAllBanks' => 'Todos os bancos',
			'home.notifications.scopeBankOnly' => ({required Object bank}) => 'Apenas ${bank}',
			'home.statistics.title' => 'Ofertas concluídas',
			'home.statistics.lifetimeCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Total: ${count} transações\nEspera média pelo ${code}: ${avgBlikTime}\nTempo médio de conclusão: ${avgPaidTime}',
			'home.statistics.last7DaysCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Últimos 7d: ${count} transações\nEspera média pelo ${code}: ${avgBlikTime}\nTempo médio de conclusão: ${avgPaidTime}',
			'home.statistics.last7DaysSingleLine' => ({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Últimos 7d: ${count} ofertas  |  Reserva méd.: ${avgReservationTime}  |  Pago méd.: ${avgPaidTime}',
			'home.statistics.errors.loading' => ({required Object error}) => 'Erro ao carregar estatísticas: ${error}',
			'onboarding.title' => 'Escolha o seu mercado',
			'onboarding.subtitle' => 'Selecione o país e o sistema de pagamento que vai usar. Pode alterá-lo a qualquer momento nas Definições.',
			'nekoInfo.title' => 'O que é um Neko?',
			'nekoInfo.description' => ({required Object app}) => 'O seu Neko é a sua identidade para usar o ${app}. É composto por uma chave privada e uma chave pública para garantir uma comunicação criptograficamente segura com o coordenador.\n\nPara garantir maior anonimato, recomenda-se usar um Neko novo para cada oferta.\n\n⚠️ IMPORTANTE: A sua chave privada é guardada apenas no seu dispositivo (no cliente). É de importância crítica fazer uma cópia de segurança da sua chave privada, já que perder o acesso a ela pode impedi-lo de resolver disputas e de recuperar os seus fundos.',
			'nekoInfo.backupWarning' => 'Lembre-se de fazer uma cópia de segurança do seu Neko',
			'generateNewKey.title' => 'Novo',
			'generateNewKey.description' => 'Tem a certeza de que quer gerar um novo Neko? O atual será perdido para sempre se não tiver feito uma cópia de segurança.',
			'generateNewKey.buttons.generate' => 'Gerar',
			'generateNewKey.errors.activeOffer' => 'Não pode gerar um novo Neko enquanto tiver uma oferta ativa.',
			'generateNewKey.errors.failed' => 'Falha ao gerar um novo Neko',
			'generateNewKey.feedback.success' => 'Novo Neko gerado com sucesso!',
			'generateNewKey.tooltips.generate' => 'Gerar novo Neko',
			'backup.title' => 'Cópia de segurança',
			'backup.description' => 'Esta é a sua chave privada. Protege a comunicação com o coordenador. Nunca a revele a ninguém. Guarde-a num local seguro para evitar problemas durante disputas.',
			'backup.feedback.copied' => 'Chave privada copiada para a área de transferência!',
			'backup.tooltips.backup' => 'Cópia de segurança do Neko',
			'restore.title' => 'Restaurar',
			'restore.labels.privateKey' => 'Chave privada',
			'restore.buttons.restore' => 'Restaurar',
			'restore.errors.invalidKey' => 'Tem de ser uma string hexadecimal de 64 caracteres.',
			'restore.errors.failed' => 'Restauro falhou',
			'restore.feedback.success' => 'Neko restaurado com sucesso! A app vai reiniciar.',
			'restore.tooltips.restore' => 'Restaurar Neko',
			'system.loadingPublicKey' => 'A carregar a sua chave pública...',
			'system.errors.generic' => 'Ocorreu um erro inesperado. Tente novamente.',
			'system.errors.loadingTimeoutConfig' => 'Erro ao carregar a configuração de timeout.',
			'system.errors.loadingCoordinatorConfig' => 'Erro ao carregar a configuração do coordenador. Tente novamente.',
			'system.errors.noPublicKey' => 'A sua chave pública não está disponível. Não é possível prosseguir.',
			'system.errors.internalOfferIncomplete' => 'Erro interno: os detalhes da oferta estão incompletos. Tente novamente.',
			'system.errors.loadingPublicKey' => 'Erro ao carregar a sua chave pública. Reinicie a app.',
			'system.blik.copied' => ({required Object code}) => 'Código ${code} copiado para a área de transferência',
			'myOffers.title' => 'As minhas ofertas',
			'myOffers.empty' => 'Ainda não há ofertas.',
			'myOffers.unknownCoordinator' => 'Coordenador desconhecido',
			'myOffers.menuLabel' => 'As minhas ofertas',
			'myOffers.filter.all' => 'Todas',
			'myOffers.filter.active' => 'Ativas',
			'myOffers.filter.completed' => 'Concluídas',
			'myOffers.filter.failed' => 'Falhadas',
			'myOffers.details.title' => 'Detalhes da oferta',
			'myOffers.details.notFound' => 'Oferta não encontrada.',
			'myOffers.details.amount' => 'Montante',
			'myOffers.details.fees' => 'Taxas',
			'myOffers.details.sats' => 'Satoshis',
			'myOffers.details.maker' => 'Maker',
			'myOffers.details.taker' => 'Taker',
			'myOffers.details.yourFee' => 'A sua taxa',
			'myOffers.details.makerFee' => 'Taxa do maker',
			'myOffers.details.takerFee' => 'Taxa do taker',
			'myOffers.details.coordinator' => 'Coordenador',
			'myOffers.details.createdAt' => 'Criada',
			'myOffers.details.reservedAt' => 'Reservada',
			'myOffers.details.blikReceivedAt' => ({required Object code}) => '${code} submetido',
			'myOffers.details.makerConfirmedAt' => 'Confirmada',
			'myOffers.details.settledAt' => 'Liquidada',
			'myOffers.details.takerPaidAt' => 'Taker pago',
			'myOffers.details.id' => 'ID da oferta',
			'myOffers.details.paymentHash' => 'Payment Hash',
			'myOffers.details.holdInvoice' => 'Hold invoice',
			'myOffers.details.continueActiveOffer' => 'Continuar oferta ativa',
			'myOffers.details.after' => ({required Object duration}) => 'após ${duration}',
			'landing.mainTitle' => ({required Object code}) => 'A sua ponte ${code} ⇄ bitcoin',
			'landing.subtitle' => ({required Object code}) => 'Pague ou venda o seu código ${code} com bitcoin',
			'landing.partnership' => 'parceria',
			'landing.actions.payBlik' => ({required Object code}) => 'Pagar ${code}',
			'landing.actions.payBlikSubtitle' => 'com bitcoin',
			'landing.actions.sellBlik' => 'Comprar bitcoin',
			'landing.actions.sellBlikSubtitle' => ({required Object code}) => 'com ${code}',
			'landing.actions.howItWorks' => 'Como funciona?',
			'faq.screenTitle' => 'FAQ',
			'faq.tooltip' => 'FAQ',
			'settings.title' => 'Definições',
			'settings.offerCreation.title' => 'Criação de ofertas',
			'settings.offerCreation.defaultCategory' => 'Categoria predefinida',
			'settings.offerCreation.defaultBank' => 'Banco predefinido',
			'settings.offerCreation.defaultBankNone' => 'Nenhum (escolher por oferta)',
			'settings.offerCreation.preferredCoordinator' => 'Coordenador preferido',
			'settings.offerCreation.automaticCoordinator' => 'Mais fiável',
			'settings.offerCreation.automaticCoordinatorDescription' => 'Escolhe o coordenador com o melhor historial, combinando as suas próprias ofertas concluídas e a atividade global da rede.',
			'settings.offerCreation.cheapestCoordinator' => 'Mais barato',
			'settings.offerCreation.cheapestCoordinatorDescription' => 'Escolhe o coordenador disponível com a taxa de maker mais baixa para cada oferta.',
			'settings.offerCreation.enablePremium' => 'Ativar preços premium',
			'settings.offerCreation.enablePremiumDescription' => 'Mostrar o seletor de premium ao criar ofertas como maker.',
			'settings.offerCreation.defaultPremium' => 'Premium predefinido',
			'settings.offerCreation.defaultPremiumDisabled' => 'Ative os preços premium para definir um premium predefinido.',
			'settings.offerCreation.premiumPerCoordinatorNote' => 'Cada coordenador define o seu próprio premium máximo, por isso o seu valor predefinido é limitado pelo coordenador usado na oferta.',
			'settings.offerCreation.categoryOptions.shop' => 'Loja, café ou restaurante',
			'settings.offerCreation.categoryOptions.atm' => 'Levantamento em multibanco',
			'settings.offerCreation.categoryOptions.online' => 'Serviço/produto online',
			'settings.offerCreation.dialogs.selectCategory' => 'Selecionar categoria predefinida',
			'settings.offerCreation.dialogs.selectBank' => 'Selecionar banco predefinido',
			'settings.offerCreation.dialogs.selectCoordinator' => 'Selecionar coordenador preferido',
			'settings.offerCreation.dialogs.premiumHint' => 'Introduza uma percentagem como 1,5. Os valores são arredondados a passos de 0,5%.',
			'settings.offerCreation.dialogs.premiumHelper' => 'Aplicado quando os preços premium estão ativados e limitado pelo máximo do coordenador selecionado.',
			'settings.display.title' => 'Visualização',
			'settings.display.bitcoinUnit' => 'Unidade de bitcoin',
			'settings.display.bitcoinUnitDescription' => 'Escolha como os montantes de bitcoin são mostrados em toda a app.',
			'settings.display.unitOptions.sats' => 'sats',
			'settings.display.unitOptions.bitcoin' => '₿ (BIP-177)',
			'settings.paymentSystem.title' => 'País / Sistema de pagamento',
			'settings.paymentSystem.subtitle' => 'Escolha o sistema de pagamento do seu país.',
			'settings.paymentSystem.dialogTitle' => 'Selecionar sistema de pagamento',
			'settings.paymentSystem.countries.PL' => 'Polónia',
			'settings.paymentSystem.countries.PT' => 'Portugal',
			'settings.paymentSystem.countries.CH' => 'Suíça',
			'settings.paymentSystem.countries.SK' => 'Eslováquia',
			'notificationSettings.title' => 'Notificações',
			'notificationSettings.androidOnly' => 'As notificações em segundo plano são atualmente suportadas apenas no Android.',
			'notificationSettings.newOfferAlerts.label' => 'Alertas de novas ofertas',
			'notificationSettings.newOfferAlerts.description' => ({required Object app}) => 'Quando ativado, o ${app} notifica-o sobre novas ofertas disponíveis para aceitar dos seus coordenadores ativos enquanto a app está em segundo plano. Isto pode ser mais rápido do que os messengers externos.',
			'wallet.title' => 'Carteira',
			'wallet.description' => 'Faça a gestão das definições da sua carteira Lightning',
			'wallet.missingReceiving.title' => 'Carteira de receção necessária',
			'wallet.missingReceiving.message' => 'Nenhuma carteira configurada para receber. Adicione uma nas definições da Carteira para aceitar ofertas.',
			'wallet.missingReceiving.openSettings' => 'Definições da carteira',
			'wallet.incompatibleReceiving.title' => 'Carteira BOLT11 necessária',
			'wallet.incompatibleReceiving.message' => 'Este coordenador só pode pagar esta oferta através de BOLT11.',
			'wallet.incompatibleReceiving.explanation' => 'A sua carteira de receção suporta ofertas BOLT12, mas não consegue criar a fatura BOLT11 necessária. Adicione uma carteira de receção compatível com BOLT11.',
			'wallet.details.title' => 'Detalhes da carteira',
			'wallet.details.pendingTitle' => 'Transações pendentes',
			'wallet.details.finishedTitle' => 'Transações concluídas',
			'nwc.title' => 'Nostr Wallet Connect (NWC)',
			'nwc.description' => 'Ligue a sua carteira Lightning via NWC',
			'nwc.labels.connectionString' => 'String de ligação NWC',
			'nwc.labels.hint' => 'nostr+walletconnect://...',
			'nwc.labels.status' => 'Estado da ligação',
			'nwc.labels.connected' => 'Ligada',
			'nwc.labels.disconnected' => 'Desligada',
			'nwc.labels.scanQrCode' => 'Leia o QR code com a sua ligação NWC',
			'nwc.labels.balance' => 'Saldo',
			'nwc.labels.budget' => 'Orçamento',
			'nwc.labels.usedBudget' => 'Usado',
			'nwc.labels.totalBudget' => 'Total',
			'nwc.labels.renewsIn' => 'Renova em',
			'nwc.labels.renewalPeriod' => 'Período de renovação',
			'nwc.labels.relay' => 'Relay',
			'nwc.labels.relays' => 'Relays',
			'nwc.prompts.enter' => 'Introduza a sua string de ligação NWC',
			'nwc.prompts.connect' => 'Ligar carteira',
			'nwc.prompts.disconnect' => 'Desligar',
			'nwc.prompts.confirmDisconnect' => 'Tem a certeza de que quer desligar a sua carteira NWC?',
			'nwc.prompts.pasteConnection' => 'Colar string de ligação',
			'nwc.prompts.chooseMethod' => 'Escolha como ligar a sua carteira Lightning',
			'nwc.prompts.howToGet' => 'Ainda não tem uma ligação NWC? Saiba como obter uma!',
			'nwc.prompts.learnMore' => 'Saiba mais sobre o NWC',
			'nwc.actions.connectAlbyGo' => 'Ligar com Alby Go',
			'nwc.actions.connectNwc' => 'Ler QR code NWC',
			'nwc.feedback.connected' => 'Carteira NWC ligada com sucesso!',
			'nwc.feedback.disconnected' => 'Carteira NWC desligada',
			'nwc.feedback.connecting' => 'A ligar à carteira NWC...',
			'nwc.feedback.loadingWalletInfo' => 'A carregar informação da carteira...',
			'nwc.errors.connecting' => ({required Object details}) => 'Erro ao ligar ao NWC: ${details}',
			'nwc.errors.disconnecting' => ({required Object details}) => 'Erro ao desligar o NWC: ${details}',
			'nwc.errors.invalid' => 'String de ligação NWC inválida',
			'nwc.errors.required' => 'A string de ligação NWC é obrigatória',
			'nwc.errors.loadingBalance' => 'Falha ao carregar o saldo da carteira',
			'nwc.errors.loadingBudget' => 'Falha ao carregar o orçamento da carteira',
			'nwc.time.minutes' => ({required Object count}) => '${count}m',
			'nwc.time.hours' => ({required Object count}) => '${count}h',
			'nwc.time.days' => ({required Object count}) => '${count}d',
			'nwc.time.justNow' => 'agora mesmo',
			'nekoManagement.title' => 'Neko',
			'relays.title' => 'Relays',
			'relays.coordinatorRelays' => 'Relays do coordenador',
			'relays.discoveryRelays' => 'Relays de descoberta',
			'relays.status.connected' => 'Ligado',
			'relays.status.connecting' => 'A ligar',
			'relays.status.reconnecting' => 'A religar',
			'relays.status.disconnected' => 'Desligado',
			'relays.popup.title' => ({required Object connected, required Object total}) => 'Relays (${connected}/${total} ligados)',
			'relays.popup.connectingMessage' => 'A ligar aos relays...',
			'offerNotifications.activeService.title' => 'À espera de novas ofertas',
			'offerNotifications.activeService.body' => ({required Object app}) => 'O serviço Nostr está a monitorizar eventos de ofertas do ${app}.',
			'offerNotifications.funded.title' => 'Oferta financiada',
			'offerNotifications.funded.body' => 'A sua hold invoice foi aceite. A oferta está agora ativa.',
			'offerNotifications.reserved.title' => 'Oferta reservada',
			'offerNotifications.reserved.body' => 'Um taker reservou a sua oferta.',
			'offerNotifications.blikReady.title' => ({required Object code}) => 'Código ${code} pronto',
			'offerNotifications.blikReady.body' => ({required Object code}) => 'O seu código ${code} está pronto para ver.',
			'offerNotifications.newOffer.title' => 'Nova oferta disponível',
			'offerNotifications.newOffer.body' => ({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}',
			'offerNotifications.newOffer.premiumSuffix' => ({required Object percent}) => '+${percent}% premium',
			'offerNotifications.categories.shop' => 'Loja',
			'offerNotifications.categories.atm' => 'Multibanco',
			'offerNotifications.categories.online' => 'Online',
			'offerNotifications.blikPendingReminder.title' => ({required Object code}) => '${code} à espera da sua ação',
			'offerNotifications.blikPendingReminder.body' => ({required Object code}) => 'Confirme o pagamento ou marque o código ${code} como inválido.',
			'offerNotifications.takerCharged.title' => ({required Object code}) => '${code} cobrado',
			'offerNotifications.takerCharged.body' => ({required Object code}) => 'O taker reporta que o ${code} foi cobrado. Confirme ou marque como inválido.',
			'offerNotifications.invalidBlik.title' => ({required Object code}) => '${code} marcado como inválido',
			'offerNotifications.invalidBlik.body' => ({required Object code}) => 'O maker marcou o seu código ${code} como inválido.',
			'offerNotifications.takerPaid.title' => 'Pagamento recebido',
			'offerNotifications.takerPaid.body' => 'O seu pagamento Lightning foi enviado.',
			'altstore.dialogTitle' => 'AltStore não instalada',
			'altstore.step1Title' => 'Descarregue e instale a AltStore PAL',
			'altstore.step1Button' => 'altstore.io/download',
			'altstore.step1Warning' => 'Precisa do Safari para instalar a AltStore PAL!',
			'altstore.step2Title' => ({required Object app}) => 'Instalar o ${app}',
			'altstore.step2Button' => ({required Object app}) => 'Instalar o ${app}',
			'altstore.step2Fallback' => 'Continua sem funcionar? Cole a fonte na AltStore',
			_ => null,
		};
	}
}
