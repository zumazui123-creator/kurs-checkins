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
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: attendees.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final attendee = attendees[index];
                  final checkinStr = attendee.checkinTime != null
                      ? DateFormat('HH:mm').format(attendee.checkinTime!)
                      : '--:--';
                  
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          attendee.firstName[0].toUpperCase(),
                          style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                        ),
                      ),
                      title: Text(attendee.firstName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text((attendee.startTime ?? '').isNotEmpty || (attendee.endTime ?? '').isNotEmpty
                          ? '${attendee.startTime ?? ''} - ${attendee.endTime ?? ''}'
                          : ''),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          checkinStr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
