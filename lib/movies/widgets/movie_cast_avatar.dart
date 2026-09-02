import 'package:cached_network_image/cached_network_image.dart';
import 'package:marquee/movies/models/cast_member.dart';
import 'package:marquee/movies/utils/cast_display.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const MovieCastAvatar({
  required final CastMember member,
  super.key,
}) extends StatelessWidget {
  static const double _avatarRadius = 28;
  static const double _width = 64;
  static const double _initialsFontSize = 13;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    final profileUrl = member.profileUrl();

    return SizedBox(
      width: _width,
      child: Column(
        spacing: 6,
        children: [
          CircleAvatar(
            radius: _avatarRadius,
            backgroundColor: colorScheme.surfaceContainerHighest,
            foregroundImage: switch (profileUrl) {
              '' || null => null,
              final profileImage => CachedNetworkImageProvider(profileImage),
            },
            child: Text(
              member.initials,
              style: MarqueeTypography.posterCode(
                fontSize: _initialsFontSize,
              ).copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ),
          Text(
            member.shortName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
