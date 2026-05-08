import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../domain/attendee.dart';

part 'attendance_provider.g.dart';

@riverpod
class Attendance extends _$Attendance {
  @override
  FutureOr<List<Attendee>> build() async {
    return _fetchAttendees();
  }

  Future<List<Attendee>> _fetchAttendees() async {
    final dio = ref.read(apiClientProvider);
    final response = await dio.get('/attendance');
    
    if (response.data is List) {
      return (response.data as List)
          .map((e) => Attendee.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<void> addAttendee(Attendee attendee) async {
    // Optimistic UI update could be done here
    final dio = ref.read(apiClientProvider);
    await dio.post('/attendance', data: attendee.toJson());
    
    // Refresh the list from the server
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAttendees());
  }
}
