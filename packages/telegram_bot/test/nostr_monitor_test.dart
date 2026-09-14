import 'dart:convert';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_telegram_bot/src/nostr_monitor.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

CoordinatorInfo announcedInfo({
  String name = 'Announced Coordinator',
  String? icon = 'https://example.com/announced.png',
}) =>
    CoordinatorInfo.fromNostrEvent(Nip01Event(
      pubKey: 'a' * 64,
      kind: kKindCoordinatorInfo,
      content: '',
      tags: [
        ['name', name],
        ['icon', icon ?? ''],
        ['payment_system', 'blik'],
      ],
    ));

Nip01Event profile(Map<String, Object?> content) => Nip01Event(
      pubKey: 'a' * 64,
      kind: Metadata.kKind,
      content: jsonEncode(content),
      tags: const [],
    );

void main() {
  test('kind-0 display name overrides the announcement name', () {
    final identity = coordinatorIdentity(
      profile({
        'display_name': 'Profile Display Name',
        'name': 'profile_user',
        'picture': 'https://example.com/profile.png',
      }),
      announcedInfo(),
    );

    expect(identity.name, 'Profile Display Name');
  });

  test('falls back through kind-0 name to kind-15125 identity', () {
    final username = coordinatorIdentity(
      profile({'name': 'profile_user', 'picture': 'javascript:bad'}),
      announcedInfo(),
    );
    final announced = coordinatorIdentity(
      profile({'display_name': ' ', 'name': ''}),
      announcedInfo(),
    );

    expect(username.name, 'profile_user');
    expect(announced.name, 'Announced Coordinator');
  });
}
