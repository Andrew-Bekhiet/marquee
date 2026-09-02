import 'package:material_ui/material_ui.dart';

class const MovieOverview({
  required final String overview,
  super.key,
}) extends StatefulWidget {
  static const int _collapsedMaxLines = 3;
  static const double _lineHeight = 1.6;
  static const double _affordanceSpacing = 4;

  @override
  State<MovieOverview> createState() => _MovieOverviewState();
}

class _MovieOverviewState() extends State<MovieOverview> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final bodyStyle = textTheme.bodyMedium?.copyWith(
      height: MovieOverview._lineHeight,
      color: colorScheme.onSurfaceVariant,
    );

    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 200),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final overflows = _textExceedsMaxLines(
            widget.overview,
            bodyStyle,
            constraints.maxWidth,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: MovieOverview._affordanceSpacing,
            children: [
              Text(
                widget.overview,
                maxLines: _isExpanded ? null : MovieOverview._collapsedMaxLines,
                overflow: _isExpanded ? null : TextOverflow.ellipsis,
                style: bodyStyle,
              ),
              if (overflows)
                GestureDetector(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  child: Text(
                    _isExpanded ? 'Less' : 'More',
                    style: bodyStyle?.copyWith(color: colorScheme.primary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  bool _textExceedsMaxLines(String text, TextStyle? style, double maxWidth) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: MovieOverview._collapsedMaxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return painter.didExceedMaxLines;
  }
}
