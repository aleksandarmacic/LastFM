import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:last_fm/data/model/album.dart';

abstract class AlbumState extends Equatable {}

class AlbumInitialState extends AlbumState {
  @override
  List<Object> get props => [];
}

class AlbumLoadingState extends AlbumState {
  @override
  List<Object> get props => [];
}

class AlbumLoadedState extends AlbumState {
  List<Album> albums;
  AlbumLoadedState({@required this.albums});
  @override
  List<Object> get props => [];
}

class AlbumErrorState extends AlbumState {
  String message;
  AlbumErrorState({@required this.message});
  @override
  List<Object> get props => [];
}
