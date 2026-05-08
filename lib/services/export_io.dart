import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveAndShareFile(String content, String filename) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/$filename';
  final file = File(path);
  await file.writeAsString(content, encoding: utf8);

  await Share.shareXFiles(
    [XFile(path)],
    subject: 'Kurs-Checkins Export',
  );
}
