class ServerConfig {
  final String address;
  final int port;

  ServerConfig({required this.address, required this.port});

  String toUrl() => 'http://$address:$port';

  Map<String, dynamic> toJson() => {'address': address, 'port': port};

  factory ServerConfig.fromJson(Map<String, dynamic> json) {
    return ServerConfig(
      address: json['address'] as String,
      port: json['port'] as int,
    );
  }
}
