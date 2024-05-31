import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm/data/model/album.dart';
import 'package:last_fm/data/repositories/album_repository.dart';

import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumRepository repository;

  AlbumBloc({@required this.repository}) : super(null);

  AlbumState get initialState => AlbumInitialState();
  @override
  Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
    if (event is FetchAlbumsEvent) {
      yield AlbumLoadingState();
      try {
        List<Album> albums = await repository.getAlbums();
        yield AlbumLoadedState(albums: albums);
      } catch (e) {
        yield AlbumErrorState(message: e.toString());
      }
    }
  }
}
