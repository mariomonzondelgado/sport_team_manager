// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
      sponsorId: json['sponsor_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      logo: json['logo'] as String,
      phone: json['phone'] as String,
      twitter: json['twitter'] as String,
      instagramUrl: json['instagram'] as String,
      facebookUrl: json['facebook'] as String,
      mail: json['mail'] as String,
    );

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'sponsor_id': instance.sponsorId,
      'name': instance.name,
      'description': instance.description,
      'logo': instance.logo,
      'phone': instance.phone,
      'twitter': instance.twitter,
      'instagram': instance.instagramUrl,
      'facebook': instance.facebookUrl,
      'mail': instance.mail,
    };
