import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  Event({
    required this.eventId,
    required this.title,
    required this.body,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @JsonKey(name: 'event_id')
  String eventId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'body')
  String body;

  @JsonKey(name: 'date')
  DateTime date;
}
