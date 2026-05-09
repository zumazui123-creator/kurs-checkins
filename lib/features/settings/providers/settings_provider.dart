import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends ChangeNotifier {
  static const _key = 'server_url';
  static const _defaultUrl = 'http://10.0.2.15:8080';
  
  String? _url;
  bool _isLoading = true;

  String? get url => _url;
  bool get isLoading => _isLoading;

  SettingsNotifier() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _url = prefs.getString(_key) ?? _defaultUrl;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setServerUrl(String url) async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, url);
    _url = url;
    _isLoading = false;
    notifyListeners();
  }
}

final settingsProvider = Provider<SettingsNotifier>((ref) => SettingsNotifier());
