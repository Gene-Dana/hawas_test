import 'dart:async';

/// Class which exposes a `tick` method to emit values periodically.
class Ticker {
  /// Emits a new `int` up to 10 every second.
  Stream<int> tick() {
    return Stream.periodic(const Duration(milliseconds: 500), (x) => x)
        .take(100);
  }
}
