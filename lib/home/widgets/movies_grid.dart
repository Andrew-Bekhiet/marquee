import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/widgets/movie_card.dart';
import 'package:marquee/movies/widgets/movie_card_size.dart';
import 'package:material_ui/material_ui.dart';

class const MoviesGrid({
  required final List<Movie> movies,
  final bool shrinkWrap = false,
  final ValueChanged<Movie>? onMovieTap,
  super.key,
}) extends StatelessWidget {
  static const int _crossAxisCount = 3;
  static const double _spacing = 11;
  static const double _captionHeight = 39;

  @override
  Widget build(BuildContext context) {
    const cardSize = MovieCardSize.medium;
    final posterHeight = cardSize.posterHeight;
    final aspectRatioWithCaption =
        cardSize.posterWidth / (posterHeight + _captionHeight);

    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: _crossAxisCount,
      crossAxisSpacing: _spacing,
      mainAxisSpacing: _spacing,
      childAspectRatio: aspectRatioWithCaption,
    );

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemCount: movies.length,
      gridDelegate: gridDelegate,
      itemBuilder: (_, index) {
        final movie = movies[index];

        return MovieCard(
          movie: movie,
          onTap: switch (onMovieTap) {
            final onTap? => () => onTap(movie),
            _ => null,
          },
        );
      },
    );
  }
}
