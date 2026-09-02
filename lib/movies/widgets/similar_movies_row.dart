import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/widgets/movie_card.dart';
import 'package:marquee/movies/widgets/movie_card_size.dart';
import 'package:material_ui/material_ui.dart';

class const SimilarMoviesRow({
  required final List<Movie> movies,
  required final ValueChanged<Movie> onMovieTap,
  super.key,
}) extends StatelessWidget {
  static const double _captionHeight = 26;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MovieCardSize.small.posterHeight + _captionHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, index) => MovieCard(
          movie: movies[index],
          size: MovieCardSize.small,
          onTap: () => onMovieTap(movies[index]),
        ),
      ),
    );
  }
}
