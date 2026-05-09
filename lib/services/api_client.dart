import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/settings/providers/settings_provider.dart';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/settings/providers/settings_provider.dart';

final apiClientProvider = Provider<Dio>((ref) {
  final config = ref.watch(settingsProvider).config;
  
  return Dio(BaseOptions(
    baseUrl: config.toUrl(),
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
});
