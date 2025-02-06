import 'dart:math';
import 'package:uuidv7/uuidv7.dart';
import 'package:test/test.dart';

void main() {
  test('UUID v7 generator', () {
    final uuidString = generateUuidV7String(Random(0));
    final uuidV7Regex = RegExp(
        r'^[0-9A-F]{8}-[0-9A-F]{4}-7[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
        caseSensitive: false);
    expect(uuidV7Regex.hasMatch(uuidString), isTrue,
        reason: 'UUID matches regex');

    expect(uuidString.substring(13), equals('-738f-bca4-9501e38b961c'),
        reason: 'UUID version, variant, and random part expected');

    final uuidTimeSubstring = uuidString.substring(0, 13).replaceAll('-', '');
    final parsedUuidTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(uuidTimeSubstring, radix: 16));
    expect(parsedUuidTime.difference(DateTime.now()),
        lessThan(const Duration(seconds: 1)),
        reason: 'UUID time encoded must be close to now');
  });

  test('UUID v7 properties', () async {
    final uuids = <String>[];
    BigInt? previousUuid;

    for (int i = 0; i < 100; i++) {
      final uuidString = generateUuidV7String();

      expect(uuidString.length, equals(36),
          reason: 'UUID with dashes should be 36 characters long');
      final uuidStringDashLess = uuidString.replaceAll('-', '');
      expect(uuidStringDashLess.length, equals(32),
          reason: 'UUID without dashes should be 32 characters long');

      expect(uuids.contains(uuidStringDashLess), isFalse,
          reason: 'UUID should be unique');
      uuids.add(uuidStringDashLess);

      final currentUuid = BigInt.parse(uuidStringDashLess, radix: 16);
      if (previousUuid != null) {
        expect(currentUuid > previousUuid, isTrue,
            reason: 'UUID should be greater than the previous one');
      }
      previousUuid = currentUuid;

      await Future.delayed(const Duration(milliseconds: 1));
    }
  });
}
