import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/server_config.dart';

class SettingsNotifier extends ChangeNotifier {
  static const _key = 'server_config';
  static final _defaultConfig = ServerConfig(address: '10.0.2.15', port: 8080);
  
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
    _config = ServerConfig(address: address, port: port);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(_config.toJson()));
    notifyListeners();
  }
}

final settingsProvider = Provider<SettingsNotifier>((ref) => SettingsNotifier());
