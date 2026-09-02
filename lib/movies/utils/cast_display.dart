import 'package:flutter/material.dart';
import 'package:marquee/movies/models/cast_member.dart';

extension CastDisplay on CastMember {
  static const int _maxNameWords = 2;
  static final RegExp _whitespace = RegExp(r'\s+');
  static final RegExp _nonLetter = RegExp('[^A-Za-z]');

  String get initials {
    final letters = name
        .trim()
        .split(_whitespace)
        .map((name) => name.replaceAll(_nonLetter, ''))
        .where((name) => name.isNotEmpty)
        .take(_maxNameWords)
        .map((word) => word.characters.first.toUpperCase())
        .join();

    return letters.isEmpty ? '?' : letters;
  }

  String get shortName {
    final names = name
        .trim()
        .split(_whitespace)
        .where((name) => name.isNotEmpty)
        .toList();

    if (names.length < _maxNameWords) return name;

    final [firstName, lastName, ...] = names;

    return '$firstName ${lastName.characters.first.toUpperCase()}.';
  }
}
