import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/server_config.dart';

class SettingsNotifier extends ChangeNotifier {
  static const _key = 'server_config';
  // Default Passwort: 'admin' gehasht
  static final _defaultPasswordHash = sha256.convert(utf8.encode('admin')).toString();
  static final _defaultConfig = ServerConfig(address: '10.0.2.15', port: 8080, username: 'admin', password: _defaultPasswordHash);
  
  ServerConfig _config = _defaultConfig;

  ServerConfig get config => _config;

  SettingsNotifier() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      _config = ServerConfig.fromJson(jsonDecode(jsonString));
    }
    notifyListeners();
  }

  Future<void> setServerConfig(String address, int port) async {
    _config = ServerConfig(address: address, port: port, username: _config.username, password: _config.password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(_config.toJson()));
    notifyListeners();
  }

  Future<void> setAuth(String username, String password) async {
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();
    _config = ServerConfig(address: _config.address, port: _config.port, username: username, password: hashedPassword);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(_config.toJson()));
    notifyListeners();
  }
}

final settingsProvider = Provider<SettingsNotifier>((ref) => SettingsNotifier());
