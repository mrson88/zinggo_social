import 'package:flutter/material.dart';
import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/themes/app_color.dart';
import 'package:zinggo_social/themes/app_styles.dart';
import 'package:zinggo_social/widgets/home/post_item_remake.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Post"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _scrollViewVertical(post),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _scrollViewVertical(state) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
        PostItemRemake(post: state),
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
