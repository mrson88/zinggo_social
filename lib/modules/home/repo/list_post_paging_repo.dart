import 'package:zinggo_social/models/post.dart';
import 'package:zinggo_social/modules/home/repo/paging_repo.dart';

class ListPostPagingRepo with PagingRepo<Post> {
  @override
  Post parseJSON(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  @override
  String get url => '/posts';
}
