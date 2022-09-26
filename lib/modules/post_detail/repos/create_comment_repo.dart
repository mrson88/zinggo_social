

import 'package:zinggo_social/providers/api_provider.dart';

class CreateCommentRepo{
  final String postId;
  final apiProvider = ApiProvider();

  CreateCommentRepo(this.postId);

  Future<bool> submitCommentToServer(String content) async {
    try{
      final res = await apiProvider.post('/posts/$postId/comments', data: {
        "content": content,
      });
      return res.statusCode == 200;
    }catch(e){
      rethrow;
    }
  }
}