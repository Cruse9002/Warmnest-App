import 'package:flutter/material.dart';
import 'package:warmnest/app_state.dart';
import 'package:warmnest/models.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedMood = '';
  final TextEditingController _noteController = TextEditingController();

  final List<MoodOption> _moods = [
    MoodOption(emoji: '😊', label: 'Happy'),
    MoodOption(emoji: '😌', label: 'Calm'),
    MoodOption(emoji: '😐', label: 'Neutral'),
    MoodOption(emoji: '😰', label: 'Anxious'),
    MoodOption(emoji: '😢', label: 'Sad'),
  ];

  // Deprecated local cache; entries now read from AppState

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text(
          'Journal & Mood',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
        children: [
          Container(
            color: const Color(0xFF1E293B),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF4A9EFF),
              labelColor: const Color(0xFF4A9EFF),
              unselectedLabelColor: const Color(0xFF9CA3AF),
              tabs: const [
                Tab(text: 'Mood Log'),
                Tab(text: 'Journal Entries'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMoodLogTab(),
                _buildJournalEntriesTab(),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildMoodLogTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'How are you feeling today?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: const Color(0xFF4A9EFF),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _moods.map((mood) => _buildMoodButton(mood)).toList(),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF374151)),
            ),
            child: TextField(
              controller: _noteController,
              maxLines: 5,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Add a note (optional)',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF9CA3AF),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () async {
              final app = AppStateProvider.of(context);
              final selected = _selectedMood.isEmpty ? 'neutral' : _selectedMood.toLowerCase();
              await app.addMood(
                MoodLog(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  mood: selected,
                  intensity: 5,
                  timestamp: DateTime.now(),
                  note: _noteController.text.trim(),
                ),
              );
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mood saved')),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF4A9EFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Save Mood',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
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
                  'Recent Moods',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF4A9EFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildRecentMoodItem('😊', 'Happy', 'Jul 29, 2025, 11:14:31 AM', 'Note: xyz'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJournalEntriesTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await _openNewEntryDialog();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF4A9EFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Add New Entry',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Builder(
              builder: (context) {
                final app = AppStateProvider.of(context);
                final entries = app.journalEntries;
                return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final e = entries[entries.length - 1 - index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                        e.content,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        e.timestamp.toLocal().toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openNewEntryDialog() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text('New Journal Entry', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            maxLines: 6,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Write your thoughts... ',
              hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
              border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF374151))),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF9CA3AF))),
            ),
            ElevatedButton(
              onPressed: () async {
                final content = controller.text.trim();
                if (content.isNotEmpty) {
                  final app = AppStateProvider.of(context);
                  await app.addJournal(
                    JournalEntryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      content: content,
                      timestamp: DateTime.now(),
                    ),
                  );
                }
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMoodButton(MoodOption mood) {
    final isSelected = _selectedMood == mood.label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = mood.label;
        });
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A9EFF).withValues(alpha: 0.2) : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A9EFF) : const Color(0xFF374151),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mood.emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              mood.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected ? const Color(0xFF4A9EFF) : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentMoodItem(String emoji, String mood, String date, String note) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mood,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF4A9EFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                if (note.isNotEmpty)
                  Text(
                    note,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}

class MoodOption {
  final String emoji;
  final String label;

  MoodOption({required this.emoji, required this.label});
}

class JournalEntry {
  final String mood;
  final String moodLabel;
  final String note;
  final String date;

  JournalEntry({
    required this.mood,
    required this.moodLabel,
    required this.note,
    required this.date,
  });
}