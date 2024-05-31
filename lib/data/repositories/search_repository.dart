import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:last_fm/data/model/album.dart';

String apiKey = "9201d819aaa2b3eb26794a62a66833d6";
var url = "https://ws.audioscrobbler.com/2.0/?method=album.search&album=believe&api_key=${apiKey}&format=json";

abstract class SearchRepository {
  Future<List<Album>> searchAlbums(String query);
}

class SearchRepositoryImpl extends SearchRepository {
  @override
  Future<List<Album>> searchAlbums(String query) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> albumsData = data["results"]["albummatches"]["album"];

      List<Album> albums = [];
      albumsData.forEach(
        (album) {
          if (album["name"].toString().toLowerCase().contains(query.toLowerCase())) {
            albums.add(
              Album(
                name: album["name"],
                artist: album["artist"],
                imageUrl: album["image"][2]["#text"],
                songUrl: album["url"],
              ),
            );
          }
        },
      );
      return albums;
    } else {
      throw Exception('Failed');
    }
  }
}
