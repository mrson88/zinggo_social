import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/providers/bloc_provider.dart';
import 'package:zinggo_social/screens/home2/list_commend_page.dart';
import 'package:zinggo_social/screens/post_detail/comments_bloc.dart';
import 'package:zinggo_social/screens/post_detail/post_detail_bloc.dart';
import 'package:zinggo_social/themes/app_color.dart';
import 'package:zinggo_social/themes/app_styles.dart';
import 'package:zinggo_social/widgets/action_post.dart';
import 'package:zinggo_social/widgets/home/post_item_remake.dart';
import 'package:zinggo_social/widgets/list_comment.dart';
import 'package:zinggo_social/widgets/post_image_sliders_widget.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);
  static const String id = 'PostDetail';
  final Post post;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: PostDetail.id),
      builder: (_) => PostDetail(
        post: widget.post,
      ),
    );
  }

  PostDetailBloc? get bloc => BlocProvider.of<PostDetailBloc>(context);
  CommentBloc? get cmtBloc => BlocProvider.of<CommentBloc>(context);
  // CommentBloc? get cmtBloc => CommentBloc(widget.post.id!);
  // @override
  // void initState() {
  //   super.initState();
  //   bloc!.getPost();
  //   cmtBloc!.getComments();
  // }

  @override
  Widget build(BuildContext context) {
    // print(post.id.toString());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _writeCmt, icon: const Icon(Icons.add))
        ],
        title: Text("Detail Post"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _scrollViewVertical(widget.post),
                ActionPost(post: widget.post),
                const Divider(thickness: 1),
                widget.post.commentCounts! > 0
                    ? ListCommentPage(
                        post: widget.post,
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _writeCmt() async {
    const content = 'I love this picture ^^ ';
    try {
      return cmtBloc!.writeCmt(content);
    } catch (e) {
      print('Write comment error');
      print(e.toString());
    }
  }
}

Widget _scrollViewVertical(state) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: AppColors.darkGray,
        borderRadius: const BorderRadius.all(Radius.circular(8))),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(state.user.avatar.url),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.user.firstName}'
                    ' ${state.user.lastName}',
                    style: AppStyles.h3,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${state.photos[0].createdAt.toString().split(' ')[0]}',
                          style: AppStyles.h4,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'length=${state.photos.length}',
                            style: AppStyles.h4,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ImageSlider(
          pictures: state.images,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      '${state.description}',
                      style: AppStyles.h4,
                      maxLines: 4,
                    ),
                  ]),
            ],
          ),
        ),
      ],
    ),
  );
}
