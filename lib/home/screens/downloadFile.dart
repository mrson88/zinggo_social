import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:zinggo_social/themes/app_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zinggo_social/models/puclic.dart';

import 'package:zinggo_social/models/post.dart';
// import 'package:zinggo_social/models/token_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../home/downloadFile.dart';
// import '../models/config_env.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);
  static String id = 'download_file';

  @override
  _DownloadFileDemoState createState() => _DownloadFileDemoState();
}

class _DownloadFileDemoState extends State<DownloadFile> {
  final StreamController<List> _streamController = StreamController();
  // @override
  // void initState() {
  //   super.initState();
  //   _useHttp();
  //   setState(() {});
  // }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  List list = [];
  List _user = [];
  List user_data = [];
  LogProvider get logger => const LogProvider('⚡️ CallApiDemoPage');
  final urlString = 'https://api.dofhunt.200lab.io/v1/posts';
  double _progressBarValue = 0;
  String paste = '';
  TextEditingController controller = TextEditingController();
  var imageUrl =
      "https://www.tugo.com.vn/wp-content/uploads/1-3339-1415416821.jpg";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";
  double size = 200;

  @override
  Widget build(BuildContext context) {
    print('build widget 1');
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Download File"),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [
              StreamBuilder(
                builder: (_, snapshot) {
                  print(snapshot.data.runtimeType);
                  return scrollViewHorizontal(snapshot.data, 80, 80, 5);
                },
                stream: _streamController.stream,
                initialData: const [],
              ),
              Center(
                child: downloading
                    ? SizedBox(
                        height: size,
                        width: size,
                        child: Card(
                          child: Center(
                            child: Text(
                              downloadingStr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: size,
                        width: size,
                        child: Center(
                          child: Image.file(File(savePath), height: 200),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Center(child: Text(downloadingStr)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: LinearProgressIndicator(
                  value: _progressBarValue,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: downloadFile,
                        child: const Text('Download'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _useHttp,
                        child: const Text('Call API'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future downloadFile() async {
    try {
      final dio = Dio();
      debugPrint(imageUrl);

      final fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          _progressBarValue = (rec / total);
          var download = _progressBarValue * 100;
          downloadingStr = "Downloading Image : ${download.toInt()} %";

          debugPrint(download.toString());
        });
      });
      setState(() {
        downloading = false;
        downloadingStr = "Completed";

        if (downloadingStr == 'Completed') {
          showSimpleNotification(
              background: Colors.blue,
              Text(
                'The image was saved on your photo gallery',
                style: AppStyles.h2,
              ));
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    final dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  Future<void> _useHttp() async {
    try {
      final res = await http.get(Uri.parse(urlString), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      });

      final users = await jsonDecode(res.body);
      // print(users);
      // data=users['data'];

      _user = users['data'];
      // print(_user);

      list = _user.map((data) => Post.fromJson(data)).toList();

      // list_user=list.toJson();

      print(list[0].user.avatar.url);
      print(list[0].user.firstName);

      // print(_user[0]);

      _streamController.sink.add(list);

      // print(list[0].id);
      // print(list[0].username);
      // print('Token : ${userToken}');
      // print(res.body);
    } catch (e) {
      debugPrint('error = $e');
      rethrow;
    }
    // setState(() {});
  }
}

class LogProvider {
  final String prefix;

  const LogProvider(this.prefix);

  void log(String content) {
    // ignore: avoid_print
    print('$prefix $content');
  }
}

SingleChildScrollView scrollViewHorizontal(
    users, double height, double width, double size) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: users.isNotEmpty
        ? Row(
            children: List.generate(users.length, (index) {
              return Padding(
                padding: EdgeInsets.only(top: size, bottom: size, left: size),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: height,
                                width: width,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            users[index].user.avatar.url),
                                        fit: BoxFit.cover)),
                              ),
                              Text(
                                users[index].user.firstName.toString(),
                                style: const TextStyle(
                                    color: Colors.black, height: 10),
                                textAlign: TextAlign.center,
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
