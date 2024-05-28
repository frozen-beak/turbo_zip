import 'dart:convert';

import 'package:turbo_zip/turbo_zip.dart';
import 'dart:io';

void main() async {
  await benchMarkBigFile();
  print("");
  await benchmarkSmallTexts();
}

Future<void> benchmarkSmallTexts() async {
  final longData = await _readFileData();
  final dataList = longData.split("\n");

  double totalLzwCompression = 0;
  double totalGzipCompression = 0;
  int validTextCount = 0;
  int totalTextCount = 0;

  for (String text in dataList) {
    if (text.isEmpty) continue;

    final lzwEncoded = LZW.encode(text);
    final gzipEncoded = _gzipCompress(text);

    final lzwCompression = (1 - (lzwEncoded.length / text.length)) * 100;
    final gzipCompression = (1 - (gzipEncoded.length / text.length)) * 100;

    totalLzwCompression += lzwCompression;
    totalGzipCompression += gzipCompression;

    totalTextCount += text.length;

    validTextCount++;
  }

  final avgLzwCompression =
      validTextCount > 0 ? totalLzwCompression / validTextCount : 0;

  final avgGzipCompression =
      validTextCount > 0 ? totalGzipCompression / validTextCount : 0;

  final avgTextCount = totalTextCount / dataList.length;

  print("-" * 50);
  print("Small Texts Benchmark Results:");
  print("-" * 50);
  print("Total texts: ${dataList.length}");
  print("Average Text length: ${avgTextCount.toStringAsFixed(2)} characters");
  print("Average LZW Compression: ${avgLzwCompression.toStringAsFixed(2)}%");
  print("Average GZIP Compression: ${avgGzipCompression.toStringAsFixed(2)}%");
  print("-" * 50);
}

Future<void> benchMarkBigFile() async {
  final originalText = await _readFileData();
  final lzwEncoded = LZW.encode(originalText);
  final gzipEncoded = _gzipCompress(originalText);

  final gzipCompression =
      (1 - (gzipEncoded.length / originalText.length)) * 100;

  final lzwCompression = (1 - (lzwEncoded.length / originalText.length)) * 100;

  print("-" * 50);
  print("Big File Benchmark Results:");
  print("-" * 50);
  print("Original Length: ${originalText.length}");
  print("LZW Encoded Length: ${lzwEncoded.length}");
  print("GZIP Encoded Length: ${gzipEncoded.length}");
  print("LZW Compression: ${lzwCompression.toStringAsFixed(2)}%");
  print("GZIP Compression: ${gzipCompression.toStringAsFixed(2)}%");
  print("-" * 50);
}

Future<String> _readFileData() async {
  final file = File('C:/dev/turbo_zip/benchmarks/docs/shakespeare.txt');

  final text = await file.readAsString();

  return text;
}

List<int> _gzipCompress(String text) {
  final List<int> encoded = utf8.encode(text);

  return gzip.encode(encoded);
}
