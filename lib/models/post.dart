import 'package:zinggo_social/models/user.dart';
import 'package:zinggo_social/models/photo.dart';
import 'package:zinggo_social/models/picture.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;

  @JsonKey(name: 'status', includeIfNull: false)
  final int? status;

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'images', includeIfNull: false)
  final List<Picture>? images;

  @JsonKey(name: 'photos', includeIfNull: false)
  final List<Photo>? photos;

  @JsonKey(name: 'comment_counts', includeIfNull: false)
  late final int? commentCounts;

  @JsonKey(name: 'like_counts', includeIfNull: false)
  int? likeCounts;

  @JsonKey(name: 'liked', includeIfNull: false)
  bool? liked;

  @JsonKey(name: 'user', includeIfNull: false)
  final User? user;

  Post({
    this.id,
    this.status,
    this.title,
    this.description,
    this.images,
    this.photos,
    this.commentCounts,
    this.likeCounts,
    this.liked,
    this.user,
  });

  String? get urlUserAvatar => user?.imgUrl;

  String get displayName => user?.displayName ?? '';

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
