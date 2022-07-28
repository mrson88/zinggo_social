import 'package:flutter/material.dart';

import 'package:zinggo_social/models/post.dart';

import 'package:zinggo_social/home/widgets/grid_image.dart';

class PostItemRemake extends StatefulWidget {
  final Post post;

  const PostItemRemake({Key? key, required this.post}) : super(key: key);

  @override
  State<PostItemRemake> createState() => _PostItemRemakeState();
}

class _PostItemRemakeState extends State<PostItemRemake> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () => null,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GridImage(photos: widget.post.photos!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
