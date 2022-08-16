import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/repositories/repositories.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _pagingRepo;

  PostBloc(this._pagingRepo) : super(PostLoadingState()) {
    on<PostEvent>(
      (event, emit) async {
        // TODO: implement event handler

        final model = await _pagingRepo.useHttp();
        bool hasReachedMax = false;

        emit(PostLoadedState(model, hasReachedMax));
      },
    );
  }
}
