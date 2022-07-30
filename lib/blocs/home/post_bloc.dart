import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/repositories/home/post_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _boredService;
  PostBloc(this._boredService) : super(PostLoadingState()) {
    on<PostEvent>(
      (event, emit) async {
        // TODO: implement event handler
        final model = await _boredService.useHttp();
        emit(PostLoadedState(model));
      },
    );
  }
}
