part of 'post2_bloc.dart';

abstract class Post2Event extends Equatable {
  const Post2Event();

  @override
  List<Object> get props => [];
}

class PostRefresh extends Post2Event {}

class PostFetched extends Post2Event {}
