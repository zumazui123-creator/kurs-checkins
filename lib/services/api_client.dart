import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/settings/providers/settings_provider.dart';

final apiClientProvider = Provider<Dio>((ref) {
  final settings = ref.watch(settingsProvider);
  final baseUrl = settings.url ?? 'http://10.0.2.15:8080';
  return Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
});
