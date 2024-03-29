import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/providers/api_provider.dart';

class ListPostsRepo {
  final apiProvider = ApiProvider();

  Future<List<Post>> getPosts() async {
    try {
      final res = await apiProvider.get("/posts");

      List data = res.data['data'];

      final list = data.map((data) => Post.fromJson(data)).toList();
      print(list);
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
