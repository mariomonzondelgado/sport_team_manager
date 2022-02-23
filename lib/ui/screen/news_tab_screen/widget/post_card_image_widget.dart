import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_team_manager/generated/assets.dart';

class PostCardImage extends StatelessWidget {
  String imageUrl;
  PostCardImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        child: Stack(
          children: [
            Image.asset(
              Assets.imagesPlaceholder,
              fit: BoxFit.cover,
              width: 600.0,
              height: 240.0,
            ),
            Container(
              width: 600.0,
              height: 240.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(imageUrl),
                ),
              ),
            ),
          ],
        ));
  }
}
