import 'dart:math' as math;
import 'dart:ui';

import 'package:boxy/boxy.dart';
import 'package:material_ui/material_ui.dart';

typedef CollapsedTitleSlot = ({double start, double width});

class MovieAppBarBoxy({
  required final double expansionPercentage,
  required final double topPadding,
  required final TextDirection textDirection,
  required final double titleScale,
}) extends BoxyDelegate<MovieAppBarSlot> {
  static const double _toolbarInset = 8;
  static const double _toolbarTitleGap = 8;

  static const double _heroInset = 16;
  static const double _posterTop = 252;
  static const double _posterWidth = 104;
  static const double _posterHeight = 156;
  static const double _posterToTitleGap = 12;
  static const double _ratingTop = 256;
  static const double _titleTop = 320;
  static const double _titleToMetaGap = 6;

  static const Curve _heroFade = Interval(
    0.55,
    1,
    curve: Curves.easeInExpo,
  );
  static const Curve _primaryTintFade = Curves.easeInExpo;

  static double get expandedHeight => _posterTop + _posterHeight;

  @override
  bool get needsCompositing => true;

  static double getTintPercentage(double expansion) =>
      _primaryTintFade.transform(1 - expansion.clamp(0.0, 1.0));

  @override
  Size layout() {
    final size = constraints.biggest;
    final wholeBar = Offset.zero & size;

    getChild(MovieAppBarSlot.backdrop).layoutRect(wholeBar);
    getChild(MovieAppBarSlot.tint).layoutRect(wholeBar);

    _layoutHero(size);

    final collapsedTitleConfig = _layoutToolbar(size);
    _layoutTitleAndMeta(size, collapsedTitleConfig);

    return size;
  }

  void _layoutHero(Size size) {
    getChild(MovieAppBarSlot.poster).layoutRect(
      _rectFromStart(
        start: _heroInset,
        top: _posterTop,
        size: const Size(_posterWidth, _posterHeight),
        boxWidth: size.width,
      ),
    );

    final rating = getChild(MovieAppBarSlot.rating)
      ..layout(BoxConstraints.loose(size));

    _place(
      rating,
      start: size.width - _heroInset - rating.size.width,
      top: _ratingTop,
      boxWidth: size.width,
    );
  }

  CollapsedTitleSlot _layoutToolbar(Size size) {
    final toolbarConstraints = BoxConstraints.loose(
      Size(size.width, kToolbarHeight),
    );

    final leading = getChild(MovieAppBarSlot.leading)
      ..layout(toolbarConstraints);
    final actions = getChild(MovieAppBarSlot.actions)
      ..layout(toolbarConstraints);

    leading.positionRect(
      _withToolbarHeight(_toolbarInset, leading.size.width, size.width),
    );
    actions.positionRect(
      _withToolbarHeight(
        size.width - _toolbarInset - actions.size.width,
        actions.size.width,
        size.width,
      ),
    );

    final afterLeading = _toolbarInset + leading.size.width + _toolbarTitleGap;
    final beforeActions = _toolbarInset + actions.size.width + _toolbarTitleGap;
    final betweenThem = (size.width - afterLeading - beforeActions).clamp(
      0.0,
      size.width,
    );

    return (start: afterLeading, width: betweenThem);
  }

  void _layoutTitleAndMeta(Size size, CollapsedTitleSlot collapsedSlot) {
    const expandedStart = _heroInset + _posterWidth + _posterToTitleGap;
    final expandedWidth = size.width - expandedStart - _heroInset;
    final widthStillFittingWhenScaledDown = collapsedSlot.width / titleScale;

    final title = getChild(MovieAppBarSlot.title)
      ..layout(
        BoxConstraints(
          maxWidth: math
              .min(expandedWidth, widthStillFittingWhenScaledDown)
              .abs(),
        ),
      );

    final collapsedSize = title.size * titleScale;
    final collapsedTopLeft = Alignment.centerLeft
        .inscribe(
          collapsedSize,
          _withToolbarHeight(
            collapsedSlot.start,
            collapsedSize.width,
            size.width,
          ),
        )
        .topLeft;
    final expandedLeft = _leftFromStart(
      expandedStart,
      title.size.width,
      size.width,
    );
    final scale = lerpDouble(titleScale, 1, expansionPercentage) ?? 1;

    title.setTransform(
      Matrix4.translationValues(
        lerpDouble(collapsedTopLeft.dx, expandedLeft, expansionPercentage) ?? 0,
        lerpDouble(collapsedTopLeft.dy, _titleTop, expansionPercentage) ?? 0,
        0,
      )..scaleByDouble(scale, scale, 1, 1),
    );

    final meta = getChild(MovieAppBarSlot.meta)
      ..layout(BoxConstraints(maxWidth: expandedWidth));

    _place(
      meta,
      start: expandedStart,
      top: _titleTop + title.size.height + _titleToMetaGap,
      boxWidth: size.width,
    );
  }

  @override
  void paintChildren() {
    getChild(MovieAppBarSlot.backdrop).paint();

    final tintOpacity = getTintPercentage(expansionPercentage);
    _paintFaded(
      MovieAppBarSlot.tint,
      tintOpacity,
    );

    final heroOpacity = MovieAppBarBoxy._heroFade.transform(
      expansionPercentage.clamp(0.0, 1.0),
    );

    _paintFaded(MovieAppBarSlot.poster, heroOpacity);
    _paintFaded(MovieAppBarSlot.rating, heroOpacity);
    _paintFaded(MovieAppBarSlot.meta, heroOpacity);
    getChild(MovieAppBarSlot.title).paint();
    getChild(MovieAppBarSlot.leading).paint();
    getChild(MovieAppBarSlot.actions).paint();
  }

  void _paintFaded(MovieAppBarSlot slot, double opacity) {
    final child = getChild(slot);
    if (opacity <= 0) return;

    if (opacity >= 1) {
      child.paint();

      return;
    }

    layers.opacity(opacity: opacity, paint: child.paint);
  }

  @override
  bool shouldRelayout(MovieAppBarBoxy oldDelegate) =>
      expansionPercentage != oldDelegate.expansionPercentage ||
      topPadding != oldDelegate.topPadding ||
      textDirection != oldDelegate.textDirection ||
      titleScale != oldDelegate.titleScale;

  @override
  bool shouldRepaint(MovieAppBarBoxy oldDelegate) =>
      shouldRelayout(oldDelegate);

  Rect _withToolbarHeight(double start, double width, double boxWidth) =>
      _rectFromStart(
        start: start,
        top: topPadding,
        size: Size(width, kToolbarHeight),
        boxWidth: boxWidth,
      );

  Rect _rectFromStart({
    required double start,
    required double top,
    required Size size,
    required double boxWidth,
  }) => Rect.fromLTWH(
    _leftFromStart(start, size.width, boxWidth),
    top,
    size.width,
    size.height,
  );

  void _place(
    BoxyChild child, {
    required double start,
    required double top,
    required double boxWidth,
  }) => child.position(
    Offset(_leftFromStart(start, child.size.width, boxWidth), top),
  );

  double _leftFromStart(double start, double width, double boxWidth) =>
      switch (textDirection) {
        TextDirection.ltr => start,
        TextDirection.rtl => boxWidth - start - width,
      };
}

enum MovieAppBarSlot() {
  backdrop,
  tint,
  poster,
  rating,
  meta,
  title,
  leading,
  actions,
}
