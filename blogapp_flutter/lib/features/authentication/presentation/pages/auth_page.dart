import 'package:blogapp_flutter/core/dependency_injection/dependency_injection.dart';
import 'package:blogapp_flutter/features/authentication/data/models/auth_response.dart';
import 'package:blogapp_flutter/features/authentication/domain/usecases/login.dart';
import 'package:blogapp_flutter/features/authentication/domain/usecases/sign_up.dart';
import 'package:blogapp_flutter/features/authentication/presentation/state/providers/auth_create_provider.dart';
import 'package:blogapp_flutter/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String email = "";
  String password = "";
  String error = "";
  bool signUpLoading = false;
  bool loginLoading = false;
  bool get loading => signUpLoading || loginLoading;

  void updateError(String value) {
    setState(() {
      error = value;
    });
  }

  void handleEmailChange(String value) {
    setState(() {
      email = value;
    });
  }

  void handlePasswordChange(String value) {
    setState(() {
      password = value;
    });
  }

  Future<void> handleLogin(void Function(AuthResponse) authUpdater) async {
    final Login login = services();
    LoadingScreen.show(context);
    final result = await login(LoginParams(email, password));
    LoadingScreen.hide();
    result.fold(
      (failure) {
        handlePasswordChange('');
        updateError(failure.message);
      },
      (successResponse) {
        authUpdater(successResponse);
      },
    );
  }

  Future<void> handleSignUp(void Function(AuthResponse) authUpdater) async {
    final SignUp signUp = services();
    LoadingScreen.show(context);
    final result = await signUp(SignUpParams(email, password));
    LoadingScreen.hide();
    result.fold(
      (failure) {
        handlePasswordChange('');
        updateError(failure.message);
      },
      (successResponse) {
        authUpdater(successResponse);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please sign in to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  enabled: !loading,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChanged: handleEmailChange,
                ),
                const SizedBox(height: 20),
                TextField(
                  enabled: !loading,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  obscureText: true,
                  onChanged: handlePasswordChange,
                ),
                const SizedBox(height: 20),
                Text(
                  error.isNotEmpty ? error : 'None',
                  style: TextStyle(
                    fontSize: 16,
                    color: error.isNotEmpty ? Colors.red : Colors.transparent,
                  ),
                ),
                const SizedBox(height: 10),
                Consumer(builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: !loading
                        ? () => handleLogin(ref.read(authCreateProvider))
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),
                Consumer(builder: (context, ref, child) {
                  return TextButton(
                    onPressed: !loading
                        ? () => handleSignUp(ref.read(authCreateProvider))
                        : null,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
