class ServerConfig {
  final String address;
  final int port;
  final String username;
  final String password;

  ServerConfig({
    required this.address, 
    required this.port,
    this.username = 'admin',
    this.password = 'admin',
  });

  String toUrl() => 'http://$address:$port';

  Map<String, dynamic> toJson() => {
    'address': address, 
    'port': port,
    'username': username,
    'password': password,
  };

  factory ServerConfig.fromJson(Map<String, dynamic> json) {
    return ServerConfig(
      address: json['address'] as String,
      port: json['port'] as int,
      username: json['username'] as String? ?? 'admin',
      password: json['password'] as String? ?? 'admin',
    );
  }
}
