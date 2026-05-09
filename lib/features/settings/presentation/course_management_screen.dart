import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/course_provider.dart';

class CourseManagementScreen extends ConsumerWidget {
  const CourseManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(courseProvider);
    final nameController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Kurse verwalten')),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    title: Text(
                      courses[index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      '${courses[index].startTime} - ${courses[index].endTime}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                        onPressed: () => ref.read(courseProvider.notifier).removeCourse(courses[index].id),
                      ),
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
