import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../domain/course.dart';

class CourseNotifier extends Notifier<List<Course>> {
  static const _key = 'courses_list';

  @override
  List<Course> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList(_key) ?? [];
    
    if (jsonStringList.isEmpty) {
      // Füge Default-Kurs hinzu, wenn die Liste leer ist
      state = [Course(id: const Uuid().v4(), name: 'Ki Kurs')];
      await _save();
    } else {
      state = jsonStringList
          .map((s) => Course.fromJson(jsonDecode(s) as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> addCourse(String name, String startTime, String endTime) async {
    if (name.isNotEmpty) {
      final newCourse = Course(
        id: const Uuid().v4(), 
        name: name, 
        startTime: startTime, 
        endTime: endTime
      );
      state = [...state, newCourse];
      await _save();
    }
  }

  Future<void> importCourses(List<Course> importedCourses) async {
    state = [...state, ...importedCourses];
    await _save();
  }

  Future<void> removeCourse(String id) async {
    state = state.where((c) => c.id != id).toList();
    await _save();
  }

  Future<void> reorderCourses(int oldIndex, int newIndex) async {
    final courses = [...state];
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = courses.removeAt(oldIndex);
    courses.insert(newIndex, item);
    state = courses;
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = state.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, jsonStringList);
  }
}

final courseProvider = NotifierProvider<CourseNotifier, List<Course>>(() => CourseNotifier());
