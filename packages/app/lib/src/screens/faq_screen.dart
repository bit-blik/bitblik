import 'dart:async'; // Import for StreamSubscription
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:bitblik_core/core.dart';
import '../../i18n/gen/strings.g.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../providers/providers.dart';

class FaqScreen extends ConsumerStatefulWidget {
  const FaqScreen({super.key});

  static const routeName = '/faq';
  @override
  ConsumerState<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends ConsumerState<FaqScreen> {
  String? _htmlContent;
  bool _isLoading = true;
  String _error = '';
  StreamSubscription<AppLocale>? _localeSubscription;
  AppLocale? _currentLocale;

  @override
  void initState() {
    super.initState();
    try {
      _currentLocale = LocaleSettings.currentLocale;
    } catch (e) {
      Logger.log.w(
        () => 'FAQ Screen: failed to read current locale during initState, '
            'defaulting to English. Error: $e',
      );
      _currentLocale = AppLocale.en;
    }
    _loadFaqContent(); // Initial load

    try {
      _localeSubscription = LocaleSettings.getLocaleStream().listen((locale) {
        // Check if the locale actually changed to avoid redundant loads if the stream emits the same locale
        if (_currentLocale != locale) {
          Logger.log.d(
            () => "FAQ Screen: Locale changed to $locale, reloading content.",
          );
          _currentLocale = locale;
          _loadFaqContent();
        }
      });
    } catch (e) {
      Logger.log.w(
        () => 'FAQ Screen: failed to subscribe to locale stream. Error: $e',
      );
    }
  }

  // Remove didChangeDependencies as locale changes are now handled by the stream
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final currentLocale = LocaleSettings.currentLocale;
  //   if (_htmlContent == null || (_previousLocale != null && _previousLocale != currentLocale)) {
  //     _loadFaqContent();
  //   }
  //   _previousLocale = currentLocale;
  // }

  @override
  void dispose() {
    _localeSubscription?.cancel();
    super.dispose();
  }

  /// Replace `{app}`, `{code}`, `{codeLength}`, `{country}`, `{validity}` in the
  /// FAQ markdown with the active payment system's values.
  String _applyTokens(String text) {
    final ps = ref.read(selectedPaymentSystemProvider);
    String countryName = ps.country;
    try {
      final c = Translations.of(
        context,
      )['settings.paymentSystem.countries.${ps.country}'];
      if (c is String && c.isNotEmpty) countryName = c;
    } catch (_) {}
    return text
        .replaceAll('{app}', ps.brandName)
        .replaceAll('{codeLength}', '${ps.codeLength}')
        .replaceAll('{code}', ps.codeLabel)
        .replaceAll('{country}', countryName)
        .replaceAll('{validity}', '${ps.codeValidityMinutes}');
  }

  Future<String> _loadMarkdownAsset(String assetKey) async {
    if (kIsWeb) {
      final assetUri = Uri.base.resolve('assets/$assetKey');
      final response = await http.get(assetUri);
      if (response.statusCode != 200) {
        throw Exception(
          'HTTP load failed for $assetKey '
          '(status ${response.statusCode})',
        );
      }

      return utf8.decode(response.bodyBytes);
    }

    return await rootBundle.loadString(assetKey);
  }

  Future<void> _loadFaqContent() async {
    // Use _currentLocale which is updated by the stream listener, or fallback to LocaleSettings.currentLocale
    // This ensures that if _loadFaqContent is called before the stream listener has a chance to update _currentLocale
    // (e.g. during initState), it still uses the correct, most up-to-date locale.
    final localeToLoad = _currentLocale ?? LocaleSettings.currentLocale;
    Logger.log.d(() => "FAQ Screen: Loading content for locale: $localeToLoad");

    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      // final locale = LocaleSettings.currentLocale; // Use localeToLoad instead
      final String langCode = localeToLoad.languageCode.toLowerCase();

      // Brand slug follows the *active payment system* (not the compile-time
      // app flavor), so e.g. a Bittwint user who switches to MB WAY sees the
      // ATM-focused BitWay FAQ. FAQs live under assets/faq/<slug>/faq_<lang>.md;
      // fall back to the brand's English file, then to the generic Bitblik FAQ
      // when no per-brand file exists for the language.
      final String slug =
          ref.read(selectedPaymentSystemProvider).brandName.toLowerCase();
      final candidates = <String>[
        'assets/faq/$slug/faq_$langCode.md',
        'assets/faq/$slug/faq_en.md',
        'assets/faq/bitblik/faq_$langCode.md',
        'assets/faq/bitblik/faq_en.md',
      ];

      String? markdownData;
      for (final filePath in candidates) {
        try {
          markdownData = await _loadMarkdownAsset(filePath);
          break;
        } catch (e) {
          Logger.log.w(
            () => 'Could not load FAQ asset $filePath. Trying next. Error: $e',
          );
        }
      }
      if (markdownData == null) {
        throw Exception(
          'Failed to load FAQ content for $slug/$langCode and fallbacks.',
        );
      }

      // Convert Markdown to HTML, then substitute payment-system tokens on the
      // final string (BitBlik/BLIK/Poland/6-digit → BitWay/MB WAY/Portugal/
      // 10-digit, etc.) so nothing can slip past the renderer.
      final html = _applyTokens(
        md.markdownToHtml(
          markdownData,
          inlineSyntaxes: [md.InlineHtmlSyntax()],
        ),
      );

      setState(() {
        _htmlContent = html; // Store HTML content
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load FAQ content: ${e.toString()}';
      });
      Logger.log.e(() => 'Error loading FAQ: $_error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reload when the user switches payment system (e.g. BLIK -> MB WAY), since
    // the FAQ slug is derived from the active payment system's brand. ref.listen
    // must run inside build(), not initState().
    ref.listen<PaymentSystem>(
      selectedPaymentSystemProvider,
      (previous, next) {
        if (previous?.id != next.id) {
          Logger.log.d(
            () => "FAQ Screen: payment system changed "
                "${previous?.id} -> ${next.id}, reloading content.",
          );
          _loadFaqContent();
        }
      },
    );

    // final t = Translations.of(context); // Access translations if needed for other parts

    Widget backButton = Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
        tooltip: 'Back',
      ),
    );

    if (_isLoading) {
      return Column(
        children: [
          backButton,
          const Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      );
    }

    if (_error.isNotEmpty) {
      return Column(
        children: [
          backButton,
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (_htmlContent == null) {
      return Column(
        children: [
          backButton,
          const Expanded(
            child: Center(child: Text('No FAQ content available.')),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        16.0,
      ), // Apply padding to SingleChildScrollView
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow button at the top
          backButton,
          // FAQ content
          Html(
            data: _htmlContent!,
            onLinkTap: (url, attributes, element) {
              if (url != null) {
                launchUrlString(url);
              }
            },
            // You can customize styles using the style parameter for flutter_html
            // style: {
            //   "h1": Style(textAlign: TextAlign.center),
            //   // Add more styles as needed
            // },
          ),
        ],
      ),
    );
  }
}
