import 'package:intl/intl.dart';
import '../features/attendance/domain/attendee.dart';

import 'export_stub.dart'
    if (dart.library.io) 'export_io.dart'
    if (dart.library.html) 'export_web.dart';

class ExportService {
  static Future<void> exportToCsv(List<Attendee> attendees) async {
    final List<List<dynamic>> rows = [];

    // Header
    rows.add(['Vorname', 'Nachname', 'Kurs', 'Uhrzeit', 'Datum']);

    for (final attendee in attendees) {
      final checkinTime = attendee.checkinTime;
      rows.add([
        attendee.firstName,
        attendee.lastName,
        attendee.course,
        checkinTime != null ? DateFormat('HH:mm').format(checkinTime) : '',
        checkinTime != null ? DateFormat('dd.MM.yyyy').format(checkinTime) : '',
      ]);
    }

    // Simple manual CSV generation to avoid package issues
    final csvString = rows.map((row) => row.join(';')).join('\n');
    
    await saveAndShareFile(
      csvString, 
      'kurs_checkins_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.csv'
    );
  }
}

abstract class ExportDelegate {
  Future<void> saveAndShare(String content, String filename);
}
