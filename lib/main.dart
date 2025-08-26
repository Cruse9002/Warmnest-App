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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Add error handling for crashes
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };
  
  // Add zone error handling
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    print('Caught error in zone: $error');
    print('Stack trace: $stack');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WarmNest',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: Builder(
        builder: (context) {
          try {
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
      },
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
