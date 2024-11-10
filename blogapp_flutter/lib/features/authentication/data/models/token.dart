import 'package:blogapp_flutter/core/errors/exceptions.dart';

class Token {
  final String id;
  final String value;
  final int expires;

  const Token({
    required this.id,
    required this.value,
    required this.expires,
  });
  Token copyWith({
    String? id,
    String? value,
    int? expires,
  }) {
    return Token(
      id: id ?? this.id,
      value: value ?? this.value,
      expires: expires ?? this.expires,
    );
  }

  factory Token.fromJson(Map<String, dynamic> json) {
    try {
      return Token(
        id: json['id'] as String,
        value: json['value'] as String,
        expires: json['expires'] as int,
      );
    } catch (exception) {
      throw DataFormatException("Unable to parse Token from JSON");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'expires': expires,
    };
  }

  @override
  String toString() {
    return 'Token(id: $id, value: $value, expires: $expires)';
  }
}
