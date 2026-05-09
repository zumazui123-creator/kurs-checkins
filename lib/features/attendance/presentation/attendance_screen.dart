import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/attendance_provider.dart';
import '../../../services/export_service.dart';
import 'add_attendee_dialog.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendeesAsync = ref.watch(attendanceProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teilnehmerliste'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(attendanceProvider.notifier).refresh(),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Als CSV exportieren',
            onPressed: attendeesAsync.maybeWhen(
              data: (list) => list.isEmpty ? null : () => ExportService.exportToCsv(list),
              orElse: () => null,
            ),
          ),
        ],
      ),
      body: attendeesAsync.when(
        data: (attendees) => attendees.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 64, color: theme.colorScheme.outline),
                    const SizedBox(height: 16),
                    const Text('Noch keine Teilnehmer eingecheckt.'),
                  ],
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Vorname')),
                      DataColumn(label: Text('Nachname')),
                      DataColumn(label: Text('Kurs')),
                      DataColumn(label: Text('Uhrzeit')),
                    ],
                    rows: attendees.map((attendee) {
                      final checkinStr = attendee.checkinTime != null
                          ? DateFormat('HH:mm').format(attendee.checkinTime!)
                          : '--:--';
                      return DataRow(cells: [
                        DataCell(Text(attendee.firstName)),
                        DataCell(Text(attendee.lastName)),
                        DataCell(Text(attendee.course)),
                        DataCell(Text(checkinStr)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Fehler beim Laden: $err'),
              ElevatedButton(
                onPressed: () => ref.read(attendanceProvider.notifier).refresh(),
                child: const Text('Erneut versuchen'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddAttendeeDialog(),
          );
        },
        label: const Text('Check-in'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
