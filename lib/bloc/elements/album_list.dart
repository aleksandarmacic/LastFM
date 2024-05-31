import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:last_fm/config/navigation/app_router.dart';
import 'package:last_fm/config/values/colors.dart';
import 'package:last_fm/config/values/constants.dart';
import 'package:last_fm/data/model/album.dart';

Widget buildResultsList(List<Album> albums) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          tr("album_list"),
          style: TextStyle(
            color: albumListTitleColor,
            fontSize: fontSize36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: albums.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var imgUrl = albums[index].imageUrl;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: albumListPadding),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    albumDetailScreenPath,
                    arguments: albums[index].toJson(),
                  );
                },
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: avatarImageSize,
                        height: avatarImageSize,
                        child: getImage(imgUrl),
                      ),
                      SizedBox(width: listItemPadding),
                      Flexible(
                        child: Text(
                          albums[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget getImage(String imgUrl) {
  if (imgUrl != null && imgUrl != "") {
    return Image.network(
      imgUrl,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
          ),
        );
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
        return SizedBox();
      },
    );
  } else {
    return Image.asset("assets/images/noImage.png");
  }
}
