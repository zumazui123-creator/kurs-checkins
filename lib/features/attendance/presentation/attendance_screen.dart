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
    final attendees = ref.watch(attendanceProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teilnehmerliste'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Als CSV exportieren',
            onPressed: attendees.isEmpty
                ? null
                : () async {
                    await ExportService.exportToCsv(attendees);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('CSV Export erfolgreich!')),
                      );
                    }
                  },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filtering
            },
          ),
        ],
      ),
      body: attendees.isEmpty
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
          : ListView.separated(
              itemCount: attendees.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final attendee = attendees[index];
                final checkinStr = attendee.checkinTime != null
                    ? DateFormat('HH:mm').format(attendee.checkinTime!)
                    : '--:--';

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      attendee.firstName[0] + attendee.lastName[0],
                      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                    ),
                  ),
                  title: Text('${attendee.firstName} ${attendee.lastName}'),
                  subtitle: Text(attendee.course),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        checkinStr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Uhrzeit',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                );
              },
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
