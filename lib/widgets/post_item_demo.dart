import 'package:flutter/material.dart';
import 'package:zinggo_social/models/models.dart';
import 'package:zinggo_social/widgets/upload/widgets/item_row.dart';

class PostItemDemo extends StatelessWidget {
  final Post post;

  const PostItemDemo({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: const [
          ItemRow(),
        ],
      ),
    );
  }
}
