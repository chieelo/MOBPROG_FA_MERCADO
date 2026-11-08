import 'package:fa4_reverse_engineering/data/user.dart';
import 'package:fa4_reverse_engineering/screens/home_screen.dart';
import 'package:fa4_reverse_engineering/screens/signup_screen.dart';
import 'package:fa4_reverse_engineering/widgets/app_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/firefly_logo.dart';
import 'package:fa4_reverse_engineering/widgets/message_dialogs.dart';
import 'package:fa4_reverse_engineering/widgets/password_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isLoading) return; 
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); 
    if (!mounted) return;

    final user = UserData.login(
      _usernameController.text.trim(),
      _passwordController.text,
    );

    if (user == null) {
      setState(() => _isLoading = false);
      await showMessageDialog(
        context,
        title: 'Login failed.',
        message: 'Incorrect username or password',
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _goToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final boxHeight = height * 0.44; 

    return Scaffold(
      appBar: AppBar(leading: const ThemeToggleButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 64),
                SizedBox(
                  height: boxHeight,
                  child: Align(
                    alignment: Alignment.center,
                    child: FireflyLogo(height: boxHeight * 2),
                  ),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: 'Username',
                  controller: _usernameController,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Kindly enter your username'
                      : null,
                ),
                const SizedBox(height: 10),
                PasswordField(
                  controller: _passwordController,
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Kindly enter your password'
                      : null,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Login'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _goToSignup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  
                  ),
                  child: const Text('Does not have an account yet? Sign Up now!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}