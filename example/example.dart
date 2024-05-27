import 'package:turbo_zip/turbo_zip.dart';

void main() {
  final String originalText = "TO BE OR NOT TO BE OR TO BE OR NOT";

  final List<int> encodedText = LZW.encode(originalText);
  print("Encoded Text : $encodedText");

  final String decodedText = LZW.decode(encodedText);
  print("Decoded Text: $decodedText");

  print(originalText == decodedText); // true
}
