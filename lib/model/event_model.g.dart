// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      title: json['title'] as String,
      body: json['body'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'date': instance.date.toIso8601String(),
    };
