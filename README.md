# TurboZip 🚀🤐

[![pub package](https://img.shields.io/pub/v/turbo_zip.svg?logo=dart&logoColor=00b9fc)](https://pub.dev/packages/turbo_zip)
[![CI](https://img.shields.io/github/actions/workflow/status/AdityaMotale/turbo_zip/unit_tests.yaml?branch=main&logo=github-actions&logoColor=white)](https://github.com/AdityaMotale/turbo_zip/actions)
[![Last Commits](https://img.shields.io/github/last-commit/AdityaMotale/turbo_zip?logo=git&logoColor=white)](https://github.com/AdityaMotale/turbo_zip/commits/main)
[![Pull Requests](https://img.shields.io/github/issues-pr/AdityaMotale/turbo_zip?logo=github&logoColor=white)](https://github.com/AdityaMotale/turbo_zip/pulls)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/AdityaMotale/turbo_zip?logo=github&logoColor=white)](https://github.com/AdityaMotale/turbo_zip/issues)
[![License](https://img.shields.io/github/license/AdityaMotale/turbo_zip?logo=open-source-initiative&logoColor=green)](https://github.com/AdityaMotale/turbo_zip/blob/main/LICENSE)

A dart library containing various algorithms for encoding and decoding text and numbers with compression.

## Quick Links

- [Installation](#installation)
- [Algorithms](#algorithms)
- [Contributing](#contributing)

## Installation

You can directly install `TurboZip` by adding `turbo_zip: ^1.0.0` to your _pubspec.yaml_ dependencies section

You can also add `TurboZip` to your project by executing,

- For Flutter Project - `flutter pub add turbo_zip`
- For Dart Project - `dart pub add turbo_zip`

## Algorithms

### LZW (Lempel-Ziv-Welch)

LZW compresses data by replacing repeated substrings with shorter codes, creating a dictionary
dynamically during encoding. It's a lossless method used in _GIF Images_ and _Unix File_ compression.

_LZW_ performs significantly faster then GZip in dart code. Have a look at
[benchmark results](./benchmark/lzw/results.txt).

Here is how you can use `LZW` in your code,

```dart
import 'package:turbo_zip/turbo_zip.dart';

final String originalText = "TO BE OR NOT TO BE OR TO BE OR NOT";

final List<int> encodedText = LZW.encode(originalText);
print("Encoded Text : $encodedText");

final String decodedText = LZW.decode(encodedText);
print("Decoded Text: $decodedText");

print(originalText == decodedText); // true
```

> 👉 Note: Unicode characters like emojis are currently not supported by `LZW`. Keep in mind to handle exceptions thrown by both `encode` and `decode` functions of _LZW_ in your code.

## Benchmarks

To benchmark `turbo_zip` algorithms against industry leading algorithms, dart scripts are created in
`./benchmarks/`. Check them out [here](./benchmark/).

## Contributing

PR's and Issues are open! If you'd like to improve `TurboZip`, please open an issue or an PR with
your suggested changes in this [repo](https://github.com/AdityaMotale/turbo_zip). Happy Coding 🤝!
