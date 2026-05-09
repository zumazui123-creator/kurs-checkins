import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'widgets/scaffold_with_navbar.dart';

import 'features/attendance/presentation/attendance_screen.dart';
import 'features/qr/presentation/qr_generator_screen.dart';
import 'features/qr/presentation/qr_scanner_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const PlaceholderScreen(title: 'Dashboard'),
          ),
          GoRoute(
            path: '/attendance',
            builder: (context, state) => const AttendanceScreen(),
          ),
          GoRoute(
            path: '/scan',
            builder: (context, state) => const QrScannerScreen(),
          ),
          GoRoute(
            path: '/generate',
            builder: (context, state) => const QrGeneratorScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              '$title wird gerade gebaut...',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
