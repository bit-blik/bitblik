import 'package:bitblik/main_bitblik.dart' show routerProvider;
import 'package:bitblik/src/utils/app_link_uri.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _nsite =
    'https://npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3.nsite.lol';
const _bitwayNsite =
    'https://npub180nj93uqjvvjksryaxaz8fk9gxwwtg06gxlkd5csrj6rqfg3phhs09n5s9.nsite.lol';

void main() {
  for (final (link, expected) in [
    ('$_nsite/app', '/'),
    ('$_nsite/app/', '/'),
    ('$_nsite/app/offers', '/offers'),
    ('$_nsite/app/offers/offer-123', '/offers/offer-123'),
    ('$_nsite/app/settings/display', '/settings/display'),
    ('$_bitwayNsite/app', '/'),
    ('$_bitwayNsite/app/offers/offer-123', '/offers/offer-123'),
    ('/app/offers/offer-123', '/offers/offer-123'),
    ('$_nsite/app/#/offers/offer-123', '/offers/offer-123'),
    ('https://bitblik.app/#/offers/offer-123', '/offers/offer-123'),
    (
      '$_nsite/app/offers/offer-123?source=link#details',
      '/offers/offer-123?source=link#details',
    ),
    ('https://bitblik.app/offers/offer-123', '/offers/offer-123'),
    ('https://app.veks.li/offers/offer-123', '/offers/offer-123'),
    ('/offers/offer-123', '/offers/offer-123'),
  ]) {
    testWidgets('native app link $link resolves to $expected', (tester) async {
      tester.binding.platformDispatcher.defaultRouteNameTestValue = link;
      addTearDown(
        tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
      );
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final router = container.read(routerProvider);
      addTearDown(router.dispose);
      // The router has captured the platform link. Keep the test's host widget
      // from independently trying to resolve it with MaterialApp's Navigator.
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue();
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      final context = tester.element(find.byType(SizedBox));

      final match = await router.routeInformationParser
          .parseRouteInformationWithDependencies(
            router.routeInformationProvider.value,
            context,
          );

      expect(match.error, isNull);
      expect(match.uri.toString(), expected);
      if (expected.startsWith('/offers/offer-123')) {
        expect(match.pathParameters['id'], 'offer-123');
      }

      // Warm links enter through the same parser after a platform route update.
      router.go('/wallet');
      router.go(link);
      final warmMatch = await router.routeInformationParser
          .parseRouteInformationWithDependencies(
            router.routeInformationProvider.value,
            context,
          );
      expect(warmMatch.error, isNull);
      expect(warmMatch.uri.toString(), expected);
    });
  }

  test(
    'normalization preserves URI encoding and repeated query parameters',
    () {
      final uri = normalizeAppLinkUri(
        Uri.parse('$_nsite/app/offers/a%2Fb?tag=one&tag=two&q=a%2Bb#details'),
      );
      expect(uri.toString(), '/offers/a%2Fb?tag=one&tag=two&q=a%2Bb#details');
      expect(uri.pathSegments, ['offers', 'a/b']);
    },
  );

  test('only the complete leading app segment is removed', () {
    for (final path in ['/application', '/app-other/offers', '/offers/app']) {
      expect(normalizeAppLinkUri(Uri.parse(path)).toString(), path);
    }
  });

  test('wallet and custom-scheme callbacks remain unchanged', () {
    for (final link in [
      'nostr+walletconnect://wallet?relay=wss%3A%2F%2Frelay.example&secret=test',
      'bitblik://nwc-callback?value=test&state=correlation',
      'bitway://nwc-callback?value=test',
      'bittwint://offers',
    ]) {
      final uri = Uri.parse(link);
      expect(normalizeAppLinkUri(uri), uri);
    }
  });
}
