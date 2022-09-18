import 'dart:convert';

import 'package:zinggo_social/models/models.dart';
import 'package:http/http.dart' as http;

class PostApi {
  // static bool get isFirstPage => (paging?.cursor ?? '') == '';
  // static bool get hasNext => paging?.hasNext ?? true;
  static String? get cursor => paging?.nextCursor;
  static Paging? paging;
  static String urlString = "https://api.dofhunt.200lab.io/v1/posts";

  static Future<List<Post>> fetchPost() async {
    List? user = [];

    final response = await http.get(
      Uri.parse('$urlString?cursor=$cursor'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );
    if (response.statusCode != 200) {
      return <Post>[];
    }
    if (response.statusCode != 200) {
      throw Exception("Failed to fetch post");
    }
    final users = await jsonDecode(response.body);

    user = (users['data']);

    if (users['paging'] != null) {
      paging = Paging.fromJson(users['paging']);
    }
    final list = user!.map((data) => Post.fromJson(data)).toList();
    return list;
  }

  void refresh() {
    paging = null;
  }
}
