import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:zinggo_social/home/repository/post_repository.dart';
import 'package:zinggo_social/themes/app_color.dart';

import 'package:http/http.dart' as http;
import 'package:zinggo_social/models/puclic.dart';
import 'package:zinggo_social/models/post.dart';
import 'dart:async';

import '../themes/app_styles.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);
  static String id = 'Home_2';

  @override
  State<Home2> createState() => _Home2();
}

String hour = ['created_at'].toString().split(':')[1];
String minute = ['created_at'].toString().split(':')[2];

class _Home2 extends State<Home2> {
  String urlString = 'https://api.dofhunt.200lab.io/v1/posts';
  final StreamController<List> _streamController = StreamController();
  List _user = [];
  List _chat = [];
  List list = [];

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
    });
  }

  @override
  void initState() {
    super.initState();
    _useHttp();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: getBody(),
    );
  }

  Future<void> _useHttp() async {
    try {
      final res = await http.get(Uri.parse(urlString), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      });

      final users = await jsonDecode(res.body);

      _user = users['data'];
      list = _user.map((data) => Post.fromJson(data)).toList();

      _streamController.sink.add(list);
    } catch (e) {
      debugPrint('error = $e');
      rethrow;
    }
  }

  Widget getBody() {
    return StreamBuilder(
      builder: (_, snapshot) {
        return ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 18, left: 14, right: 15),
              child: CupertinoSearchTextField(
                itemColor: AppColors.white,
                itemSize: 26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.blur),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, bottom: 24),
              child: Text(
                "What's new?",
                style: AppStyles.h1,
              ),
            ),
            Container(
              color: Colors.black,
              child: const SizedBox(
                height: 1,
              ),
            ),
            _scrollViewHorizontal(snapshot.data),
            Container(
              color: Colors.black,
              child: const SizedBox(
                height: 2,
              ),
            ),
            // _scrollViewVetical(_chat, context),
            _scrollViewVetical(snapshot.data, context)
          ],
        );
      },
      stream: _streamController.stream,
      initialData: const [],
    );
  }
}

SingleChildScrollView _scrollViewHorizontal(users) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: users.isNotEmpty
        ? Row(
            children: List.generate(users.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 18, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 135,
                                width: 135,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            users[index].user.avatar.url),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  users[index].user.avatar.url),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        (users[index]
                                                .user
                                                .firstName
                                                .toString() +
                                            ' ' +
                                            users[index]
                                                .user
                                                .lastName
                                                .toString()),
                                        style: AppStyles.h5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // user[index]['status'].toString() == 'online'
                          //     ? Positioned(
                          //         top: 45,
                          //         left: 42,
                          //         child: Container(
                          //           width: 15,
                          //           height: 15,
                          //           decoration: BoxDecoration(
                          //             color: Colors.green,
                          //             shape: BoxShape.circle,
                          //             border: Border.all(
                          //                 color: AppColors.textColor,
                          //                 width: 2.5),
                          //           ),
                          //         ),
                          //       )
                          //     : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          )
        : Container(),
  );
}

Widget _scrollViewVetical(users, context) {
  // String hour(int index) {
  //   return chatUser[index]['created_at'].toString().split(':')[1];
  // }
  //
  // String minute(int index) {
  //   return chatUser[index]['created_at'].toString().split(':')[2].split('.')[0];
  // }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          users.length,
          (index) => Container(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: AppColors.darkGray,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
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
                                image:
                                    NetworkImage(users[index].user.avatar.url),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                '${users[index].user.firstName}'
                                ' ${users[index].user.lastName}',
                                style: AppStyles.h3,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: const Text(
                                '',
                                // int.parse(hour(index = index)) < 12
                                //     ? '${hour(index = index)} '
                                //         ': ${minute(index = index)} AM'
                                //     : '0${int.parse(hour(index = index)) - 12} '
                                //         ': ${minute(index = index)} PM',
                                // style: AppStyles.h4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Image(
                              image: NetworkImage(
                                  users[index].photos[0].image.url),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Image(
                              image: NetworkImage(users[index].user.avatar.url),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            '${users[index].user.firstName}',
                            style: AppStyles.h3,
                            maxLines: 4,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
