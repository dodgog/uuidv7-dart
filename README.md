# UUID v7 for Dart

A Dart implementation of UUID version 7 (UUIDv7) as specified in [RFC 9562](https://www.rfc-editor.org/rfc/rfc9562.html#name-uuid-version-7). UUIDv7 provides a time-ordered, unique identifier that's suitable for database primary keys and distributed systems.

## Features

- UUIDv7
- Efficient implementation
- Option to seed it with a custom generator
- Pure Dart implementation with no external dependencies

## Usage

```dart
// Generate multiple UUIDs
for (int i = 0; i < 3; i++) {
  final uuid = generateUuidV7String();
  print(uuid);
}
```

You can also provide your own Random instance (useful for testing):

```dart
import 'dart:math';

// Using a custom random number generator
final customRandom = Random(42);
final uuid = generateUuidV7String(customRandom);
```