import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  Post({
    required this.title,
    required this.body,
    required this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'body')
  String body;

  @JsonKey(name: 'image')
  String imageUrl;
}
