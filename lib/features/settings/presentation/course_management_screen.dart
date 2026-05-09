import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/course_provider.dart';

class CourseManagementScreen extends ConsumerWidget {
  const CourseManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(courseProvider);
    final courseController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Kurse verwalten')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: courseController,
              decoration: InputDecoration(
                labelText: 'Neuer Kurs',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ref.read(courseProvider.notifier).addCourse(courseController.text);
                    courseController.clear();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(courses[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => ref.read(courseProvider.notifier).removeCourse(courses[index].id),
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
