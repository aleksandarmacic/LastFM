import 'dart:convert';

import 'package:flutter/cupertino.dart';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  Album({
    @required this.name,
    @required this.artist,
    @required this.imageUrl,
    @required this.songUrl,
  });

  String name;
  String artist;
  String imageUrl;
  String songUrl;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        name: json["name"],
        artist: json["artist"],
        imageUrl: json["imageUrl"],
        songUrl: json["songUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "artist": artist,
        "imageUrl": imageUrl,
        "songUrl": songUrl,
      };
}
