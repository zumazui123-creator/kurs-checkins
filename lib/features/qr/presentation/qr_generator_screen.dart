import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/api_client.dart';

class QrGeneratorScreen extends ConsumerStatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  ConsumerState<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends ConsumerState<QrGeneratorScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _qrUrl;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _generateQr() {
    if (_firstNameController.text.isNotEmpty && _lastNameController.text.isNotEmpty) {
      final data = {
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
      };
      
      setState(() {
        _isLoading = true;
        final baseUrl = ref.read(apiClientProvider).options.baseUrl;
        _qrUrl = '$baseUrl/qr?data=${Uri.encodeComponent(jsonEncode(data))}';
      });

      // Simuliere Ladezeit oder warte, bis das Bild geladen ist
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) setState(() => _isLoading = false);
      });
    } else {
      setState(() => _qrUrl = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'Vorname',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      onChanged: (_) => _generateQr(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nachname',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (_) => _generateQr(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_qrUrl != null)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: _isLoading
                        ? const SizedBox(width: 200, height: 200, child: Center(child: CircularProgressIndicator()))
                        : SvgPicture.network(
                            _qrUrl!,
                            width: 200,
                            height: 200,
                          ),
                  ),
                ],
              )
            else
              Center(
                child: Text(
                  'Gib einen Namen ein, um einen QR-Code auf dem Server zu generieren.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.outline),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
