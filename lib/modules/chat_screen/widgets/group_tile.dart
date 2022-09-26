import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zinggo_social/modules/chat_screen/screens/chat_page.dart';
import 'package:zinggo_social/modules/chat_screen/screens/home_page.dart';
import 'package:zinggo_social/modules/chat_screen/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print(widget.groupName);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Exit"),
                content: const Text("Are you sure you delete the group? "),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // await _firestore
                      //     .collection('groups')
                      //     .doc(widget.groupId)
                      //     .delete();

                      print('${widget.groupId}_${widget.groupName}');
                      print(FirebaseAuth.instance.currentUser!.uid);

                      final data_user = _firestore
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection(FirebaseAuth.instance.currentUser!.uid)
                          .doc('groups')
                          .delete();
                      print(data_user);
                      final updates = <String, dynamic>{
                        "${widget.groupId}_${widget.groupName}":
                            FieldValue.delete(),
                      };
                      // data_user.update(updates);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeChatPage()));
                    },
                    icon: const Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                  ),
                ],
              );
            });
      },
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              groupId: widget.groupId,
              groupName: widget.groupName,
              userName: widget.userName,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Join the conversation as ${widget.userName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
