import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:last_fm/data/model/album.dart';

abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  List<Album> albums;
  SearchLoaded({@required this.albums});
  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}
