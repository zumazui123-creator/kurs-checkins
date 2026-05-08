import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/attendee.dart';
import 'package:uuid/uuid.dart';

part 'attendance_provider.g.dart';

@riverpod
class Attendance extends _$Attendance {
  @override
  List<Attendee> build() {
    return [
      Attendee(
        id: const Uuid().v4(),
        firstName: 'Max',
        lastName: 'Mustermann',
        course: 'Flutter Advanced',
        checkinTime: DateTime.now(),
      ),
      Attendee(
        id: const Uuid().v4(),
        firstName: 'Erika',
        lastName: 'Musterfrau',
        course: 'Dart Basics',
        checkinTime: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
    ];
  }

  void addAttendee(Attendee attendee) {
    state = [...state, attendee];
  }
}
