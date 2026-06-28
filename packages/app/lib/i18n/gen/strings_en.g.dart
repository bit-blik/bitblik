///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$en app = Translations$app$en.internal(_root);
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$lightningAddress$en lightningAddress = Translations$lightningAddress$en.internal(_root);
	late final Translations$offers$en offers = Translations$offers$en.internal(_root);
	late final Translations$reservations$en reservations = Translations$reservations$en.internal(_root);
	late final Translations$exchange$en exchange = Translations$exchange$en.internal(_root);
	late final Translations$coordinator$en coordinator = Translations$coordinator$en.internal(_root);
	late final Translations$maker$en maker = Translations$maker$en.internal(_root);
	late final Translations$taker$en taker = Translations$taker$en.internal(_root);
	late final Translations$blik$en blik = Translations$blik$en.internal(_root);
	late final Translations$home$en home = Translations$home$en.internal(_root);
	late final Translations$nekoInfo$en nekoInfo = Translations$nekoInfo$en.internal(_root);
	late final Translations$generateNewKey$en generateNewKey = Translations$generateNewKey$en.internal(_root);
	late final Translations$backup$en backup = Translations$backup$en.internal(_root);
	late final Translations$restore$en restore = Translations$restore$en.internal(_root);
	late final Translations$system$en system = Translations$system$en.internal(_root);
	late final Translations$myOffers$en myOffers = Translations$myOffers$en.internal(_root);
	late final Translations$landing$en landing = Translations$landing$en.internal(_root);
	late final Translations$faq$en faq = Translations$faq$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$notificationSettings$en notificationSettings = Translations$notificationSettings$en.internal(_root);
	late final Translations$wallet$en wallet = Translations$wallet$en.internal(_root);
	late final Translations$nwc$en nwc = Translations$nwc$en.internal(_root);
	late final Translations$nekoManagement$en nekoManagement = Translations$nekoManagement$en.internal(_root);
	late final Translations$relays$en relays = Translations$relays$en.internal(_root);
	late final Translations$offerNotifications$en offerNotifications = Translations$offerNotifications$en.internal(_root);
	late final Translations$altstore$en altstore = Translations$altstore$en.internal(_root);
}

// Path: app
class Translations$app$en {
	Translations$app$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${app}'
	String title({required Object app}) => '${app}';

	/// en: 'Hello!'
	String get greeting => 'Hello!';

	/// en: 'Changelog'
	String get changelog => 'Changelog';
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$common$buttons$en buttons = Translations$common$buttons$en.internal(_root);
	late final Translations$common$labels$en labels = Translations$common$labels$en.internal(_root);
	late final Translations$common$notifications$en notifications = Translations$common$notifications$en.internal(_root);
	late final Translations$common$clipboard$en clipboard = Translations$common$clipboard$en.internal(_root);
	late final Translations$common$actions$en actions = Translations$common$actions$en.internal(_root);
}

// Path: lightningAddress
class Translations$lightningAddress$en {
	Translations$lightningAddress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$lightningAddress$labels$en labels = Translations$lightningAddress$labels$en.internal(_root);
	late final Translations$lightningAddress$prompts$en prompts = Translations$lightningAddress$prompts$en.internal(_root);
	late final Translations$lightningAddress$feedback$en feedback = Translations$lightningAddress$feedback$en.internal(_root);
	late final Translations$lightningAddress$errors$en errors = Translations$lightningAddress$errors$en.internal(_root);
}

// Path: offers
class Translations$offers$en {
	Translations$offers$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$offers$details$en details = Translations$offers$details$en.internal(_root);
	late final Translations$offers$labels$en labels = Translations$offers$labels$en.internal(_root);
	late final Translations$offers$tooltips$en tooltips = Translations$offers$tooltips$en.internal(_root);
	late final Translations$offers$actions$en actions = Translations$offers$actions$en.internal(_root);
	late final Translations$offers$status$en status = Translations$offers$status$en.internal(_root);
	late final Translations$offers$statusMessages$en statusMessages = Translations$offers$statusMessages$en.internal(_root);
	late final Translations$offers$progress$en progress = Translations$offers$progress$en.internal(_root);
	late final Translations$offers$errors$en errors = Translations$offers$errors$en.internal(_root);
	late final Translations$offers$success$en success = Translations$offers$success$en.internal(_root);
}

// Path: reservations
class Translations$reservations$en {
	Translations$reservations$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$reservations$actions$en actions = Translations$reservations$actions$en.internal(_root);
	late final Translations$reservations$feedback$en feedback = Translations$reservations$feedback$en.internal(_root);
	late final Translations$reservations$errors$en errors = Translations$reservations$errors$en.internal(_root);
}

// Path: exchange
class Translations$exchange$en {
	Translations$exchange$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$exchange$labels$en labels = Translations$exchange$labels$en.internal(_root);
	late final Translations$exchange$feedback$en feedback = Translations$exchange$feedback$en.internal(_root);
	late final Translations$exchange$errors$en errors = Translations$exchange$errors$en.internal(_root);
}

// Path: coordinator
class Translations$coordinator$en {
	Translations$coordinator$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinators'
	String get title => 'Coordinators';

	late final Translations$coordinator$info$en info = Translations$coordinator$info$en.internal(_root);
	late final Translations$coordinator$selector$en selector = Translations$coordinator$selector$en.internal(_root);
	late final Translations$coordinator$dialog$en dialog = Translations$coordinator$dialog$en.internal(_root);
	late final Translations$coordinator$details$en details = Translations$coordinator$details$en.internal(_root);
	late final Translations$coordinator$coldStart$en coldStart = Translations$coordinator$coldStart$en.internal(_root);
	late final Translations$coordinator$management$en management = Translations$coordinator$management$en.internal(_root);
}

// Path: maker
class Translations$maker$en {
	Translations$maker$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$maker$roleSelection$en roleSelection = Translations$maker$roleSelection$en.internal(_root);
	late final Translations$maker$amountForm$en amountForm = Translations$maker$amountForm$en.internal(_root);
	late final Translations$maker$payInvoice$en payInvoice = Translations$maker$payInvoice$en.internal(_root);
	late final Translations$maker$waitTaker$en waitTaker = Translations$maker$waitTaker$en.internal(_root);
	late final Translations$maker$waitForBlik$en waitForBlik = Translations$maker$waitForBlik$en.internal(_root);
	late final Translations$maker$confirmPayment$en confirmPayment = Translations$maker$confirmPayment$en.internal(_root);
	late final Translations$maker$invalidBlik$en invalidBlik = Translations$maker$invalidBlik$en.internal(_root);
	late final Translations$maker$conflict$en conflict = Translations$maker$conflict$en.internal(_root);
	late final Translations$maker$success$en success = Translations$maker$success$en.internal(_root);
}

// Path: taker
class Translations$taker$en {
	Translations$taker$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$taker$roleSelection$en roleSelection = Translations$taker$roleSelection$en.internal(_root);
	late final Translations$taker$progress$en progress = Translations$taker$progress$en.internal(_root);
	late final Translations$taker$submitBlik$en submitBlik = Translations$taker$submitBlik$en.internal(_root);
	late final Translations$taker$waitConfirmation$en waitConfirmation = Translations$taker$waitConfirmation$en.internal(_root);
	late final Translations$taker$paymentProcess$en paymentProcess = Translations$taker$paymentProcess$en.internal(_root);
	late final Translations$taker$paymentFailed$en paymentFailed = Translations$taker$paymentFailed$en.internal(_root);
	late final Translations$taker$paymentSuccess$en paymentSuccess = Translations$taker$paymentSuccess$en.internal(_root);
	late final Translations$taker$invalidBlik$en invalidBlik = Translations$taker$invalidBlik$en.internal(_root);
	late final Translations$taker$conflict$en conflict = Translations$taker$conflict$en.internal(_root);
}

// Path: blik
class Translations$blik$en {
	Translations$blik$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$blik$instructions$en instructions = Translations$blik$instructions$en.internal(_root);
}

// Path: home
class Translations$home$en {
	Translations$home$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$home$notifications$en notifications = Translations$home$notifications$en.internal(_root);
	late final Translations$home$statistics$en statistics = Translations$home$statistics$en.internal(_root);
}

// Path: nekoInfo
class Translations$nekoInfo$en {
	Translations$nekoInfo$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What is a Neko?'
	String get title => 'What is a Neko?';

	/// en: 'Your Neko is your identity for using ${app}. It's composed of a private and public key to ensure cryptographically secure communication with the coordinator. To ensure greater anonymity, it is recommended to use a new, fresh Neko for each offer. ⚠️ IMPORTANT: Your private key is only stored on your device (client-side). It is critically important to backup your private key, as losing access to it may prevent you from resolving disputes and recovering your funds.'
	String description({required Object app}) => 'Your Neko is your identity for using ${app}. It\'s composed of a private and public key to ensure cryptographically secure communication with the coordinator.\n\nTo ensure greater anonymity, it is recommended to use a new, fresh Neko for each offer.\n\n⚠️ IMPORTANT: Your private key is only stored on your device (client-side). It is critically important to backup your private key, as losing access to it may prevent you from resolving disputes and recovering your funds.';

	/// en: 'Remember to backup your Neko'
	String get backupWarning => 'Remember to backup your Neko';
}

// Path: generateNewKey
class Translations$generateNewKey$en {
	Translations$generateNewKey$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New'
	String get title => 'New';

	/// en: 'Are you sure you want to generate a new Neko? Your current one will be lost forever if you haven't backed it up.'
	String get description => 'Are you sure you want to generate a new Neko? Your current one will be lost forever if you haven\'t backed it up.';

	late final Translations$generateNewKey$buttons$en buttons = Translations$generateNewKey$buttons$en.internal(_root);
	late final Translations$generateNewKey$errors$en errors = Translations$generateNewKey$errors$en.internal(_root);
	late final Translations$generateNewKey$feedback$en feedback = Translations$generateNewKey$feedback$en.internal(_root);
	late final Translations$generateNewKey$tooltips$en tooltips = Translations$generateNewKey$tooltips$en.internal(_root);
}

// Path: backup
class Translations$backup$en {
	Translations$backup$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Backup'
	String get title => 'Backup';

	/// en: 'This is your private key. It secures communication with the coordinator. Never reveal it to anyone. Back it up in a secure place to prevent issues during disputes.'
	String get description => 'This is your private key. It secures communication with the coordinator. Never reveal it to anyone. Back it up in a secure place to prevent issues during disputes.';

	late final Translations$backup$feedback$en feedback = Translations$backup$feedback$en.internal(_root);
	late final Translations$backup$tooltips$en tooltips = Translations$backup$tooltips$en.internal(_root);
}

// Path: restore
class Translations$restore$en {
	Translations$restore$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Restore'
	String get title => 'Restore';

	late final Translations$restore$labels$en labels = Translations$restore$labels$en.internal(_root);
	late final Translations$restore$buttons$en buttons = Translations$restore$buttons$en.internal(_root);
	late final Translations$restore$errors$en errors = Translations$restore$errors$en.internal(_root);
	late final Translations$restore$feedback$en feedback = Translations$restore$feedback$en.internal(_root);
	late final Translations$restore$tooltips$en tooltips = Translations$restore$tooltips$en.internal(_root);
}

// Path: system
class Translations$system$en {
	Translations$system$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading your public key...'
	String get loadingPublicKey => 'Loading your public key...';

	late final Translations$system$errors$en errors = Translations$system$errors$en.internal(_root);
	late final Translations$system$blik$en blik = Translations$system$blik$en.internal(_root);
}

// Path: myOffers
class Translations$myOffers$en {
	Translations$myOffers$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My offers'
	String get title => 'My offers';

	/// en: 'No offers yet.'
	String get empty => 'No offers yet.';

	/// en: 'Unknown coordinator'
	String get unknownCoordinator => 'Unknown coordinator';

	/// en: 'My offers'
	String get menuLabel => 'My offers';

	late final Translations$myOffers$filter$en filter = Translations$myOffers$filter$en.internal(_root);
	late final Translations$myOffers$details$en details = Translations$myOffers$details$en.internal(_root);
}

// Path: landing
class Translations$landing$en {
	Translations$landing$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your ${code} ⇄ bitcoin Bridge'
	String mainTitle({required Object code}) => 'Your ${code} ⇄ bitcoin Bridge';

	/// en: 'Pay for or sell your ${code} code with bitcoin'
	String subtitle({required Object code}) => 'Pay for or sell your ${code} code with bitcoin';

	/// en: 'partnership'
	String get partnership => 'partnership';

	late final Translations$landing$actions$en actions = Translations$landing$actions$en.internal(_root);
}

// Path: faq
class Translations$faq$en {
	Translations$faq$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'FAQ'
	String get screenTitle => 'FAQ';

	/// en: 'FAQ'
	String get tooltip => 'FAQ';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	late final Translations$settings$offerCreation$en offerCreation = Translations$settings$offerCreation$en.internal(_root);
	late final Translations$settings$display$en display = Translations$settings$display$en.internal(_root);
	late final Translations$settings$paymentSystem$en paymentSystem = Translations$settings$paymentSystem$en.internal(_root);
}

// Path: notificationSettings
class Translations$notificationSettings$en {
	Translations$notificationSettings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'Background notifications are currently only supported on Android.'
	String get androidOnly => 'Background notifications are currently only supported on Android.';

	late final Translations$notificationSettings$newOfferAlerts$en newOfferAlerts = Translations$notificationSettings$newOfferAlerts$en.internal(_root);
}

// Path: wallet
class Translations$wallet$en {
	Translations$wallet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Wallet'
	String get title => 'Wallet';

	/// en: 'Manage your Lightning wallet settings'
	String get description => 'Manage your Lightning wallet settings';

	late final Translations$wallet$missingReceiving$en missingReceiving = Translations$wallet$missingReceiving$en.internal(_root);
	late final Translations$wallet$details$en details = Translations$wallet$details$en.internal(_root);
}

// Path: nwc
class Translations$nwc$en {
	Translations$nwc$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Nostr Wallet Connect (NWC)'
	String get title => 'Nostr Wallet Connect (NWC)';

	/// en: 'Connect your Lightning wallet via NWC'
	String get description => 'Connect your Lightning wallet via NWC';

	late final Translations$nwc$labels$en labels = Translations$nwc$labels$en.internal(_root);
	late final Translations$nwc$prompts$en prompts = Translations$nwc$prompts$en.internal(_root);
	late final Translations$nwc$actions$en actions = Translations$nwc$actions$en.internal(_root);
	late final Translations$nwc$feedback$en feedback = Translations$nwc$feedback$en.internal(_root);
	late final Translations$nwc$errors$en errors = Translations$nwc$errors$en.internal(_root);
	late final Translations$nwc$time$en time = Translations$nwc$time$en.internal(_root);
}

// Path: nekoManagement
class Translations$nekoManagement$en {
	Translations$nekoManagement$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Neko'
	String get title => 'Neko';
}

// Path: relays
class Translations$relays$en {
	Translations$relays$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Relays'
	String get title => 'Relays';

	/// en: 'Coordinator relays'
	String get coordinatorRelays => 'Coordinator relays';

	/// en: 'Discovery relays'
	String get discoveryRelays => 'Discovery relays';

	late final Translations$relays$status$en status = Translations$relays$status$en.internal(_root);
	late final Translations$relays$popup$en popup = Translations$relays$popup$en.internal(_root);
}

// Path: offerNotifications
class Translations$offerNotifications$en {
	Translations$offerNotifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$offerNotifications$activeService$en activeService = Translations$offerNotifications$activeService$en.internal(_root);
	late final Translations$offerNotifications$funded$en funded = Translations$offerNotifications$funded$en.internal(_root);
	late final Translations$offerNotifications$reserved$en reserved = Translations$offerNotifications$reserved$en.internal(_root);
	late final Translations$offerNotifications$blikReady$en blikReady = Translations$offerNotifications$blikReady$en.internal(_root);
	late final Translations$offerNotifications$newOffer$en newOffer = Translations$offerNotifications$newOffer$en.internal(_root);
	late final Translations$offerNotifications$categories$en categories = Translations$offerNotifications$categories$en.internal(_root);
	late final Translations$offerNotifications$blikPendingReminder$en blikPendingReminder = Translations$offerNotifications$blikPendingReminder$en.internal(_root);
	late final Translations$offerNotifications$takerCharged$en takerCharged = Translations$offerNotifications$takerCharged$en.internal(_root);
	late final Translations$offerNotifications$invalidBlik$en invalidBlik = Translations$offerNotifications$invalidBlik$en.internal(_root);
	late final Translations$offerNotifications$takerPaid$en takerPaid = Translations$offerNotifications$takerPaid$en.internal(_root);
}

// Path: altstore
class Translations$altstore$en {
	Translations$altstore$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'AltStore Not Installed'
	String get dialogTitle => 'AltStore Not Installed';

	/// en: 'Download and install AltStore PAL'
	String get step1Title => 'Download and install AltStore PAL';

	/// en: 'altstore.io/download'
	String get step1Button => 'altstore.io/download';

	/// en: 'You need Safari to install AltStore PAL!'
	String get step1Warning => 'You need Safari to install AltStore PAL!';

	/// en: 'Install ${app}'
	String step2Title({required Object app}) => 'Install ${app}';

	/// en: 'Install ${app}'
	String step2Button({required Object app}) => 'Install ${app}';

	/// en: 'Still not working? Paste the source into AltStore'
	String get step2Fallback => 'Still not working? Paste the source into AltStore';
}

// Path: common.buttons
class Translations$common$buttons$en {
	Translations$common$buttons$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Go Home'
	String get goHome => 'Go Home';

	/// en: 'Save and Continue'
	String get saveAndContinue => 'Save and Continue';

	/// en: 'Reveal'
	String get reveal => 'Reveal';

	/// en: 'Hide'
	String get hide => 'Hide';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Restore'
	String get restore => 'Restore';

	/// en: 'FAQ'
	String get faq => 'FAQ';
}

// Path: common.labels
class Translations$common$labels$en {
	Translations$common$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Amount (${currency})'
	String amount({required Object currency}) => 'Amount (${currency})';

	/// en: 'Status: ${status}'
	String status({required Object status}) => 'Status: ${status}';

	/// en: 'Role: ${role}'
	String role({required Object role}) => 'Role: ${role}';
}

// Path: common.notifications
class Translations$common$notifications$en {
	Translations$common$notifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Loading...'
	String get loading => 'Loading...';
}

// Path: common.clipboard
class Translations$common$clipboard$en {
	Translations$common$clipboard$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy to clipboard'
	String get copyToClipboard => 'Copy to clipboard';

	/// en: 'Paste from clipboard'
	String get pasteFromClipboard => 'Paste from clipboard';

	/// en: 'Copied to clipboard!'
	String get copied => 'Copied to clipboard!';
}

// Path: common.actions
class Translations$common$actions$en {
	Translations$common$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel and return to offers'
	String get cancelAndReturnToOffers => 'Cancel and return to offers';

	/// en: 'Cancel and return home'
	String get cancelAndReturnHome => 'Cancel and return home';
}

// Path: lightningAddress.labels
class Translations$lightningAddress$labels$en {
	Translations$lightningAddress$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Lightning Address (LNURL)'
	String get address => 'Lightning Address (LNURL)';

	/// en: 'user@domain.com'
	String get hint => 'user@domain.com';

	/// en: 'Lightning Address: ${address}'
	String short({required Object address}) => 'Lightning Address: ${address}';

	/// en: 'Your receiving address:'
	String get receivingAddress => 'Your receiving address:';
}

// Path: lightningAddress.prompts
class Translations$lightningAddress$prompts$en {
	Translations$lightningAddress$prompts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter your Lightning address to continue'
	String get enter => 'Enter your Lightning address to continue';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Enter a valid Lightning address'
	String get invalid => 'Enter a valid Lightning address';

	/// en: 'Lightning address is required.'
	String get required => 'Lightning address is required.';

	/// en: 'You must set a Lightning address to take an offer.'
	String get enterToTakeOffer => 'You must set a Lightning address to take an offer.';

	/// en: 'Lightning address is missing. Please add one to be able to take offers.'
	String get missing => 'Lightning address is missing. Please add one to be able to take offers.';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Are you sure you want to delete your Lightning address?'
	String get confirmDelete => 'Are you sure you want to delete your Lightning address?';

	/// en: 'Don't have a Lightning address yet? Learn how to get one!'
	String get howToGet => 'Don\'t have a Lightning address yet? Learn how to get one!';

	/// en: 'Learn more about Lightning Address'
	String get learnMore => 'Learn more about Lightning Address';
}

// Path: lightningAddress.feedback
class Translations$lightningAddress$feedback$en {
	Translations$lightningAddress$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Lightning address saved!'
	String get saved => 'Lightning address saved!';

	/// en: 'Lightning address updated!'
	String get updated => 'Lightning address updated!';

	/// en: 'Valid Lightning address'
	String get valid => 'Valid Lightning address';
}

// Path: lightningAddress.errors
class Translations$lightningAddress$errors$en {
	Translations$lightningAddress$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error saving address: ${details}'
	String saving({required Object details}) => 'Error saving address: ${details}';

	/// en: 'Error loading Lightning address: ${details}'
	String loading({required Object details}) => 'Error loading Lightning address: ${details}';
}

// Path: offers.details
class Translations$offers$details$en {
	Translations$offers$details$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your offer:'
	String get yourOffer => 'Your offer:';

	/// en: 'Offer:'
	String get selectedOffer => 'Offer:';

	/// en: 'You have an active offer:'
	String get activeOffer => 'You have an active offer:';

	/// en: 'Finished offers'
	String get finishedOffers => 'Finished offers';

	/// en: 'No available offers.'
	String get noAvailable => 'No available offers.';

	/// en: 'Tip: share ${app} in your community and among friends to increase ${app} orders.'
	String noAvailableTip({required Object app}) => 'Tip: share ${app} in your community and among friends to increase ${app} orders.';

	/// en: 'No successful trades.'
	String get noSuccessfulTrades => 'No successful trades.';

	/// en: 'Loading offer details...'
	String get loadingDetails => 'Loading offer details...';

	/// en: 'Amount: ${amount} satoshi'
	String amount({required Object amount}) => 'Amount: ${amount} satoshi';

	/// en: '${amount} ${currency}'
	String amountWithCurrency({required Object amount, required Object currency}) => '${amount} ${currency}';

	/// en: 'Fee: ${fee} sats'
	String makerFee({required Object fee}) => 'Fee: ${fee} sats';

	/// en: 'Fee: ${fee} sats'
	String takerFee({required Object fee}) => 'Fee: ${fee} sats';

	/// en: '${sats} + ${fee} (fee) satoshi Status: ${status}'
	String subtitle({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (fee) satoshi\nStatus: ${status}';

	/// en: '${sats} + ${fee} (fee) satoshi Status: ${status} Paid: ${date}'
	String subtitleWithDate({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (fee) satoshi\nStatus: ${status}\nPaid: ${date}';

	/// en: 'Status: ${status} Amount: ${amount} satoshi'
	String activeSubtitle({required Object status, required Object amount}) => 'Status: ${status}\nAmount: ${amount} satoshi';

	/// en: 'Offer ID: ${id}...'
	String id({required Object id}) => 'Offer ID: ${id}...';

	/// en: 'Created: ${dateTime}'
	String created({required Object dateTime}) => 'Created: ${dateTime}';

	/// en: 'Taken after: ${duration}'
	String takenAfter({required Object duration}) => 'Taken after: ${duration}';

	/// en: 'Paid after: ${duration}'
	String paidAfter({required Object duration}) => 'Paid after: ${duration}';

	/// en: 'Exchange Rate'
	String get exchangeRate => 'Exchange Rate';

	/// en: 'Amount'
	String get amountLabel => 'Amount';

	/// en: 'Maker fee'
	String get makerFeeLabel => 'Maker fee';

	/// en: 'Taker fee'
	String get takerFeeLabel => 'Taker fee';

	/// en: 'Fee'
	String get feeLabel => 'Fee';

	/// en: 'Status'
	String get statusLabel => 'Status';

	/// en: 'You'll receive'
	String get youllReceive => 'You\'ll receive';

	/// en: 'Coordinator'
	String get coordinator => 'Coordinator';

	/// en: 'Category'
	String get categoryLabel => 'Category';

	late final Translations$offers$details$categories$en categories = Translations$offers$details$categories$en.internal(_root);
	late final Translations$offers$details$consents$en consents = Translations$offers$details$consents$en.internal(_root);
}

// Path: offers.labels
class Translations$offers$labels$en {
	Translations$offers$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Premium'
	String get premium => 'Premium';

	/// en: '+${percent}% premium'
	String premiumBadge({required Object percent}) => '+${percent}% premium';
}

// Path: offers.tooltips
class Translations$offers$tooltips$en {
	Translations$offers$tooltips$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinator charges a ${feePercent}% taker fee. This includes Lightning routing fees and is deducted from the amount you receive.'
	String takerFeeInfo({required Object feePercent}) => 'Coordinator charges a ${feePercent}% taker fee. This includes Lightning routing fees and is deducted from the amount you receive.';

	/// en: 'A premium means this offer is priced above market. For the same fiat amount, the maker locks fewer sats in the hold invoice, so you pay above market and receive fewer sats than at the market rate. The maximum premium is set by the coordinator.'
	String get premiumInfoTaker => 'A premium means this offer is priced above market. For the same fiat amount, the maker locks fewer sats in the hold invoice, so you pay above market and receive fewer sats than at the market rate. The maximum premium is set by the coordinator.';

	/// en: 'Fetched at'
	String get ratesFetchedAt => 'Fetched at';

	/// en: 'Avg. rate sources'
	String get ratesSources => 'Avg. rate sources';
}

// Path: offers.actions
class Translations$offers$actions$en {
	Translations$offers$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'TAKE'
	String get take => 'TAKE';

	/// en: 'Take Offer'
	String get takeOffer => 'Take Offer';

	/// en: 'ENTER ${code}'
	String resume({required Object code}) => 'ENTER ${code}';

	/// en: 'Cancel offer'
	String get cancel => 'Cancel offer';

	/// en: 'View details'
	String get view => 'View details';
}

// Path: offers.status
class Translations$offers$status$en {
	Translations$offers$status$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'Funded'
	String get funded => 'Funded';

	/// en: 'Expired'
	String get expired => 'Expired';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'Reserved'
	String get reserved => 'Reserved';

	/// en: '${code} Sent'
	String blikReceived({required Object code}) => '${code} Sent';

	/// en: '${code} Received'
	String blikSentToMaker({required Object code}) => '${code} Received';

	/// en: '${code} expired'
	String expiredBlik({required Object code}) => '${code} expired';

	/// en: '${code} expired'
	String expiredSentBlik({required Object code}) => '${code} expired';

	/// en: 'Taker Charged'
	String get takerCharged => 'Taker Charged';

	/// en: 'Invalid ${code}'
	String invalidBlik({required Object code}) => 'Invalid ${code}';

	/// en: 'Conflict'
	String get conflict => 'Conflict';

	/// en: 'Dispute'
	String get dispute => 'Dispute';

	/// en: 'Confirmed'
	String get makerConfirmed => 'Confirmed';

	/// en: 'Settled'
	String get settled => 'Settled';

	/// en: 'Paying Taker'
	String get payingTaker => 'Paying Taker';

	/// en: 'Taker Payment Failed'
	String get takerPaymentFailed => 'Taker Payment Failed';

	/// en: 'Taker Paid'
	String get takerPaid => 'Taker Paid';

	/// en: 'Unknown'
	String get unknownStatus => 'Unknown';
}

// Path: offers.statusMessages
class Translations$offers$statusMessages$en {
	Translations$offers$statusMessages$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer reserved by Taker!'
	String get reserved => 'Offer reserved by Taker!';

	/// en: 'Offer cancelled successfully.'
	String get cancelled => 'Offer cancelled successfully.';

	/// en: 'Offer has been cancelled or expired.'
	String get cancelledOrExpired => 'Offer has been cancelled or expired.';

	/// en: 'Offer is no longer available (Status: ${status}).'
	String noLongerAvailable({required Object status}) => 'Offer is no longer available (Status: ${status}).';
}

// Path: offers.progress
class Translations$offers$progress$en {
	Translations$offers$progress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Waiting for taker: ${time}'
	String waitingForTaker({required Object time}) => 'Waiting for taker: ${time}';

	/// en: 'Reserved: ${seconds} s left'
	String reserved({required Object seconds}) => 'Reserved: ${seconds} s left';

	/// en: 'Confirming: ${seconds} s left'
	String confirming({required Object seconds}) => 'Confirming: ${seconds} s left';
}

// Path: offers.errors
class Translations$offers$errors$en {
	Translations$offers$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading offers: ${details}'
	String loading({required Object details}) => 'Error loading offers: ${details}';

	/// en: 'Error loading offer details: ${details}'
	String loadingDetails({required Object details}) => 'Error loading offer details: ${details}';

	/// en: 'Error: Offer details missing or invalid.'
	String get detailsMissing => 'Error: Offer details missing or invalid.';

	/// en: 'Unable to load offer details.'
	String get detailsNotLoaded => 'Unable to load offer details.';

	/// en: 'Error: Offer not found.'
	String get notFound => 'Error: Offer not found.';

	/// en: 'Error: Offer is in an unexpected state.'
	String get unexpectedState => 'Error: Offer is in an unexpected state.';

	/// en: 'Offer is in an unexpected state (${status}). Please try again or contact support.'
	String unexpectedStateWithStatus({required Object status}) => 'Offer is in an unexpected state (${status}). Please try again or contact support.';

	/// en: 'Offer has invalid status.'
	String get invalidStatus => 'Offer has invalid status.';

	/// en: 'Error: Could not identify offer to cancel.'
	String get couldNotIdentify => 'Error: Could not identify offer to cancel.';

	/// en: 'Offer cannot be cancelled in current state (${status}).'
	String cannotBeCancelled({required Object status}) => 'Offer cannot be cancelled in current state (${status}).';

	/// en: 'Failed to cancel offer: ${details}'
	String failedToCancel({required Object details}) => 'Failed to cancel offer: ${details}';

	/// en: 'Error: Lost active offer details.'
	String get activeDetailsLost => 'Error: Lost active offer details.';

	/// en: 'Error checking active offers: ${details}'
	String checkingActive({required Object details}) => 'Error checking active offers: ${details}';

	/// en: 'Cannot resume offer in state: ${status}'
	String cannotResume({required Object status}) => 'Cannot resume offer in state: ${status}';

	/// en: 'Cannot resume taker offer in state: ${status}'
	String cannotResumeTaker({required Object status}) => 'Cannot resume taker offer in state: ${status}';

	/// en: 'Error resuming offer: ${details}'
	String resuming({required Object details}) => 'Error resuming offer: ${details}';

	/// en: 'Maker public key not found'
	String get makerPublicKeyNotFound => 'Maker public key not found';

	/// en: 'Taker public key not found.'
	String get takerPublicKeyNotFound => 'Taker public key not found.';

	/// en: 'Accept the ATM surcharge condition before taking this offer.'
	String get atmConsentRequired => 'Accept the ATM surcharge condition before taking this offer.';

	/// en: 'Accept the ecommerce refund-return condition before taking this offer.'
	String get ecommerceConsentRequired => 'Accept the ecommerce refund-return condition before taking this offer.';

	/// en: 'You cannot take your own offer.'
	String get cannotTakeOwnOffer => 'You cannot take your own offer.';
}

// Path: offers.success
class Translations$offers$success$en {
	Translations$offers$success$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer completed'
	String get title => 'Offer completed';

	/// en: 'Payment confirmed!'
	String get headline => 'Payment confirmed!';

	/// en: 'Taker will be paid now.'
	String get subtitle => 'Taker will be paid now.';

	/// en: 'Offer details:'
	String get detailsTitle => 'Offer details:';

	/// en: 'Offer took ${time} to complete.'
	String duration({required Object time}) => 'Offer took ${time} to complete.';
}

// Path: reservations.actions
class Translations$reservations$actions$en {
	Translations$reservations$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel reservation'
	String get cancel => 'Cancel reservation';
}

// Path: reservations.feedback
class Translations$reservations$feedback$en {
	Translations$reservations$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reservation cancelled.'
	String get cancelled => 'Reservation cancelled.';
}

// Path: reservations.errors
class Translations$reservations$errors$en {
	Translations$reservations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to cancel reservation: ${error}'
	String cancelling({required Object error}) => 'Failed to cancel reservation: ${error}';

	/// en: 'Failed to reserve offer: ${details}'
	String failedToReserve({required Object details}) => 'Failed to reserve offer: ${details}';

	/// en: 'Failed to reserve offer (no timestamp).'
	String get failedNoTimestamp => 'Failed to reserve offer (no timestamp).';

	/// en: 'Offer reservation timestamp missing.'
	String get timestampMissing => 'Offer reservation timestamp missing.';

	/// en: 'Offer is no longer in reserved state (${status}).'
	String notReserved({required Object status}) => 'Offer is no longer in reserved state (${status}).';
}

// Path: exchange.labels
class Translations$exchange$labels$en {
	Translations$exchange$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter amount (${currency}) to pay:'
	String enterAmount({required Object currency}) => 'Enter amount (${currency}) to pay:';

	/// en: '≈ ${sats} satoshi'
	String equivalent({required Object sats}) => '≈ ${sats} satoshi';

	/// en: 'Exchange rate ≈ ${rate} ${currency}/BTC'
	String rate({required Object rate, required Object currency}) => 'Exchange rate ≈ ${rate} ${currency}/BTC';
}

// Path: exchange.feedback
class Translations$exchange$feedback$en {
	Translations$exchange$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fetching exchange rate...'
	String get fetching => 'Fetching exchange rate...';
}

// Path: exchange.errors
class Translations$exchange$errors$en {
	Translations$exchange$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to fetch exchange rate.'
	String get fetchingRate => 'Failed to fetch exchange rate.';

	/// en: 'Invalid number format'
	String get invalidFormat => 'Invalid number format';

	/// en: 'Amount must be positive'
	String get mustBePositive => 'Amount must be positive';

	/// en: 'Invalid fee percentage'
	String get invalidFeePercentage => 'Invalid fee percentage';

	/// en: 'Amount is too low. Minimum is ${minAmount} ${currency}.'
	String tooLowFiat({required Object minAmount, required Object currency}) => 'Amount is too low. Minimum is ${minAmount} ${currency}.';

	/// en: 'Amount is too high. Maximum is ${maxAmount} ${currency}.'
	String tooHighFiat({required Object maxAmount, required Object currency}) => 'Amount is too high. Maximum is ${maxAmount} ${currency}.';

	/// en: 'ATM can't dispense this amount. Use a combination of notes: ${notes}.'
	String atmNotDispensable({required Object notes}) => 'ATM can\'t dispense this amount. Use a combination of notes: ${notes}.';
}

// Path: coordinator.info
class Translations$coordinator$info$en {
	Translations$coordinator$info$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'fee'
	String get fee => 'fee';

	/// en: 'Amount: ${minAmount}-${maxAmount} ${currency}'
	String rangeDisplay({required Object minAmount, required Object maxAmount, required Object currency}) => 'Amount: ${minAmount}-${maxAmount} ${currency}';

	/// en: '${fee}% fee'
	String feeDisplay({required Object fee}) => '${fee}% fee';
}

// Path: coordinator.selector
class Translations$coordinator$selector$en {
	Translations$coordinator$selector$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading Coordinators...'
	String get loading => 'Loading Coordinators...';

	/// en: 'Error Loading Coordinators'
	String get errorLoading => 'Error Loading Coordinators';

	/// en: 'Choose Coordinator'
	String get choose => 'Choose Coordinator';

	/// en: 'View Nostr profile'
	String get viewNostrProfile => 'View Nostr profile';

	/// en: 'This coordinator is unresponsive'
	String get unresponsive => 'This coordinator is unresponsive';

	/// en: 'Waiting for coordinator response'
	String get waitingResponse => 'Waiting for coordinator response';

	/// en: 'I accept coordinator's '
	String get termsAccept => 'I accept coordinator\'s ';

	/// en: 'Terms of use'
	String get termsOfUsage => 'Terms of use';
}

// Path: coordinator.dialog
class Translations$coordinator$dialog$en {
	Translations$coordinator$dialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Maker Fee'
	String get makerFee => 'Maker Fee';

	/// en: 'Taker Fee'
	String get takerFee => 'Taker Fee';

	/// en: 'Amount Range'
	String get amountRange => 'Amount Range';

	/// en: 'Reservation Time'
	String get reservationTime => 'Reservation Time';

	/// en: 'Currencies'
	String get currencies => 'Currencies';

	/// en: 'View Terms'
	String get viewTerms => 'View Terms';
}

// Path: coordinator.details
class Translations$coordinator$details$en {
	Translations$coordinator$details$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinator'
	String get title => 'Coordinator';

	/// en: 'Relays in use'
	String get relaysInUse => 'Relays in use';

	/// en: 'All communication with this coordinator is routed to these relays (from its NIP-65 list).'
	String get relaysInUseHint => 'All communication with this coordinator is routed to these relays (from its NIP-65 list).';

	/// en: 'No relays known yet'
	String get noRelays => 'No relays known yet';

	/// en: 'Maker fee'
	String get makerFee => 'Maker fee';

	/// en: 'Taker fee'
	String get takerFee => 'Taker fee';

	/// en: 'Amount range'
	String get amountRange => 'Amount range';

	/// en: 'Max premium'
	String get maxPremium => 'Max premium';

	/// en: 'Premium'
	String get maxPremiumInfoTitle => 'Premium';

	/// en: 'A premium is an optional price markup above the market rate that a maker can set on an offer. With a premium, the maker locks fewer sats for the same fiat amount, so the taker pays above market and the maker keeps the difference. This value is the highest premium this coordinator allows on its offers.'
	String get maxPremiumInfoBody => 'A premium is an optional price markup above the market rate that a maker can set on an offer. With a premium, the maker locks fewer sats for the same fiat amount, so the taker pays above market and the maker keeps the difference. This value is the highest premium this coordinator allows on its offers.';

	/// en: 'Reservation time'
	String get reservationTime => 'Reservation time';

	/// en: 'Currencies'
	String get currencies => 'Currencies';

	/// en: 'Payment system'
	String get paymentSystem => 'Payment system';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Your offers'
	String get yourOffers => 'Your offers';

	/// en: 'Successful offers (30d)'
	String get successfulOffers => 'Successful offers (30d)';

	/// en: 'Online'
	String get statusOnline => 'Online';

	/// en: 'Offline'
	String get statusOffline => 'Offline';

	/// en: 'Unknown'
	String get statusUnknown => 'Unknown';

	/// en: 'Open Nostr profile'
	String get openNostrProfile => 'Open Nostr profile';

	/// en: 'Terms of use'
	String get termsOfUsage => 'Terms of use';
}

// Path: coordinator.coldStart
class Translations$coordinator$coldStart$en {
	Translations$coordinator$coldStart$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Discovering coordinators'
	String get title => 'Discovering coordinators';

	/// en: '${app} is finding public coordinators, checking which ones are reachable, and enabling a small default set for you.'
	String body({required Object app}) => '${app} is finding public coordinators, checking which ones are reachable, and enabling a small default set for you.';

	/// en: 'You can change enabled coordinators later in Settings.'
	String get settingsHint => 'You can change enabled coordinators later in Settings.';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Discovered'
	String get discovered => 'Discovered';

	/// en: 'Candidates'
	String get candidates => 'Candidates';

	/// en: 'Enabled'
	String get enabled => 'Enabled';

	/// en: 'Current coordinators'
	String get recordsTitle => 'Current coordinators';

	/// en: 'Enabled'
	String get recordEnabled => 'Enabled';

	/// en: 'Healthy candidate'
	String get recordHealthyCandidate => 'Healthy candidate';

	/// en: 'Candidate offline'
	String get recordOfflineCandidate => 'Candidate offline';

	/// en: 'Checking'
	String get recordChecking => 'Checking';

	/// en: 'Discovered'
	String get recordDiscovered => 'Discovered';

	late final Translations$coordinator$coldStart$phases$en phases = Translations$coordinator$coldStart$phases$en.internal(_root);
}

// Path: coordinator.management
class Translations$coordinator$management$en {
	Translations$coordinator$management$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinator Management'
	String get title => 'Coordinator Management';

	/// en: 'Coordinators'
	String get availableCoordinators => 'Coordinators';

	/// en: 'No coordinators discovered yet.'
	String get noCoordinators => 'No coordinators discovered yet.';

	/// en: 'Online'
	String get online => 'Online';

	/// en: 'Unknown/Offline'
	String get unknownOffline => 'Unknown/Offline';

	/// en: 'Open Nostr Profile'
	String get openNostrProfile => 'Open Nostr Profile';

	/// en: 'Enable'
	String get enable => 'Enable';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Add custom coordinator'
	String get addCustomWhitelist => 'Add custom coordinator';

	/// en: 'npub1...'
	String get addCustomWhitelistHint => 'npub1...';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Coordinator disabled'
	String get coordinatorDisabled => 'Coordinator disabled';

	/// en: 'Coordinator enabled'
	String get coordinatorEnabled => 'Coordinator enabled';

	/// en: 'Coordinator added to custom whitelist'
	String get coordinatorAdded => 'Coordinator added to custom whitelist';

	/// en: 'Coordinator removed from custom whitelist'
	String get coordinatorRemoved => 'Coordinator removed from custom whitelist';

	/// en: 'No coordinator info found on relays. Coordinator not added.'
	String get coordinatorAddInfoUnavailable => 'No coordinator info found on relays. Coordinator not added.';

	/// en: 'Please enter an npub'
	String get pleaseEnterNpub => 'Please enter an npub';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Your offers'
	String get metricYourOffers => 'Your offers';

	/// en: 'Number of offers you have successfully completed with this coordinator.'
	String get metricYourOffersTooltip => 'Number of offers you have successfully completed with this coordinator.';

	/// en: 'Offers (30d)'
	String get metricNetworkOffers => 'Offers (30d)';

	/// en: 'Successful offers settled by this coordinator across all users in the last 30 days.'
	String get metricNetworkOffersTooltip => 'Successful offers settled by this coordinator across all users in the last 30 days.';
}

// Path: maker.roleSelection
class Translations$maker$roleSelection$en {
	Translations$maker$roleSelection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'PAY with Lightning'
	String get button => 'PAY with Lightning';
}

// Path: maker.amountForm
class Translations$maker$amountForm$en {
	Translations$maker$amountForm$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$maker$amountForm$progress$en progress = Translations$maker$amountForm$progress$en.internal(_root);
	late final Translations$maker$amountForm$labels$en labels = Translations$maker$amountForm$labels$en.internal(_root);
	late final Translations$maker$amountForm$actions$en actions = Translations$maker$amountForm$actions$en.internal(_root);
	late final Translations$maker$amountForm$tooltips$en tooltips = Translations$maker$amountForm$tooltips$en.internal(_root);
	late final Translations$maker$amountForm$category$en category = Translations$maker$amountForm$category$en.internal(_root);
	late final Translations$maker$amountForm$onboarding$en onboarding = Translations$maker$amountForm$onboarding$en.internal(_root);
	late final Translations$maker$amountForm$errors$en errors = Translations$maker$amountForm$errors$en.internal(_root);
}

// Path: maker.payInvoice
class Translations$maker$payInvoice$en {
	Translations$maker$payInvoice$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pay this Hold invoice:'
	String get title => 'Pay this Hold invoice:';

	late final Translations$maker$payInvoice$actions$en actions = Translations$maker$payInvoice$actions$en.internal(_root);
	late final Translations$maker$payInvoice$feedback$en feedback = Translations$maker$payInvoice$feedback$en.internal(_root);
	late final Translations$maker$payInvoice$errors$en errors = Translations$maker$payInvoice$errors$en.internal(_root);
	late final Translations$maker$payInvoice$budgetWarning$en budgetWarning = Translations$maker$payInvoice$budgetWarning$en.internal(_root);
}

// Path: maker.waitTaker
class Translations$maker$waitTaker$en {
	Translations$maker$waitTaker$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Waiting for a Taker to reserve your offer...'
	String get message => 'Waiting for a Taker to reserve your offer...';

	/// en: 'Waiting for taker: ${time}'
	String progressLabel({required Object time}) => 'Waiting for taker: ${time}';

	/// en: 'Error: Lost active offer details.'
	String get errorActiveOfferDetailsLost => 'Error: Lost active offer details.';

	/// en: 'Error: Failed to retrieve ${code} code.'
	String errorFailedToRetrieveBlik({required Object code}) => 'Error: Failed to retrieve ${code} code.';

	/// en: 'Error retrieving ${code} code: ${details}'
	String errorRetrievingBlik({required Object code, required Object details}) => 'Error retrieving ${code} code: ${details}';

	/// en: 'Offer is no longer available (Status: ${status}).'
	String offerNoLongerAvailable({required Object status}) => 'Offer is no longer available (Status: ${status}).';

	/// en: 'Error: Could not identify offer to cancel.'
	String get errorCouldNotIdentifyOffer => 'Error: Could not identify offer to cancel.';

	/// en: 'Offer cannot be cancelled in current state (${status}).'
	String offerCannotBeCancelled({required Object status}) => 'Offer cannot be cancelled in current state (${status}).';

	/// en: 'Offer cancelled successfully.'
	String get offerCancelledSuccessfully => 'Offer cancelled successfully.';

	/// en: 'Failed to cancel offer: ${details}'
	String failedToCancelOffer({required Object details}) => 'Failed to cancel offer: ${details}';

	/// en: 'Offer Expired'
	String get offerExpiredTitle => 'Offer Expired';

	/// en: 'No taker reserved your offer in time.'
	String get offerExpiredMessage => 'No taker reserved your offer in time.';

	/// en: 'New offer — same amount'
	String get recreateOffer => 'New offer — same amount';
}

// Path: maker.waitForBlik
class Translations$maker$waitForBlik$en {
	Translations$maker$waitForBlik$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Waiting for ${code}'
	String title({required Object code}) => 'Waiting for ${code}';

	/// en: 'Taker has reserved offer!'
	String get messageInfo => 'Taker has reserved offer!';

	/// en: 'Waiting to provide ${code} code...'
	String messageWaiting({required Object code}) => 'Waiting to provide ${code} code...';

	/// en: 'Reserved: ${seconds} s left'
	String progressLabel({required Object seconds}) => 'Reserved: ${seconds} s left';
}

// Path: maker.confirmPayment
class Translations$maker$confirmPayment$en {
	Translations$maker$confirmPayment$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${code} code received!'
	String title({required Object code}) => '${code} code received!';

	/// en: 'Retrieving ${code} code...'
	String retrieving({required Object code}) => 'Retrieving ${code} code...';

	/// en: 'Enter this code into the payment terminal. When Taker confirms in their banking app and payment is successful, press Confirm below.'
	String get instructions => 'Enter this code into the payment terminal. When Taker confirms in their banking app and payment is successful, press Confirm below.';

	/// en: 'Enter the code into the ${code} payment request.'
	String instruction1({required Object code}) => 'Enter the code into the ${code} payment request.';

	/// en: 'Wait until Taker confirms the payment in their app.'
	String get instruction2 => 'Wait until Taker confirms the payment in their app.';

	/// en: 'When payment is succesful, press Confirm below:'
	String get instruction3 => 'When payment is succesful, press Confirm below:';

	/// en: 'To withdraw ${amount} €, go to the nearest MULTIBANCO ATM, press the green key and choose the "Withdraw Cash" ("Levantar Dinheiro") option. Enter the code. This code is valid for ${minutes} minutes.'
	String mbwayAtmInstructions({required Object amount, required Object minutes}) => 'To withdraw ${amount} €, go to the nearest MULTIBANCO ATM, press the green key and choose the "Withdraw Cash" ("Levantar Dinheiro") option. Enter the code. This code is valid for ${minutes} minutes.';

	/// en: 'The taker has reported that the ${code} payment was charged from their bank account. If you mark this as invalid, this will cause a conflict.'
	String takerChargedWarning({required Object code}) => 'The taker has reported that the ${code} payment was charged from their bank account. If you mark this as invalid, this will cause a conflict.';

	/// en: 'Unless you mark the ${code} as invalid, the payment will be auto-confirmed and the taker paid when this timer runs out.'
	String autoConfirmInfo({required Object code}) => 'Unless you mark the ${code} as invalid, the payment will be auto-confirmed and the taker paid when this timer runs out.';

	/// en: 'Auto-confirm in ${time}'
	String autoConfirmCountdown({required Object time}) => 'Auto-confirm in ${time}';

	/// en: '${code} Code Expired'
	String expiredTitle({required Object code}) => '${code} Code Expired';

	/// en: 'The ${code} code has expired. You need to manually confirm the payment status:'
	String expiredWarning({required Object code}) => 'The ${code} code has expired. You need to manually confirm the payment status:';

	/// en: 'If the ${code} payment was successful and you completed your purchase, click "Confirm successful payment" below.'
	String expiredInstruction1({required Object code}) => 'If the ${code} payment was successful and you completed your purchase, click "Confirm successful payment" below.';

	/// en: 'If the ${code} payment failed or was not completed, click "Invalid ${code} Code" below.'
	String expiredInstruction2({required Object code}) => 'If the ${code} payment failed or was not completed, click "Invalid ${code} Code" below.';

	late final Translations$maker$confirmPayment$actions$en actions = Translations$maker$confirmPayment$actions$en.internal(_root);
	late final Translations$maker$confirmPayment$confirmDialog$en confirmDialog = Translations$maker$confirmPayment$confirmDialog$en.internal(_root);
	late final Translations$maker$confirmPayment$invalidBlikDisputeDialog$en invalidBlikDisputeDialog = Translations$maker$confirmPayment$invalidBlikDisputeDialog$en.internal(_root);
	late final Translations$maker$confirmPayment$feedback$en feedback = Translations$maker$confirmPayment$feedback$en.internal(_root);
	late final Translations$maker$confirmPayment$errors$en errors = Translations$maker$confirmPayment$errors$en.internal(_root);
}

// Path: maker.invalidBlik
class Translations$maker$invalidBlik$en {
	Translations$maker$invalidBlik$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid ${code} Code'
	String title({required Object code}) => 'Invalid ${code} Code';

	/// en: 'You marked the ${code} code as invalid. Waiting for taker to provide new code or start dispute.'
	String info({required Object code}) => 'You marked the ${code} code as invalid. Waiting for taker to provide new code or start dispute.';
}

// Path: maker.conflict
class Translations$maker$conflict$en {
	Translations$maker$conflict$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer Conflict'
	String get title => 'Offer Conflict';

	/// en: 'Offer Conflict Reported'
	String get headline => 'Offer Conflict Reported';

	/// en: 'You marked the ${code} code as invalid, but the Taker reported a conflict, indicating they believe the payment was successful.'
	String body({required Object code}) => 'You marked the ${code} code as invalid, but the Taker reported a conflict, indicating they believe the payment was successful.';

	/// en: 'Wait for the coordinator to review the situation. You may be asked for more details. Check back later or contact support if needed.'
	String get instructions => 'Wait for the coordinator to review the situation. You may be asked for more details. Check back later or contact support if needed.';

	late final Translations$maker$conflict$actions$en actions = Translations$maker$conflict$actions$en.internal(_root);
	late final Translations$maker$conflict$disputeDialog$en disputeDialog = Translations$maker$conflict$disputeDialog$en.internal(_root);
	late final Translations$maker$conflict$feedback$en feedback = Translations$maker$conflict$feedback$en.internal(_root);
	late final Translations$maker$conflict$errors$en errors = Translations$maker$conflict$errors$en.internal(_root);
	late final Translations$maker$conflict$nostrContact$en nostrContact = Translations$maker$conflict$nostrContact$en.internal(_root);
}

// Path: maker.success
class Translations$maker$success$en {
	Translations$maker$success$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer completed'
	String get title => 'Offer completed';

	/// en: 'Payment confirmed!'
	String get headline => 'Payment confirmed!';

	/// en: 'Taker will now be paid.'
	String get subtitle => 'Taker will now be paid.';

	/// en: 'Offer details:'
	String get detailsTitle => 'Offer details:';

	/// en: 'Offer took ${time}!'
	String duration({required Object time}) => 'Offer took ${time}!';
}

// Path: taker.roleSelection
class Translations$taker$roleSelection$en {
	Translations$taker$roleSelection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SELL ${code} code for satoshi'
	String button({required Object code}) => 'SELL ${code} code for satoshi';
}

// Path: taker.progress
class Translations$taker$progress$en {
	Translations$taker$progress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Submit ${code}'
	String step1({required Object code}) => 'Submit ${code}';

	/// en: 'Confirm ${code}'
	String step2({required Object code}) => 'Confirm ${code}';

	/// en: 'Get Paid'
	String get step3 => 'Get Paid';
}

// Path: taker.submitBlik
class Translations$taker$submitBlik$en {
	Translations$taker$submitBlik$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter ${digits}-digit ${code}'
	String title({required Object digits, required Object code}) => 'Enter ${digits}-digit ${code}';

	/// en: '${code} Code'
	String label({required Object code}) => '${code} Code';

	/// en: 'Enter ${code} before time ends...'
	String instruction({required Object code}) => 'Enter ${code} before time ends...';

	/// en: 'Enter ${code} within: ${seconds} s'
	String timeLimit({required Object code, required Object seconds}) => 'Enter ${code} within: ${seconds} s';

	/// en: 'Time to enter ${code} code has expired.'
	String timeExpired({required Object code}) => 'Time to enter ${code} code has expired.';

	late final Translations$taker$submitBlik$actions$en actions = Translations$taker$submitBlik$actions$en.internal(_root);
	late final Translations$taker$submitBlik$feedback$en feedback = Translations$taker$submitBlik$feedback$en.internal(_root);
	late final Translations$taker$submitBlik$validation$en validation = Translations$taker$submitBlik$validation$en.internal(_root);
	late final Translations$taker$submitBlik$errors$en errors = Translations$taker$submitBlik$errors$en.internal(_root);
	late final Translations$taker$submitBlik$details$en details = Translations$taker$submitBlik$details$en.internal(_root);
}

// Path: taker.waitConfirmation
class Translations$taker$waitConfirmation$en {
	Translations$taker$waitConfirmation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Waiting for Maker'
	String get title => 'Waiting for Maker';

	/// en: 'Offer status: ${status}'
	String statusLabel({required Object status}) => 'Offer status: ${status}';

	/// en: 'Waiting for Maker confirmation: ${seconds} s'
	String waitingMaker({required Object seconds}) => 'Waiting for Maker confirmation: ${seconds} s';

	/// en: 'Waiting for Maker to confirm ${code} is correct. Time remaining: ${seconds}s'
	String waitingMakerConfirmation({required Object code, required Object seconds}) => 'Waiting for Maker to confirm ${code} is correct. Time remaining: ${seconds}s';

	/// en: 'VERY IMPORTANT: Make sure you only accept ${code} confirmation for ${amount} ${currency}'
	String importantNotice({required Object code, required Object amount, required Object currency}) => 'VERY IMPORTANT: Make sure you only accept ${code} confirmation for ${amount} ${currency}';

	/// en: 'VERY IMPORTANT: In your banking app, ensure you are confirming a ${code} payment for exactly ${amount} ${currency}.'
	String importantBlikAmountConfirmation({required Object code, required Object amount, required Object currency}) => 'VERY IMPORTANT: In your banking app, ensure you are confirming a ${code} payment for exactly ${amount} ${currency}.';

	/// en: 'The maker must now enter it into the payment terminal within ${minutes} minutes. You then must accept the ${code} code in your banking app.'
	String instructions({required Object minutes, required Object code}) => 'The maker must now enter it into the payment terminal within ${minutes} minutes. You then must accept the ${code} code in your banking app.';

	/// en: 'The maker must now enter your ${code} code at the ATM within ${minutes} minutes.'
	String instructionsNoConfirm({required Object code, required Object minutes}) => 'The maker must now enter your ${code} code at the ATM within ${minutes} minutes.';

	late final Translations$taker$waitConfirmation$categoryReminder$en categoryReminder = Translations$taker$waitConfirmation$categoryReminder$en.internal(_root);

	/// en: 'Waiting for maker to receive your ${code} code...'
	String waitingForMakerToReceive({required Object code}) => 'Waiting for maker to receive your ${code} code...';

	/// en: 'Maker has received your ${code} code.'
	String makerReceivedBlik({required Object code}) => 'Maker has received your ${code} code.';

	/// en: '${code} ${minutes}m expiration time has passed. Waiting for maker to confirm or mark code as invalid.'
	String timerExpiredMessage({required Object code, required Object minutes}) => '${code} ${minutes}m expiration time has passed. Waiting for maker to confirm or mark code as invalid.';

	/// en: '${code} ${minutes}m expiration time has passed but the maker hasn't received the ${code} code. You can resend a new ${code} code or cancel.'
	String timerExpiredActions({required Object code, required Object minutes}) => '${code} ${minutes}m expiration time has passed but the maker hasn\'t received the ${code} code. You can resend a new ${code} code or cancel.';

	/// en: 'Resend New ${code} Code'
	String resendBlikButton({required Object code}) => 'Resend New ${code} Code';

	/// en: 'Navigated home.'
	String get navigatedHome => 'Navigated home.';

	/// en: '${code} Code Expired'
	String expiredTitle({required Object code}) => '${code} Code Expired';

	/// en: 'The maker did not receive the ${code} code so it couldn't have used it.'
	String expiredWarning({required Object code}) => 'The maker did not receive the ${code} code so it couldn\'t have used it.';

	/// en: 'Reservation ends in'
	String get expiredRelistCountdownLabel => 'Reservation ends in';

	/// en: 'The maker hasn't confirmed the payment yet. What would you like to do?'
	String get expiredSentWarning => 'The maker hasn\'t confirmed the payment yet. What would you like to do?';

	/// en: 'If you want to try again with a new ${code} code, renew the reservation.'
	String expiredInstruction1({required Object code}) => 'If you want to try again with a new ${code} code, renew the reservation.';

	/// en: 'If you no longer want to complete this transaction, cancel the reservation.'
	String get expiredInstruction2 => 'If you no longer want to complete this transaction, cancel the reservation.';

	/// en: 'If the ${code} payment was charged from your bank account, do not worry, the bitcoin is still safely locked with the coordinator.'
	String expiredInstruction3({required Object code}) => 'If the ${code} payment was charged from your bank account, do not worry, the bitcoin is still safely locked with the coordinator.';

	late final Translations$taker$waitConfirmation$takerCharged$en takerCharged = Translations$taker$waitConfirmation$takerCharged$en.internal(_root);
	late final Translations$taker$waitConfirmation$expiredActions$en expiredActions = Translations$taker$waitConfirmation$expiredActions$en.internal(_root);
	late final Translations$taker$waitConfirmation$feedback$en feedback = Translations$taker$waitConfirmation$feedback$en.internal(_root);
	late final Translations$taker$waitConfirmation$errors$en errors = Translations$taker$waitConfirmation$errors$en.internal(_root);
}

// Path: taker.paymentProcess
class Translations$taker$paymentProcess$en {
	Translations$taker$paymentProcess$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment Process'
	String get title => 'Payment Process';

	/// en: 'Waiting for offer status update...'
	String get waitingForOfferUpdate => 'Waiting for offer status update...';

	late final Translations$taker$paymentProcess$states$en states = Translations$taker$paymentProcess$states$en.internal(_root);
	late final Translations$taker$paymentProcess$steps$en steps = Translations$taker$paymentProcess$steps$en.internal(_root);
	late final Translations$taker$paymentProcess$errors$en errors = Translations$taker$paymentProcess$errors$en.internal(_root);
	late final Translations$taker$paymentProcess$loading$en loading = Translations$taker$paymentProcess$loading$en.internal(_root);
	late final Translations$taker$paymentProcess$actions$en actions = Translations$taker$paymentProcess$actions$en.internal(_root);
}

// Path: taker.paymentFailed
class Translations$taker$paymentFailed$en {
	Translations$taker$paymentFailed$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment Failed'
	String get title => 'Payment Failed';

	/// en: 'Please provide a new Lightning invoice for ${netAmount}'
	String instructions({required Object netAmount}) => 'Please provide a new Lightning invoice for ${netAmount}';

	late final Translations$taker$paymentFailed$form$en form = Translations$taker$paymentFailed$form$en.internal(_root);
	late final Translations$taker$paymentFailed$actions$en actions = Translations$taker$paymentFailed$actions$en.internal(_root);
	late final Translations$taker$paymentFailed$errors$en errors = Translations$taker$paymentFailed$errors$en.internal(_root);
	late final Translations$taker$paymentFailed$walletSection$en walletSection = Translations$taker$paymentFailed$walletSection$en.internal(_root);
	late final Translations$taker$paymentFailed$loading$en loading = Translations$taker$paymentFailed$loading$en.internal(_root);
	late final Translations$taker$paymentFailed$success$en success = Translations$taker$paymentFailed$success$en.internal(_root);
}

// Path: taker.paymentSuccess
class Translations$taker$paymentSuccess$en {
	Translations$taker$paymentSuccess$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment Successful'
	String get title => 'Payment Successful';

	/// en: 'Your payment has been processed successfully.'
	String get message => 'Your payment has been processed successfully.';

	late final Translations$taker$paymentSuccess$actions$en actions = Translations$taker$paymentSuccess$actions$en.internal(_root);
}

// Path: taker.invalidBlik
class Translations$taker$invalidBlik$en {
	Translations$taker$invalidBlik$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid ${code} Code'
	String title({required Object code}) => 'Invalid ${code} Code';

	/// en: 'Maker Rejected ${code} Code'
	String message({required Object code}) => 'Maker Rejected ${code} Code';

	/// en: 'The offer maker indicated that the ${code} code you provided was invalid or didn't work.\n\nWhat would you like to do?'
	String explanation({required Object code}) => 'The offer maker indicated that the ${code} code you provided was invalid or didn\'t work.\n\nWhat would you like to do?';

	/// en: 'If you were NOT charged:'
	String get werentCharged => 'If you were NOT charged:';

	/// en: 'If you were charged:'
	String get wereCharged => 'If you were charged:';

	late final Translations$taker$invalidBlik$actions$en actions = Translations$taker$invalidBlik$actions$en.internal(_root);
	late final Translations$taker$invalidBlik$confirmDialog$en confirmDialog = Translations$taker$invalidBlik$confirmDialog$en.internal(_root);
	late final Translations$taker$invalidBlik$disputeConfirmDialog$en disputeConfirmDialog = Translations$taker$invalidBlik$disputeConfirmDialog$en.internal(_root);
	late final Translations$taker$invalidBlik$feedback$en feedback = Translations$taker$invalidBlik$feedback$en.internal(_root);
	late final Translations$taker$invalidBlik$errors$en errors = Translations$taker$invalidBlik$errors$en.internal(_root);
}

// Path: taker.conflict
class Translations$taker$conflict$en {
	Translations$taker$conflict$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer Conflict'
	String get title => 'Offer Conflict';

	/// en: 'Offer Conflict Reported'
	String get headline => 'Offer Conflict Reported';

	/// en: 'The Maker marked the ${code} code as invalid, but you reported a conflict, indicating you believe the payment was successful.'
	String body({required Object code}) => 'The Maker marked the ${code} code as invalid, but you reported a conflict, indicating you believe the payment was successful.';

	/// en: 'Wait for the coordinator to review the situation. You may be asked for more details. Check back later or contact support if needed.'
	String get instructions => 'Wait for the coordinator to review the situation. You may be asked for more details. Check back later or contact support if needed.';

	late final Translations$taker$conflict$actions$en actions = Translations$taker$conflict$actions$en.internal(_root);
	late final Translations$taker$conflict$feedback$en feedback = Translations$taker$conflict$feedback$en.internal(_root);
	late final Translations$taker$conflict$errors$en errors = Translations$taker$conflict$errors$en.internal(_root);
	late final Translations$taker$conflict$nostrContact$en nostrContact = Translations$taker$conflict$nostrContact$en.internal(_root);
}

// Path: blik.instructions
class Translations$blik$instructions$en {
	Translations$blik$instructions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Once the Maker enters the ${code} code, you will need to confirm the payment in your banking app. Ensure the amount is correct before confirming.'
	String taker({required Object code}) => 'Once the Maker enters the ${code} code, you will need to confirm the payment in your banking app. Ensure the amount is correct before confirming.';
}

// Path: home.notifications
class Translations$home$notifications$en {
	Translations$home$notifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Get notified about new offers via:'
	String get title => 'Get notified about new offers via:';

	/// en: 'Telegram'
	String get telegram => 'Telegram';

	/// en: 'SimpleX'
	String get simplex => 'SimpleX';

	/// en: 'Matrix'
	String get matrix => 'Matrix';

	/// en: 'Signal'
	String get signal => 'Signal';
}

// Path: home.statistics
class Translations$home$statistics$en {
	Translations$home$statistics$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Finished Offers'
	String get title => 'Finished Offers';

	/// en: 'All: ${count} transactions Avg wait for ${code}: ${avgBlikTime} Avg completion time: ${avgPaidTime}'
	String lifetimeCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'All: ${count} transactions\nAvg wait for ${code}: ${avgBlikTime}\nAvg completion time: ${avgPaidTime}';

	/// en: 'Last 7d: ${count} transactions Avg wait for ${code}: ${avgBlikTime} Avg completion time: ${avgPaidTime}'
	String last7DaysCompact({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Last 7d: ${count} transactions\nAvg wait for ${code}: ${avgBlikTime}\nAvg completion time: ${avgPaidTime}';

	/// en: 'Last 7d: ${count} offers | Avg reserve: ${avgReservationTime} | Avg Paid: ${avgPaidTime}'
	String last7DaysSingleLine({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Last 7d: ${count} offers  |  Avg reserve: ${avgReservationTime}  |  Avg Paid: ${avgPaidTime}';

	late final Translations$home$statistics$errors$en errors = Translations$home$statistics$errors$en.internal(_root);
}

// Path: generateNewKey.buttons
class Translations$generateNewKey$buttons$en {
	Translations$generateNewKey$buttons$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Generate'
	String get generate => 'Generate';
}

// Path: generateNewKey.errors
class Translations$generateNewKey$errors$en {
	Translations$generateNewKey$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'You cannot generate a new Neko while you have an active offer.'
	String get activeOffer => 'You cannot generate a new Neko while you have an active offer.';

	/// en: 'Failed to generate new Neko'
	String get failed => 'Failed to generate new Neko';
}

// Path: generateNewKey.feedback
class Translations$generateNewKey$feedback$en {
	Translations$generateNewKey$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New Neko generated successfully!'
	String get success => 'New Neko generated successfully!';
}

// Path: generateNewKey.tooltips
class Translations$generateNewKey$tooltips$en {
	Translations$generateNewKey$tooltips$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Generate New Neko'
	String get generate => 'Generate New Neko';
}

// Path: backup.feedback
class Translations$backup$feedback$en {
	Translations$backup$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private key copied to clipboard!'
	String get copied => 'Private key copied to clipboard!';
}

// Path: backup.tooltips
class Translations$backup$tooltips$en {
	Translations$backup$tooltips$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Backup Neko'
	String get backup => 'Backup Neko';
}

// Path: restore.labels
class Translations$restore$labels$en {
	Translations$restore$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private Key'
	String get privateKey => 'Private Key';
}

// Path: restore.buttons
class Translations$restore$buttons$en {
	Translations$restore$buttons$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Restore'
	String get restore => 'Restore';
}

// Path: restore.errors
class Translations$restore$errors$en {
	Translations$restore$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Must be a 64-character hex string.'
	String get invalidKey => 'Must be a 64-character hex string.';

	/// en: 'Restore failed'
	String get failed => 'Restore failed';
}

// Path: restore.feedback
class Translations$restore$feedback$en {
	Translations$restore$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Neko restored successfully! App will restart.'
	String get success => 'Neko restored successfully! App will restart.';
}

// Path: restore.tooltips
class Translations$restore$tooltips$en {
	Translations$restore$tooltips$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Restore Neko'
	String get restore => 'Restore Neko';
}

// Path: system.errors
class Translations$system$errors$en {
	Translations$system$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'An unexpected error occurred. Please try again.'
	String get generic => 'An unexpected error occurred. Please try again.';

	/// en: 'Error loading timeout configuration.'
	String get loadingTimeoutConfig => 'Error loading timeout configuration.';

	/// en: 'Error loading coordinator configuration. Please try again.'
	String get loadingCoordinatorConfig => 'Error loading coordinator configuration. Please try again.';

	/// en: 'Your public key is not available. Cannot proceed.'
	String get noPublicKey => 'Your public key is not available. Cannot proceed.';

	/// en: 'Internal error: Offer details are incomplete. Please try again.'
	String get internalOfferIncomplete => 'Internal error: Offer details are incomplete. Please try again.';

	/// en: 'Error loading your public key. Please restart the app.'
	String get loadingPublicKey => 'Error loading your public key. Please restart the app.';
}

// Path: system.blik
class Translations$system$blik$en {
	Translations$system$blik$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${code} code copied to clipboard'
	String copied({required Object code}) => '${code} code copied to clipboard';
}

// Path: myOffers.filter
class Translations$myOffers$filter$en {
	Translations$myOffers$filter$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Failed'
	String get failed => 'Failed';
}

// Path: myOffers.details
class Translations$myOffers$details$en {
	Translations$myOffers$details$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer Details'
	String get title => 'Offer Details';

	/// en: 'Offer not found.'
	String get notFound => 'Offer not found.';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Fees'
	String get fees => 'Fees';

	/// en: 'Satoshis'
	String get sats => 'Satoshis';

	/// en: 'Maker'
	String get maker => 'Maker';

	/// en: 'Taker'
	String get taker => 'Taker';

	/// en: 'Your fee'
	String get yourFee => 'Your fee';

	/// en: 'Maker Fee'
	String get makerFee => 'Maker Fee';

	/// en: 'Taker Fee'
	String get takerFee => 'Taker Fee';

	/// en: 'Coordinator'
	String get coordinator => 'Coordinator';

	/// en: 'Created'
	String get createdAt => 'Created';

	/// en: 'Reserved'
	String get reservedAt => 'Reserved';

	/// en: '${code} Submitted'
	String blikReceivedAt({required Object code}) => '${code} Submitted';

	/// en: 'Confirmed'
	String get makerConfirmedAt => 'Confirmed';

	/// en: 'Settled'
	String get settledAt => 'Settled';

	/// en: 'Taker Paid'
	String get takerPaidAt => 'Taker Paid';

	/// en: 'Offer ID'
	String get id => 'Offer ID';

	/// en: 'Payment Hash'
	String get paymentHash => 'Payment Hash';

	/// en: 'Hold Invoice'
	String get holdInvoice => 'Hold Invoice';

	/// en: 'Continue active offer'
	String get continueActiveOffer => 'Continue active offer';

	/// en: 'after ${duration}'
	String after({required Object duration}) => 'after ${duration}';
}

// Path: landing.actions
class Translations$landing$actions$en {
	Translations$landing$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pay ${code}'
	String payBlik({required Object code}) => 'Pay ${code}';

	/// en: 'with bitcoin'
	String get payBlikSubtitle => 'with bitcoin';

	/// en: 'Buy bitcoin'
	String get sellBlik => 'Buy bitcoin';

	/// en: 'with ${code}'
	String sellBlikSubtitle({required Object code}) => 'with ${code}';

	/// en: 'How it works?'
	String get howItWorks => 'How it works?';
}

// Path: settings.offerCreation
class Translations$settings$offerCreation$en {
	Translations$settings$offerCreation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer creation'
	String get title => 'Offer creation';

	/// en: 'Default category'
	String get defaultCategory => 'Default category';

	/// en: 'Preferred coordinator'
	String get preferredCoordinator => 'Preferred coordinator';

	/// en: 'Most reliable'
	String get automaticCoordinator => 'Most reliable';

	/// en: 'Picks the coordinator with the best track record, combining your own completed offers and overall network activity.'
	String get automaticCoordinatorDescription => 'Picks the coordinator with the best track record, combining your own completed offers and overall network activity.';

	/// en: 'Cheapest'
	String get cheapestCoordinator => 'Cheapest';

	/// en: 'Picks the available coordinator with the lowest maker fee for each offer.'
	String get cheapestCoordinatorDescription => 'Picks the available coordinator with the lowest maker fee for each offer.';

	/// en: 'Enable premium pricing'
	String get enablePremium => 'Enable premium pricing';

	/// en: 'Show the premium slider when creating maker offers.'
	String get enablePremiumDescription => 'Show the premium slider when creating maker offers.';

	/// en: 'Default premium'
	String get defaultPremium => 'Default premium';

	/// en: 'Enable premium pricing to set a default premium.'
	String get defaultPremiumDisabled => 'Enable premium pricing to set a default premium.';

	/// en: 'Each coordinator sets its own maximum premium, so your default is capped by the coordinator used for an offer.'
	String get premiumPerCoordinatorNote => 'Each coordinator sets its own maximum premium, so your default is capped by the coordinator used for an offer.';

	late final Translations$settings$offerCreation$categoryOptions$en categoryOptions = Translations$settings$offerCreation$categoryOptions$en.internal(_root);
	late final Translations$settings$offerCreation$dialogs$en dialogs = Translations$settings$offerCreation$dialogs$en.internal(_root);
}

// Path: settings.display
class Translations$settings$display$en {
	Translations$settings$display$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Display'
	String get title => 'Display';

	/// en: 'Bitcoin unit'
	String get bitcoinUnit => 'Bitcoin unit';

	/// en: 'Choose how bitcoin amounts are shown throughout the app.'
	String get bitcoinUnitDescription => 'Choose how bitcoin amounts are shown throughout the app.';

	late final Translations$settings$display$unitOptions$en unitOptions = Translations$settings$display$unitOptions$en.internal(_root);
}

// Path: settings.paymentSystem
class Translations$settings$paymentSystem$en {
	Translations$settings$paymentSystem$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Country / Payment System'
	String get title => 'Country / Payment System';

	/// en: 'Choose your country's payment system.'
	String get subtitle => 'Choose your country\'s payment system.';

	/// en: 'Select payment system'
	String get dialogTitle => 'Select payment system';

	late final Translations$settings$paymentSystem$countries$en countries = Translations$settings$paymentSystem$countries$en.internal(_root);
}

// Path: notificationSettings.newOfferAlerts
class Translations$notificationSettings$newOfferAlerts$en {
	Translations$notificationSettings$newOfferAlerts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New offer alerts'
	String get label => 'New offer alerts';

	/// en: 'When enabled, ${app} will notify you about new offers available to take from your enabled coordinators while the app is in the background. This may be faster than external messengers.'
	String description({required Object app}) => 'When enabled, ${app} will notify you about new offers available to take from your enabled coordinators while the app is in the background. This may be faster than external messengers.';
}

// Path: wallet.missingReceiving
class Translations$wallet$missingReceiving$en {
	Translations$wallet$missingReceiving$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Receiving wallet required'
	String get title => 'Receiving wallet required';

	/// en: 'No wallet configured for receiving. Add one in Wallet settings to take offers.'
	String get message => 'No wallet configured for receiving. Add one in Wallet settings to take offers.';

	/// en: 'Wallet settings'
	String get openSettings => 'Wallet settings';
}

// Path: wallet.details
class Translations$wallet$details$en {
	Translations$wallet$details$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Wallet details'
	String get title => 'Wallet details';

	/// en: 'Pending transactions'
	String get pendingTitle => 'Pending transactions';

	/// en: 'Finished transactions'
	String get finishedTitle => 'Finished transactions';
}

// Path: nwc.labels
class Translations$nwc$labels$en {
	Translations$nwc$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'NWC Connection String'
	String get connectionString => 'NWC Connection String';

	/// en: 'nostr+walletconnect://...'
	String get hint => 'nostr+walletconnect://...';

	/// en: 'Connection Status'
	String get status => 'Connection Status';

	/// en: 'Connected'
	String get connected => 'Connected';

	/// en: 'Disconnected'
	String get disconnected => 'Disconnected';

	/// en: 'Scan QR code with your NWC connection'
	String get scanQrCode => 'Scan QR code with your NWC connection';

	/// en: 'Balance'
	String get balance => 'Balance';

	/// en: 'Budget'
	String get budget => 'Budget';

	/// en: 'Used'
	String get usedBudget => 'Used';

	/// en: 'Total'
	String get totalBudget => 'Total';

	/// en: 'Renews in'
	String get renewsIn => 'Renews in';

	/// en: 'Renewal Period'
	String get renewalPeriod => 'Renewal Period';

	/// en: 'Relay'
	String get relay => 'Relay';

	/// en: 'Relays'
	String get relays => 'Relays';
}

// Path: nwc.prompts
class Translations$nwc$prompts$en {
	Translations$nwc$prompts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter your NWC connection string'
	String get enter => 'Enter your NWC connection string';

	/// en: 'Connect Wallet'
	String get connect => 'Connect Wallet';

	/// en: 'Disconnect'
	String get disconnect => 'Disconnect';

	/// en: 'Are you sure you want to disconnect your NWC wallet?'
	String get confirmDisconnect => 'Are you sure you want to disconnect your NWC wallet?';

	/// en: 'Paste connection string'
	String get pasteConnection => 'Paste connection string';

	/// en: 'Choose how to connect your Lightning wallet'
	String get chooseMethod => 'Choose how to connect your Lightning wallet';

	/// en: 'Don't have an NWC connection yet? Learn how to get one!'
	String get howToGet => 'Don\'t have an NWC connection yet? Learn how to get one!';

	/// en: 'Learn more about NWC'
	String get learnMore => 'Learn more about NWC';
}

// Path: nwc.actions
class Translations$nwc$actions$en {
	Translations$nwc$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connect with Alby Go'
	String get connectAlbyGo => 'Connect with Alby Go';

	/// en: 'Scan NWC QR Code'
	String get connectNwc => 'Scan NWC QR Code';
}

// Path: nwc.feedback
class Translations$nwc$feedback$en {
	Translations$nwc$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'NWC wallet connected successfully!'
	String get connected => 'NWC wallet connected successfully!';

	/// en: 'NWC wallet disconnected'
	String get disconnected => 'NWC wallet disconnected';

	/// en: 'Connecting to NWC wallet...'
	String get connecting => 'Connecting to NWC wallet...';

	/// en: 'Loading wallet information...'
	String get loadingWalletInfo => 'Loading wallet information...';
}

// Path: nwc.errors
class Translations$nwc$errors$en {
	Translations$nwc$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error connecting to NWC: ${details}'
	String connecting({required Object details}) => 'Error connecting to NWC: ${details}';

	/// en: 'Error disconnecting NWC: ${details}'
	String disconnecting({required Object details}) => 'Error disconnecting NWC: ${details}';

	/// en: 'Invalid NWC connection string'
	String get invalid => 'Invalid NWC connection string';

	/// en: 'NWC connection string is required'
	String get required => 'NWC connection string is required';

	/// en: 'Failed to load wallet balance'
	String get loadingBalance => 'Failed to load wallet balance';

	/// en: 'Failed to load wallet budget'
	String get loadingBudget => 'Failed to load wallet budget';
}

// Path: nwc.time
class Translations$nwc$time$en {
	Translations$nwc$time$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${count}m'
	String minutes({required Object count}) => '${count}m';

	/// en: '${count}h'
	String hours({required Object count}) => '${count}h';

	/// en: '${count}d'
	String days({required Object count}) => '${count}d';

	/// en: 'just now'
	String get justNow => 'just now';
}

// Path: relays.status
class Translations$relays$status$en {
	Translations$relays$status$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connected'
	String get connected => 'Connected';

	/// en: 'Connecting'
	String get connecting => 'Connecting';

	/// en: 'Reconnecting'
	String get reconnecting => 'Reconnecting';

	/// en: 'Disconnected'
	String get disconnected => 'Disconnected';
}

// Path: relays.popup
class Translations$relays$popup$en {
	Translations$relays$popup$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Relays (${connected}/${total} connected)'
	String title({required Object connected, required Object total}) => 'Relays (${connected}/${total} connected)';

	/// en: 'Connecting to relays...'
	String get connectingMessage => 'Connecting to relays...';
}

// Path: offerNotifications.activeService
class Translations$offerNotifications$activeService$en {
	Translations$offerNotifications$activeService$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Waiting for new offers'
	String get title => 'Waiting for new offers';

	/// en: 'Nostr service monitoring events of ${app} offers.'
	String body({required Object app}) => 'Nostr service monitoring events of ${app} offers.';
}

// Path: offerNotifications.funded
class Translations$offerNotifications$funded$en {
	Translations$offerNotifications$funded$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer funded'
	String get title => 'Offer funded';

	/// en: 'Your hold invoice was accepted. Offer is now live.'
	String get body => 'Your hold invoice was accepted. Offer is now live.';
}

// Path: offerNotifications.reserved
class Translations$offerNotifications$reserved$en {
	Translations$offerNotifications$reserved$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer reserved'
	String get title => 'Offer reserved';

	/// en: 'A taker has reserved your offer.'
	String get body => 'A taker has reserved your offer.';
}

// Path: offerNotifications.blikReady
class Translations$offerNotifications$blikReady$en {
	Translations$offerNotifications$blikReady$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${code} code ready'
	String title({required Object code}) => '${code} code ready';

	/// en: 'Your ${code} code is ready to view.'
	String body({required Object code}) => 'Your ${code} code is ready to view.';
}

// Path: offerNotifications.newOffer
class Translations$offerNotifications$newOffer$en {
	Translations$offerNotifications$newOffer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New offer available'
	String get title => 'New offer available';

	/// en: '${amount} ${currency} · ${sats}'
	String body({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}';

	/// en: '+${percent}% premium'
	String premiumSuffix({required Object percent}) => '+${percent}% premium';
}

// Path: offerNotifications.categories
class Translations$offerNotifications$categories$en {
	Translations$offerNotifications$categories$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shop'
	String get shop => 'Shop';

	/// en: 'ATM'
	String get atm => 'ATM';

	/// en: 'Online'
	String get online => 'Online';
}

// Path: offerNotifications.blikPendingReminder
class Translations$offerNotifications$blikPendingReminder$en {
	Translations$offerNotifications$blikPendingReminder$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${code} waiting for your action'
	String title({required Object code}) => '${code} waiting for your action';

	/// en: 'Confirm the payment or mark the ${code} code as invalid.'
	String body({required Object code}) => 'Confirm the payment or mark the ${code} code as invalid.';
}

// Path: offerNotifications.takerCharged
class Translations$offerNotifications$takerCharged$en {
	Translations$offerNotifications$takerCharged$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${code} charged'
	String title({required Object code}) => '${code} charged';

	/// en: 'Taker reports ${code} was charged. Confirm or mark as invalid.'
	String body({required Object code}) => 'Taker reports ${code} was charged. Confirm or mark as invalid.';
}

// Path: offerNotifications.invalidBlik
class Translations$offerNotifications$invalidBlik$en {
	Translations$offerNotifications$invalidBlik$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${code} marked invalid'
	String title({required Object code}) => '${code} marked invalid';

	/// en: 'Maker marked your ${code} code as invalid.'
	String body({required Object code}) => 'Maker marked your ${code} code as invalid.';
}

// Path: offerNotifications.takerPaid
class Translations$offerNotifications$takerPaid$en {
	Translations$offerNotifications$takerPaid$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment received'
	String get title => 'Payment received';

	/// en: 'Your Lightning payment has been sent.'
	String get body => 'Your Lightning payment has been sent.';
}

// Path: offers.details.categories
class Translations$offers$details$categories$en {
	Translations$offers$details$categories$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shop, café or restaurant'
	String get physicalShop => 'Shop, café or restaurant';

	/// en: 'ATM cash out'
	String get atmCashout => 'ATM cash out';

	/// en: 'Online service/product'
	String get onlineService => 'Online service/product';
}

// Path: offers.details.consents
class Translations$offers$details$consents$en {
	Translations$offers$details$consents$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Some ATMs add an extra fee on top of the offer amount. By taking this offer, you accept any additional bank charges required by the ATM.'
	String get atm => 'Some ATMs add an extra fee on top of the offer amount. By taking this offer, you accept any additional bank charges required by the ATM.';

	/// en: 'For various reasons — such as an out-of-stock item, overpayment correction, or other merchant-side issues — the online merchant may automatically send money back to the bank account linked to the ${code} you generated. Those funds land in your account and are not yours to keep. If this happens, contact the coordinator in good faith and arrange to return the funds to the maker. By taking this offer you accept these terms and honorably swear to act honestly in such situations.'
	String ecommerce({required Object code}) => 'For various reasons — such as an out-of-stock item, overpayment correction, or other merchant-side issues — the online merchant may automatically send money back to the bank account linked to the ${code} you generated. Those funds land in your account and are not yours to keep. If this happens, contact the coordinator in good faith and arrange to return the funds to the maker. By taking this offer you accept these terms and honorably swear to act honestly in such situations.';
}

// Path: coordinator.coldStart.phases
class Translations$coordinator$coldStart$phases$en {
	Translations$coordinator$coldStart$phases$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading coordinator filters'
	String get loadingMuteList => 'Loading coordinator filters';

	/// en: 'Discovering coordinators on Nostr'
	String get discovering => 'Discovering coordinators on Nostr';

	/// en: 'Loading coordinator profiles'
	String get loadingProfiles => 'Loading coordinator profiles';

	/// en: 'Reading coordinator history'
	String get loadingStats => 'Reading coordinator history';

	/// en: 'Checking coordinator health'
	String get checkingHealth => 'Checking coordinator health';

	/// en: 'Enabling default coordinators'
	String get finalizing => 'Enabling default coordinators';

	/// en: 'Done'
	String get completed => 'Done';
}

// Path: maker.amountForm.progress
class Translations$maker$amountForm$progress$en {
	Translations$maker$amountForm$progress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '1. Create Offer'
	String get step1 => '1. Create Offer';

	/// en: '2. Wait for Taker'
	String get step2 => '2. Wait for Taker';

	/// en: '3. Use ${code}'
	String step3({required Object code}) => '3. Use ${code}';
}

// Path: maker.amountForm.labels
class Translations$maker$amountForm$labels$en {
	Translations$maker$amountForm$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinator'
	String get coordinator => 'Coordinator';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Exchange Rate'
	String get exchangeRate => 'Exchange Rate';

	/// en: 'Fee'
	String get fee => 'Fee';

	/// en: 'Amount to Pay'
	String get satoshisToPay => 'Amount to Pay';

	/// en: 'Enter amount'
	String get enterAmount => 'Enter amount';

	/// en: 'Custom'
	String get customAmount => 'Custom';

	/// en: 'Tap to select'
	String get tapToSelect => 'Tap to select';

	/// en: 'Premium'
	String get premium => 'Premium';
}

// Path: maker.amountForm.actions
class Translations$maker$amountForm$actions$en {
	Translations$maker$amountForm$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Generate Invoice'
	String get generateInvoice => 'Generate Invoice';
}

// Path: maker.amountForm.tooltips
class Translations$maker$amountForm$tooltips$en {
	Translations$maker$amountForm$tooltips$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinator charges a ${feePercent}% maker fee. This fee is deducted from your Lightning payment.'
	String feeInfo({required Object feePercent}) => 'Coordinator charges a ${feePercent}% maker fee. This fee is deducted from your Lightning payment.';

	/// en: 'This calculation is based on client-side fetched exchange rates. The coordinator will calculate the exact amount, and the invoice amount will be the final and exact amount to pay.'
	String get payInfo => 'This calculation is based on client-side fetched exchange rates. The coordinator will calculate the exact amount, and the invoice amount will be the final and exact amount to pay.';

	/// en: 'An optional premium lets you sell your sats above market price. The premium reduces the sats locked in your hold invoice for the same fiat amount, so the taker pays above market and you keep the difference. Default is off (0%). The maximum premium is set by the selected coordinator.'
	String get premiumInfo => 'An optional premium lets you sell your sats above market price. The premium reduces the sats locked in your hold invoice for the same fiat amount, so the taker pays above market and you keep the difference. Default is off (0%). The maximum premium is set by the selected coordinator.';
}

// Path: maker.amountForm.category
class Translations$maker$amountForm$category$en {
	Translations$maker$amountForm$category$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer category'
	String get label => 'Offer category';

	/// en: '${system} does not support this category.'
	String unsupportedForSystem({required Object system}) => '${system} does not support this category.';

	late final Translations$maker$amountForm$category$options$en options = Translations$maker$amountForm$category$options$en.internal(_root);
	late final Translations$maker$amountForm$category$shortLabels$en shortLabels = Translations$maker$amountForm$category$shortLabels$en.internal(_root);

	/// en: 'Takers will see that this offer is for ATM cash out and may avoid it if their bank charges extra ATM fees.'
	String get atmHint => 'Takers will see that this offer is for ATM cash out and may avoid it if their bank charges extra ATM fees.';

	/// en: 'The ideal place to use ${app} is a self-checkout terminal — since waiting for a taker to reserve, generate and confirm a ${code} code might take a couple of minutes. Works great at shops, cafes, and restaurants alike. If you're feeling brave enough to make a regular cashier (and the people queued behind you) wait those couple of minutes, good for you.'
	String physicalShopHint({required Object app, required Object code}) => 'The ideal place to use ${app} is a self-checkout terminal — since waiting for a taker to reserve, generate and confirm a ${code} code might take a couple of minutes. Works great at shops, cafes, and restaurants alike. If you\'re feeling brave enough to make a regular cashier (and the people queued behind you) wait those couple of minutes, good for you.';

	/// en: 'Online merchant refund risk'
	String get ecommerceWarningTitle => 'Online merchant refund risk';

	/// en: 'For various reasons — such as an out-of-stock item, overpayment correction, or other merchant-side issues — the online merchant may automatically issue a refund back to the bank account linked to the ${code}, which is the taker's account. The coordinator cannot force the taker to return those funds to you.'
	String ecommerceWarningBody({required Object code}) => 'For various reasons — such as an out-of-stock item, overpayment correction, or other merchant-side issues — the online merchant may automatically issue a refund back to the bank account linked to the ${code}, which is the taker\'s account. The coordinator cannot force the taker to return those funds to you.';

	/// en: 'I understand the refund risk and will add a note to the order instructing the merchant to refund a different account if a refund becomes necessary.'
	String get ecommerceConfirmation => 'I understand the refund risk and will add a note to the order instructing the merchant to refund a different account if a refund becomes necessary.';

	/// en: 'why this is needed?'
	String get whyThisIsNeeded => 'why this is needed?';
}

// Path: maker.amountForm.onboarding
class Translations$maker$amountForm$onboarding$en {
	Translations$maker$amountForm$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New'
	String get titlePrefix => 'New';

	/// en: 'Choose the offer category'
	String get title => 'Choose the offer category';

	/// en: 'Pick the category that best matches what you are paying for before generating the invoice.'
	String get body => 'Pick the category that best matches what you are paying for before generating the invoice.';

	/// en: 'Why does this matter?'
	String get showWhy => 'Why does this matter?';

	/// en: 'Hide details'
	String get hideWhy => 'Hide details';

	/// en: 'Choosing the right category helps takers decide safely'
	String get whyTitle => 'Choosing the right category helps takers decide safely';

	/// en: 'Different situations carry different expectations and risks. ATM cash outs may include extra bank fees, and online purchases can involve refund edge cases. Marking the right category gives takers the context they need before accepting your offer.'
	String get whyBody => 'Different situations carry different expectations and risks. ATM cash outs may include extra bank fees, and online purchases can involve refund edge cases. Marking the right category gives takers the context they need before accepting your offer.';

	/// en: 'Got it'
	String get cta => 'Got it';
}

// Path: maker.amountForm.errors
class Translations$maker$amountForm$errors$en {
	Translations$maker$amountForm$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error initiating offer: ${details}'
	String initiating({required Object details}) => 'Error initiating offer: ${details}';

	/// en: 'Error: Public key not yet loaded.'
	String get publicKeyNotLoaded => 'Error: Public key not yet loaded.';

	/// en: 'No coordinator supports this amount. Try a different value.'
	String get noCoordinatorMatchesAmount => 'No coordinator supports this amount. Try a different value.';

	/// en: 'Select an offer category.'
	String get categoryRequired => 'Select an offer category.';

	/// en: 'Confirm the online merchant refund risk before continuing.'
	String get ecommerceConfirmationRequired => 'Confirm the online merchant refund risk before continuing.';
}

// Path: maker.payInvoice.actions
class Translations$maker$payInvoice$actions$en {
	Translations$maker$payInvoice$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy Invoice'
	String get copy => 'Copy Invoice';

	/// en: 'Open in External Wallet'
	String get payInWallet => 'Open in External Wallet';

	/// en: 'Connect Wallet'
	String get connectWallet => 'Connect Wallet';

	/// en: 'Pay'
	String get payWithNwc => 'Pay';

	/// en: 'Paying...'
	String get paying => 'Paying...';
}

// Path: maker.payInvoice.feedback
class Translations$maker$payInvoice$feedback$en {
	Translations$maker$payInvoice$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invoice copied to clipboard!'
	String get copied => 'Invoice copied to clipboard!';

	/// en: 'Waiting for payment confirmation...'
	String get waitingConfirmation => 'Waiting for payment confirmation...';

	/// en: 'NWC wallet connected!'
	String get nwcConnected => 'NWC wallet connected!';

	/// en: 'Payment successful!'
	String get nwcPaymentSuccess => 'Payment successful!';
}

// Path: maker.payInvoice.errors
class Translations$maker$payInvoice$errors$en {
	Translations$maker$payInvoice$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Could not open Lightning app for invoice.'
	String get couldNotOpenApp => 'Could not open Lightning app for invoice.';

	/// en: 'Error opening Lightning app: ${details}'
	String openingApp({required Object details}) => 'Error opening Lightning app: ${details}';

	/// en: 'Public key is not available.'
	String get publicKeyNotAvailable => 'Public key is not available.';

	/// en: 'Could not fetch active offer details. It may have expired.'
	String get couldNotFetchActive => 'Could not fetch active offer details. It may have expired.';

	/// en: 'Payment failed: ${details}'
	String nwcPaymentFailed({required Object details}) => 'Payment failed: ${details}';

	/// en: 'NWC wallet not connected'
	String get nwcNotConnected => 'NWC wallet not connected';

	/// en: 'Insufficient balance. Need ${required} sats, have ${available} sats'
	String insufficientBalance({required Object required, required Object available}) => 'Insufficient balance. Need ${required} sats, have ${available} sats';

	/// en: 'Coordinator reports this offer is already funded. It cannot be cancelled now.'
	String get cancelOfferAlreadyFunded => 'Coordinator reports this offer is already funded. It cannot be cancelled now.';

	/// en: 'Could not cancel offer: ${details}'
	String cancelFailed({required Object details}) => 'Could not cancel offer: ${details}';
}

// Path: maker.payInvoice.budgetWarning
class Translations$maker$payInvoice$budgetWarning$en {
	Translations$maker$payInvoice$budgetWarning$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment may fail'
	String get title => 'Payment may fail';

	/// en: 'Your default spending wallet ${name} does not have enough balance for this payment.'
	String balanceTooLow({required Object name}) => 'Your default spending wallet ${name} does not have enough balance for this payment.';

	/// en: 'Your default spending wallet ${name} does not have enough spending budget for this payment.'
	String budgetTooLow({required Object name}) => 'Your default spending wallet ${name} does not have enough spending budget for this payment.';

	/// en: 'Balance: ${available}'
	String balanceLine({required Object available}) => 'Balance: ${available}';

	/// en: 'Remaining NWC budget: ${remaining}'
	String budgetLine({required Object remaining}) => 'Remaining NWC budget: ${remaining}';

	/// en: 'Required: ${required}'
	String requiredLine({required Object required}) => 'Required: ${required}';

	/// en: 'Add funds to ${name} to cover this payment amount.'
	String addFundsHint({required Object name}) => 'Add funds to ${name} to cover this payment amount.';

	/// en: 'Increase the NWC spending budget for this connection in your wallet app.'
	String get increaseBudgetHint => 'Increase the NWC spending budget for this connection in your wallet app.';

	/// en: 'Or use a different wallet:'
	String get switchWalletLabel => 'Or use a different wallet:';

	/// en: 'May fail'
	String get walletLowFundsTag => 'May fail';

	/// en: 'Try anyway'
	String get payAnyway => 'Try anyway';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Pay invoice'
	String get readyTitle => 'Pay invoice';
}

// Path: maker.confirmPayment.actions
class Translations$maker$confirmPayment$actions$en {
	Translations$maker$confirmPayment$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirm successful payment'
	String get confirm => 'Confirm successful payment';

	/// en: 'Invalid ${code} Code'
	String markInvalid({required Object code}) => 'Invalid ${code} Code';

	/// en: 'Copy ${code}'
	String copyBlik({required Object code}) => 'Copy ${code}';
}

// Path: maker.confirmPayment.confirmDialog
class Translations$maker$confirmPayment$confirmDialog$en {
	Translations$maker$confirmPayment$confirmDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirm Payment?'
	String get title => 'Confirm Payment?';

	/// en: 'This action is irreversible. After confirming: • The Taker will receive the funds immediately • The coordinator will not be able to dispute the funds • You cannot undo this action Only confirm if the ${code} payment was successful.'
	String content({required Object code}) => 'This action is irreversible. After confirming:\n\n• The Taker will receive the funds immediately\n• The coordinator will not be able to dispute the funds\n• You cannot undo this action\n\nOnly confirm if the ${code} payment was successful.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Yes, Confirm Payment'
	String get confirmButton => 'Yes, Confirm Payment';
}

// Path: maker.confirmPayment.invalidBlikDisputeDialog
class Translations$maker$confirmPayment$invalidBlikDisputeDialog$en {
	Translations$maker$confirmPayment$invalidBlikDisputeDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open Dispute?'
	String get title => 'Open Dispute?';

	/// en: 'The taker has reported that the ${code} payment was charged from their account. Marking this as invalid will immediately open a DISPUTE that requires coordinator intervention. • A dispute fee may be charged if ruled against you • The hold invoice will be settled immediately • Manual verification will be required Only proceed if you are certain the ${code} payment did NOT succeed.'
	String content({required Object code}) => 'The taker has reported that the ${code} payment was charged from their account.\n\nMarking this as invalid will immediately open a DISPUTE that requires coordinator intervention.\n\n• A dispute fee may be charged if ruled against you\n• The hold invoice will be settled immediately\n• Manual verification will be required\n\nOnly proceed if you are certain the ${code} payment did NOT succeed.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Yes, Open Dispute'
	String get confirmButton => 'Yes, Open Dispute';
}

// Path: maker.confirmPayment.feedback
class Translations$maker$confirmPayment$feedback$en {
	Translations$maker$confirmPayment$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Maker confirmed payment.'
	String get confirmed => 'Maker confirmed payment.';

	/// en: 'Payment confirmed! Taker will receive funds.'
	String get confirmedTakerPaid => 'Payment confirmed! Taker will receive funds.';

	/// en: 'Confirming: ${seconds} s left'
	String progressLabel({required Object seconds}) => 'Confirming: ${seconds} s left';
}

// Path: maker.confirmPayment.errors
class Translations$maker$confirmPayment$errors$en {
	Translations$maker$confirmPayment$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error: Failed to retrieve ${code} code.'
	String failedToRetrieve({required Object code}) => 'Error: Failed to retrieve ${code} code.';

	/// en: 'Error retrieving ${code} code: ${details}'
	String retrieving({required Object code, required Object details}) => 'Error retrieving ${code} code: ${details}';

	/// en: 'Error: Missing payment hash or public key.'
	String get missingHashOrKey => 'Error: Missing payment hash or public key.';

	/// en: 'Offer is not in correct state for confirmation (Status: ${status})'
	String incorrectState({required Object status}) => 'Offer is not in correct state for confirmation (Status: ${status})';

	/// en: 'Error confirming payment: ${details}'
	String confirming({required Object details}) => 'Error confirming payment: ${details}';

	/// en: 'Error: Received invalid offer state.'
	String get invalidState => 'Error: Received invalid offer state.';

	/// en: 'Internal error: Incomplete offer details.'
	String get internalIncomplete => 'Internal error: Incomplete offer details.';

	/// en: 'Offer is no longer awaiting confirmation (Status: ${status}).'
	String notAwaitingConfirmation({required Object status}) => 'Offer is no longer awaiting confirmation (Status: ${status}).';

	/// en: 'Received unexpected offer status from server.'
	String get unexpectedStatus => 'Received unexpected offer status from server.';
}

// Path: maker.conflict.actions
class Translations$maker$conflict$actions$en {
	Translations$maker$conflict$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Back to Home'
	String get back => 'Back to Home';

	/// en: 'My mistake, confirm ${code} payment success'
	String confirmPayment({required Object code}) => 'My mistake, confirm ${code} payment success';

	/// en: '${code} payment did NOT succeed, OPEN DISPUTE'
	String openDispute({required Object code}) => '${code} payment did NOT succeed, OPEN DISPUTE';

	/// en: 'Submit Dispute'
	String get submitDispute => 'Submit Dispute';
}

// Path: maker.conflict.disputeDialog
class Translations$maker$conflict$disputeDialog$en {
	Translations$maker$conflict$disputeDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open dispute?'
	String get title => 'Open dispute?';

	/// en: 'Opening a dispute requires manual verification by the coordinator, which will take time. A dispute fee will be deducted if the dispute is ruled against you. The hold invoice will be settled to prevent it from expiring. If the dispute is ruled in your favor, you will receive a refund (minus fees) to a wallet of your choice.'
	String get content => 'Opening a dispute requires manual verification by the coordinator, which will take time. A dispute fee will be deducted if the dispute is ruled against you. The hold invoice will be settled to prevent it from expiring. If the dispute is ruled in your favor, you will receive a refund (minus fees) to a wallet of your choice.';

	/// en: 'Opening a dispute will require manual coordinator intervention, which takes time and incurs a dispute fee. The hold invoice will be immediately settled to prevent it from expiring before the dispute is resolved. If the dispute is ruled in your favor, the satoshi amount will be refunded to a wallet of your choice (minus fees). Make sure you have a wallet ready to receive.'
	String get contentDetailed => 'Opening a dispute will require manual coordinator intervention, which takes time and incurs a dispute fee.\n\nThe hold invoice will be immediately settled to prevent it from expiring before the dispute is resolved.\n\nIf the dispute is ruled in your favor, the satoshi amount will be refunded to a wallet of your choice (minus fees). Make sure you have a wallet ready to receive.';

	late final Translations$maker$conflict$disputeDialog$actions$en actions = Translations$maker$conflict$disputeDialog$actions$en.internal(_root);
}

// Path: maker.conflict.feedback
class Translations$maker$conflict$feedback$en {
	Translations$maker$conflict$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Dispute successfully opened. Coordinator will review.'
	String get disputeOpenedSuccess => 'Dispute successfully opened. Coordinator will review.';
}

// Path: maker.conflict.errors
class Translations$maker$conflict$errors$en {
	Translations$maker$conflict$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error opening dispute: ${error}'
	String openingDispute({required Object error}) => 'Error opening dispute: ${error}';
}

// Path: maker.conflict.nostrContact
class Translations$maker$conflict$nostrContact$en {
	Translations$maker$conflict$nostrContact$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Contact Coordinator on Nostr'
	String get title => 'Contact Coordinator on Nostr';

	/// en: 'You can DM the coordinator directly for help with this dispute.'
	String get description => 'You can DM the coordinator directly for help with this dispute.';

	/// en: 'Copy npub'
	String get copyNpub => 'Copy npub';

	/// en: 'View Profile'
	String get openProfile => 'View Profile';

	/// en: 'Coordinator npub copied to clipboard!'
	String get npubCopied => 'Coordinator npub copied to clipboard!';

	/// en: 'To send DMs, login with your Neko private key (nsec) in any Nostr client that supports direct messages.'
	String get yourIdentityDescription => 'To send DMs, login with your Neko private key (nsec) in any Nostr client that supports direct messages.';

	/// en: 'Manage Neko Keys'
	String get manageNekoKeys => 'Manage Neko Keys';
}

// Path: taker.submitBlik.actions
class Translations$taker$submitBlik$actions$en {
	Translations$taker$submitBlik$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Submit ${code}'
	String submit({required Object code}) => 'Submit ${code}';
}

// Path: taker.submitBlik.feedback
class Translations$taker$submitBlik$feedback$en {
	Translations$taker$submitBlik$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pasted ${code} code.'
	String pasted({required Object code}) => 'Pasted ${code} code.';
}

// Path: taker.submitBlik.validation
class Translations$taker$submitBlik$validation$en {
	Translations$taker$submitBlik$validation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter a valid ${digits}-digit ${code} code.'
	String invalidFormat({required Object digits, required Object code}) => 'Enter a valid ${digits}-digit ${code} code.';
}

// Path: taker.submitBlik.errors
class Translations$taker$submitBlik$errors$en {
	Translations$taker$submitBlik$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error submitting ${code} code: ${details}'
	String submitting({required Object code, required Object details}) => 'Error submitting ${code} code: ${details}';

	/// en: 'Clipboard does not contain a valid ${digits}-digit ${code} code.'
	String clipboardInvalid({required Object digits, required Object code}) => 'Clipboard does not contain a valid ${digits}-digit ${code} code.';

	/// en: 'Error: Offer state has changed.'
	String get stateChanged => 'Error: Offer state has changed.';

	/// en: 'Error: Offer state is no longer valid.'
	String get stateNotValid => 'Error: Offer state is no longer valid.';

	/// en: 'Fetched active offer ID (${fetchedId}) does not match initial offer ID (${initialId}). State mismatch?'
	String fetchedIdMismatch({required Object fetchedId, required Object initialId}) => 'Fetched active offer ID (${fetchedId}) does not match initial offer ID (${initialId}). State mismatch?';

	/// en: 'Offer payment hash missing after fetch.'
	String get paymentHashMissing => 'Offer payment hash missing after fetch.';
}

// Path: taker.submitBlik.details
class Translations$taker$submitBlik$details$en {
	Translations$taker$submitBlik$details$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Requested ${code} amount'
	String requestedAmount({required Object code}) => 'Requested ${code} amount';

	/// en: 'Exchange Rate'
	String get exchangeRate => 'Exchange Rate';

	/// en: 'Taker fee'
	String get takerFee => 'Taker fee';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'You'll receive'
	String get youllReceive => 'You\'ll receive';
}

// Path: taker.waitConfirmation.categoryReminder
class Translations$taker$waitConfirmation$categoryReminder$en {
	Translations$taker$waitConfirmation$categoryReminder$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ATM offer reminder: your bank may still ask you to approve an extra ATM fee on top of the main amount.'
	String get atm => 'ATM offer reminder: your bank may still ask you to approve an extra ATM fee on top of the main amount.';

	/// en: 'Online order reminder: if the merchant sends an automatic refund to your bank account, contact the coordinator and return it.'
	String get ecommerce => 'Online order reminder: if the merchant sends an automatic refund to your bank account, contact the coordinator and return it.';
}

// Path: taker.waitConfirmation.takerCharged
class Translations$taker$waitConfirmation$takerCharged$en {
	Translations$taker$waitConfirmation$takerCharged$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'You marked ${code} as charged'
	String title({required Object code}) => 'You marked ${code} as charged';

	/// en: 'The maker has ${minutes}min to confirm the payment or dispute the payment. If they do nothing the payment will auto confirm and you will receive the bitcoin.'
	String message({required Object minutes}) => 'The maker has ${minutes}min to confirm the payment or dispute the payment. If they do nothing the payment will auto confirm and you will receive the bitcoin.';
}

// Path: taker.waitConfirmation.expiredActions
class Translations$taker$waitConfirmation$expiredActions$en {
	Translations$taker$waitConfirmation$expiredActions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${code} was charged from my bank account'
	String reportConflict({required Object code}) => '${code} was charged from my bank account';

	/// en: 'Try again with new ${code} code'
	String renewReservation({required Object code}) => 'Try again with new ${code} code';

	/// en: 'Cancel reservation'
	String get cancelReservation => 'Cancel reservation';
}

// Path: taker.waitConfirmation.feedback
class Translations$taker$waitConfirmation$feedback$en {
	Translations$taker$waitConfirmation$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Maker confirmed payment.'
	String get makerConfirmed => 'Maker confirmed payment.';

	/// en: 'Payment successful! You will receive funds shortly.'
	String get paymentSuccessful => 'Payment successful! You will receive funds shortly.';

	/// en: 'Conflict reported. Coordinator will review the situation.'
	String get conflictReported => 'Conflict reported. Coordinator will review the situation.';
}

// Path: taker.waitConfirmation.errors
class Translations$taker$waitConfirmation$errors$en {
	Translations$taker$waitConfirmation$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Received an offer with an invalid state for this screen. Resetting.'
	String get invalidOfferStateReceived => 'Received an offer with an invalid state for this screen. Resetting.';

	/// en: 'Error reporting conflict: ${details}'
	String reportingConflict({required Object details}) => 'Error reporting conflict: ${details}';
}

// Path: taker.paymentProcess.states
class Translations$taker$paymentProcess$states$en {
	Translations$taker$paymentProcess$states$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Preparing to send payment...'
	String get preparing => 'Preparing to send payment...';

	/// en: 'Sending payment...'
	String get sending => 'Sending payment...';

	/// en: 'Payment received!'
	String get received => 'Payment received!';

	/// en: 'Payment failed'
	String get failed => 'Payment failed';

	/// en: 'Waiting for offer update...'
	String get waitingUpdate => 'Waiting for offer update...';
}

// Path: taker.paymentProcess.steps
class Translations$taker$paymentProcess$steps$en {
	Translations$taker$paymentProcess$steps$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Maker confirmed ${code} payment'
	String makerConfirmedBlik({required Object code}) => 'Maker confirmed ${code} payment';

	/// en: 'Maker's hold invoice settled'
	String get makerInvoiceSettled => 'Maker\'s hold invoice settled';

	/// en: 'Paying your Lightning invoice'
	String get takerInvoicePaid => 'Paying your Lightning invoice';

	/// en: 'Payment to your invoice failed'
	String get takerPaymentFailed => 'Payment to your invoice failed';
}

// Path: taker.paymentProcess.errors
class Translations$taker$paymentProcess$errors$en {
	Translations$taker$paymentProcess$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error sending payment: ${details}'
	String sending({required Object details}) => 'Error sending payment: ${details}';

	/// en: 'Offer not confirmed by Maker.'
	String get notConfirmed => 'Offer not confirmed by Maker.';

	/// en: 'Offer expired.'
	String get expired => 'Offer expired.';

	/// en: 'Offer cancelled.'
	String get cancelled => 'Offer cancelled.';

	/// en: 'Offer payment failed.'
	String get paymentFailed => 'Offer payment failed.';

	/// en: 'Unknown offer error.'
	String get unknown => 'Unknown offer error.';

	/// en: 'The payment to your Lightning invoice failed.'
	String get takerPaymentFailed => 'The payment to your Lightning invoice failed.';

	/// en: 'Error: Cannot fetch your public key.'
	String get noPublicKey => 'Error: Cannot fetch your public key.';

	/// en: 'Error loading your data'
	String get loadingPublicKey => 'Error loading your data';

	/// en: 'Error: Missing payment details.'
	String get missingPaymentHash => 'Error: Missing payment details.';
}

// Path: taker.paymentProcess.loading
class Translations$taker$paymentProcess$loading$en {
	Translations$taker$paymentProcess$loading$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading your data...'
	String get publicKey => 'Loading your data...';
}

// Path: taker.paymentProcess.actions
class Translations$taker$paymentProcess$actions$en {
	Translations$taker$paymentProcess$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Retry with new invoice'
	String get goToFailureDetails => 'Retry with new invoice';
}

// Path: taker.paymentFailed.form
class Translations$taker$paymentFailed$form$en {
	Translations$taker$paymentFailed$form$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New Lightning invoice'
	String get newInvoiceLabel => 'New Lightning invoice';

	/// en: 'Enter your BOLT11 invoice'
	String get newInvoiceHint => 'Enter your BOLT11 invoice';
}

// Path: taker.paymentFailed.actions
class Translations$taker$paymentFailed$actions$en {
	Translations$taker$paymentFailed$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Submit New Invoice'
	String get retryPayment => 'Submit New Invoice';
}

// Path: taker.paymentFailed.errors
class Translations$taker$paymentFailed$errors$en {
	Translations$taker$paymentFailed$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please enter a valid invoice'
	String get enterValidInvoice => 'Please enter a valid invoice';

	/// en: 'Error updating invoice: ${details}'
	String updatingInvoice({required Object details}) => 'Error updating invoice: ${details}';

	/// en: 'Payment retry failed. Please check the invoice or try again later.'
	String get paymentRetryFailed => 'Payment retry failed. Please check the invoice or try again later.';

	/// en: 'Taker public key not found.'
	String get takerPublicKeyNotFound => 'Taker public key not found.';

	/// en: 'Failed to generate invoice: ${details}'
	String generateFailed({required Object details}) => 'Failed to generate invoice: ${details}';
}

// Path: taker.paymentFailed.walletSection
class Translations$taker$paymentFailed$walletSection$en {
	Translations$taker$paymentFailed$walletSection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Generate invoice from wallet'
	String get title => 'Generate invoice from wallet';

	/// en: 'default'
	String get defaultLabel => 'default';

	/// en: 'Tap to generate invoice for ${amountSats}'
	String tapToGenerate({required Object amountSats}) => 'Tap to generate invoice for ${amountSats}';
}

// Path: taker.paymentFailed.loading
class Translations$taker$paymentFailed$loading$en {
	Translations$taker$paymentFailed$loading$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Processing your payment retry...'
	String get processingPayment => 'Processing your payment retry...';
}

// Path: taker.paymentFailed.success
class Translations$taker$paymentFailed$success$en {
	Translations$taker$paymentFailed$success$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment Successful'
	String get title => 'Payment Successful';

	/// en: 'Your payment has been processed successfully.'
	String get message => 'Your payment has been processed successfully.';
}

// Path: taker.paymentSuccess.actions
class Translations$taker$paymentSuccess$actions$en {
	Translations$taker$paymentSuccess$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Go to home'
	String get goHome => 'Go to home';
}

// Path: taker.invalidBlik.actions
class Translations$taker$invalidBlik$actions$en {
	Translations$taker$invalidBlik$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Send new ${code} code'
	String retry({required Object code}) => 'Send new ${code} code';

	/// en: 'Cancel Transaction'
	String get cancelReservation => 'Cancel Transaction';

	/// en: 'Start Dispute'
	String get reportConflict => 'Start Dispute';

	/// en: 'Return to home'
	String get returnHome => 'Return to home';
}

// Path: taker.invalidBlik.confirmDialog
class Translations$taker$invalidBlik$confirmDialog$en {
	Translations$taker$invalidBlik$confirmDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Are you sure?'
	String get title => 'Are you sure?';

	/// en: 'Once you tap this, there is no turning back. If the amount WAS in fact charged from your bank account, the coordinator will NOT be able to guarantee you receive the bitcoin, and you may lose your funds. If you are not sure, it is best to wait a bit and confirm that you did NOT get charged before continuing.'
	String get content => 'Once you tap this, there is no turning back.\n\nIf the amount WAS in fact charged from your bank account, the coordinator will NOT be able to guarantee you receive the bitcoin, and you may lose your funds.\n\nIf you are not sure, it is best to wait a bit and confirm that you did NOT get charged before continuing.';

	late final Translations$taker$invalidBlik$confirmDialog$actions$en actions = Translations$taker$invalidBlik$confirmDialog$actions$en.internal(_root);
}

// Path: taker.invalidBlik.disputeConfirmDialog
class Translations$taker$invalidBlik$disputeConfirmDialog$en {
	Translations$taker$invalidBlik$disputeConfirmDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Start a dispute?'
	String get title => 'Start a dispute?';

	/// en: 'Only start a dispute if the amount WAS charged from your bank account. The coordinator will manually review your case, which takes time. You will need to provide proof of payment.'
	String get content => 'Only start a dispute if the amount WAS charged from your bank account.\n\nThe coordinator will manually review your case, which takes time. You will need to provide proof of payment.';

	late final Translations$taker$invalidBlik$disputeConfirmDialog$actions$en actions = Translations$taker$invalidBlik$disputeConfirmDialog$actions$en.internal(_root);
}

// Path: taker.invalidBlik.feedback
class Translations$taker$invalidBlik$feedback$en {
	Translations$taker$invalidBlik$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Conflict reported. Coordinator will review.'
	String get conflictReportedSuccess => 'Conflict reported. Coordinator will review.';
}

// Path: taker.invalidBlik.errors
class Translations$taker$invalidBlik$errors$en {
	Translations$taker$invalidBlik$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to reserve offer again'
	String get reservationFailed => 'Failed to reserve offer again';

	/// en: 'Error reporting conflict: ${details}'
	String conflictReport({required Object details}) => 'Error reporting conflict: ${details}';
}

// Path: taker.conflict.actions
class Translations$taker$conflict$actions$en {
	Translations$taker$conflict$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Back to Home'
	String get back => 'Back to Home';
}

// Path: taker.conflict.feedback
class Translations$taker$conflict$feedback$en {
	Translations$taker$conflict$feedback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Conflict reported. Coordinator will review.'
	String get reported => 'Conflict reported. Coordinator will review.';
}

// Path: taker.conflict.errors
class Translations$taker$conflict$errors$en {
	Translations$taker$conflict$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error reporting conflict: ${details}'
	String reporting({required Object details}) => 'Error reporting conflict: ${details}';
}

// Path: taker.conflict.nostrContact
class Translations$taker$conflict$nostrContact$en {
	Translations$taker$conflict$nostrContact$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Contact Coordinator on Nostr'
	String get title => 'Contact Coordinator on Nostr';

	/// en: 'You can DM the coordinator directly for help with this dispute.'
	String get description => 'You can DM the coordinator directly for help with this dispute.';

	/// en: 'Copy npub'
	String get copyNpub => 'Copy npub';

	/// en: 'View Profile'
	String get openProfile => 'View Profile';

	/// en: 'Coordinator npub copied to clipboard!'
	String get npubCopied => 'Coordinator npub copied to clipboard!';

	/// en: 'To send DMs, login with your Neko private key (nsec) in any Nostr client that supports direct messages.'
	String get yourIdentityDescription => 'To send DMs, login with your Neko private key (nsec) in any Nostr client that supports direct messages.';

	/// en: 'Manage Neko Keys'
	String get manageNekoKeys => 'Manage Neko Keys';
}

// Path: home.statistics.errors
class Translations$home$statistics$errors$en {
	Translations$home$statistics$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading statistics: ${error}'
	String loading({required Object error}) => 'Error loading statistics: ${error}';
}

// Path: settings.offerCreation.categoryOptions
class Translations$settings$offerCreation$categoryOptions$en {
	Translations$settings$offerCreation$categoryOptions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shop, café or restaurant'
	String get shop => 'Shop, café or restaurant';

	/// en: 'ATM cash out'
	String get atm => 'ATM cash out';

	/// en: 'Online service/product'
	String get online => 'Online service/product';
}

// Path: settings.offerCreation.dialogs
class Translations$settings$offerCreation$dialogs$en {
	Translations$settings$offerCreation$dialogs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select default category'
	String get selectCategory => 'Select default category';

	/// en: 'Select preferred coordinator'
	String get selectCoordinator => 'Select preferred coordinator';

	/// en: 'Enter a percentage like 1.5. Values are rounded to 0.5% steps.'
	String get premiumHint => 'Enter a percentage like 1.5. Values are rounded to 0.5% steps.';

	/// en: 'Applied when premium pricing is enabled and clamped by the selected coordinator maximum.'
	String get premiumHelper => 'Applied when premium pricing is enabled and clamped by the selected coordinator maximum.';
}

// Path: settings.display.unitOptions
class Translations$settings$display$unitOptions$en {
	Translations$settings$display$unitOptions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'sats'
	String get sats => 'sats';

	/// en: '₿ (BIP-177)'
	String get bitcoin => '₿ (BIP-177)';
}

// Path: settings.paymentSystem.countries
class Translations$settings$paymentSystem$countries$en {
	Translations$settings$paymentSystem$countries$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Poland'
	String get PL => 'Poland';

	/// en: 'Portugal'
	String get PT => 'Portugal';

	/// en: 'Switzerland'
	String get CH => 'Switzerland';
}

// Path: maker.amountForm.category.options
class Translations$maker$amountForm$category$options$en {
	Translations$maker$amountForm$category$options$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shop, café or restaurant'
	String get physicalShop => 'Shop, café or restaurant';

	/// en: 'ATM cash out'
	String get atmCashout => 'ATM cash out';

	/// en: 'Online service/product'
	String get onlineService => 'Online service/product';
}

// Path: maker.amountForm.category.shortLabels
class Translations$maker$amountForm$category$shortLabels$en {
	Translations$maker$amountForm$category$shortLabels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shop'
	String get shop => 'Shop';

	/// en: 'ATM'
	String get atm => 'ATM';

	/// en: 'Online'
	String get online => 'Online';
}

// Path: maker.conflict.disputeDialog.actions
class Translations$maker$conflict$disputeDialog$actions$en {
	Translations$maker$conflict$disputeDialog$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open Dispute'
	String get confirm => 'Open Dispute';

	/// en: 'Cancel'
	String get cancel => 'Cancel';
}

// Path: taker.invalidBlik.confirmDialog.actions
class Translations$taker$invalidBlik$confirmDialog$actions$en {
	Translations$taker$invalidBlik$confirmDialog$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'I'm sure, continue'
	String get proceed => 'I\'m sure, continue';

	/// en: 'Cancel'
	String get cancel => 'Cancel';
}

// Path: taker.invalidBlik.disputeConfirmDialog.actions
class Translations$taker$invalidBlik$disputeConfirmDialog$actions$en {
	Translations$taker$invalidBlik$disputeConfirmDialog$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Yes, I was charged'
	String get proceed => 'Yes, I was charged';

	/// en: 'Cancel'
	String get cancel => 'Cancel';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => ({required Object app}) => '${app}',
			'app.greeting' => 'Hello!',
			'app.changelog' => 'Changelog',
			'common.buttons.cancel' => 'Cancel',
			'common.buttons.save' => 'Save',
			'common.buttons.done' => 'Done',
			'common.buttons.retry' => 'Retry',
			'common.buttons.goHome' => 'Go Home',
			'common.buttons.saveAndContinue' => 'Save and Continue',
			'common.buttons.reveal' => 'Reveal',
			'common.buttons.hide' => 'Hide',
			'common.buttons.copy' => 'Copy',
			'common.buttons.close' => 'Close',
			'common.buttons.restore' => 'Restore',
			'common.buttons.faq' => 'FAQ',
			'common.labels.amount' => ({required Object currency}) => 'Amount (${currency})',
			'common.labels.status' => ({required Object status}) => 'Status: ${status}',
			'common.labels.role' => ({required Object role}) => 'Role: ${role}',
			'common.notifications.success' => 'Success',
			'common.notifications.error' => 'Error',
			'common.notifications.loading' => 'Loading...',
			'common.clipboard.copyToClipboard' => 'Copy to clipboard',
			'common.clipboard.pasteFromClipboard' => 'Paste from clipboard',
			'common.clipboard.copied' => 'Copied to clipboard!',
			'common.actions.cancelAndReturnToOffers' => 'Cancel and return to offers',
			'common.actions.cancelAndReturnHome' => 'Cancel and return home',
			'lightningAddress.labels.address' => 'Lightning Address (LNURL)',
			'lightningAddress.labels.hint' => 'user@domain.com',
			'lightningAddress.labels.short' => ({required Object address}) => 'Lightning Address: ${address}',
			'lightningAddress.labels.receivingAddress' => 'Your receiving address:',
			'lightningAddress.prompts.enter' => 'Enter your Lightning address to continue',
			'lightningAddress.prompts.edit' => 'Edit',
			'lightningAddress.prompts.invalid' => 'Enter a valid Lightning address',
			'lightningAddress.prompts.required' => 'Lightning address is required.',
			'lightningAddress.prompts.enterToTakeOffer' => 'You must set a Lightning address to take an offer.',
			'lightningAddress.prompts.missing' => 'Lightning address is missing. Please add one to be able to take offers.',
			'lightningAddress.prompts.add' => 'Add',
			'lightningAddress.prompts.delete' => 'Delete',
			'lightningAddress.prompts.confirmDelete' => 'Are you sure you want to delete your Lightning address?',
			'lightningAddress.prompts.howToGet' => 'Don\'t have a Lightning address yet? Learn how to get one!',
			'lightningAddress.prompts.learnMore' => 'Learn more about Lightning Address',
			'lightningAddress.feedback.saved' => 'Lightning address saved!',
			'lightningAddress.feedback.updated' => 'Lightning address updated!',
			'lightningAddress.feedback.valid' => 'Valid Lightning address',
			'lightningAddress.errors.saving' => ({required Object details}) => 'Error saving address: ${details}',
			'lightningAddress.errors.loading' => ({required Object details}) => 'Error loading Lightning address: ${details}',
			'offers.details.yourOffer' => 'Your offer:',
			'offers.details.selectedOffer' => 'Offer:',
			'offers.details.activeOffer' => 'You have an active offer:',
			'offers.details.finishedOffers' => 'Finished offers',
			'offers.details.noAvailable' => 'No available offers.',
			'offers.details.noAvailableTip' => ({required Object app}) => 'Tip: share ${app} in your community and among friends to increase ${app} orders.',
			'offers.details.noSuccessfulTrades' => 'No successful trades.',
			'offers.details.loadingDetails' => 'Loading offer details...',
			'offers.details.amount' => ({required Object amount}) => 'Amount: ${amount} satoshi',
			'offers.details.amountWithCurrency' => ({required Object amount, required Object currency}) => '${amount} ${currency}',
			'offers.details.makerFee' => ({required Object fee}) => 'Fee: ${fee} sats',
			'offers.details.takerFee' => ({required Object fee}) => 'Fee: ${fee} sats',
			'offers.details.subtitle' => ({required Object sats, required Object fee, required Object status}) => '${sats} + ${fee} (fee) satoshi\nStatus: ${status}',
			'offers.details.subtitleWithDate' => ({required Object sats, required Object fee, required Object status, required Object date}) => '${sats} + ${fee} (fee) satoshi\nStatus: ${status}\nPaid: ${date}',
			'offers.details.activeSubtitle' => ({required Object status, required Object amount}) => 'Status: ${status}\nAmount: ${amount} satoshi',
			'offers.details.id' => ({required Object id}) => 'Offer ID: ${id}...',
			'offers.details.created' => ({required Object dateTime}) => 'Created: ${dateTime}',
			'offers.details.takenAfter' => ({required Object duration}) => 'Taken after: ${duration}',
			'offers.details.paidAfter' => ({required Object duration}) => 'Paid after: ${duration}',
			'offers.details.exchangeRate' => 'Exchange Rate',
			'offers.details.amountLabel' => 'Amount',
			'offers.details.makerFeeLabel' => 'Maker fee',
			'offers.details.takerFeeLabel' => 'Taker fee',
			'offers.details.feeLabel' => 'Fee',
			'offers.details.statusLabel' => 'Status',
			'offers.details.youllReceive' => 'You\'ll receive',
			'offers.details.coordinator' => 'Coordinator',
			'offers.details.categoryLabel' => 'Category',
			'offers.details.categories.physicalShop' => 'Shop, café or restaurant',
			'offers.details.categories.atmCashout' => 'ATM cash out',
			'offers.details.categories.onlineService' => 'Online service/product',
			'offers.details.consents.atm' => 'Some ATMs add an extra fee on top of the offer amount. By taking this offer, you accept any additional bank charges required by the ATM.',
			'offers.details.consents.ecommerce' => ({required Object code}) => 'For various reasons — such as an out-of-stock item, overpayment correction, or other merchant-side issues — the online merchant may automatically send money back to the bank account linked to the ${code} you generated. Those funds land in your account and are not yours to keep. If this happens, contact the coordinator in good faith and arrange to return the funds to the maker. By taking this offer you accept these terms and honorably swear to act honestly in such situations.',
			'offers.labels.premium' => 'Premium',
			'offers.labels.premiumBadge' => ({required Object percent}) => '+${percent}% premium',
			'offers.tooltips.takerFeeInfo' => ({required Object feePercent}) => 'Coordinator charges a ${feePercent}% taker fee. This includes Lightning routing fees and is deducted from the amount you receive.',
			'offers.tooltips.premiumInfoTaker' => 'A premium means this offer is priced above market. For the same fiat amount, the maker locks fewer sats in the hold invoice, so you pay above market and receive fewer sats than at the market rate. The maximum premium is set by the coordinator.',
			'offers.tooltips.ratesFetchedAt' => 'Fetched at',
			'offers.tooltips.ratesSources' => 'Avg. rate sources',
			'offers.actions.take' => 'TAKE',
			'offers.actions.takeOffer' => 'Take Offer',
			'offers.actions.resume' => ({required Object code}) => 'ENTER ${code}',
			'offers.actions.cancel' => 'Cancel offer',
			'offers.actions.view' => 'View details',
			'offers.status.created' => 'Created',
			'offers.status.funded' => 'Funded',
			'offers.status.expired' => 'Expired',
			'offers.status.cancelled' => 'Cancelled',
			'offers.status.reserved' => 'Reserved',
			'offers.status.blikReceived' => ({required Object code}) => '${code} Sent',
			'offers.status.blikSentToMaker' => ({required Object code}) => '${code} Received',
			'offers.status.expiredBlik' => ({required Object code}) => '${code} expired',
			'offers.status.expiredSentBlik' => ({required Object code}) => '${code} expired',
			'offers.status.takerCharged' => 'Taker Charged',
			'offers.status.invalidBlik' => ({required Object code}) => 'Invalid ${code}',
			'offers.status.conflict' => 'Conflict',
			'offers.status.dispute' => 'Dispute',
			'offers.status.makerConfirmed' => 'Confirmed',
			'offers.status.settled' => 'Settled',
			'offers.status.payingTaker' => 'Paying Taker',
			'offers.status.takerPaymentFailed' => 'Taker Payment Failed',
			'offers.status.takerPaid' => 'Taker Paid',
			'offers.status.unknownStatus' => 'Unknown',
			'offers.statusMessages.reserved' => 'Offer reserved by Taker!',
			'offers.statusMessages.cancelled' => 'Offer cancelled successfully.',
			'offers.statusMessages.cancelledOrExpired' => 'Offer has been cancelled or expired.',
			'offers.statusMessages.noLongerAvailable' => ({required Object status}) => 'Offer is no longer available (Status: ${status}).',
			'offers.progress.waitingForTaker' => ({required Object time}) => 'Waiting for taker: ${time}',
			'offers.progress.reserved' => ({required Object seconds}) => 'Reserved: ${seconds} s left',
			'offers.progress.confirming' => ({required Object seconds}) => 'Confirming: ${seconds} s left',
			'offers.errors.loading' => ({required Object details}) => 'Error loading offers: ${details}',
			'offers.errors.loadingDetails' => ({required Object details}) => 'Error loading offer details: ${details}',
			'offers.errors.detailsMissing' => 'Error: Offer details missing or invalid.',
			'offers.errors.detailsNotLoaded' => 'Unable to load offer details.',
			'offers.errors.notFound' => 'Error: Offer not found.',
			'offers.errors.unexpectedState' => 'Error: Offer is in an unexpected state.',
			'offers.errors.unexpectedStateWithStatus' => ({required Object status}) => 'Offer is in an unexpected state (${status}). Please try again or contact support.',
			'offers.errors.invalidStatus' => 'Offer has invalid status.',
			'offers.errors.couldNotIdentify' => 'Error: Could not identify offer to cancel.',
			'offers.errors.cannotBeCancelled' => ({required Object status}) => 'Offer cannot be cancelled in current state (${status}).',
			'offers.errors.failedToCancel' => ({required Object details}) => 'Failed to cancel offer: ${details}',
			'offers.errors.activeDetailsLost' => 'Error: Lost active offer details.',
			'offers.errors.checkingActive' => ({required Object details}) => 'Error checking active offers: ${details}',
			'offers.errors.cannotResume' => ({required Object status}) => 'Cannot resume offer in state: ${status}',
			'offers.errors.cannotResumeTaker' => ({required Object status}) => 'Cannot resume taker offer in state: ${status}',
			'offers.errors.resuming' => ({required Object details}) => 'Error resuming offer: ${details}',
			'offers.errors.makerPublicKeyNotFound' => 'Maker public key not found',
			'offers.errors.takerPublicKeyNotFound' => 'Taker public key not found.',
			'offers.errors.atmConsentRequired' => 'Accept the ATM surcharge condition before taking this offer.',
			'offers.errors.ecommerceConsentRequired' => 'Accept the ecommerce refund-return condition before taking this offer.',
			'offers.errors.cannotTakeOwnOffer' => 'You cannot take your own offer.',
			'offers.success.title' => 'Offer completed',
			'offers.success.headline' => 'Payment confirmed!',
			'offers.success.subtitle' => 'Taker will be paid now.',
			'offers.success.detailsTitle' => 'Offer details:',
			'offers.success.duration' => ({required Object time}) => 'Offer took ${time} to complete.',
			'reservations.actions.cancel' => 'Cancel reservation',
			'reservations.feedback.cancelled' => 'Reservation cancelled.',
			'reservations.errors.cancelling' => ({required Object error}) => 'Failed to cancel reservation: ${error}',
			'reservations.errors.failedToReserve' => ({required Object details}) => 'Failed to reserve offer: ${details}',
			'reservations.errors.failedNoTimestamp' => 'Failed to reserve offer (no timestamp).',
			'reservations.errors.timestampMissing' => 'Offer reservation timestamp missing.',
			'reservations.errors.notReserved' => ({required Object status}) => 'Offer is no longer in reserved state (${status}).',
			'exchange.labels.enterAmount' => ({required Object currency}) => 'Enter amount (${currency}) to pay:',
			'exchange.labels.equivalent' => ({required Object sats}) => '≈ ${sats} satoshi',
			'exchange.labels.rate' => ({required Object rate, required Object currency}) => 'Exchange rate ≈ ${rate} ${currency}/BTC',
			'exchange.feedback.fetching' => 'Fetching exchange rate...',
			'exchange.errors.fetchingRate' => 'Failed to fetch exchange rate.',
			'exchange.errors.invalidFormat' => 'Invalid number format',
			'exchange.errors.mustBePositive' => 'Amount must be positive',
			'exchange.errors.invalidFeePercentage' => 'Invalid fee percentage',
			'exchange.errors.tooLowFiat' => ({required Object minAmount, required Object currency}) => 'Amount is too low. Minimum is ${minAmount} ${currency}.',
			'exchange.errors.tooHighFiat' => ({required Object maxAmount, required Object currency}) => 'Amount is too high. Maximum is ${maxAmount} ${currency}.',
			'exchange.errors.atmNotDispensable' => ({required Object notes}) => 'ATM can\'t dispense this amount. Use a combination of notes: ${notes}.',
			'coordinator.title' => 'Coordinators',
			'coordinator.info.fee' => 'fee',
			'coordinator.info.rangeDisplay' => ({required Object minAmount, required Object maxAmount, required Object currency}) => 'Amount: ${minAmount}-${maxAmount} ${currency}',
			'coordinator.info.feeDisplay' => ({required Object fee}) => '${fee}% fee',
			'coordinator.selector.loading' => 'Loading Coordinators...',
			'coordinator.selector.errorLoading' => 'Error Loading Coordinators',
			'coordinator.selector.choose' => 'Choose Coordinator',
			'coordinator.selector.viewNostrProfile' => 'View Nostr profile',
			'coordinator.selector.unresponsive' => 'This coordinator is unresponsive',
			'coordinator.selector.waitingResponse' => 'Waiting for coordinator response',
			'coordinator.selector.termsAccept' => 'I accept coordinator\'s ',
			'coordinator.selector.termsOfUsage' => 'Terms of use',
			'coordinator.dialog.makerFee' => 'Maker Fee',
			'coordinator.dialog.takerFee' => 'Taker Fee',
			'coordinator.dialog.amountRange' => 'Amount Range',
			'coordinator.dialog.reservationTime' => 'Reservation Time',
			'coordinator.dialog.currencies' => 'Currencies',
			'coordinator.dialog.viewTerms' => 'View Terms',
			'coordinator.details.title' => 'Coordinator',
			'coordinator.details.relaysInUse' => 'Relays in use',
			'coordinator.details.relaysInUseHint' => 'All communication with this coordinator is routed to these relays (from its NIP-65 list).',
			'coordinator.details.noRelays' => 'No relays known yet',
			'coordinator.details.makerFee' => 'Maker fee',
			'coordinator.details.takerFee' => 'Taker fee',
			'coordinator.details.amountRange' => 'Amount range',
			'coordinator.details.maxPremium' => 'Max premium',
			'coordinator.details.maxPremiumInfoTitle' => 'Premium',
			'coordinator.details.maxPremiumInfoBody' => 'A premium is an optional price markup above the market rate that a maker can set on an offer. With a premium, the maker locks fewer sats for the same fiat amount, so the taker pays above market and the maker keeps the difference. This value is the highest premium this coordinator allows on its offers.',
			'coordinator.details.reservationTime' => 'Reservation time',
			'coordinator.details.currencies' => 'Currencies',
			'coordinator.details.paymentSystem' => 'Payment system',
			'coordinator.details.version' => 'Version',
			'coordinator.details.yourOffers' => 'Your offers',
			'coordinator.details.successfulOffers' => 'Successful offers (30d)',
			'coordinator.details.statusOnline' => 'Online',
			'coordinator.details.statusOffline' => 'Offline',
			'coordinator.details.statusUnknown' => 'Unknown',
			'coordinator.details.openNostrProfile' => 'Open Nostr profile',
			'coordinator.details.termsOfUsage' => 'Terms of use',
			'coordinator.coldStart.title' => 'Discovering coordinators',
			'coordinator.coldStart.body' => ({required Object app}) => '${app} is finding public coordinators, checking which ones are reachable, and enabling a small default set for you.',
			'coordinator.coldStart.settingsHint' => 'You can change enabled coordinators later in Settings.',
			'coordinator.coldStart.ok' => 'OK',
			'coordinator.coldStart.discovered' => 'Discovered',
			'coordinator.coldStart.candidates' => 'Candidates',
			'coordinator.coldStart.enabled' => 'Enabled',
			'coordinator.coldStart.recordsTitle' => 'Current coordinators',
			'coordinator.coldStart.recordEnabled' => 'Enabled',
			'coordinator.coldStart.recordHealthyCandidate' => 'Healthy candidate',
			'coordinator.coldStart.recordOfflineCandidate' => 'Candidate offline',
			'coordinator.coldStart.recordChecking' => 'Checking',
			'coordinator.coldStart.recordDiscovered' => 'Discovered',
			'coordinator.coldStart.phases.loadingMuteList' => 'Loading coordinator filters',
			'coordinator.coldStart.phases.discovering' => 'Discovering coordinators on Nostr',
			'coordinator.coldStart.phases.loadingProfiles' => 'Loading coordinator profiles',
			'coordinator.coldStart.phases.loadingStats' => 'Reading coordinator history',
			'coordinator.coldStart.phases.checkingHealth' => 'Checking coordinator health',
			'coordinator.coldStart.phases.finalizing' => 'Enabling default coordinators',
			'coordinator.coldStart.phases.completed' => 'Done',
			'coordinator.management.title' => 'Coordinator Management',
			'coordinator.management.availableCoordinators' => 'Coordinators',
			'coordinator.management.noCoordinators' => 'No coordinators discovered yet.',
			'coordinator.management.online' => 'Online',
			'coordinator.management.unknownOffline' => 'Unknown/Offline',
			'coordinator.management.openNostrProfile' => 'Open Nostr Profile',
			'coordinator.management.enable' => 'Enable',
			'coordinator.management.remove' => 'Remove',
			'coordinator.management.addCustomWhitelist' => 'Add custom coordinator',
			'coordinator.management.addCustomWhitelistHint' => 'npub1...',
			'coordinator.management.add' => 'Add',
			'coordinator.management.coordinatorDisabled' => 'Coordinator disabled',
			'coordinator.management.coordinatorEnabled' => 'Coordinator enabled',
			'coordinator.management.coordinatorAdded' => 'Coordinator added to custom whitelist',
			'coordinator.management.coordinatorRemoved' => 'Coordinator removed from custom whitelist',
			'coordinator.management.coordinatorAddInfoUnavailable' => 'No coordinator info found on relays. Coordinator not added.',
			'coordinator.management.pleaseEnterNpub' => 'Please enter an npub',
			'coordinator.management.error' => 'Error',
			'coordinator.management.metricYourOffers' => 'Your offers',
			'coordinator.management.metricYourOffersTooltip' => 'Number of offers you have successfully completed with this coordinator.',
			'coordinator.management.metricNetworkOffers' => 'Offers (30d)',
			'coordinator.management.metricNetworkOffersTooltip' => 'Successful offers settled by this coordinator across all users in the last 30 days.',
			'maker.roleSelection.button' => 'PAY with Lightning',
			'maker.amountForm.progress.step1' => '1. Create Offer',
			'maker.amountForm.progress.step2' => '2. Wait for Taker',
			'maker.amountForm.progress.step3' => ({required Object code}) => '3. Use ${code}',
			'maker.amountForm.labels.coordinator' => 'Coordinator',
			'maker.amountForm.labels.category' => 'Category',
			'maker.amountForm.labels.exchangeRate' => 'Exchange Rate',
			'maker.amountForm.labels.fee' => 'Fee',
			'maker.amountForm.labels.satoshisToPay' => 'Amount to Pay',
			'maker.amountForm.labels.enterAmount' => 'Enter amount',
			'maker.amountForm.labels.customAmount' => 'Custom',
			'maker.amountForm.labels.tapToSelect' => 'Tap to select',
			'maker.amountForm.labels.premium' => 'Premium',
			'maker.amountForm.actions.generateInvoice' => 'Generate Invoice',
			'maker.amountForm.tooltips.feeInfo' => ({required Object feePercent}) => 'Coordinator charges a ${feePercent}% maker fee. This fee is deducted from your Lightning payment.',
			'maker.amountForm.tooltips.payInfo' => 'This calculation is based on client-side fetched exchange rates. The coordinator will calculate the exact amount, and the invoice amount will be the final and exact amount to pay.',
			'maker.amountForm.tooltips.premiumInfo' => 'An optional premium lets you sell your sats above market price. The premium reduces the sats locked in your hold invoice for the same fiat amount, so the taker pays above market and you keep the difference. Default is off (0%). The maximum premium is set by the selected coordinator.',
			'maker.amountForm.category.label' => 'Offer category',
			'maker.amountForm.category.unsupportedForSystem' => ({required Object system}) => '${system} does not support this category.',
			'maker.amountForm.category.options.physicalShop' => 'Shop, café or restaurant',
			'maker.amountForm.category.options.atmCashout' => 'ATM cash out',
			'maker.amountForm.category.options.onlineService' => 'Online service/product',
			'maker.amountForm.category.shortLabels.shop' => 'Shop',
			'maker.amountForm.category.shortLabels.atm' => 'ATM',
			'maker.amountForm.category.shortLabels.online' => 'Online',
			'maker.amountForm.category.atmHint' => 'Takers will see that this offer is for ATM cash out and may avoid it if their bank charges extra ATM fees.',
			'maker.amountForm.category.physicalShopHint' => ({required Object app, required Object code}) => 'The ideal place to use ${app} is a self-checkout terminal — since waiting for a taker to reserve, generate and confirm a ${code} code might take a couple of minutes. Works great at shops, cafes, and restaurants alike. If you\'re feeling brave enough to make a regular cashier (and the people queued behind you) wait those couple of minutes, good for you.',
			'maker.amountForm.category.ecommerceWarningTitle' => 'Online merchant refund risk',
			'maker.amountForm.category.ecommerceWarningBody' => ({required Object code}) => 'For various reasons — such as an out-of-stock item, overpayment correction, or other merchant-side issues — the online merchant may automatically issue a refund back to the bank account linked to the ${code}, which is the taker\'s account. The coordinator cannot force the taker to return those funds to you.',
			'maker.amountForm.category.ecommerceConfirmation' => 'I understand the refund risk and will add a note to the order instructing the merchant to refund a different account if a refund becomes necessary.',
			'maker.amountForm.category.whyThisIsNeeded' => 'why this is needed?',
			'maker.amountForm.onboarding.titlePrefix' => 'New',
			'maker.amountForm.onboarding.title' => 'Choose the offer category',
			'maker.amountForm.onboarding.body' => 'Pick the category that best matches what you are paying for before generating the invoice.',
			'maker.amountForm.onboarding.showWhy' => 'Why does this matter?',
			'maker.amountForm.onboarding.hideWhy' => 'Hide details',
			'maker.amountForm.onboarding.whyTitle' => 'Choosing the right category helps takers decide safely',
			'maker.amountForm.onboarding.whyBody' => 'Different situations carry different expectations and risks. ATM cash outs may include extra bank fees, and online purchases can involve refund edge cases. Marking the right category gives takers the context they need before accepting your offer.',
			'maker.amountForm.onboarding.cta' => 'Got it',
			'maker.amountForm.errors.initiating' => ({required Object details}) => 'Error initiating offer: ${details}',
			'maker.amountForm.errors.publicKeyNotLoaded' => 'Error: Public key not yet loaded.',
			'maker.amountForm.errors.noCoordinatorMatchesAmount' => 'No coordinator supports this amount. Try a different value.',
			'maker.amountForm.errors.categoryRequired' => 'Select an offer category.',
			'maker.amountForm.errors.ecommerceConfirmationRequired' => 'Confirm the online merchant refund risk before continuing.',
			'maker.payInvoice.title' => 'Pay this Hold invoice:',
			'maker.payInvoice.actions.copy' => 'Copy Invoice',
			'maker.payInvoice.actions.payInWallet' => 'Open in External Wallet',
			'maker.payInvoice.actions.connectWallet' => 'Connect Wallet',
			'maker.payInvoice.actions.payWithNwc' => 'Pay',
			'maker.payInvoice.actions.paying' => 'Paying...',
			'maker.payInvoice.feedback.copied' => 'Invoice copied to clipboard!',
			'maker.payInvoice.feedback.waitingConfirmation' => 'Waiting for payment confirmation...',
			'maker.payInvoice.feedback.nwcConnected' => 'NWC wallet connected!',
			'maker.payInvoice.feedback.nwcPaymentSuccess' => 'Payment successful!',
			'maker.payInvoice.errors.couldNotOpenApp' => 'Could not open Lightning app for invoice.',
			'maker.payInvoice.errors.openingApp' => ({required Object details}) => 'Error opening Lightning app: ${details}',
			'maker.payInvoice.errors.publicKeyNotAvailable' => 'Public key is not available.',
			'maker.payInvoice.errors.couldNotFetchActive' => 'Could not fetch active offer details. It may have expired.',
			'maker.payInvoice.errors.nwcPaymentFailed' => ({required Object details}) => 'Payment failed: ${details}',
			'maker.payInvoice.errors.nwcNotConnected' => 'NWC wallet not connected',
			'maker.payInvoice.errors.insufficientBalance' => ({required Object required, required Object available}) => 'Insufficient balance. Need ${required} sats, have ${available} sats',
			'maker.payInvoice.errors.cancelOfferAlreadyFunded' => 'Coordinator reports this offer is already funded. It cannot be cancelled now.',
			'maker.payInvoice.errors.cancelFailed' => ({required Object details}) => 'Could not cancel offer: ${details}',
			'maker.payInvoice.budgetWarning.title' => 'Payment may fail',
			'maker.payInvoice.budgetWarning.balanceTooLow' => ({required Object name}) => 'Your default spending wallet ${name} does not have enough balance for this payment.',
			'maker.payInvoice.budgetWarning.budgetTooLow' => ({required Object name}) => 'Your default spending wallet ${name} does not have enough spending budget for this payment.',
			'maker.payInvoice.budgetWarning.balanceLine' => ({required Object available}) => 'Balance: ${available}',
			'maker.payInvoice.budgetWarning.budgetLine' => ({required Object remaining}) => 'Remaining NWC budget: ${remaining}',
			'maker.payInvoice.budgetWarning.requiredLine' => ({required Object required}) => 'Required: ${required}',
			'maker.payInvoice.budgetWarning.addFundsHint' => ({required Object name}) => 'Add funds to ${name} to cover this payment amount.',
			'maker.payInvoice.budgetWarning.increaseBudgetHint' => 'Increase the NWC spending budget for this connection in your wallet app.',
			'maker.payInvoice.budgetWarning.switchWalletLabel' => 'Or use a different wallet:',
			'maker.payInvoice.budgetWarning.walletLowFundsTag' => 'May fail',
			'maker.payInvoice.budgetWarning.payAnyway' => 'Try anyway',
			'maker.payInvoice.budgetWarning.cancel' => 'Cancel',
			'maker.payInvoice.budgetWarning.readyTitle' => 'Pay invoice',
			'maker.waitTaker.message' => 'Waiting for a Taker to reserve your offer...',
			'maker.waitTaker.progressLabel' => ({required Object time}) => 'Waiting for taker: ${time}',
			'maker.waitTaker.errorActiveOfferDetailsLost' => 'Error: Lost active offer details.',
			'maker.waitTaker.errorFailedToRetrieveBlik' => ({required Object code}) => 'Error: Failed to retrieve ${code} code.',
			'maker.waitTaker.errorRetrievingBlik' => ({required Object code, required Object details}) => 'Error retrieving ${code} code: ${details}',
			'maker.waitTaker.offerNoLongerAvailable' => ({required Object status}) => 'Offer is no longer available (Status: ${status}).',
			'maker.waitTaker.errorCouldNotIdentifyOffer' => 'Error: Could not identify offer to cancel.',
			'maker.waitTaker.offerCannotBeCancelled' => ({required Object status}) => 'Offer cannot be cancelled in current state (${status}).',
			'maker.waitTaker.offerCancelledSuccessfully' => 'Offer cancelled successfully.',
			'maker.waitTaker.failedToCancelOffer' => ({required Object details}) => 'Failed to cancel offer: ${details}',
			'maker.waitTaker.offerExpiredTitle' => 'Offer Expired',
			'maker.waitTaker.offerExpiredMessage' => 'No taker reserved your offer in time.',
			'maker.waitTaker.recreateOffer' => 'New offer — same amount',
			'maker.waitForBlik.title' => ({required Object code}) => 'Waiting for ${code}',
			'maker.waitForBlik.messageInfo' => 'Taker has reserved offer!',
			'maker.waitForBlik.messageWaiting' => ({required Object code}) => 'Waiting to provide ${code} code...',
			'maker.waitForBlik.progressLabel' => ({required Object seconds}) => 'Reserved: ${seconds} s left',
			'maker.confirmPayment.title' => ({required Object code}) => '${code} code received!',
			'maker.confirmPayment.retrieving' => ({required Object code}) => 'Retrieving ${code} code...',
			'maker.confirmPayment.instructions' => 'Enter this code into the payment terminal. When Taker confirms in their banking app and payment is successful, press Confirm below.',
			'maker.confirmPayment.instruction1' => ({required Object code}) => 'Enter the code into the ${code} payment request.',
			'maker.confirmPayment.instruction2' => 'Wait until Taker confirms the payment in their app.',
			'maker.confirmPayment.instruction3' => 'When payment is succesful, press Confirm below:',
			'maker.confirmPayment.mbwayAtmInstructions' => ({required Object amount, required Object minutes}) => 'To withdraw ${amount} €, go to the nearest MULTIBANCO ATM, press the green key and choose the "Withdraw Cash" ("Levantar Dinheiro") option. Enter the code. This code is valid for ${minutes} minutes.',
			'maker.confirmPayment.takerChargedWarning' => ({required Object code}) => 'The taker has reported that the ${code} payment was charged from their bank account. If you mark this as invalid, this will cause a conflict.',
			'maker.confirmPayment.autoConfirmInfo' => ({required Object code}) => 'Unless you mark the ${code} as invalid, the payment will be auto-confirmed and the taker paid when this timer runs out.',
			'maker.confirmPayment.autoConfirmCountdown' => ({required Object time}) => 'Auto-confirm in ${time}',
			'maker.confirmPayment.expiredTitle' => ({required Object code}) => '${code} Code Expired',
			'maker.confirmPayment.expiredWarning' => ({required Object code}) => 'The ${code} code has expired. You need to manually confirm the payment status:',
			'maker.confirmPayment.expiredInstruction1' => ({required Object code}) => 'If the ${code} payment was successful and you completed your purchase, click "Confirm successful payment" below.',
			'maker.confirmPayment.expiredInstruction2' => ({required Object code}) => 'If the ${code} payment failed or was not completed, click "Invalid ${code} Code" below.',
			'maker.confirmPayment.actions.confirm' => 'Confirm successful payment',
			'maker.confirmPayment.actions.markInvalid' => ({required Object code}) => 'Invalid ${code} Code',
			'maker.confirmPayment.actions.copyBlik' => ({required Object code}) => 'Copy ${code}',
			'maker.confirmPayment.confirmDialog.title' => 'Confirm Payment?',
			'maker.confirmPayment.confirmDialog.content' => ({required Object code}) => 'This action is irreversible. After confirming:\n\n• The Taker will receive the funds immediately\n• The coordinator will not be able to dispute the funds\n• You cannot undo this action\n\nOnly confirm if the ${code} payment was successful.',
			'maker.confirmPayment.confirmDialog.cancel' => 'Cancel',
			'maker.confirmPayment.confirmDialog.confirmButton' => 'Yes, Confirm Payment',
			'maker.confirmPayment.invalidBlikDisputeDialog.title' => 'Open Dispute?',
			'maker.confirmPayment.invalidBlikDisputeDialog.content' => ({required Object code}) => 'The taker has reported that the ${code} payment was charged from their account.\n\nMarking this as invalid will immediately open a DISPUTE that requires coordinator intervention.\n\n• A dispute fee may be charged if ruled against you\n• The hold invoice will be settled immediately\n• Manual verification will be required\n\nOnly proceed if you are certain the ${code} payment did NOT succeed.',
			'maker.confirmPayment.invalidBlikDisputeDialog.cancel' => 'Cancel',
			'maker.confirmPayment.invalidBlikDisputeDialog.confirmButton' => 'Yes, Open Dispute',
			'maker.confirmPayment.feedback.confirmed' => 'Maker confirmed payment.',
			'maker.confirmPayment.feedback.confirmedTakerPaid' => 'Payment confirmed! Taker will receive funds.',
			'maker.confirmPayment.feedback.progressLabel' => ({required Object seconds}) => 'Confirming: ${seconds} s left',
			'maker.confirmPayment.errors.failedToRetrieve' => ({required Object code}) => 'Error: Failed to retrieve ${code} code.',
			'maker.confirmPayment.errors.retrieving' => ({required Object code, required Object details}) => 'Error retrieving ${code} code: ${details}',
			'maker.confirmPayment.errors.missingHashOrKey' => 'Error: Missing payment hash or public key.',
			'maker.confirmPayment.errors.incorrectState' => ({required Object status}) => 'Offer is not in correct state for confirmation (Status: ${status})',
			'maker.confirmPayment.errors.confirming' => ({required Object details}) => 'Error confirming payment: ${details}',
			'maker.confirmPayment.errors.invalidState' => 'Error: Received invalid offer state.',
			'maker.confirmPayment.errors.internalIncomplete' => 'Internal error: Incomplete offer details.',
			'maker.confirmPayment.errors.notAwaitingConfirmation' => ({required Object status}) => 'Offer is no longer awaiting confirmation (Status: ${status}).',
			'maker.confirmPayment.errors.unexpectedStatus' => 'Received unexpected offer status from server.',
			'maker.invalidBlik.title' => ({required Object code}) => 'Invalid ${code} Code',
			'maker.invalidBlik.info' => ({required Object code}) => 'You marked the ${code} code as invalid. Waiting for taker to provide new code or start dispute.',
			'maker.conflict.title' => 'Offer Conflict',
			'maker.conflict.headline' => 'Offer Conflict Reported',
			'maker.conflict.body' => ({required Object code}) => 'You marked the ${code} code as invalid, but the Taker reported a conflict, indicating they believe the payment was successful.',
			'maker.conflict.instructions' => 'Wait for the coordinator to review the situation. You may be asked for more details. Check back later or contact support if needed.',
			'maker.conflict.actions.back' => 'Back to Home',
			'maker.conflict.actions.confirmPayment' => ({required Object code}) => 'My mistake, confirm ${code} payment success',
			'maker.conflict.actions.openDispute' => ({required Object code}) => '${code} payment did NOT succeed, OPEN DISPUTE',
			'maker.conflict.actions.submitDispute' => 'Submit Dispute',
			'maker.conflict.disputeDialog.title' => 'Open dispute?',
			'maker.conflict.disputeDialog.content' => 'Opening a dispute requires manual verification by the coordinator, which will take time. A dispute fee will be deducted if the dispute is ruled against you. The hold invoice will be settled to prevent it from expiring. If the dispute is ruled in your favor, you will receive a refund (minus fees) to a wallet of your choice.',
			'maker.conflict.disputeDialog.contentDetailed' => 'Opening a dispute will require manual coordinator intervention, which takes time and incurs a dispute fee.\n\nThe hold invoice will be immediately settled to prevent it from expiring before the dispute is resolved.\n\nIf the dispute is ruled in your favor, the satoshi amount will be refunded to a wallet of your choice (minus fees). Make sure you have a wallet ready to receive.',
			'maker.conflict.disputeDialog.actions.confirm' => 'Open Dispute',
			'maker.conflict.disputeDialog.actions.cancel' => 'Cancel',
			'maker.conflict.feedback.disputeOpenedSuccess' => 'Dispute successfully opened. Coordinator will review.',
			'maker.conflict.errors.openingDispute' => ({required Object error}) => 'Error opening dispute: ${error}',
			'maker.conflict.nostrContact.title' => 'Contact Coordinator on Nostr',
			'maker.conflict.nostrContact.description' => 'You can DM the coordinator directly for help with this dispute.',
			'maker.conflict.nostrContact.copyNpub' => 'Copy npub',
			'maker.conflict.nostrContact.openProfile' => 'View Profile',
			'maker.conflict.nostrContact.npubCopied' => 'Coordinator npub copied to clipboard!',
			'maker.conflict.nostrContact.yourIdentityDescription' => 'To send DMs, login with your Neko private key (nsec) in any Nostr client that supports direct messages.',
			'maker.conflict.nostrContact.manageNekoKeys' => 'Manage Neko Keys',
			'maker.success.title' => 'Offer completed',
			'maker.success.headline' => 'Payment confirmed!',
			'maker.success.subtitle' => 'Taker will now be paid.',
			'maker.success.detailsTitle' => 'Offer details:',
			'maker.success.duration' => ({required Object time}) => 'Offer took ${time}!',
			'taker.roleSelection.button' => ({required Object code}) => 'SELL ${code} code for satoshi',
			'taker.progress.step1' => ({required Object code}) => 'Submit ${code}',
			'taker.progress.step2' => ({required Object code}) => 'Confirm ${code}',
			'taker.progress.step3' => 'Get Paid',
			'taker.submitBlik.title' => ({required Object digits, required Object code}) => 'Enter ${digits}-digit ${code}',
			'taker.submitBlik.label' => ({required Object code}) => '${code} Code',
			'taker.submitBlik.instruction' => ({required Object code}) => 'Enter ${code} before time ends...',
			'taker.submitBlik.timeLimit' => ({required Object code, required Object seconds}) => 'Enter ${code} within: ${seconds} s',
			'taker.submitBlik.timeExpired' => ({required Object code}) => 'Time to enter ${code} code has expired.',
			'taker.submitBlik.actions.submit' => ({required Object code}) => 'Submit ${code}',
			'taker.submitBlik.feedback.pasted' => ({required Object code}) => 'Pasted ${code} code.',
			'taker.submitBlik.validation.invalidFormat' => ({required Object digits, required Object code}) => 'Enter a valid ${digits}-digit ${code} code.',
			'taker.submitBlik.errors.submitting' => ({required Object code, required Object details}) => 'Error submitting ${code} code: ${details}',
			'taker.submitBlik.errors.clipboardInvalid' => ({required Object digits, required Object code}) => 'Clipboard does not contain a valid ${digits}-digit ${code} code.',
			'taker.submitBlik.errors.stateChanged' => 'Error: Offer state has changed.',
			'taker.submitBlik.errors.stateNotValid' => 'Error: Offer state is no longer valid.',
			'taker.submitBlik.errors.fetchedIdMismatch' => ({required Object fetchedId, required Object initialId}) => 'Fetched active offer ID (${fetchedId}) does not match initial offer ID (${initialId}). State mismatch?',
			'taker.submitBlik.errors.paymentHashMissing' => 'Offer payment hash missing after fetch.',
			'taker.submitBlik.details.requestedAmount' => ({required Object code}) => 'Requested ${code} amount',
			'taker.submitBlik.details.exchangeRate' => 'Exchange Rate',
			'taker.submitBlik.details.takerFee' => 'Taker fee',
			'taker.submitBlik.details.status' => 'Status',
			'taker.submitBlik.details.youllReceive' => 'You\'ll receive',
			'taker.waitConfirmation.title' => 'Waiting for Maker',
			'taker.waitConfirmation.statusLabel' => ({required Object status}) => 'Offer status: ${status}',
			'taker.waitConfirmation.waitingMaker' => ({required Object seconds}) => 'Waiting for Maker confirmation: ${seconds} s',
			'taker.waitConfirmation.waitingMakerConfirmation' => ({required Object code, required Object seconds}) => 'Waiting for Maker to confirm ${code} is correct. Time remaining: ${seconds}s',
			'taker.waitConfirmation.importantNotice' => ({required Object code, required Object amount, required Object currency}) => 'VERY IMPORTANT: Make sure you only accept ${code} confirmation for ${amount} ${currency}',
			'taker.waitConfirmation.importantBlikAmountConfirmation' => ({required Object code, required Object amount, required Object currency}) => 'VERY IMPORTANT: In your banking app, ensure you are confirming a ${code} payment for exactly ${amount} ${currency}.',
			'taker.waitConfirmation.instructions' => ({required Object minutes, required Object code}) => 'The maker must now enter it into the payment terminal within ${minutes} minutes. You then must accept the ${code} code in your banking app.',
			'taker.waitConfirmation.instructionsNoConfirm' => ({required Object code, required Object minutes}) => 'The maker must now enter your ${code} code at the ATM within ${minutes} minutes.',
			'taker.waitConfirmation.categoryReminder.atm' => 'ATM offer reminder: your bank may still ask you to approve an extra ATM fee on top of the main amount.',
			'taker.waitConfirmation.categoryReminder.ecommerce' => 'Online order reminder: if the merchant sends an automatic refund to your bank account, contact the coordinator and return it.',
			'taker.waitConfirmation.waitingForMakerToReceive' => ({required Object code}) => 'Waiting for maker to receive your ${code} code...',
			'taker.waitConfirmation.makerReceivedBlik' => ({required Object code}) => 'Maker has received your ${code} code.',
			'taker.waitConfirmation.timerExpiredMessage' => ({required Object code, required Object minutes}) => '${code} ${minutes}m expiration time has passed. Waiting for maker to confirm or mark code as invalid.',
			'taker.waitConfirmation.timerExpiredActions' => ({required Object code, required Object minutes}) => '${code} ${minutes}m expiration time has passed but the maker hasn\'t received the ${code} code. You can resend a new ${code} code or cancel.',
			'taker.waitConfirmation.resendBlikButton' => ({required Object code}) => 'Resend New ${code} Code',
			'taker.waitConfirmation.navigatedHome' => 'Navigated home.',
			'taker.waitConfirmation.expiredTitle' => ({required Object code}) => '${code} Code Expired',
			'taker.waitConfirmation.expiredWarning' => ({required Object code}) => 'The maker did not receive the ${code} code so it couldn\'t have used it.',
			'taker.waitConfirmation.expiredRelistCountdownLabel' => 'Reservation ends in',
			'taker.waitConfirmation.expiredSentWarning' => 'The maker hasn\'t confirmed the payment yet. What would you like to do?',
			'taker.waitConfirmation.expiredInstruction1' => ({required Object code}) => 'If you want to try again with a new ${code} code, renew the reservation.',
			'taker.waitConfirmation.expiredInstruction2' => 'If you no longer want to complete this transaction, cancel the reservation.',
			'taker.waitConfirmation.expiredInstruction3' => ({required Object code}) => 'If the ${code} payment was charged from your bank account, do not worry, the bitcoin is still safely locked with the coordinator.',
			'taker.waitConfirmation.takerCharged.title' => ({required Object code}) => 'You marked ${code} as charged',
			'taker.waitConfirmation.takerCharged.message' => ({required Object minutes}) => 'The maker has ${minutes}min to confirm the payment or dispute the payment. If they do nothing the payment will auto confirm and you will receive the bitcoin.',
			'taker.waitConfirmation.expiredActions.reportConflict' => ({required Object code}) => '${code} was charged from my bank account',
			'taker.waitConfirmation.expiredActions.renewReservation' => ({required Object code}) => 'Try again with new ${code} code',
			'taker.waitConfirmation.expiredActions.cancelReservation' => 'Cancel reservation',
			'taker.waitConfirmation.feedback.makerConfirmed' => 'Maker confirmed payment.',
			'taker.waitConfirmation.feedback.paymentSuccessful' => 'Payment successful! You will receive funds shortly.',
			'taker.waitConfirmation.feedback.conflictReported' => 'Conflict reported. Coordinator will review the situation.',
			'taker.waitConfirmation.errors.invalidOfferStateReceived' => 'Received an offer with an invalid state for this screen. Resetting.',
			'taker.waitConfirmation.errors.reportingConflict' => ({required Object details}) => 'Error reporting conflict: ${details}',
			'taker.paymentProcess.title' => 'Payment Process',
			'taker.paymentProcess.waitingForOfferUpdate' => 'Waiting for offer status update...',
			'taker.paymentProcess.states.preparing' => 'Preparing to send payment...',
			'taker.paymentProcess.states.sending' => 'Sending payment...',
			'taker.paymentProcess.states.received' => 'Payment received!',
			'taker.paymentProcess.states.failed' => 'Payment failed',
			'taker.paymentProcess.states.waitingUpdate' => 'Waiting for offer update...',
			'taker.paymentProcess.steps.makerConfirmedBlik' => ({required Object code}) => 'Maker confirmed ${code} payment',
			'taker.paymentProcess.steps.makerInvoiceSettled' => 'Maker\'s hold invoice settled',
			'taker.paymentProcess.steps.takerInvoicePaid' => 'Paying your Lightning invoice',
			'taker.paymentProcess.steps.takerPaymentFailed' => 'Payment to your invoice failed',
			'taker.paymentProcess.errors.sending' => ({required Object details}) => 'Error sending payment: ${details}',
			'taker.paymentProcess.errors.notConfirmed' => 'Offer not confirmed by Maker.',
			'taker.paymentProcess.errors.expired' => 'Offer expired.',
			'taker.paymentProcess.errors.cancelled' => 'Offer cancelled.',
			'taker.paymentProcess.errors.paymentFailed' => 'Offer payment failed.',
			'taker.paymentProcess.errors.unknown' => 'Unknown offer error.',
			'taker.paymentProcess.errors.takerPaymentFailed' => 'The payment to your Lightning invoice failed.',
			'taker.paymentProcess.errors.noPublicKey' => 'Error: Cannot fetch your public key.',
			'taker.paymentProcess.errors.loadingPublicKey' => 'Error loading your data',
			'taker.paymentProcess.errors.missingPaymentHash' => 'Error: Missing payment details.',
			'taker.paymentProcess.loading.publicKey' => 'Loading your data...',
			'taker.paymentProcess.actions.goToFailureDetails' => 'Retry with new invoice',
			'taker.paymentFailed.title' => 'Payment Failed',
			'taker.paymentFailed.instructions' => ({required Object netAmount}) => 'Please provide a new Lightning invoice for ${netAmount}',
			'taker.paymentFailed.form.newInvoiceLabel' => 'New Lightning invoice',
			'taker.paymentFailed.form.newInvoiceHint' => 'Enter your BOLT11 invoice',
			'taker.paymentFailed.actions.retryPayment' => 'Submit New Invoice',
			'taker.paymentFailed.errors.enterValidInvoice' => 'Please enter a valid invoice',
			'taker.paymentFailed.errors.updatingInvoice' => ({required Object details}) => 'Error updating invoice: ${details}',
			'taker.paymentFailed.errors.paymentRetryFailed' => 'Payment retry failed. Please check the invoice or try again later.',
			'taker.paymentFailed.errors.takerPublicKeyNotFound' => 'Taker public key not found.',
			'taker.paymentFailed.errors.generateFailed' => ({required Object details}) => 'Failed to generate invoice: ${details}',
			'taker.paymentFailed.walletSection.title' => 'Generate invoice from wallet',
			'taker.paymentFailed.walletSection.defaultLabel' => 'default',
			'taker.paymentFailed.walletSection.tapToGenerate' => ({required Object amountSats}) => 'Tap to generate invoice for ${amountSats}',
			'taker.paymentFailed.loading.processingPayment' => 'Processing your payment retry...',
			'taker.paymentFailed.success.title' => 'Payment Successful',
			'taker.paymentFailed.success.message' => 'Your payment has been processed successfully.',
			'taker.paymentSuccess.title' => 'Payment Successful',
			'taker.paymentSuccess.message' => 'Your payment has been processed successfully.',
			'taker.paymentSuccess.actions.goHome' => 'Go to home',
			'taker.invalidBlik.title' => ({required Object code}) => 'Invalid ${code} Code',
			'taker.invalidBlik.message' => ({required Object code}) => 'Maker Rejected ${code} Code',
			'taker.invalidBlik.explanation' => ({required Object code}) => 'The offer maker indicated that the ${code} code you provided was invalid or didn\'t work.\n\nWhat would you like to do?',
			'taker.invalidBlik.werentCharged' => 'If you were NOT charged:',
			'taker.invalidBlik.wereCharged' => 'If you were charged:',
			'taker.invalidBlik.actions.retry' => ({required Object code}) => 'Send new ${code} code',
			'taker.invalidBlik.actions.cancelReservation' => 'Cancel Transaction',
			'taker.invalidBlik.actions.reportConflict' => 'Start Dispute',
			'taker.invalidBlik.actions.returnHome' => 'Return to home',
			'taker.invalidBlik.confirmDialog.title' => 'Are you sure?',
			'taker.invalidBlik.confirmDialog.content' => 'Once you tap this, there is no turning back.\n\nIf the amount WAS in fact charged from your bank account, the coordinator will NOT be able to guarantee you receive the bitcoin, and you may lose your funds.\n\nIf you are not sure, it is best to wait a bit and confirm that you did NOT get charged before continuing.',
			'taker.invalidBlik.confirmDialog.actions.proceed' => 'I\'m sure, continue',
			'taker.invalidBlik.confirmDialog.actions.cancel' => 'Cancel',
			'taker.invalidBlik.disputeConfirmDialog.title' => 'Start a dispute?',
			_ => null,
		} ?? switch (path) {
			'taker.invalidBlik.disputeConfirmDialog.content' => 'Only start a dispute if the amount WAS charged from your bank account.\n\nThe coordinator will manually review your case, which takes time. You will need to provide proof of payment.',
			'taker.invalidBlik.disputeConfirmDialog.actions.proceed' => 'Yes, I was charged',
			'taker.invalidBlik.disputeConfirmDialog.actions.cancel' => 'Cancel',
			'taker.invalidBlik.feedback.conflictReportedSuccess' => 'Conflict reported. Coordinator will review.',
			'taker.invalidBlik.errors.reservationFailed' => 'Failed to reserve offer again',
			'taker.invalidBlik.errors.conflictReport' => ({required Object details}) => 'Error reporting conflict: ${details}',
			'taker.conflict.title' => 'Offer Conflict',
			'taker.conflict.headline' => 'Offer Conflict Reported',
			'taker.conflict.body' => ({required Object code}) => 'The Maker marked the ${code} code as invalid, but you reported a conflict, indicating you believe the payment was successful.',
			'taker.conflict.instructions' => 'Wait for the coordinator to review the situation. You may be asked for more details. Check back later or contact support if needed.',
			'taker.conflict.actions.back' => 'Back to Home',
			'taker.conflict.feedback.reported' => 'Conflict reported. Coordinator will review.',
			'taker.conflict.errors.reporting' => ({required Object details}) => 'Error reporting conflict: ${details}',
			'taker.conflict.nostrContact.title' => 'Contact Coordinator on Nostr',
			'taker.conflict.nostrContact.description' => 'You can DM the coordinator directly for help with this dispute.',
			'taker.conflict.nostrContact.copyNpub' => 'Copy npub',
			'taker.conflict.nostrContact.openProfile' => 'View Profile',
			'taker.conflict.nostrContact.npubCopied' => 'Coordinator npub copied to clipboard!',
			'taker.conflict.nostrContact.yourIdentityDescription' => 'To send DMs, login with your Neko private key (nsec) in any Nostr client that supports direct messages.',
			'taker.conflict.nostrContact.manageNekoKeys' => 'Manage Neko Keys',
			'blik.instructions.taker' => ({required Object code}) => 'Once the Maker enters the ${code} code, you will need to confirm the payment in your banking app. Ensure the amount is correct before confirming.',
			'home.notifications.title' => 'Get notified about new offers via:',
			'home.notifications.telegram' => 'Telegram',
			'home.notifications.simplex' => 'SimpleX',
			'home.notifications.matrix' => 'Matrix',
			'home.notifications.signal' => 'Signal',
			'home.statistics.title' => 'Finished Offers',
			'home.statistics.lifetimeCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'All: ${count} transactions\nAvg wait for ${code}: ${avgBlikTime}\nAvg completion time: ${avgPaidTime}',
			'home.statistics.last7DaysCompact' => ({required Object count, required Object code, required Object avgBlikTime, required Object avgPaidTime}) => 'Last 7d: ${count} transactions\nAvg wait for ${code}: ${avgBlikTime}\nAvg completion time: ${avgPaidTime}',
			'home.statistics.last7DaysSingleLine' => ({required Object count, required Object avgReservationTime, required Object avgPaidTime}) => 'Last 7d: ${count} offers  |  Avg reserve: ${avgReservationTime}  |  Avg Paid: ${avgPaidTime}',
			'home.statistics.errors.loading' => ({required Object error}) => 'Error loading statistics: ${error}',
			'nekoInfo.title' => 'What is a Neko?',
			'nekoInfo.description' => ({required Object app}) => 'Your Neko is your identity for using ${app}. It\'s composed of a private and public key to ensure cryptographically secure communication with the coordinator.\n\nTo ensure greater anonymity, it is recommended to use a new, fresh Neko for each offer.\n\n⚠️ IMPORTANT: Your private key is only stored on your device (client-side). It is critically important to backup your private key, as losing access to it may prevent you from resolving disputes and recovering your funds.',
			'nekoInfo.backupWarning' => 'Remember to backup your Neko',
			'generateNewKey.title' => 'New',
			'generateNewKey.description' => 'Are you sure you want to generate a new Neko? Your current one will be lost forever if you haven\'t backed it up.',
			'generateNewKey.buttons.generate' => 'Generate',
			'generateNewKey.errors.activeOffer' => 'You cannot generate a new Neko while you have an active offer.',
			'generateNewKey.errors.failed' => 'Failed to generate new Neko',
			'generateNewKey.feedback.success' => 'New Neko generated successfully!',
			'generateNewKey.tooltips.generate' => 'Generate New Neko',
			'backup.title' => 'Backup',
			'backup.description' => 'This is your private key. It secures communication with the coordinator. Never reveal it to anyone. Back it up in a secure place to prevent issues during disputes.',
			'backup.feedback.copied' => 'Private key copied to clipboard!',
			'backup.tooltips.backup' => 'Backup Neko',
			'restore.title' => 'Restore',
			'restore.labels.privateKey' => 'Private Key',
			'restore.buttons.restore' => 'Restore',
			'restore.errors.invalidKey' => 'Must be a 64-character hex string.',
			'restore.errors.failed' => 'Restore failed',
			'restore.feedback.success' => 'Neko restored successfully! App will restart.',
			'restore.tooltips.restore' => 'Restore Neko',
			'system.loadingPublicKey' => 'Loading your public key...',
			'system.errors.generic' => 'An unexpected error occurred. Please try again.',
			'system.errors.loadingTimeoutConfig' => 'Error loading timeout configuration.',
			'system.errors.loadingCoordinatorConfig' => 'Error loading coordinator configuration. Please try again.',
			'system.errors.noPublicKey' => 'Your public key is not available. Cannot proceed.',
			'system.errors.internalOfferIncomplete' => 'Internal error: Offer details are incomplete. Please try again.',
			'system.errors.loadingPublicKey' => 'Error loading your public key. Please restart the app.',
			'system.blik.copied' => ({required Object code}) => '${code} code copied to clipboard',
			'myOffers.title' => 'My offers',
			'myOffers.empty' => 'No offers yet.',
			'myOffers.unknownCoordinator' => 'Unknown coordinator',
			'myOffers.menuLabel' => 'My offers',
			'myOffers.filter.all' => 'All',
			'myOffers.filter.active' => 'Active',
			'myOffers.filter.completed' => 'Completed',
			'myOffers.filter.failed' => 'Failed',
			'myOffers.details.title' => 'Offer Details',
			'myOffers.details.notFound' => 'Offer not found.',
			'myOffers.details.amount' => 'Amount',
			'myOffers.details.fees' => 'Fees',
			'myOffers.details.sats' => 'Satoshis',
			'myOffers.details.maker' => 'Maker',
			'myOffers.details.taker' => 'Taker',
			'myOffers.details.yourFee' => 'Your fee',
			'myOffers.details.makerFee' => 'Maker Fee',
			'myOffers.details.takerFee' => 'Taker Fee',
			'myOffers.details.coordinator' => 'Coordinator',
			'myOffers.details.createdAt' => 'Created',
			'myOffers.details.reservedAt' => 'Reserved',
			'myOffers.details.blikReceivedAt' => ({required Object code}) => '${code} Submitted',
			'myOffers.details.makerConfirmedAt' => 'Confirmed',
			'myOffers.details.settledAt' => 'Settled',
			'myOffers.details.takerPaidAt' => 'Taker Paid',
			'myOffers.details.id' => 'Offer ID',
			'myOffers.details.paymentHash' => 'Payment Hash',
			'myOffers.details.holdInvoice' => 'Hold Invoice',
			'myOffers.details.continueActiveOffer' => 'Continue active offer',
			'myOffers.details.after' => ({required Object duration}) => 'after ${duration}',
			'landing.mainTitle' => ({required Object code}) => 'Your ${code} ⇄ bitcoin Bridge',
			'landing.subtitle' => ({required Object code}) => 'Pay for or sell your ${code} code with bitcoin',
			'landing.partnership' => 'partnership',
			'landing.actions.payBlik' => ({required Object code}) => 'Pay ${code}',
			'landing.actions.payBlikSubtitle' => 'with bitcoin',
			'landing.actions.sellBlik' => 'Buy bitcoin',
			'landing.actions.sellBlikSubtitle' => ({required Object code}) => 'with ${code}',
			'landing.actions.howItWorks' => 'How it works?',
			'faq.screenTitle' => 'FAQ',
			'faq.tooltip' => 'FAQ',
			'settings.title' => 'Settings',
			'settings.offerCreation.title' => 'Offer creation',
			'settings.offerCreation.defaultCategory' => 'Default category',
			'settings.offerCreation.preferredCoordinator' => 'Preferred coordinator',
			'settings.offerCreation.automaticCoordinator' => 'Most reliable',
			'settings.offerCreation.automaticCoordinatorDescription' => 'Picks the coordinator with the best track record, combining your own completed offers and overall network activity.',
			'settings.offerCreation.cheapestCoordinator' => 'Cheapest',
			'settings.offerCreation.cheapestCoordinatorDescription' => 'Picks the available coordinator with the lowest maker fee for each offer.',
			'settings.offerCreation.enablePremium' => 'Enable premium pricing',
			'settings.offerCreation.enablePremiumDescription' => 'Show the premium slider when creating maker offers.',
			'settings.offerCreation.defaultPremium' => 'Default premium',
			'settings.offerCreation.defaultPremiumDisabled' => 'Enable premium pricing to set a default premium.',
			'settings.offerCreation.premiumPerCoordinatorNote' => 'Each coordinator sets its own maximum premium, so your default is capped by the coordinator used for an offer.',
			'settings.offerCreation.categoryOptions.shop' => 'Shop, café or restaurant',
			'settings.offerCreation.categoryOptions.atm' => 'ATM cash out',
			'settings.offerCreation.categoryOptions.online' => 'Online service/product',
			'settings.offerCreation.dialogs.selectCategory' => 'Select default category',
			'settings.offerCreation.dialogs.selectCoordinator' => 'Select preferred coordinator',
			'settings.offerCreation.dialogs.premiumHint' => 'Enter a percentage like 1.5. Values are rounded to 0.5% steps.',
			'settings.offerCreation.dialogs.premiumHelper' => 'Applied when premium pricing is enabled and clamped by the selected coordinator maximum.',
			'settings.display.title' => 'Display',
			'settings.display.bitcoinUnit' => 'Bitcoin unit',
			'settings.display.bitcoinUnitDescription' => 'Choose how bitcoin amounts are shown throughout the app.',
			'settings.display.unitOptions.sats' => 'sats',
			'settings.display.unitOptions.bitcoin' => '₿ (BIP-177)',
			'settings.paymentSystem.title' => 'Country / Payment System',
			'settings.paymentSystem.subtitle' => 'Choose your country\'s payment system.',
			'settings.paymentSystem.dialogTitle' => 'Select payment system',
			'settings.paymentSystem.countries.PL' => 'Poland',
			'settings.paymentSystem.countries.PT' => 'Portugal',
			'settings.paymentSystem.countries.CH' => 'Switzerland',
			'notificationSettings.title' => 'Notifications',
			'notificationSettings.androidOnly' => 'Background notifications are currently only supported on Android.',
			'notificationSettings.newOfferAlerts.label' => 'New offer alerts',
			'notificationSettings.newOfferAlerts.description' => ({required Object app}) => 'When enabled, ${app} will notify you about new offers available to take from your enabled coordinators while the app is in the background. This may be faster than external messengers.',
			'wallet.title' => 'Wallet',
			'wallet.description' => 'Manage your Lightning wallet settings',
			'wallet.missingReceiving.title' => 'Receiving wallet required',
			'wallet.missingReceiving.message' => 'No wallet configured for receiving. Add one in Wallet settings to take offers.',
			'wallet.missingReceiving.openSettings' => 'Wallet settings',
			'wallet.details.title' => 'Wallet details',
			'wallet.details.pendingTitle' => 'Pending transactions',
			'wallet.details.finishedTitle' => 'Finished transactions',
			'nwc.title' => 'Nostr Wallet Connect (NWC)',
			'nwc.description' => 'Connect your Lightning wallet via NWC',
			'nwc.labels.connectionString' => 'NWC Connection String',
			'nwc.labels.hint' => 'nostr+walletconnect://...',
			'nwc.labels.status' => 'Connection Status',
			'nwc.labels.connected' => 'Connected',
			'nwc.labels.disconnected' => 'Disconnected',
			'nwc.labels.scanQrCode' => 'Scan QR code with your NWC connection',
			'nwc.labels.balance' => 'Balance',
			'nwc.labels.budget' => 'Budget',
			'nwc.labels.usedBudget' => 'Used',
			'nwc.labels.totalBudget' => 'Total',
			'nwc.labels.renewsIn' => 'Renews in',
			'nwc.labels.renewalPeriod' => 'Renewal Period',
			'nwc.labels.relay' => 'Relay',
			'nwc.labels.relays' => 'Relays',
			'nwc.prompts.enter' => 'Enter your NWC connection string',
			'nwc.prompts.connect' => 'Connect Wallet',
			'nwc.prompts.disconnect' => 'Disconnect',
			'nwc.prompts.confirmDisconnect' => 'Are you sure you want to disconnect your NWC wallet?',
			'nwc.prompts.pasteConnection' => 'Paste connection string',
			'nwc.prompts.chooseMethod' => 'Choose how to connect your Lightning wallet',
			'nwc.prompts.howToGet' => 'Don\'t have an NWC connection yet? Learn how to get one!',
			'nwc.prompts.learnMore' => 'Learn more about NWC',
			'nwc.actions.connectAlbyGo' => 'Connect with Alby Go',
			'nwc.actions.connectNwc' => 'Scan NWC QR Code',
			'nwc.feedback.connected' => 'NWC wallet connected successfully!',
			'nwc.feedback.disconnected' => 'NWC wallet disconnected',
			'nwc.feedback.connecting' => 'Connecting to NWC wallet...',
			'nwc.feedback.loadingWalletInfo' => 'Loading wallet information...',
			'nwc.errors.connecting' => ({required Object details}) => 'Error connecting to NWC: ${details}',
			'nwc.errors.disconnecting' => ({required Object details}) => 'Error disconnecting NWC: ${details}',
			'nwc.errors.invalid' => 'Invalid NWC connection string',
			'nwc.errors.required' => 'NWC connection string is required',
			'nwc.errors.loadingBalance' => 'Failed to load wallet balance',
			'nwc.errors.loadingBudget' => 'Failed to load wallet budget',
			'nwc.time.minutes' => ({required Object count}) => '${count}m',
			'nwc.time.hours' => ({required Object count}) => '${count}h',
			'nwc.time.days' => ({required Object count}) => '${count}d',
			'nwc.time.justNow' => 'just now',
			'nekoManagement.title' => 'Neko',
			'relays.title' => 'Relays',
			'relays.coordinatorRelays' => 'Coordinator relays',
			'relays.discoveryRelays' => 'Discovery relays',
			'relays.status.connected' => 'Connected',
			'relays.status.connecting' => 'Connecting',
			'relays.status.reconnecting' => 'Reconnecting',
			'relays.status.disconnected' => 'Disconnected',
			'relays.popup.title' => ({required Object connected, required Object total}) => 'Relays (${connected}/${total} connected)',
			'relays.popup.connectingMessage' => 'Connecting to relays...',
			'offerNotifications.activeService.title' => 'Waiting for new offers',
			'offerNotifications.activeService.body' => ({required Object app}) => 'Nostr service monitoring events of ${app} offers.',
			'offerNotifications.funded.title' => 'Offer funded',
			'offerNotifications.funded.body' => 'Your hold invoice was accepted. Offer is now live.',
			'offerNotifications.reserved.title' => 'Offer reserved',
			'offerNotifications.reserved.body' => 'A taker has reserved your offer.',
			'offerNotifications.blikReady.title' => ({required Object code}) => '${code} code ready',
			'offerNotifications.blikReady.body' => ({required Object code}) => 'Your ${code} code is ready to view.',
			'offerNotifications.newOffer.title' => 'New offer available',
			'offerNotifications.newOffer.body' => ({required Object amount, required Object currency, required Object sats}) => '${amount} ${currency} · ${sats}',
			'offerNotifications.newOffer.premiumSuffix' => ({required Object percent}) => '+${percent}% premium',
			'offerNotifications.categories.shop' => 'Shop',
			'offerNotifications.categories.atm' => 'ATM',
			'offerNotifications.categories.online' => 'Online',
			'offerNotifications.blikPendingReminder.title' => ({required Object code}) => '${code} waiting for your action',
			'offerNotifications.blikPendingReminder.body' => ({required Object code}) => 'Confirm the payment or mark the ${code} code as invalid.',
			'offerNotifications.takerCharged.title' => ({required Object code}) => '${code} charged',
			'offerNotifications.takerCharged.body' => ({required Object code}) => 'Taker reports ${code} was charged. Confirm or mark as invalid.',
			'offerNotifications.invalidBlik.title' => ({required Object code}) => '${code} marked invalid',
			'offerNotifications.invalidBlik.body' => ({required Object code}) => 'Maker marked your ${code} code as invalid.',
			'offerNotifications.takerPaid.title' => 'Payment received',
			'offerNotifications.takerPaid.body' => 'Your Lightning payment has been sent.',
			'altstore.dialogTitle' => 'AltStore Not Installed',
			'altstore.step1Title' => 'Download and install AltStore PAL',
			'altstore.step1Button' => 'altstore.io/download',
			'altstore.step1Warning' => 'You need Safari to install AltStore PAL!',
			'altstore.step2Title' => ({required Object app}) => 'Install ${app}',
			'altstore.step2Button' => ({required Object app}) => 'Install ${app}',
			'altstore.step2Fallback' => 'Still not working? Paste the source into AltStore',
			_ => null,
		};
	}
}
