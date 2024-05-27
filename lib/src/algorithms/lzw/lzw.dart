import '../../constants/decode_dictionary.dart';
import '../../constants/encode_dictionary.dart';

///
/// Implementation of the TurboZip repository using the LZW (Lempel-Ziv-Welch)
/// algorithm.
///
/// This class provides methods to encode and decode plain text
///
class LZW {
  ///
  /// Encodes and compresses a string using LZW algorithm
  ///
  /// **Note:** This function throws an `UnsupportedError` if the input
  /// character is not supported by the algorithm.
  ///
  /// ```
  /// final String plainText = "TO BE OR NOT TO BE";
  /// final compressedText = LZW().encode(plainText);
  ///
  /// print(compressedText);
  /// ```
  ///
  static List<int> encode(String plainText) {
    try {
      // mutable reference of pre-defined [kEncodeDictionary] length
      int dictSize = kEncodeDictionary.length;

      // Mutable version of pre-defined [kEncodeDictionary]
      Map<String, int> dictionary = Map.from(kEncodeDictionary);

      // Indicates the current sequence in [plainText], used while iteration
      String w = "";

      List<int> result = [];

      for (int i = 0; i < plainText.length; i++) {
        String c = plainText[i];
        String wc = w + c;
        if (dictionary.containsKey(wc)) {
          w = wc;
        } else {
          final localW = dictionary[w];

          if (localW == null) {
            throw UnsupportedError(
              "Input text contains unsupported characters by the algorithm: $w",
            );
          }

          result.add(localW);

          // Add [wc] to the dictionary.
          dictionary[wc] = dictSize;
          dictSize++;
          w = c;
        }
      }

      // Output the code for [w].
      if (w.isNotEmpty) {
        final localW = dictionary[w];

        if (localW == null) {
          throw UnsupportedError(
            "Input text contains unsupported characters by the algorithm: $w",
          );
        }

        result.add(localW);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Decodes and decompresses an encoded string using LZW algorithm.
  ///
  /// **Note:** This function throws an `ArgumentError` if the input contains
  /// invalid encodings.
  ///
  /// ```
  /// final String plainText = "TO BE OR NOT TO BE";
  ///
  /// final compressedText = LZW().encode(plainText);
  /// final decompressedText = LZW().decode(compressedText);
  ///
  /// print(decompressedText == plainText);
  /// ```
  ///
  static String decode(List<int> encodedData) {
    try {
      int dictSize = kDecodeDictionary.length;
      Map<int, String> dictionary = Map.from(kDecodeDictionary);

      String w = String.fromCharCode(encodedData.removeAt(0));
      List<String> result = [w];

      for (int k in encodedData) {
        String entry;
        if (dictionary.containsKey(k)) {
          entry = dictionary[k]!;
        } else if (k == dictSize) {
          entry = w + w[0];
        } else {
          throw ArgumentError('Text includes a bad compressed code: $k');
        }

        result.add(entry);

        dictionary[dictSize] = w + entry[0];
        dictSize++;

        w = entry;
      }
      return result.join('');
    } catch (e) {
      rethrow;
    }
  }
}
