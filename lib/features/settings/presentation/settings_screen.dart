import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final controller = TextEditingController(text: settings.url);

    return Scaffold(
      appBar: AppBar(title: const Text('Setup')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Server URL',
                hintText: 'http://192.168.178.XX:8080',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(settingsProvider).setServerUrl(controller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Server-URL gespeichert')),
                );
              },
              child: const Text('Speichern'),
            ),
            const SizedBox(height: 32),
            if (settings.isLoading)
              const CircularProgressIndicator()
            else
              Text('Aktuelle URL: ${settings.url}'),
          ],
        ),
      ),
    );
  }
}
