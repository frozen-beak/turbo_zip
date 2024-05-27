import 'package:test/test.dart';
import 'package:turbo_zip/turbo_zip.dart';

void main() {
  group('LZW', () {
    test('Encode and Decode', () {
      final String plainText = "TO_BE&OR*NOT-TO/BE";
      final compressedText = LZW.encode(plainText);
      final String decompressedText = LZW.decode(compressedText);

      expect(decompressedText, equals(plainText));
    });

    test('Encode with unsupported character', () {
      // Unicode characters are not supported
      final encodedText = "TurboZip is 😎🔥";

      expect(() => LZW.encode(encodedText), throwsUnsupportedError);
    });

    test('Decode with bad compressed code', () {
      // XZ is not valid encoding
      final encodedText = [1, 2, 3, 4, 5, 1450];

      expect(() => LZW.decode(encodedText), throwsArgumentError);
    });
  });
}
