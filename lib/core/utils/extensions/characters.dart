import 'package:flutter/material.dart';

extension CharactersExtension on Characters {
  Characters replaceAt(int index, Characters replacement) {
    final characters = toList();
    characters[index] = replacement.string;

    return characters.join().characters;
  }

  Characters padRight(int width, [String padding = ' ']) {
    return length < width
        ? this + (padding * (width - length)).characters
        : string.characters;
  }
}
