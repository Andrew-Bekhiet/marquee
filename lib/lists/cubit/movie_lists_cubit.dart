import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marquee/lists/cubit/movie_lists_state.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/lists/models/movie_lists_exception.dart';
import 'package:marquee/lists/repositories/movie_lists_repository.dart';

class MovieListsCubit(final MovieListsRepository _movieListsRepository)
    extends Cubit<MovieListsState> {
  StreamSubscription<void>? _changesSubscription;

  this : super(const MovieListsLoading(selectedList: MovieList.favorites)) {
    _changesSubscription = _movieListsRepository.changes.listen(
      (_) => load(),
    );
  }

  Future<void> load() async {
    try {
      final movies = await _movieListsRepository.getMoviesInList(
        state.selectedList,
      );

      emit(MovieListsLoaded(selectedList: state.selectedList, movies: movies));
    } on MovieListsException catch (exception) {
      emit(
        MovieListsError(
          selectedList: state.selectedList,
          message: exception.message,
        ),
      );
    }
  }

  void onListSelected(MovieList list) {
    if (state case MovieListsLoaded(:final selectedList)
        when selectedList == list) {
      return;
    }

    emit(MovieListsLoading(selectedList: list));
    load();
  }

  @override
  Future<void> close() async {
    await _changesSubscription?.cancel();

    return super.close();
  }
}
