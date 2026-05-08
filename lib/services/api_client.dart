import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@riverpod
Dio apiClient(ApiClientRef ref) {
  // ACHTUNG: Ersetze 'localhost' durch deine lokale IP-Adresse (z.B. 192.168.178.XX),
  // damit mobile Geräte im WLAN den Server finden können.
  return Dio(BaseOptions(
    baseUrl: 'http://10.0.2.15:8080', 
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
}
