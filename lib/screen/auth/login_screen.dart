import 'package:ewaste/main.dart';
import 'package:ewaste/screen/auth/register_screen.dart';
import 'package:ewaste/screen/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create controllers for the text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sign in the user
  void signIn(BuildContext context) async {
    await supabase.auth.signInWithPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    // Redirect to the main layout
    if (mounted) context.go('/main-layout');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Masukkan email',
                    labelText: 'Email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required.';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email format.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Masukkan Password',
                    labelText: 'Password',
                  ),
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () => signIn(context),
                  child: const Text("Login"),
                ),
                Row(
                  children: [
                    const Text("Belum punya akun?"),
                    TextButton(
                      onPressed: () {
                        context.go('/register');

                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
