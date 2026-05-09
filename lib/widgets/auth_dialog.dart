import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  final VoidCallback onSuccess;

  const AuthDialog({super.key, required this.onSuccess});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String? _error;

  void _checkAuth() {
    if (_userController.text == 'local' && _passController.text == '1234') {
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
