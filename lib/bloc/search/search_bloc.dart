import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm/bloc/search/search_event.dart';
import 'package:last_fm/bloc/search/search_state.dart';
import 'package:last_fm/data/model/album.dart';
import 'package:last_fm/data/repositories/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;
  SearchBloc({@required this.searchRepository}) : super(null);

  SearchState get initialState => SearchUninitialized();
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is Search) {
      yield SearchUninitialized();
      try {
        List<Album> albums = await searchRepository.searchAlbums(event.query);
        yield SearchLoaded(albums: albums);
      } catch (e) {
        yield SearchError();
      }
    }
  }
}
