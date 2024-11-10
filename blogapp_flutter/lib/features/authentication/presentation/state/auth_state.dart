import 'package:blogapp_flutter/features/authentication/typedefs/token.dart';
import 'package:blogapp_flutter/features/authentication/typedefs/user.dart';
import 'package:blogapp_flutter/features/authentication/typedefs/user_role.dart';
import 'package:equatable/equatable.dart';
class AuthState extends Equatable {
  final User? user;
  final Token? token;

  const AuthState({
    this.user,
    this.token,
  });

  factory AuthState.initial() {
    return const AuthState(
      user: null,
      token: null,
    );
  }

  bool get signedIn =>
      user?.id != null && token != null && DateTime.now().millisecondsSinceEpoch < token!.expires;

  String get email => user?.email ?? '';

  String get fullName => '${user?.firstName} ${user?.lastName}';
  UserRole? get role => user?.role;
  bool get isStudent => role == UserRole.student;
  bool get isParent => role == UserRole.parent;
  bool get isInstitution => role == UserRole.institution;
  bool get isAdmin => role == UserRole.admin;


  AuthState copyWith({
    User? user,
    Token? token,
  }) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [user, token];
}
