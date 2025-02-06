import 'dart:math';

/// Generates a UUID v7 string according to RFC 9562.
/// https://www.rfc-editor.org/rfc/rfc9562.html#name-uuid-version-7
///
/// Returns a 36-character string in the format:
/// `xxxxxxxx-xxxx-7xxx-yxxx-xxxxxxxxxxxx` where:
/// - `x` is any hexadecimal digit
/// - `7` indicates version 7
///
/// Example:
/// ```dart
/// final uuid = generateUuidV7String();
/// print(uuid); // for ex.: 0189e85d-3725-7abc-89ab-1234567890ab
/// ```
///
/// The generated UUIDs are:
/// - Time-ordered (monotonically increasing)
/// - Unique across multiple generations
/// - Suitable for database primary keys
///
/// If [random] is not provided, uses [Random.secure()] for cryptographically
/// secure random number generation. You can provide your own [Random] instance
/// for testing or specific use cases.
String generateUuidV7String([Random? random]) {
  final dashLess = _generateUuidV7(random).toRadixString(16).padLeft(32, '0');
  return '${dashLess.substring(0, 8)}-'
      '${dashLess.substring(8, 12)}-'
      '${dashLess.substring(12, 16)}-'
      '${dashLess.substring(16, 20)}-'
      '${dashLess.substring(20)}';
}

BigInt _generateUuidV7([Random? random]) {
  random ??= Random.secure();

  BigInt result = BigInt.from(DateTime.now().millisecondsSinceEpoch);

  result <<= 4;
  result |= BigInt.from(0x7); // 0b0111

  result <<= 12;
  result |= BigInt.from(
      random.nextInt(0xFFF + 1)); // max number represented by 12 bits

  result <<= 2;
  result |= BigInt.from(0x2); // 0b10

  result <<= 30;
  result |= BigInt.from(
      random.nextInt(0x3FFFFFFF + 1)); // max number represented by 30 bits
  result <<= 32;
  result |= BigInt.from(
      random.nextInt(0xFFFFFFFF + 1)); // max number represented by 32 bits

  return result;
}
