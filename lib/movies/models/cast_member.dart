import 'package:json_annotation/json_annotation.dart';
import 'package:marquee/movies/utils/tmdb_image_url.dart';

part 'cast_member.g.dart';

@JsonSerializable()
class const CastMember({
  required final int id,
  final String name = '',
  final String character = '',
  final String? profilePath,
  final int order = 0,
}) {
  factory fromJson(Map<String, dynamic> json) => _$CastMemberFromJson(json);

  Map<String, dynamic> toJson() => _$CastMemberToJson(this);

  String? profileUrl({int width = 185}) =>
      TmdbImageUrl.forPath(profilePath, width: width);
}
