import 'dart:math';

abstract class RandomNumberGenerator {
  static int randomInRange({required int min, required int max}) {
    final random = Random();
    return min + random.nextInt(max - min);
  }
}
