import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicTherapyScreen extends StatefulWidget {
  const MusicTherapyScreen({super.key});

  @override
  State<MusicTherapyScreen> createState() => _MusicTherapyScreenState();
}

class _MusicTherapyScreenState extends State<MusicTherapyScreen> {
  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text(
          'Music Therapy',
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
              'Therapeutic Sounds & Music',
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
              'Immerse yourself in calming sounds designed to reduce stress and promote relaxation.',
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
              final columns = width >= 1200 ? 3 : width >= 800 ? 2 : 1;
              final aspect = width >= 1200 ? 1.1 : width >= 800 ? 0.9 : 0.8;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                childAspectRatio: aspect,
                children: [
                _buildSoundCard(
                  context,
                  'River Flow',
                  'Gentle river ambience ideal for relaxation',
                  '6:20',
                ),
                _buildSoundCard(
                  context,
                  'Sleep',
                  'Soothing piano piece to ease into sleep',
                  '10:00',
                ),
                _buildSoundCard(
                  context,
                  'Ocean Waves',
                  'A deep soundscape that guides external distractions for profound introspection',
                  '1:45',
                ),
              ],
              );
            }),
            const SizedBox(height: 24),
            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width >= 900 ? 3 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.4,
                children: [
                  _buildMiniSoundCard(
                    context,
                    'Rain Sounds',
                    'Peaceful rainfall',
                    '15:30',
                  ),
                  _buildMiniSoundCard(
                    context,
                    'Forest Birds',
                    'Morning birdsong',
                    '12:15',
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

  Widget _buildSoundCard(
    BuildContext context,
    String title,
    String description,
    String duration,
  ) {
    return GestureDetector(
      onTap: () => _playSound(context, title),
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
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF4A9EFF).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.music_note,
                color: Color(0xFF4A9EFF),
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
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
              maxLines: 2,
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
                    'Play Sound',
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

  Widget _buildMiniSoundCard(
    BuildContext context,
    String title,
    String description,
    String duration,
  ) {
    return GestureDetector(
      onTap: () => _playSound(context, title),
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
            Row(
              children: [
                const Icon(Icons.music_note, color: Color(0xFF4A9EFF)),
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
            const SizedBox(height: 8),
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
      ),
    );
  }

  void _playSound(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: Text(
            'Play $title',
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Would you like to play this sound?',
                style: TextStyle(color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Find a comfortable position and enjoy the therapeutic sounds.',
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
              onPressed: () async {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Now playing: $title'),
                    backgroundColor: const Color(0xFF4A9EFF),
                  ),
                );
                // In absence of bundled assets, play a short remote sample tone
                await _player.stop();
                await _player.play(UrlSource('https://www2.cs.uic.edu/~i101/SoundFiles/StarWars60.wav'));
              },
              child: const Text('Play'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}