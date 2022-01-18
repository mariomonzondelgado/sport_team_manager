// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['image'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'image': instance.imageUrl,
    };
