import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final _userController = TextEditingController();
  final _passController = TextEditingController();

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
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _eraseAllData(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alle Daten löschen?'),
        content: const Text('Dies setzt alle Einstellungen und Kurse zurück.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Abbrechen')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Löschen')),
        ],
      ),
    );
    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Daten gelöscht. App neu starten.')));
    }
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
            TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'IP Adresse', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _portController, decoration: const InputDecoration(labelText: 'Port', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            ElevatedButton(
              onPressed: () async {
                final address = _addressController.text;
                final port = int.tryParse(_portController.text) ?? 8080;
                final testUrl = 'http://$address:$port';
                try {
                  final dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 3)));
                  await dio.get('$testUrl/');
                  await settings.setServerConfig(address, port);
                  if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Konfiguration gespeichert')));
                } catch (e) {
                  if (mounted) showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Fehler'), content: Text('Server nicht erreichbar: $e')));
                }
              },
              child: const Text('Speichern'),
            ),
            const Divider(height: 48),
            const Text('Anmeldedaten ändern', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Neuer Benutzername')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Neues Passwort'), obscureText: true),
            ElevatedButton(
              onPressed: () => settings.setAuth(_userController.text, _passController.text),
              child: const Text('Anmeldedaten ändern'),
            ),
            const Divider(height: 48),
            const Text('Datenverwaltung', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(onPressed: () => _eraseAllData(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Alle Daten löschen')),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CourseManagementScreen())),
              icon: const Icon(Icons.book), label: const Text('Kurse verwalten'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QrGeneratorScreen())),
              icon: const Icon(Icons.qr_code), label: const Text('QR Generator öffnen'),
            ),
          ],
        ),
      ),
    );
  }
}
