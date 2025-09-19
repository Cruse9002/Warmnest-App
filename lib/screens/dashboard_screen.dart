import 'package:flutter/material.dart';
import 'package:warmnest/app_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Singa Adithya!',
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
              'How are you feeling today?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF9CA3AF),
              ) ?? const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF374151)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.format_quote, color: Color(0xFF4A9EFF)),
                  const SizedBox(width: 12),
                  Text(
                    '"Dream it. Wish it. Do it."',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF4A9EFF),
                      fontStyle: FontStyle.italic,
                    ) ?? const TextStyle(
                      color: Color(0xFF4A9EFF),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Builder(builder: (context) {
              final app = AppStateProvider.of(context);
              final recentMood = app.moodLogs.isNotEmpty ? app.moodLogs.last.mood : '—';
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A9EFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.mood, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      'Recent Mood: $recentMood',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ) ?? const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildProgressCard(
                    context,
                    'Weekly Progress',
                    _weeklyProgress(context),
                    Icons.trending_up,
                    const Color(0xFF059669),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                    context,
                    'Mood Average',
                    _moodAverage(context),
                    Icons.mood,
                    const Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ) ?? const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width >= 1200 ? 4 : width >= 900 ? 3 : width >= 600 ? 2 : 1;
              final aspect = width >= 900 ? 1.2 : 1.0;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: aspect,
                children: [
                  _buildQuickActionCard(
                    context,
                    'Start a Breathing Exercise',
                    'Start Exercise',
                    Icons.air,
                    const Color(0xFF059669),
                  ),
                  _buildQuickActionCard(
                    context,
                    'Chat with Wellness Bot',
                    'Chat with Wellness Bot',
                    Icons.chat_bubble_outline,
                    const Color(0xFF3B82F6),
                  ),
                  _buildQuickActionCard(
                    context,
                    'Log Your Mood',
                    'Log Your Mood',
                    Icons.edit,
                    const Color(0xFFF59E0B),
                  ),
                  _buildQuickActionCard(
                    context,
                    'Write in Your Journal',
                    'Write in Your Journal',
                    Icons.book,
                    const Color(0xFF8B5CF6),
                  ),
                ],
              );
            }),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    context,
                    'Last Logged Mood',
                    'Your recent emotional state.',
                    'You felt Calm 5 hours ago.',
                    Icons.trending_up,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    context,
                    'Recent Journal Entry',
                    'Your latest thoughts and reflections.',
                    '"Thoughts on today" written 1 day ago.',
                    Icons.calendar_today,
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate based on the action
        if (title.contains('Breathing')) {
          Navigator.pushNamed(context, '/breathing');
        } else if (title.contains('Chat')) {
          Navigator.pushNamed(context, '/chatbot');
        } else if (title.contains('Mood')) {
          _showMoodDialog(context);
        } else if (title.contains('Journal')) {
          Navigator.pushNamed(context, '/journal');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ) ?? const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ) ?? TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String description,
    String info,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4A9EFF), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ) ?? const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
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
          const SizedBox(height: 12),
          Text(
            info,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF4A9EFF),
              fontWeight: FontWeight.w600,
            ) ?? const TextStyle(
              color: Color(0xFF4A9EFF),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ) ?? const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ) ?? TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _weeklyProgress(BuildContext context) {
    final app = AppStateProvider.of(context);
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final count = app.breathingSessions.where((s) => s.timestamp.isAfter(startOfWeek)).length +
        app.pomodoroSessions.where((s) => s.startTime.isAfter(startOfWeek)).length +
        app.moodLogs.where((s) => s.timestamp.isAfter(startOfWeek)).length +
        app.journalEntries.where((s) => s.timestamp.isAfter(startOfWeek)).length;
    return '$count actions';
  }

  String _moodAverage(BuildContext context) {
    final app = AppStateProvider.of(context);
    if (app.moodLogs.isEmpty) return '—';
    final avg = app.moodLogs.map((e) => e.intensity).fold<int>(0, (a, b) => a + b) / app.moodLogs.length;
    return '${avg.toStringAsFixed(1)}/10';
  }

  void _showMoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            'Log Your Mood',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'How are you feeling right now?',
                style: TextStyle(color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMoodButton(context, '😊', 'Happy'),
                  _buildMoodButton(context, '😌', 'Calm'),
                  _buildMoodButton(context, '😔', 'Sad'),
                  _buildMoodButton(context, '😤', 'Stressed'),
                ],
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mood logged successfully!'),
                    backgroundColor: Color(0xFF059669),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMoodButton(BuildContext context, String emoji, String label) {
    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}