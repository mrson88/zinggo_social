import 'package:zinggo_social/models/comment.dart';
import 'package:zinggo_social/providers/bloc_provider.dart';
import 'package:zinggo_social/screens/post_detail/blocs/app_event_bloc.dart';
import 'package:zinggo_social/screens/post_detail/create_comment_bloc.dart';
import 'package:zinggo_social/screens/post_detail/list_comments_bloc.dart';
import 'package:zinggo_social/screens/post_detail/react_cmt_bloc.dart';
import 'package:zinggo_social/screens/post_detail/repos/create_comment_repo.dart';
import 'package:zinggo_social/screens/post_detail/repos/list_comments_repo.dart';
import 'package:zinggo_social/screens/post_detail/repos/react_cmt_repo.dart';

class CommentBloc extends BlocBase {
  final String postId;
  final ListCommentsBloc _commentsBloc;
  final CreateCommentBloc _createCmtBloc;
  final ReactCmtBloc _reactCmtBloc;
  // Delete, edit comment

  Stream<List<Comment>> get listCmtStream => _commentsBloc.listCmtStream;

  CommentBloc(this.postId)
      : _commentsBloc = ListCommentsBloc(ListCommentsRepo(postId)),
        _createCmtBloc = CreateCommentBloc(CreateCommentRepo(postId)),
        _reactCmtBloc = ReactCmtBloc(ReactCmtRepo(postId));

  Future<void> getComments() async => _commentsBloc.getComments();

  Future<void> writeCmt(String content) async {
    final newText = "$content + ${(_commentsBloc.currentLen + 1)}";
    final res = await _createCmtBloc.createCmt(newText);
    print(res.toString());
    if (res) {
      _commentsBloc.getComments();
      AppEventBloc().emitEvent(const BlocEvent(EventName.createCmt));
    }
  }

  Future<bool> react(String id, int type) async {
    try {
      final res = await _reactCmtBloc.react(id, type);
      if (res) {
        getComments();
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> unReact(String id) async {
    try {
      final res = await _reactCmtBloc.unReact(id);
      if (res) {
        getComments();
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
