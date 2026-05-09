import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../providers/course_provider.dart';
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
    final courseNotifier = ref.watch(courseProvider);
    final courses = courseNotifier.courses;
    
    final courseController = TextEditingController();

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
            const Text('Kurse verwalten', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: courseController,
              decoration: InputDecoration(
                labelText: 'Neuer Kurs',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    courseNotifier.addCourse(courseController.text);
                    courseController.clear();
                  },
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(courses[index].name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => courseNotifier.removeCourse(courses[index].id),
                ),
              ),
            ),
            const Divider(height: 48),
            const Text('QR Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
