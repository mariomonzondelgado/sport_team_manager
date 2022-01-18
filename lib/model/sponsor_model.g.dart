// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
      name: json['name'] as String,
      description: json['description'] as String,
      logo: json['logo'] as String,
      phone: json['phone'] as String,
      webUrl: json['web'] as String,
      instagramUrl: json['instagram'] as String,
      facebookUrl: json['facebook'] as String,
      mail: json['mail'] as String,
    );

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'logo': instance.logo,
      'phone': instance.phone,
      'web': instance.webUrl,
      'instagram': instance.instagramUrl,
      'facebook': instance.facebookUrl,
      'mail': instance.mail,
    };
