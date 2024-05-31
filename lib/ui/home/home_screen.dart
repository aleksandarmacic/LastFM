import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm/bloc/album_bloc.dart';
import 'package:last_fm/bloc/album_event.dart';
import 'package:last_fm/bloc/album_state.dart';
import 'package:last_fm/bloc/elements/album_list.dart';
import 'package:last_fm/bloc/elements/error.dart';
import 'package:last_fm/bloc/elements/loading.dart';
import 'package:last_fm/bloc/search/search_bloc.dart';
import 'package:last_fm/config/values/colors.dart';

import 'components/album_search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AlbumBloc albumBloc;

  @override
  void initState() {
    albumBloc = BlocProvider.of<AlbumBloc>(context);
    albumBloc.add(FetchAlbumsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: AlbumSearch(searchBloc: BlocProvider.of<SearchBloc>(context)));
              }),
        ],
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumInitialState) {
            return buildLoading();
          } else if (state is AlbumLoadingState) {
            return buildLoading();
          } else if (state is AlbumLoadedState) {
            return buildResultsList(state.albums);
          } else if (state is AlbumErrorState) {
            return buildError(state.message);
          } else {
            return buildError(tr("error"));
          }
        },
      ),
    );
  }
}
