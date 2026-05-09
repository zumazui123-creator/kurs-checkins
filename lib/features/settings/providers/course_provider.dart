import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseNotifier extends ChangeNotifier {
  static const _key = 'courses';
  List<String> _courses = [];

  List<String> get courses => _courses;

  CourseNotifier() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _courses = prefs.getStringList(_key) ?? [];
    notifyListeners();
  }

  Future<void> addCourse(String course) async {
    if (course.isNotEmpty && !_courses.contains(course)) {
      _courses.add(course);
      await _save();
    }
  }

  Future<void> removeCourse(String course) async {
    _courses.remove(course);
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _courses);
    notifyListeners();
  }
}

final courseProvider = Provider<CourseNotifier>((ref) => CourseNotifier());
