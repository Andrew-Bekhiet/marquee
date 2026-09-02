import 'package:json_annotation/json_annotation.dart';
import 'package:marquee/movies/models/cast_member.dart';

part 'credits_response.g.dart';

@JsonSerializable()
class const CreditsResponse({
  required final int id,
  final List<CastMember> cast = const [],
}) {
  factory fromJson(Map<String, dynamic> json) =>
      _$CreditsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsResponseToJson(this);
}
