import 'package:blogapp_flutter/core/errors/exceptions.dart';
import 'package:blogapp_flutter/features/authentication/typedefs/user_role.dart';

class User {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;
  final UserRole? role;

  const User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.role,
  });

  String? get fullName =>
      firstName == null || lastName == null ? null : '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'] as String?,
        email: json['email'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json['birthDate'] as String)
            : null,
        role: json['role'] != null
            ? UserRole.values
                .firstWhere((e) => e.toString().split('.').last == json['role'])
            : null,
      );
    } catch (e) {
      throw DataFormatException('Unable to parse User from JSON');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate?.toIso8601String(),
      'role': role?.toString(),
    };
  }
}
