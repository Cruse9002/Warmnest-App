import 'package:flutter/material.dart';
import 'package:warmnest/app_state.dart';
import 'package:warmnest/i18n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final app = AppStateProvider.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.favorite, color: Color(0xFF4A9EFF), size: 56),
                const SizedBox(height: 12),
                Text(
                  I18n.t(context, 'app.title'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: const Color(0xFF4A9EFF),
                        fontWeight: FontWeight.bold,
                      ) ?? const TextStyle(color: Color(0xFF4A9EFF), fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  context,
                  controller: _emailController,
                  hint: I18n.t(context, 'login.email'),
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  context,
                  controller: _nameController,
                  hint: I18n.t(context, 'login.name'),
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() => _loading = true);
                          try {
                            await app.login(
                              email: _emailController.text.trim(),
                              name: _nameController.text.trim(),
                            );
                            if (!mounted) return;
                            Navigator.of(context).pushReplacementNamed('/onboarding');
                          } finally {
                            if (mounted) setState(() => _loading = false);
                          }
                        },
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(I18n.t(context, 'login.continue')),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () async {
                    await app.setDarkMode(!app.darkMode);
                  },
                  child: Text(
                    app.darkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                    style: const TextStyle(color: Color(0xFF9CA3AF)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF9CA3AF)),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}


