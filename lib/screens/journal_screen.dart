import 'package:flutter/material.dart';

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

  final List<JournalEntry> _recentEntries = [
    JournalEntry(
      mood: '😊',
      moodLabel: 'Happy',
      note: 'xyz',
      date: 'Jul 29, 2025, 11:14:31 AM',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Column(
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
          Container(
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
          Container(
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
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _recentEntries.length,
              itemBuilder: (context, index) {
                final entry = _recentEntries[index];
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
                      Row(
                        children: [
                          Text(
                            entry.mood,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            entry.moodLabel,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            entry.date,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                      if (entry.note.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Note: ${entry.note}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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