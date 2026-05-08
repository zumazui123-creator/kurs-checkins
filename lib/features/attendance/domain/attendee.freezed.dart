// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Attendee implements DiagnosticableTreeMixin {

 String get id;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName; String get course;@JsonKey(name: 'checkin_time') DateTime? get checkinTime;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Attendee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendeeCopyWith<Attendee> get copyWith => _$AttendeeCopyWithImpl<Attendee>(this as Attendee, _$identity);

  /// Serializes this Attendee to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Attendee'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('firstName', firstName))..add(DiagnosticsProperty('lastName', lastName))..add(DiagnosticsProperty('course', course))..add(DiagnosticsProperty('checkinTime', checkinTime))..add(DiagnosticsProperty('createdAt', createdAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attendee&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.course, course) || other.course == course)&&(identical(other.checkinTime, checkinTime) || other.checkinTime == checkinTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,course,checkinTime,createdAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Attendee(id: $id, firstName: $firstName, lastName: $lastName, course: $course, checkinTime: $checkinTime, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AttendeeCopyWith<$Res>  {
  factory $AttendeeCopyWith(Attendee value, $Res Function(Attendee) _then) = _$AttendeeCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String course,@JsonKey(name: 'checkin_time') DateTime? checkinTime,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$AttendeeCopyWithImpl<$Res>
    implements $AttendeeCopyWith<$Res> {
  _$AttendeeCopyWithImpl(this._self, this._then);

  final Attendee _self;
  final $Res Function(Attendee) _then;

/// Create a copy of Attendee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? course = null,Object? checkinTime = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as String,checkinTime: freezed == checkinTime ? _self.checkinTime : checkinTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Attendee].
extension AttendeePatterns on Attendee {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attendee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attendee() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attendee value)  $default,){
final _that = this;
switch (_that) {
case _Attendee():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attendee value)?  $default,){
final _that = this;
switch (_that) {
case _Attendee() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String course, @JsonKey(name: 'checkin_time')  DateTime? checkinTime, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attendee() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.course,_that.checkinTime,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String course, @JsonKey(name: 'checkin_time')  DateTime? checkinTime, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Attendee():
return $default(_that.id,_that.firstName,_that.lastName,_that.course,_that.checkinTime,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String course, @JsonKey(name: 'checkin_time')  DateTime? checkinTime, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Attendee() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.course,_that.checkinTime,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Attendee with DiagnosticableTreeMixin implements Attendee {
  const _Attendee({required this.id, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, required this.course, @JsonKey(name: 'checkin_time') this.checkinTime, @JsonKey(name: 'created_at') this.createdAt});
  factory _Attendee.fromJson(Map<String, dynamic> json) => _$AttendeeFromJson(json);

@override final  String id;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override final  String course;
@override@JsonKey(name: 'checkin_time') final  DateTime? checkinTime;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of Attendee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendeeCopyWith<_Attendee> get copyWith => __$AttendeeCopyWithImpl<_Attendee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendeeToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Attendee'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('firstName', firstName))..add(DiagnosticsProperty('lastName', lastName))..add(DiagnosticsProperty('course', course))..add(DiagnosticsProperty('checkinTime', checkinTime))..add(DiagnosticsProperty('createdAt', createdAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attendee&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.course, course) || other.course == course)&&(identical(other.checkinTime, checkinTime) || other.checkinTime == checkinTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,course,checkinTime,createdAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Attendee(id: $id, firstName: $firstName, lastName: $lastName, course: $course, checkinTime: $checkinTime, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AttendeeCopyWith<$Res> implements $AttendeeCopyWith<$Res> {
  factory _$AttendeeCopyWith(_Attendee value, $Res Function(_Attendee) _then) = __$AttendeeCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String course,@JsonKey(name: 'checkin_time') DateTime? checkinTime,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$AttendeeCopyWithImpl<$Res>
    implements _$AttendeeCopyWith<$Res> {
  __$AttendeeCopyWithImpl(this._self, this._then);

  final _Attendee _self;
  final $Res Function(_Attendee) _then;

/// Create a copy of Attendee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? course = null,Object? checkinTime = freezed,Object? createdAt = freezed,}) {
  return _then(_Attendee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as String,checkinTime: freezed == checkinTime ? _self.checkinTime : checkinTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
