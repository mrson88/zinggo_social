import 'package:zinggo_social/screens/post_detail/repos/create_comment_repo.dart';

class CreateCommentBloc {
  final CreateCommentRepo _repo;

  CreateCommentBloc(this._repo);

  Future<bool> createCmt(String content) async {
    return _repo.submitCommentToServer(content);
  }
}
