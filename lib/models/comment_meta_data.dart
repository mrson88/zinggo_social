import 'package:json_annotation/json_annotation.dart';

part 'comment_meta_data.g.dart';

@JsonSerializable()
class CommentMetaData {
  @JsonKey(name: 'react', includeIfNull: true)
  Map? react;
  // {
  //  '3' : {
  //    '12121' //
  //     '12312'
  //    'asasa
  //  },
  // '4': {''id},
  // '5': {''id},
  // '6': {''id},
  // }

  @JsonKey(name: 'your_react', includeIfNull: true)
  int? yourReact;

  CommentMetaData({
    this.react,
    this.yourReact,
  });

  factory CommentMetaData.fromJson(Map<String, dynamic> json) =>
      _$CommentMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentMetaDataToJson(this);
}
