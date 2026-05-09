class Attendee {
  final String id;
  final String firstName;
  final String lastName;
  final String course;
  final DateTime? checkinTime;
  final String? startTime;
  final String? endTime;

  Attendee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    this.checkinTime,
    this.startTime,
    this.endTime,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      id: (json['id'] ?? '') as String,
      firstName: (json['firstName'] ?? json['first_name'] ?? '') as String,
      lastName: (json['lastName'] ?? json['last_name'] ?? '') as String,
      course: (json['course'] ?? '') as String,
      checkinTime: json['checkinTime'] != null 
          ? DateTime.tryParse(json['checkinTime'] as String) 
          : (json['checkin_time'] != null ? DateTime.tryParse(json['checkin_time'] as String) : null),
      startTime: (json['startTime'] ?? json['start_time']) as String?,
      endTime: (json['endTime'] ?? json['end_time']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'checkinTime': checkinTime?.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
