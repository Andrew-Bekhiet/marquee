enum MovieList({required final String label}) {
  favorites(label: 'Favorites'),
  watchlist(label: 'Want to watch'),
  watching(label: 'Watching'),
  watched(label: 'Watched');

  static const Set<MovieList> _watchStages = {watchlist, watching, watched};

  Set<MovieList> get exclusiveWithLists =>
      _watchStages.contains(this) ? _watchStages.difference({this}) : const {};
}
