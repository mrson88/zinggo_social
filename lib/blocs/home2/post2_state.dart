part of 'post2_bloc.dart';

enum Post2Status { initial, success, failure }

class Post2State extends Equatable {
  const Post2State({
    this.status = Post2Status.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final Post2Status status;
  final List<Post> posts;
  final bool hasReachedMax;

  Post2State copyWith({
    Post2Status? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return Post2State(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
