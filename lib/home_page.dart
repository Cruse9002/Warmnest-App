import 'package:flutter/material.dart';
import 'package:warmnest/screens/dashboard_screen.dart';
import 'package:warmnest/screens/breathing_exercises_screen.dart';
import 'package:warmnest/screens/chatbot_screen.dart';
import 'package:warmnest/screens/journal_screen.dart';
import 'package:warmnest/screens/music_therapy_screen.dart';
import 'package:warmnest/screens/focus_mode_screen.dart';
import 'package:warmnest/screens/task_assessment_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
    print('HomePage initialized successfully');
  }
  
  final List<Widget> _screens = [
    const DashboardScreen(),
    const BreathingExercisesScreen(),
    const ChatbotScreen(),
    const JournalScreen(),
    const MusicTherapyScreen(),
    const FocusModeScreen(),
    const TaskAssessmentScreen(),
  ];

  final List<DrawerItem> _drawerItems = [
    DrawerItem(icon: Icons.dashboard, title: 'Dashboard'),
    DrawerItem(icon: Icons.air, title: 'Breathing Exercises'),
    DrawerItem(icon: Icons.chat_bubble_outline, title: 'Chatbot'),
    DrawerItem(icon: Icons.book, title: 'Journal'),
    DrawerItem(icon: Icons.music_note, title: 'Music Therapy'),
    DrawerItem(icon: Icons.timer, title: 'Focus Mode'),
    DrawerItem(icon: Icons.assignment, title: 'Task Assessment'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: Row(
          children: [
            const Icon(Icons.favorite, color: Color(0xFF4A9EFF), size: 28),
            const SizedBox(width: 12),
            Text(
              'WarmNest',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF4A9EFF),
                fontWeight: FontWeight.bold,
              ) ?? const TextStyle(
                color: Color(0xFF4A9EFF),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF4A9EFF),
              child: Text(
                'S',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ) ?? const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: _buildDrawer(),
      body: _screens.isNotEmpty && _selectedIndex < _screens.length 
          ? _screens[_selectedIndex] 
          : const Center(
              child: Text(
                'No content available',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0A192F),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF374151)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF9CA3AF),
                      ) ?? const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _drawerItems.length,
              itemBuilder: (context, index) {
                final item = _drawerItems[index];
                final isSelected = _selectedIndex == index;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: isSelected
                      ? BoxDecoration(
                          color: const Color(0xFF4A9EFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  child: ListTile(
                    leading: Icon(
                      item.icon,
                      color: isSelected ? const Color(0xFF4A9EFF) : Colors.white,
                    ),
                    title: Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected ? const Color(0xFF4A9EFF) : Colors.white,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ) ?? TextStyle(
                        color: isSelected ? const Color(0xFF4A9EFF) : Colors.white,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(color: Color(0xFF374151)),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.white),
                  title: Text(
                    'Profile',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white) ?? const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white) ?? const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white) ?? const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFFF4757),
                  child: Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Singa Adithya',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ) ?? const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'adithya@gmail.com',
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
                const Icon(Icons.arrow_forward_ios, color: Color(0xFF9CA3AF), size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String title;

  DrawerItem({required this.icon, required this.title});
}