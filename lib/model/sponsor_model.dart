import 'package:json_annotation/json_annotation.dart';

part 'sponsor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Sponsor {
  Sponsor({
    required this.sponsorId,
    required this.name,
    required this.description,
    required this.logo,
    required this.phone,
    required this.twitter,
    required this.instagramUrl,
    required this.facebookUrl,
    required this.mail,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) =>
      _$SponsorFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorToJson(this);

  @JsonKey(name: 'sponsor_id')
  String sponsorId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'logo')
  String logo;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'twitter')
  String twitter;

  @JsonKey(name: 'instagram')
  String instagramUrl;

  @JsonKey(name: 'facebook')
  String facebookUrl;

  @JsonKey(name: 'mail')
  String mail;
}
