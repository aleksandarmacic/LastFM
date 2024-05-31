import 'package:flutter/material.dart';
import 'package:last_fm/config/values/colors.dart';
import 'package:last_fm/config/values/constants.dart';
import 'package:last_fm/data/model/album.dart';
import 'package:url_launcher/url_launcher.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;
  AlbumDetailScreen({@required this.album});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(album.name),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            top: mainContentPadding,
            left: mainContentPadding,
            right: mainContentPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * imageSizeRatio,
                width: MediaQuery.of(context).size.width * imageSizeRatio,
                child: Image.network(
                  album.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: componentVerticalSpacing,
              ),
              Text(
                album.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: componentVerticalSpacing,
              ),
              Text(
                album.artist,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: fontSize16,
                ),
              ),
              SizedBox(
                height: componentVerticalSpacing,
              ),
              InkWell(
                onTap: () => launchURL(album.songUrl),
                child: Text(
                  album.songUrl,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: fontSize16,
                    color: urlColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchURL(String songUrl) async {
    await canLaunch(songUrl) ? await launch(songUrl) : throw "URL cannot be launched";
  }
}
