import 'package:flutter/material.dart';
import 'package:zinggo_social/models/models.dart';
import 'package:zinggo_social/screens/post_detail/post_detail_page.dart';
import 'package:zinggo_social/widgets/action_post.dart';
import 'package:zinggo_social/widgets/home/grid_image.dart';

import 'package:zinggo_social/widgets/upload/widgets/item_row.dart';

class PostItemRemake extends StatelessWidget {
  final Post post;

  const PostItemRemake({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: GestureDetector(
        onTap: () => _navigateToPostDetailPage(context),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: ItemRow(
                    avatarUrl: post.urlUserAvatar,
                    title: post.displayName,
                    subtitle: 'Time created',
                    // onTap: () => navigateToProfilePage(context, post.user),
                  ),
                ),
                GridImage(
                  photos: post.photos ?? [],
                ),
                ActionPost(post: post),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPostDetailPage(BuildContext context) {
    onPressed:
    () => Navigator.pushNamed(context, PostDetailPage.id, arguments: post);
  }
}
