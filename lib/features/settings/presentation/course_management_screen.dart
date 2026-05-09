import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import '../providers/course_provider.dart';
import '../domain/course.dart';

class CourseManagementScreen extends ConsumerWidget {
  const CourseManagementScreen({super.key});

  Future<void> _importCsv(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if (result != null && result.files.single.path != null) {
      final input = await File(result.files.single.path!).readAsString();
      final List<List<dynamic>> fields = input.split('\n').map((line) => line.split(',')).toList();
      
      final imported = fields.map((row) {
        return Course(
          id: const Uuid().v4(),
          name: row.isNotEmpty ? row[0].toString() : 'Unbekannter Kurs',
          startTime: row.length > 1 ? row[1].toString() : '',
          endTime: row.length > 2 ? row[2].toString() : '',
        );
      }).toList();
      
      ref.read(courseProvider.notifier).importCourses(imported);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${imported.length} Kurse importiert')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(courseProvider);
    final nameController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Kurse verwalten'), actions: [
        IconButton(icon: const Icon(Icons.upload_file), onPressed: () => _importCsv(context, ref)),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Kursname', border: OutlineInputBorder())),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: TextField(controller: startController, decoration: const InputDecoration(labelText: 'Von (HH:MM)'))),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: endController, decoration: const InputDecoration(labelText: 'Bis (HH:MM)'))),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ref.read(courseProvider.notifier).addCourse(nameController.text, startController.text, endController.text);
                nameController.clear();
                startController.clear();
                endController.clear();
              },
              child: const Text('Kurs hinzufügen'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ReorderableListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: courses.length,
                onReorder: (int oldIndex, int newIndex) {
                  ref.read(courseProvider.notifier).reorderCourses(oldIndex, newIndex);
                },
                itemBuilder: (context, index) => Card(
                  key: ValueKey(courses[index].id),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle, size: 28),
                    ),
                    title: Text(courses[index].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text('${courses[index].startTime} - ${courses[index].endTime}', style: const TextStyle(fontSize: 14)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                      onPressed: () => ref.read(courseProvider.notifier).removeCourse(courses[index].id),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
