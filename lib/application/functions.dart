import 'dart:math';

int randomNumber({required int min, required int max}) {
  return min + Random().nextInt(max - min);
}
