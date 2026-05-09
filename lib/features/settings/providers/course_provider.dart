import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../domain/course.dart';

class CourseNotifier extends ChangeNotifier {
  static const _key = 'courses_list';
  List<Course> _courses = [];

  List<Course> get courses => _courses;

  CourseNotifier() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList(_key) ?? [];
    _courses = jsonStringList
        .map((s) => Course.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  Future<void> addCourse(String name) async {
    if (name.isNotEmpty) {
      final newCourse = Course(id: const Uuid().v4(), name: name);
      _courses.add(newCourse);
      await _save();
    }
  }

  Future<void> removeCourse(String id) async {
    _courses.removeWhere((c) => c.id == id);
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = _courses.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, jsonStringList);
    notifyListeners();
  }
}

final courseProvider = Provider<CourseNotifier>((ref) => CourseNotifier());
