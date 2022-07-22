import 'package:zinggo_social/modules/navigationbar_item.dart';
import 'package:zinggo_social/modules/scrollViewVeticalChatuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:zinggo_social/modules/scrollViewItemHorizontal.dart';

import 'package:zinggo_social/themes/app_color.dart';

import 'package:zinggo_social/home/home_2.dart';

class MesHomePage extends StatefulWidget {
  const MesHomePage({Key? key}) : super(key: key);
  static String id = 'Message_HomePage';

  @override
  State<MesHomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;
String hour = ['created_at'].toString().split(':')[1];
String minute = ['created_at'].toString().split(':')[2];

class _HomePageState extends State<MesHomePage> {
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

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => setState(() {
                  Navigator.pop(context);
                  // print(_user);
                }),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textColor,
                  size: 28,
                ),
              ),
              TextButton(
                onPressed: () => setState(() {
                  readJson();
                  // print(_user);
                }),
                child: const Icon(
                  Icons.add,
                  color: AppColors.textColor,
                  size: 38,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, bottom: 24),
            child: const Text(
              'Messages',
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
          scrollViewHorizontal(_user),
          Container(
            color: Colors.black,
            child: const SizedBox(
              height: 2,
            ),
          ),
          scrollViewVetical(_chat, context)
        ],
      ),
    );
  }
}
