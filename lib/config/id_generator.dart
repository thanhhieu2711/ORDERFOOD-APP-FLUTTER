import 'dart:math';

String generateId(int length) {
  final rand = Random();
  final codeUnits = List.generate(length, (index) {
    return rand.nextInt(10) + 48;
  });
  return '1' + String.fromCharCodes(codeUnits);
}
