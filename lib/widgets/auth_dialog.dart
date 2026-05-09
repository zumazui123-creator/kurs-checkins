import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/settings/providers/settings_provider.dart';

class AuthDialog extends ConsumerStatefulWidget {
  final VoidCallback onSuccess;

  const AuthDialog({super.key, required this.onSuccess});

  @override
  ConsumerState<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends ConsumerState<AuthDialog> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String? _error;

  void _checkAuth() {
    final config = ref.read(settingsProvider).config;
    final hashedInput = sha256.convert(utf8.encode(_passController.text)).toString();
    
    if (_userController.text == config.username && hashedInput == config.password) {
      widget.onSuccess();
    } else {
      setState(() => _error = 'Falsche Zugangsdaten');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Setup Zugriff'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Benutzername')),
          TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Passwort'), obscureText: true),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
        ElevatedButton(onPressed: _checkAuth, child: const Text('Anmelden')),
      ],
    );
  }
}
