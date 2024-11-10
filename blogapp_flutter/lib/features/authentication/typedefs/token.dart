class Token {
  final String value;
  final int expires;

  const Token({
    required this.value,
    required this.expires,
  });

  Token copyWith({
    String? value,
    int? expires,
  }) {
    return Token(
      value: value ?? this.value,
      expires: expires ?? this.expires,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'expires': expires,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      value: map['value'] as String,
      expires: map['expires'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Token && other.value == value && other.expires == expires;
  }

  @override
  int get hashCode => value.hashCode ^ expires.hashCode;

  @override
  String toString() => 'Token(value: $value, expires: $expires)';
}