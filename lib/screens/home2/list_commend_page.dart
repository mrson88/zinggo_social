import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zinggo_social/models/comment.dart';
import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/providers/api_provider.dart';
import 'package:zinggo_social/providers/bloc_provider.dart';
import 'package:zinggo_social/screens/post_detail/comments_bloc.dart';
// import 'package:zinggo_social/screens/post_detail/repos/list_comments_repo.dart';
import 'package:zinggo_social/widgets/comment_item_bubble.dart';
import 'package:zinggo_social/widgets/upload/widgets/activity_indicator.dart';

class ListCommentPage extends StatefulWidget {
  const ListCommentPage({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;
  @override
  _ListCommentState createState() => _ListCommentState(post);
}

class _ListCommentState extends State<ListCommentPage> {
  final StreamController<List<Comment>> _streamController = StreamController();
  final Post post;

  List<Comment> list = [];

  _ListCommentState(this.post);
  @override
  void initState() {
    super.initState();
    getComment();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  CommentBloc? get commentBloc => BlocProvider.of<CommentBloc>(context);
  // List<Comment> get commentBloc =>
  //     ListCommentsRepo(post.id!).getComments() as List<Comment>;

  @override
  Widget build(BuildContext context) {
    // print('commentBloc=${commentBloc.toString()}');
    //
    print('commentid=${post.id}');
    return StreamBuilder<List<Comment>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          // print(commentBloc?.postId.toString());
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

  Future<void> getComment() async {
    final apiProvider = ApiProvider();
    final String postId = post.id.toString();
    try {
      final res = await apiProvider.get("/posts/$postId/comments");

      if (res.statusCode != 200) {
        return null;
      }

      List data = res.data['data'];
      list = data.map((json) => Comment.fromJson(json)).toList();
      _streamController.sink.add(list);

      // return data.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
