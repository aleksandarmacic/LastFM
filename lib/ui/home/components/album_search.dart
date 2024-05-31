import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm/bloc/search/search_bloc.dart';
import 'package:last_fm/bloc/search/search_event.dart';
import 'package:last_fm/bloc/search/search_state.dart';
import 'package:last_fm/config/navigation/app_router.dart';
import 'package:last_fm/config/values/constants.dart';

class AlbumSearch extends SearchDelegate<List> {
  SearchBloc searchBloc;
  AlbumSearch({@required this.searchBloc});
  String queryString;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    searchBloc.add(Search(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchUninitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchError) {
          return Center(
            child: Text(
              tr("failed_to_load"),
            ),
          );
        }
        if (state is SearchLoaded) {
          if (state.albums.isEmpty) {
            return Center(
              child: Text(
                tr("no_results"),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(listPadding),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      albumDetailScreenPath,
                      arguments: state.albums[index],
                    );
                  },
                  child: Card(
                    child: Container(
                      height: cardHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: cardSpacing,
                          ),
                          Flexible(
                              child: Text(
                            state.albums[index].name + " - ${state.albums[index].artist}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.albums.length,
            ),
          );
        }
        return const Scaffold();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
