import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Player {
  Player({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.position,
    required this.photoUrl,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  @JsonKey(name: 'number')
  String number;

  @JsonKey(name: 'position')
  String position;

  @JsonKey(name: 'photo')
  String photoUrl;
}
