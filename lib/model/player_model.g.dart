// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      number: json['number'] as String,
      position: json['position'] as String,
      photoUrl: json['photo'] as String,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'number': instance.number,
      'position': instance.position,
      'photo': instance.photoUrl,
    };
