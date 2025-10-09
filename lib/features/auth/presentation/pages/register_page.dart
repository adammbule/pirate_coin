import 'package:flutter/material.dart';
import 'package:Piratecoin/widgets/theme_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isLoading = false;

  void _register() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2)); // simulate network delay

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful!')),
    );

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const PirateTitle("Join PirateCoin"),
                const SizedBox(height: 48),
                PirateTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter your email';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                PirateTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter password';
                    if (v.length < 6) return 'At least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                PirateTextField(
                  controller: _confirmController,
                  hintText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (v) {
                    if (v != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                PirateButton(
                  text: 'Register',
                  isLoading: _isLoading,
                  onPressed: _register,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
