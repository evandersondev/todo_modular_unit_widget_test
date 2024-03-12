import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_tests/app/features/auth/controllers/login_controller.dart';
import 'package:flutter_tests/app/features/auth/dtos/login_dto.dart';
import 'package:flutter_tests/app/features/auth/states/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Modular.get<LoginController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscurePassword = true;
  bool isSubmitting = false;
  String messageError = '';

  void changeObscurePasswordInput() {
    setState(() {
      isObscurePassword = !isObscurePassword;
    });
  }

  Future<void> handleSubmitLogin() async {
    await loginController.login(
      LoginDto(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  Widget showMessageError() {
    return Text(
      messageError,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder(
          valueListenable: loginController,
          builder: (context, value, child) {
            if (value is LoadingLoginState) {
              isSubmitting = true;
              messageError = '';
            }

            if (value is ErrorLoginState) {
              isSubmitting = false;
              messageError = value.message;
            }

            if (value is SuccessLoginState) {
              isSubmitting = false;
              messageError = '';
              Modular.to.pushReplacementNamed('/todos/');
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Icon(
                    Icons.person,
                    size: 86,
                    color: Colors.blue.shade600,
                  ),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  key: const Key('email-input-login'),
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('password-input-login'),
                  controller: passwordController,
                  obscureText: isObscurePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Password',
                    suffix: InkWell(
                      onTap: changeObscurePasswordInput,
                      child: Icon(
                        isObscurePassword
                            ? Icons.lock_rounded
                            : Icons.lock_open_rounded,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  key: const Key('button-login'),
                  color: isSubmitting
                      ? Colors.purple.shade800.withOpacity(0.5)
                      : Colors.purple.shade800,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: isSubmitting ? null : handleSubmitLogin,
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Center(
                        child: isSubmitting
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (messageError.isNotEmpty) showMessageError(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Modular.to.navigate('/register');
                      },
                      child: Text(
                        "Register here",
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
