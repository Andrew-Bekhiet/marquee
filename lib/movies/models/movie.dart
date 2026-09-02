import 'package:json_annotation/json_annotation.dart';
import 'package:marquee/movies/models/genre.dart';

part 'movie.g.dart';

@JsonSerializable()
class const Movie({
  required final int id,
  final String title = '',
  final String originalTitle = '',
  final String originalLanguage = '',
  final String overview = '',
  final double popularity = 0,
  final double voteAverage = 0,
  final int voteCount = 0,
  final bool adult = false,
  final bool video = false,
  final String? posterPath,
  final String? backdropPath,
  final DateTime? releaseDate,
  final List<int>? genreIds,
  final List<Genre>? genres,
  final int? runtime,
}) {
  static const _tmdbMovieImageBaseUrl = 'https://image.tmdb.org/t/p';

  factory fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  String? posterUrl({int width = 500}) {
    if (posterPath case null || '') return null;

    return '$_tmdbMovieImageBaseUrl/w$width$posterPath';
  }

  String? backdropUrl({int width = 780}) {
    if (backdropPath case null || '') return null;

    return '$_tmdbMovieImageBaseUrl/w$width$backdropPath';
  }
}
