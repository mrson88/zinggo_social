import 'package:flutter/material.dart';
import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/providers/bloc_provider.dart';
import 'package:zinggo_social/screens/home2/list_commend_page.dart';
import 'package:zinggo_social/screens/post_detail/comments_bloc.dart';
import 'package:zinggo_social/screens/post_detail/post_detail_bloc.dart';
import 'package:zinggo_social/themes/app_color.dart';
import 'package:zinggo_social/themes/app_styles.dart';
import 'package:zinggo_social/widgets/action_post.dart';
import 'package:zinggo_social/widgets/post_image_sliders_widget.dart';
import 'package:zinggo_social/widgets/space_widget.dart';

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
      settings: const RouteSettings(name: PostDetail.id),
      builder: (_) => PostDetail(
        post: widget.post,
      ),
    );
  }

  PostDetailBloc? get bloc => BlocProvider.of<PostDetailBloc>(context);
  CommentBloc? get cmtBloc => BlocProvider.of<CommentBloc>(context);
  String qrString = "";
  late TextEditingController _controller;
  String contentComment = '';
  // CommentBloc? get cmtBloc => CommentBloc(widget.post.id!);
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    // bloc!.getPost();
    // cmtBloc!.getComments();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    // print(post.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Post"),
      ),
      body: SingleChildScrollView(
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
                : Container(),
            Positioned(
              bottom: 10,
              child: Container(
                color: scaffoldBackgroundColor,
                // color: AppColor.pinkAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 70,
                      width: size.width - 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          // ignore: unnecessary_null_in_if_null_operators
                          height: 50,
                          child: TextField(
                            controller: _controller,
                            onChanged: (String contentValue) {
                              contentComment = contentValue;
                              debugPrint(contentComment);
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              // prefixIcon: widget.icon,
                              labelText: 'Comment...',
                              hintText: 'Enter Comment',
                              hintStyle: const TextStyle(color: AppColors.grey),
                              suffixIcon: IconButton(
                                onPressed: _controller.clear,
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizeBox10W(),
                    InkWell(
                      onTap: () {
                        debugPrint('Tap send comment');
                        // FocusScope.of(context).unfocus();
                        // cmtBloc!.writeCmt(contentComment);
                        _writeCmt(contentComment);
                        _controller.clear();
                      },
                      child: const Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _writeCmt(content) async {
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
                          state.photos[0].createdAt.toString().split(' ')[0],
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
