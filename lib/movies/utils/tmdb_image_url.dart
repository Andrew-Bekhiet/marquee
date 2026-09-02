abstract final class const TmdbImageUrl._() {
  static const String _baseUrl = 'https://image.tmdb.org/t/p';

  static String? forPath(String? path, {required int width}) {
    if (path case null || '') return null;

    return '$_baseUrl/w$width$path';
  }
}
