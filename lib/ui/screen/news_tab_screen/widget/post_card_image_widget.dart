import 'package:flutter/material.dart';
import 'package:sport_team_manager/generated/assets.dart';

class PostCardImage extends StatelessWidget {
  const PostCardImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: Image.asset(
        Assets.imagesPlaceholder,
        fit: BoxFit.cover,
        width: 600,
        height: 240,
      ),
    );
  }
}
