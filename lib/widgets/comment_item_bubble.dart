import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

import 'package:zinggo_social/models/comment.dart';
import 'package:zinggo_social/utils/string_utils.dart';
import 'package:zinggo_social/utils/uidata.dart';
import 'package:zinggo_social/widgets/upload/widgets/item_row.dart';

class CommentItemBubble extends StatefulWidget {
  final Comment cmt;
  // int: type
  // bool: true, false
  final Function(int, bool) onReact;

  const CommentItemBubble({
    Key? key,
    required this.cmt,
    required this.onReact,
  }) : super(key: key);

  @override
  State<CommentItemBubble> createState() => _CommentItemBubbleState();
}

class ReactionData {
  final String text;
  final String? imgData;
  final Color color;

  ReactionData({
    required this.text,
    this.imgData,
    required this.color,
  });
}

class _CommentItemBubbleState extends State<CommentItemBubble> {
  late final Comment cmt;
  int yourReact = 0;

  Map<int, ReactionData> mapReactions = {
    1: ReactionData(text: 'Like', imgData: UIData.likeGif, color: Colors.blue),
    2: ReactionData(
        text: 'Haha', imgData: UIData.hahaGif, color: Colors.yellow),
    3: ReactionData(text: 'Heart', imgData: UIData.loveGif, color: Colors.pink),
    4: ReactionData(text: 'Sad', imgData: UIData.sadGif, color: Colors.purple),
    5: ReactionData(
        text: 'Wow', imgData: UIData.wowGif, color: Colors.yellowAccent),
    6: ReactionData(text: 'Angry', imgData: UIData.angryGif, color: Colors.red),
  };

  @override
  void initState() {
    super.initState();

    cmt = widget.cmt;
    yourReact = cmt.metaData?.yourReact ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ItemRow(
              avatarUrl: cmt.urlUserAvatar,
              title: cmt.displayName,
              sizeAvatar: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              cmt.content!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Row(
            children: [
              Text(
                StringUtils.calcTimePost(cmt.createdAt!),
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(width: 8),
              buildReactButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildReactButton() {
    return ReactionButton<int>(
      onReactionChanged: (int? value) {
        print('Selected value: $value');
        if (value != null && value != yourReact) {
          setState(() {
            yourReact = value;
          });
          widget.onReact(value, true);
        }
      },
      reactions: mapReactions.keys.map(_buildReactItem).toList(),
      initialReaction: _buildReactItem(yourReact),
    );
  }

  Reaction<int> _buildReactItem(int value) {
    final imgData =
        mapReactions.containsKey(value) ? mapReactions[value]!.imgData : null;
    final textPlaceHolder = mapReactions.containsKey(value)
        ? mapReactions[value]!.text
        : 'Reaction';
    final textColor = textPlaceHolder != 'Reaction'
        ? mapReactions[value]!.color
        : Colors.black;

    return Reaction<int>(
      value: value,
      previewIcon: imgData != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Image.asset(
                imgData,
                width: 30,
                height: 30,
              ),
            )
          : const SizedBox(),
      icon: Text(
        textPlaceHolder,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
