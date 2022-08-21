import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:zinggo_social/models/models.dart';
import 'package:zinggo_social/providers/bloc_provider.dart';
import 'package:zinggo_social/repositories/post/post_detail_repo.dart';
import 'package:zinggo_social/screens/post_detail/blocs/app_event_bloc.dart';

class PostDetailBloc extends BlocBase {
  final String _postId;

  final _postCtrl = BehaviorSubject<Post>();
  Stream<Post> get postsStream => _postCtrl.stream;
  Post get postDetail => _postCtrl.stream.value;

  late final StreamSubscription<BlocEvent> _subCreateCmt;

  PostDetailBloc(this._postId) {
    _subCreateCmt = AppEventBloc().listenEvent(
      eventName: EventName.createCmt,
      handler: _onCreateCmt,
    );
  }

  Future<void> getPost() async {
    try {
      final res = await PostDetailRepo().getPost(_postId);
      if (res != null) {
        _postCtrl.sink.add(res);
      }
    } catch (e) {
      _postCtrl.sink.addError('Cannot fetch post right now!!!');
    }
  }

  Future<void> deletePost() async {
    try {
      AppEventBloc().emitEvent(BlocEvent(EventName.deletePost, _postId));
      return;
      // final res = await deletePostBloc.deletePost(_postId);
      // if(res){
      //   AppEventBloc().emitEvent(BlocEvent(EventName.deletePost,_postId));
      // }
    } catch (e) {
      rethrow;
    }
  }

  void _onCreateCmt(BlocEvent evt) {
    final currentNum = postDetail.commentCounts ?? 0;
    final newCount = currentNum + 1;
    _postCtrl.sink.add(postDetail..commentCounts = newCount);
  }

  @override
  void dispose() {
    _postCtrl.close();
    _subCreateCmt.cancel();
  }
}
