import 'dart:math';

import 'package:marquee/movies/models/movie.dart';

extension MovieDisplay on Movie {
  static final RegExp _leadingArticle = RegExp(
    r'^(the|a|an)\s+',
    caseSensitive: false,
  );
  static final RegExp _nonLetter = RegExp('[^A-Za-z]');
  static const int _posterCodeLength = 3;

  String get posterCode {
    final stripped = title.replaceFirst(_leadingArticle, '');
    final letters = stripped.replaceAll(_nonLetter, '').toUpperCase();

    return letters.substring(0, min(letters.length, _posterCodeLength));
  }

  String get runtimeLabel => switch (runtime) {
    final runtime? => '${runtime}m',
    _ => '',
  };

  String get ratingLabel => voteAverage.toStringAsFixed(1);
}
