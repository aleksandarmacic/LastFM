import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_fm/data/model/album.dart';
import 'package:last_fm/ui/albumDetails/album_detail_screen.dart';
import 'package:last_fm/ui/home/home_screen.dart';

const String rootPath = "/";
const String albumDetailScreenPath = "/albumDetailScreen";

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = json.encode(routeSettings.arguments);
    switch (routeSettings.name) {
      case rootPath:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case albumDetailScreenPath:
        return MaterialPageRoute(
          builder: (_) => AlbumDetailScreen(
            album: Album(
              imageUrl: json.decode(args)["imageUrl"],
              artist: json.decode(args)["artist"],
              name: json.decode(args)["name"],
              songUrl: json.decode(args)["songUrl"],
            ),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  void dispose() {}

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr("error")),
          ),
          body: Center(
            child: Text(tr("error")),
          ),
        );
      },
    );
  }
}
