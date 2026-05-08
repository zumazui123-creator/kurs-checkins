import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../features/attendance/domain/attendee.dart';

// Conditional import would be cleaner, but for simplicity we use a helper 
// that avoids direct dart:io usage on web if possible.
// However, dart:io File and Directory will fail to compile on web.
// So we MUST use conditional imports or separate files.

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

    final csvString = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);
    
    await saveAndShareFile(
      csvString, 
      'kurs_checkins_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.csv'
    );
  }
}

abstract class ExportDelegate {
  Future<void> saveAndShare(String content, String filename);
}
