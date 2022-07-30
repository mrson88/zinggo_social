import 'package:flutter/cupertino.dart';
import 'package:zinggo_social/widgets/scrollViewVeticalChatuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:zinggo_social/themes/app_color.dart';
import '../../themes/app_styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  static String id = 'Notification';

  @override
  State<NotificationPage> createState() => _NotificationPage();
}

// String hour = ['created_at'].toString().split(':')[1];
// String minute = ['created_at'].toString().split(':')[2];

class _NotificationPage extends State<NotificationPage> {
  List _user = [];
  List _chat = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String userResponse =
        await rootBundle.loadString('assets/data/users.json');
    final String chatResponse =
        await rootBundle.loadString('assets/data/chats.json');
    final userdata = await json.decode(userResponse);
    final chatted = await json.decode(chatResponse);

    setState(() {
      _user = userdata["results"];
      _chat = chatted["results"];

      // print(_user);
      // print(_chat);
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 18, left: 14, right: 15),
          child: CupertinoSearchTextField(
            itemColor: AppColors.white,
            itemSize: 26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: AppColors.blur),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, bottom: 24),
          child: const Text(
            "Notifications",
            style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.normal,
                color: AppColors.textColor),
          ),
        ),
        Container(
          color: Colors.black,
          child: const SizedBox(
            height: 1,
          ),
        ),
        Container(
          color: Colors.black,
          child: const SizedBox(
            height: 2,
          ),
        ),
        scrollViewVetical(_chat, context)
      ],
    );
  }
}
