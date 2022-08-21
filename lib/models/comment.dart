

import 'package:json_annotation/json_annotation.dart';
import 'package:zinggo_social/models/models.dart';

import 'comment_meta_data.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(name: 'id', includeIfNull: false)
  String? id;

  @JsonKey(name: 'status', includeIfNull: false)
  final int? status;

  @JsonKey(name: 'created_at', includeIfNull: false)
  DateTime? createdAt;

  @JsonKey(name: 'content', includeIfNull: false)
  String? content;

  @JsonKey(name: 'user', includeIfNull: false)
  User? user;

  @JsonKey(name: 'liked', includeIfNull: false)
  bool? liked;

  @JsonKey(name: 'like_count', includeIfNull: false)
  int? likeCounts;

  @JsonKey(name: 'metadata', includeIfNull: true)
  CommentMetaData? metaData;

  String get ownerId => user?.id ?? '';

  Comment({
    this.id,
    this.status,
    this.createdAt,
    this.content,
    this.user,
    this.liked,
    this.likeCounts,
    this.metaData,
  });

  String get displayName => user?.displayName ?? '';

  String? get urlUserAvatar => user?.imgUrl;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
