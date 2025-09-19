import 'package:flutter/material.dart';
import 'package:warmnest/app_state.dart';
import 'package:warmnest/i18n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String _language = 'en';
  bool _darkMode = true;

  @override
  void initState() {
    super.initState();
    final app = AppStateProvider.of(context);
    final user = app.user!;
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _language = user.language;
    _darkMode = user.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    final app = AppStateProvider.of(context);
    final user = app.user!;
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: Text(I18n.t(context, 'profile.title'), style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Name', _nameController),
            const SizedBox(height: 12),
            _buildTextField('Email', _emailController, enabled: false),
            const SizedBox(height: 12),
            const Text('Language', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF374151)),
              ),
              child: DropdownButton<String>(
                value: _language,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E293B),
                underline: const SizedBox.shrink(),
                iconEnabledColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ta', child: Text('Tamil')),
                ],
                onChanged: (v) => setState(() => _language = v ?? 'en'),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                  child: Text('Dark Mode', style: TextStyle(color: Colors.white)),
                ),
                Switch(
                  value: _darkMode,
                  onChanged: (v) => setState(() => _darkMode = v),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final updated = user.copyWith(
                        name: _nameController.text.trim(),
                        language: _language,
                        darkMode: _darkMode,
                      );
                      await app.updateProfile(updated);
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated')),
                      );
                    },
                    child: Text(I18n.t(context, 'profile.save')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await app.logout();
                      if (!mounted) return;
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                    },
                    child: Text(I18n.t(context, 'profile.signOut')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF374151)),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}


