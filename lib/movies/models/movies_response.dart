import 'package:json_annotation/json_annotation.dart';
import 'package:marquee/movies/models/movie.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class const MoviesResponse({
  required final int page,
  required final int totalPages,
  required final int totalResults,
  final List<Movie> results = const [],
}) {
  factory fromJson(Map<String, dynamic> json) => _$MoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);
}
