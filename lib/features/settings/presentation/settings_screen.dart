import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../../qr/presentation/qr_generator_screen.dart';

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
            const Text('Server Einstellungen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Server URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(settingsProvider).setServerUrl(controller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('URL gespeichert')),
                );
              },
              child: const Text('Speichern'),
            ),
            const SizedBox(height: 16),
            Text('Aktive Verbindung: ${settings.url}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            const Divider(height: 48),
            const Text('QR Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const QrGeneratorScreen()),
                );
              },
              icon: const Icon(Icons.qr_code),
              label: const Text('QR Generator öffnen'),
            ),
          ],
        ),
      ),
    );
  }
}
