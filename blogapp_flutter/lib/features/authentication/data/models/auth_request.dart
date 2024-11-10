class AuthRequest {
  final String username;
  final String password;

  const AuthRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  factory AuthRequest.fromJson(Map<String, dynamic> json) => AuthRequest(
        username: json['username'] as String,
        password: json['password'] as String,
      );
}