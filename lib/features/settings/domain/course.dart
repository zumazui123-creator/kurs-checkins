class Course {
  final String id;
  final String name;
  final String startTime;
  final String endTime;

  Course({
    required this.id, 
    required this.name, 
    this.startTime = '', 
    this.endTime = ''
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
