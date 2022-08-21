import 'package:flutter/material.dart';

import 'package:zinggo_social/models/comment.dart';
import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/providers/bloc_provider.dart';
import 'package:zinggo_social/screens/post_detail/comments_bloc.dart';
import 'package:zinggo_social/screens/post_detail/repos/list_comments_repo.dart';
import 'package:zinggo_social/widgets/comment_item_bubble.dart';
import 'package:zinggo_social/widgets/upload/widgets/activity_indicator.dart';

class ListComment extends StatefulWidget {
  const ListComment({
    Key? key,
  }) : super(key: key);

  @override
  _ListCommentState createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  late final Post post;

  CommentBloc? get commentBloc => BlocProvider.of<CommentBloc>(context);
  // ListCommentsRepo get commentBloc => ListCommentsRepo(post.id!);

  @override
  Widget build(BuildContext context) {
    print('commentBloc=$commentBloc');

    print('commentid=${post.id}');
    return StreamBuilder<List<Comment>>(
      stream: commentBloc!.listCmtStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          print(commentBloc?.postId.toString());
          return const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text('ERR'),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 12),
              child: const Center(
                child: Text('No comment'),
              ),
            );
          }

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 60),
            itemBuilder: (context, index) {
              final comment = snapshot.data?[index];

              return Container(
                color: Colors.transparent,
                key: ValueKey(comment!.id),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: CommentItemBubble(
                        cmt: comment,
                        onReact: (type, isReact) {
                          if (isReact) {
                            commentBloc?.react(comment.id!, type);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: snapshot.data?.length ?? 0,
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        return const ActivityIndicator();
      },
    );
  }
}
