import 'package:flutter/material.dart';
import 'package:warmnest/app_state.dart';
import 'package:warmnest/i18n.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? _gender;
  String? _favoriteColor;
  String? _stressSource;
  String? _copingMechanism;

  @override
  Widget build(BuildContext context) {
    final app = AppStateProvider.of(context);
    final user = app.user!;
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: Text(I18n.t(context, 'onboarding.title'), style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              I18n.t(context, 'onboarding.tellUs'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ) ?? const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Gender',
              value: _gender,
              items: const ['male', 'female', 'other', 'preferNotToSay'],
              onChanged: (v) => setState(() => _gender = v),
            ),
            const SizedBox(height: 12),
            _buildDropdown(
              label: 'Favorite Color',
              value: _favoriteColor,
              items: const ['red', 'blue', 'green', 'yellow', 'purple', 'pink', 'orange', 'black', 'white', 'other_color'],
              onChanged: (v) => setState(() => _favoriteColor = v),
            ),
            const SizedBox(height: 12),
            _buildTextInput('Primary Stress Source', (v) => _stressSource = v),
            const SizedBox(height: 12),
            _buildTextInput('Coping Mechanism', (v) => _copingMechanism = v),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final updated = user.copyWith(
                        gender: _gender,
                        favoriteColor: _favoriteColor,
                        stressSource: _stressSource,
                        copingMechanism: _copingMechanism,
                        onboarded: true,
                        hasCompletedQuestionnaire: true,
                      );
                      await app.updateProfile(updated);
                      if (!mounted) return;
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: const Text('Finish'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
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
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFF1E293B),
            underline: const SizedBox.shrink(),
            iconEnabledColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildTextInput(String label, ValueChanged<String> onChanged) {
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
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}


