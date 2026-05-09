import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository.dart';

Response onRequest(RequestContext context) {
  final repository = context.read<AttendeeRepository>();
  final attendees = repository.attendees;

  final rows = [
    ['Vorname', 'Nachname', 'Kurs', 'Uhrzeit', 'Datum'],
    ...attendees.map((a) {
      final time = a['checkin_time'] != null ? DateTime.parse(a['checkin_time'] as String).toLocal() : null;
      return [
        a['first_name'] ?? '',
        a['last_name'] ?? '',
        a['course'] ?? '',
        time != null ? '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}' : '',
        time != null ? '${time.day.toString().padLeft(2, '0')}.${time.month.toString().padLeft(2, '0')}.${time.year}' : '',
      ];
    }),
  ];

  final csv = rows.map((row) => row.join(';')).join('\n');

  final now = DateTime.now();
  final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_'
                    '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';

  return Response(
    body: csv,
    headers: {
      'Content-Type': 'text/csv; charset=utf-8',
      'Content-Disposition': 'attachment; filename="kurs_checkins_$timestamp.csv"',
    },
  );
}
