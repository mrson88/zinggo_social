import 'package:zinggo_social/providers/api_provider.dart';

class ReactCmtRepo {
  final _apiProvider = ApiProvider();
  final String postId;

  ReactCmtRepo(this.postId);

  Future<bool> unReact(String commentId) async {
    final url = '/posts/$postId/comments/$commentId/unreact';

    try {
      final res = await _apiProvider.delete(url);
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> react(String commentId, int type) async {
    final url = '/posts/$postId/comments/$commentId/react';

    try {
      final res = await _apiProvider.post(url, queryParameters: {'type': type});
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
