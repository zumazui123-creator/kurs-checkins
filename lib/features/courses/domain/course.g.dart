// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Course _$CourseFromJson(Map<String, dynamic> json) => _Course(
  id: json['id'] as String,
  title: json['title'] as String,
  room: json['room'] as String?,
  startTime: json['start_time'] == null
      ? null
      : DateTime.parse(json['start_time'] as String),
);

Map<String, dynamic> _$CourseToJson(_Course instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'room': instance.room,
  'start_time': instance.startTime?.toIso8601String(),
};
