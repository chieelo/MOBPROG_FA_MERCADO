import 'package:fa4_reverse_engineering/data/user.dart';
import 'package:fa4_reverse_engineering/screens/login_screen.dart';
import 'package:fa4_reverse_engineering/screens/parameter_screen.dart';
import 'package:fa4_reverse_engineering/screens/supplies_screen.dart';
import 'package:fa4_reverse_engineering/widgets/firefly_logo.dart';
import 'package:fa4_reverse_engineering/widgets/message_dialogs.dart';
import 'package:fa4_reverse_engineering/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Logout confirmation',
      message: 'Are you sure you want to logout?',
    );
    if (!confirmed || !context.mounted) return;

    UserData.logout();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = UserData.activeUser;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: const ThemeToggleButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ParameterSettingsScreen(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello\n${user?.firstName ?? ''} ${user?.lastName ?? ''}\n'
                  'You are now one of the Fireflies',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                FireflyLogo(height: height * 0.25),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 36), 
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SuppliesScreen(),
                    ),
                  ),
                  child: const Text('Check for Supplies'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}