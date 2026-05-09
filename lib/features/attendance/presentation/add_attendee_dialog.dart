import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../domain/attendee.dart';
import '../providers/attendance_provider.dart';
import '../../settings/providers/course_provider.dart';

class AddAttendeeDialog extends ConsumerStatefulWidget {
  const AddAttendeeDialog({super.key});

  @override
  ConsumerState<AddAttendeeDialog> createState() => _AddAttendeeDialogState();
}

class _AddAttendeeDialogState extends ConsumerState<AddAttendeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _selectedCourse;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedCourse != null) {
      final attendee = Attendee(
        id: const Uuid().v4(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        course: _selectedCourse!,
        checkinTime: DateTime.now(),
      );

      ref.read(attendanceProvider.notifier).addAttendee(attendee);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(courseProvider);
    
    // Initialisiere Auswahl, wenn noch nicht gesetzt
    if (_selectedCourse == null && courses.isNotEmpty) {
      _selectedCourse = courses.first.name;
    }

    return AlertDialog(
      title: const Text('Teilnehmer hinzufügen'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Vorname',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Pflichtfeld' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Nachname',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Pflichtfeld' : null,
              ),
              const SizedBox(height: 16),
              if (courses.isEmpty)
                const Text('Keine Kurse verfügbar. Bitte im Setup hinzufügen.', style: TextStyle(color: Colors.red)),
              if (courses.isNotEmpty)
                DropdownButtonFormField<String>(
                  value: _selectedCourse,
                  decoration: const InputDecoration(
                    labelText: 'Kurs',
                    prefixIcon: Icon(Icons.book_outlined),
                  ),
                  items: courses.map((course) {
                    return DropdownMenuItem<String>(
                      value: course.name,
                      child: Text(course.name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCourse = newValue;
                      });
                    }
                  },
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: courses.isEmpty ? null : _submit,
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
