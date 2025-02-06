import 'dart:math';
import 'package:uuidv7/uuidv7.dart';

void main() {
  // Generate a single UUID v7
  final uuid = generateUuidV7String();
  print('Single UUID v7: $uuid');

  // Generate multiple UUIDs (they will be time-ordered)
  print('\nGenerating multiple UUIDs:');
  for (int i = 0; i < 5; i++) {
    final uuid = generateUuidV7String();
    print('UUID $i: $uuid');
  }

  // Using a custom random number generator (for reproducible results)
  final customRandom = Random(42);
  final uuidWithCustomRandom = generateUuidV7String(customRandom);
  print('\nUUID with custom Random: $uuidWithCustomRandom');
}
