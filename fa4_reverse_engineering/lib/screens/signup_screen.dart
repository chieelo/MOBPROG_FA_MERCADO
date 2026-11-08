import 'package:fa4_reverse_engineering/data/user.dart';
import 'package:fa4_reverse_engineering/models/users.dart';
import 'package:fa4_reverse_engineering/widgets/app_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/firefly_logo.dart';
import 'package:fa4_reverse_engineering/widgets/password_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String message) {
    return (value == null || value.trim().isEmpty) ? message : null;
  }

  Future<void> _signup() async {
    if (_isLoading) return; 
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); 
    if (!mounted) return;

    UserData.register(
      FireflyUser(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      ),
    );

    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
                FireflyLogo(height: height * 0.3),
                const SizedBox(height: 8),
                Text(
                  'Become a Firefly',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Username',
                  controller: _usernameController,
                  maxLength: 50,
                  validator: (v) {
                    final empty =
                        _requiredValidator(v, 'Kindly enter your username');
                    if (empty != null) return empty;
                    if (UserData.userExists(v!.trim())) {
                      return 'Username already taken';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                PasswordField(
                  controller: _passwordController,
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Kindly enter your password'
                      : null,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'First Name',
                  controller: _firstNameController,
                  maxLength: 50,
                  validator: (v) =>
                      _requiredValidator(v, 'Kindly enter your first name'),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: 'Last Name',
                  controller: _lastNameController,
                  maxLength: 50,
                  validator: (v) =>
                      _requiredValidator(v, 'Kindly enter your last name'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signup,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Signup'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                   
                  ),
                  child: const Text('Cancel'),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}