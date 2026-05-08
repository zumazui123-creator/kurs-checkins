// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attendee _$AttendeeFromJson(Map<String, dynamic> json) => _Attendee(
  id: json['id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  course: json['course'] as String,
  checkinTime: json['checkin_time'] == null
      ? null
      : DateTime.parse(json['checkin_time'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$AttendeeToJson(_Attendee instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'course': instance.course,
  'checkin_time': instance.checkinTime?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
};
