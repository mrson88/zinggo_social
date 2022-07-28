part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostLoadingState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PostErrorState extends PostState {
  final String message;
  const PostErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostLoadedState extends PostState {
  final List model;

  const PostLoadedState(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
