import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import 'course_management_screen.dart';
import '../../qr/presentation/qr_generator_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late TextEditingController _addressController;
  late TextEditingController _portController;

  @override
  void initState() {
    super.initState();
    final config = ref.read(settingsProvider).config;
    _addressController = TextEditingController(text: config.address);
    _portController = TextEditingController(text: config.port.toString());
  }

  @override
  void dispose() {
    _addressController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Setup')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Server Einstellungen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'IP Adresse', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _portController,
              decoration: const InputDecoration(labelText: 'Port', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                final port = int.tryParse(_portController.text) ?? 8080;
                await settings.setServerConfig(_addressController.text, port);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Konfiguration gespeichert')),
                  );
                }
              },
              child: const Text('Speichern'),
            ),
            const SizedBox(height: 16),
            Text('Aktive Verbindung: ${settings.config.toUrl()}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            const Divider(height: 48),
            const Text('Datenverwaltung', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CourseManagementScreen()),
              ),
              icon: const Icon(Icons.book),
              label: const Text('Kurse verwalten'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const QrGeneratorScreen()),
              ),
              icon: const Icon(Icons.qr_code),
              label: const Text('QR Generator öffnen'),
            ),
          ],
        ),
      ),
    );
  }
}
