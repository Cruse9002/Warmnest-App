import 'dart:async';
import 'package:flutter/material.dart';
import 'package:warmnest/theme.dart';
import 'package:warmnest/home_page.dart';
import 'package:warmnest/screens/breathing_exercises_screen.dart';
import 'package:warmnest/screens/chatbot_screen.dart';
import 'package:warmnest/screens/journal_screen.dart';
import 'package:warmnest/screens/music_therapy_screen.dart';
import 'package:warmnest/screens/focus_mode_screen.dart';
import 'package:warmnest/screens/task_assessment_screen.dart';
import 'package:warmnest/app_state.dart';
import 'package:warmnest/storage_service.dart';
import 'package:warmnest/screens/login_screen.dart';
import 'package:warmnest/screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Add error handling for crashes
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };
  
  // Add zone error handling
  runZonedGuarded(() {
    runApp(const Root());
  }, (error, stack) {
    print('Caught error in zone: $error');
    print('Stack trace: $stack');
  });
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late final AppState _state;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _state = AppState(StorageService());
    _state.load().then((_) {
      if (mounted) setState(() => _loaded = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = _state.darkMode ? ThemeMode.dark : ThemeMode.light;

    final app = MaterialApp(
      title: 'WarmNest',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: Builder(
        builder: (context) {
          try {
            if (!_loaded) {
              return const Scaffold(
                backgroundColor: Color(0xFF0A192F),
                body: Center(child: CircularProgressIndicator(color: Color(0xFF4A9EFF))),
              );
            }
            final user = _state.user;
            if (user == null) {
              return const LoginScreen();
            }
            if (!user.onboarded) {
              return const OnboardingScreen();
            }
            return const HomePage();
          } catch (e) {
            print('Error loading HomePage: $e');
            return Scaffold(
              backgroundColor: const Color(0xFF0A192F),
              appBar: AppBar(
                backgroundColor: const Color(0xFF0A192F),
                title: const Text(
                  'WarmNest',
                  style: TextStyle(
                    color: Color(0xFF4A9EFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Color(0xFFFF4757),
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Error: $e',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Try to reload the app
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      routes: {
        '/breathing': (context) => const BreathingExercisesScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/journal': (context) => const JournalScreen(),
        '/music': (context) => const MusicTherapyScreen(),
        '/focus': (context) => const FocusModeScreen(),
        '/assessment': (context) => const TaskAssessmentScreen(),
        '/login': (context) => const LoginScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
      builder: (context, child) {
        return child!;
      },
    );
    return AppStateProvider(notifier: _state, child: app);
  }
}
