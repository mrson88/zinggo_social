import 'package:flutter/material.dart';
import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/modules/home/screens/post_item_remake.dart';
import 'package:zinggo_social/modules/post_detail/screens/post_detail.dart';

import 'package:zinggo_social/widgets/action_post.dart';


class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post? post;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        title: Center(
          child: Column(
            children: [
              Text(
                '${post?.user!.firstName.toString()}'
                '${post?.user!.lastName.toString()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        isThreeLine: true,
        subtitle: Center(
          child: Column(
            children: [
              PostItemRemake(post: post!),
              ActionPost(post: post!),
            ],
          ),
        ),
        dense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostDetail(post: post!),
            ),
          );
        },
      ),
    );
  }
}
