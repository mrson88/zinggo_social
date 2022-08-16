import 'package:zinggo_social/repositories/home/paging_repo.dart';

import '../../models/post.dart';

class ListPostPagingRepo with PagingRepo<Post> {
  @override
  Post parseJSON(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  @override
  String get url => '/posts';
}
