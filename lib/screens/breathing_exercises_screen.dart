import 'package:flutter/material.dart';
import 'package:warmnest/app_state.dart';
import 'package:warmnest/models.dart';

class BreathingExercisesScreen extends StatelessWidget {
  const BreathingExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text(
          'Breathing Exercises',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guided Breathing Exercises',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ) ?? const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find calm and focus with these simple breathing techniques.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF9CA3AF),
              ) ?? const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width >= 900 ? 2 : 1;
              final aspect = width >= 900 ? 2.2 : 1.6;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: aspect,
                children: [
                _buildBreathingCard(
                  context,
                  'Box Breathing',
                  'A simple technique to calm your nerves by inhaling, holding, exhaling, and holding for equal durations.',
                  '5 min',
                ),
                _buildBreathingCard(
                  context,
                  '4-7-8 Breathing',
                  'A relaxing breath technique: inhale for 4, hold for 7, exhale for 8. Helps with sleep and anxiety.',
                  '3 min',
                ),
                _buildBreathingCard(
                  context,
                  'Diaphragmatic Breathing',
                  'Focus on deep belly breaths to fully engage the diaphragm, promoting relaxation and efficient breathing.',
                  '7 min',
                ),
              ],
              );
            }),
            const SizedBox(height: 24),
            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width >= 900 ? 3 : 2;
              final aspect = width >= 900 ? 2.0 : 1.4;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: aspect,
                children: [
                _buildTechniqueCard(
                  context,
                  'Mindful Breathing',
                  'Simple awareness of breath',
                  '4 min',
                ),
                _buildTechniqueCard(
                  context,
                  'Ocean Breathing',
                  'Breathe like ocean waves',
                  '6 min',
                ),
              ],
              );
            }),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildBreathingCard(
    BuildContext context,
    String title,
    String description,
    String duration,
  ) {
    return GestureDetector(
      onTap: () => _startBreathingExercise(context, title),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF374151)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF4A9EFF),
                fontWeight: FontWeight.bold,
              ) ?? const TextStyle(
                color: Color(0xFF4A9EFF),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF9CA3AF),
                height: 1.4,
              ) ?? const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.schedule, color: Color(0xFF9CA3AF), size: 16),
                const SizedBox(width: 4),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF9CA3AF),
                  ) ?? const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF4A9EFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Start Exercise',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechniqueCard(
    BuildContext context,
    String title,
    String description,
    String duration,
  ) {
    return GestureDetector(
      onTap: () => _startBreathingExercise(context, title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF374151)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ) ?? const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF9CA3AF),
              ) ?? const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.schedule, color: Color(0xFF9CA3AF), size: 14),
                const SizedBox(width: 4),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF9CA3AF),
                  ) ?? const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startBreathingExercise(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: Text(
            'Start $title',
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you ready to begin your breathing exercise?',
                style: TextStyle(color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Find a comfortable position and focus on your breath.',
                style: TextStyle(color: Color(0xFF9CA3AF)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF9CA3AF)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showBreathingTimer(context, title);
              },
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }

  void _showBreathingTimer(BuildContext context, String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Breathe in...',
                style: TextStyle(
                  color: Color(0xFF4A9EFF),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Focus on your breath and relax.',
                style: TextStyle(color: Color(0xFF9CA3AF)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final app = AppStateProvider.of(context);
                await app.addBreathingSession(
                  BreathingSession(
                    exerciseId: title,
                    durationMinutes: 5,
                    timestamp: DateTime.now(),
                  ),
                );
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Finish'),
            ),
          ],
        );
      },
    );
  }
}