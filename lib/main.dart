import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'features/settings/providers/settings_provider.dart';
import 'features/settings/providers/course_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final container = ProviderContainer();
  
  // Provider einmalig initialisieren, um Daten zu laden
  container.read(settingsProvider);
  container.read(courseProvider);
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const BuchungsApp(),
    ),
  );
}
