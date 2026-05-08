// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Attendance)
final attendanceProvider = AttendanceProvider._();

final class AttendanceProvider
    extends $NotifierProvider<Attendance, List<Attendee>> {
  AttendanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceHash();

  @$internal
  @override
  Attendance create() => Attendance();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Attendee> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Attendee>>(value),
    );
  }
}

String _$attendanceHash() => r'a7fbd48dd1ee04098807cb3ac332ec17260695f3';

abstract class _$Attendance extends $Notifier<List<Attendee>> {
  List<Attendee> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Attendee>, List<Attendee>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Attendee>, List<Attendee>>,
              List<Attendee>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
