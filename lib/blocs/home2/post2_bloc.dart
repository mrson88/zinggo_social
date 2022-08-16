import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:zinggo_social/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zinggo_social/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
part 'post2_event.dart';
part 'post2_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class Post2Bloc extends Bloc<Post2Event, Post2State> {
  Post2Bloc() : super(const Post2State()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<Post2State> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == Post2Status.initial) {
        final posts = await PostApi.fetchPost();
        return emit(
          state.copyWith(
            status: Post2Status.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await PostApi.fetchPost();
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: Post2Status.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: Post2Status.failure));
    }
  }
}
