import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'attendee.freezed.dart';
part 'attendee.g.dart';

@freezed
abstract class Attendee with _$Attendee {
  const factory Attendee({
    required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String course,
    @JsonKey(name: 'checkin_time') DateTime? checkinTime,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Attendee;

  factory Attendee.fromJson(Map<String, dynamic> json) => _$AttendeeFromJson(json);
}
