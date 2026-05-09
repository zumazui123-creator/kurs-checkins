import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _qrKey = GlobalKey();
  String _qrData = '';

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
        _qrData = jsonEncode(data);
      });
    } else {
      setState(() {
        _qrData = '';
      });
    }
  }

  Future<void> _saveQrCode() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) return;

    try {
      final boundary = _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      
      await Gal.putImageBytes(pngBytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('QR Code in Galerie gespeichert')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fehler: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('QR Generator')),
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
            if (_qrData.isNotEmpty)
              Column(
                children: [
                  RepaintBoundary(
                    key: _qrKey,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: QrImageView(
                        data: _qrData,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _saveQrCode,
                    icon: const Icon(Icons.download),
                    label: const Text('Speichern'),
                  ),
                ],
              )
            else
              Center(
                child: Text(
                  'Gib einen Namen ein, um einen QR-Code lokal zu generieren.',
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
