import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zinggo_social/dialog_err_mixin.dart';
import 'package:zinggo_social/models/models.dart';
import 'package:zinggo_social/providers/bloc_provider.dart';
import 'package:zinggo_social/screens/home2/list_commend_page.dart';
import 'package:zinggo_social/screens/post_detail/comments_bloc.dart';
import 'package:zinggo_social/screens/post_detail/post_detail_bloc.dart';
import 'package:zinggo_social/widgets/action_post.dart';
import 'package:zinggo_social/widgets/home/grid_image.dart';
import 'package:zinggo_social/widgets/list_comment.dart';
import 'package:zinggo_social/widgets/upload/widgets/item_row.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> with DialogErrorMixin {
  Post get post => widget.post;

  PostDetailBloc? get bloc => BlocProvider.of<PostDetailBloc>(context);

  CommentBloc? get cmtBloc => BlocProvider.of<CommentBloc>(context);

  @override
  void initState() {
    super.initState();

    bloc!.getPost();

    cmtBloc!.getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Post>(
          stream: bloc!.postsStream,
          initialData: widget.post,
          builder: (context, snapshot) {
            final post = snapshot.data;
            return Stack(
              children: [
                CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        title: const Text('Post Detail Page'),
                        snap: true,
                        floating: true,
                        elevation: 1,
                        forceElevated: true,
                        actions: [
                          IconButton(
                              onPressed: _writeCmt, icon: const Icon(Icons.add))
                        ],
                      ),
                      CupertinoSliverRefreshControl(
                        onRefresh: bloc!.getPost,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                              child: ItemRow(
                                avatarUrl: post!.urlUserAvatar,
                                title: post.displayName,
                                subtitle: 'Time created',
                                onTap: () {},
                                rightWidget: IconButton(
                                  onPressed: deletePost,
                                  icon: const Icon(Icons.more_horiz),
                                ),
                              ),
                            ),
                            GridImage(photos: post.photos!, padding: 0),
                            ActionPost(post: post),
                            const Divider(thickness: 1),
                            ListCommentPage(post: widget.post),
                          ],
                        ),
                      ),
                    ]),
              ],
            );
          }),
    );
  }

  Future<void> _writeCmt() async {
    const content = 'I love this picture ^^ ';
    try {
      return cmtBloc!.writeCmt(content);
    } catch (e) {
      showErrorMessage('Write comment error');
    }
  }

  Future<void> deletePost() async {
    try {
      return bloc!.deletePost().then((value) {
        Navigator.pop(context);
      });
    } catch (e) {}
  }
}
