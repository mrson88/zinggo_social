import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:zinggo_social/models/puclic.dart';
import 'package:http/http.dart' as http;
import 'package:zinggo_social/models/post.dart';

class PostRepository {
  List _user = [];

  List list = [];
  String urlString = 'https://api.dofhunt.200lab.io/v1/posts';
  Future<List<Post>> useHttp() async {
    try {
      final res = await http.get(Uri.parse(urlString), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      });

      final users = await jsonDecode(res.body);

      _user = users['data'];
      final list = _user.map((data) => Post.fromJson(data)).toList();
      // print(list);
      return list;
    } catch (e) {
      debugPrint('error = $e');
      rethrow;
    }
  }
}
