import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:zinggo_social/models/puclic.dart';
import 'package:http/http.dart' as http;
import 'package:zinggo_social/models/models.dart';

import '../../models/paging.dart';

class PostRepository {
  List _user = [];
  Paging? paging;
  String get cursor => paging?.nextCursor ?? '';
  List list = [];
  String urlString = 'https://api.dofhunt.200lab.io/v1/posts';
  Future<List<Post>> useHttp() async {
    try {
      final res = await http.get(Uri.parse(urlString), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
        'cursor': cursor,
      });

      final users = await jsonDecode(res.body);

      _user = users['data'];
      final list = _user.map((data) => Post.fromJson(data)).toList();
      if (users['paging'] != null) {
        paging = Paging.fromJson(users['paging']);
      }
      // print(list);
      return list;
    } catch (e) {
      debugPrint('error = $e');
      rethrow;
    }
  }
}
