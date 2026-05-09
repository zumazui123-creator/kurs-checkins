class AttendeeRepository {
  final List<Map<String, dynamic>> _attendees = [];

  List<Map<String, dynamic>> get attendees => List.unmodifiable(_attendees);

  void add(Map<String, dynamic> attendee) {
    _attendees.add(attendee);
  }

  void clear() {
    _attendees.clear();
  }
}

final repository = AttendeeRepository();
