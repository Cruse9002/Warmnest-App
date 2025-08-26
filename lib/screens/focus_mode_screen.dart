import 'package:flutter/material.dart';
import 'dart:async';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen>
    with SingleTickerProviderStateMixin {
  int _minutes = 25;
  int _seconds = 0;
  int _totalMinutes = 25;
  bool _isRunning = false;
  Timer? _timer;
  String _selectedTechnique = 'Pomodoro Technique';

  final List<FocusTechnique> _techniques = [
    FocusTechnique('Pomodoro Technique', 'Work in focused bursts with short breaks in between.', 25),
    FocusTechnique('2 Minute Rule', 'Quick tasks in 2-minute intervals.', 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Focus Mode',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Boost your productivity with proven focusing techniques.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedTechnique == 'Pomodoro Technique'
                          ? const Color(0xFF1E293B)
                          : const Color(0xFF374151),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedTechnique == 'Pomodoro Technique'
                            ? const Color(0xFF4A9EFF)
                            : const Color(0xFF374151),
                      ),
                    ),
                    child: Text(
                      'Pomodoro Technique',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: _selectedTechnique == 'Pomodoro Technique'
                            ? const Color(0xFF4A9EFF)
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTechnique = '2 Minute Rule';
                        _minutes = 2;
                        _seconds = 0;
                        _totalMinutes = 2;
                        _isRunning = false;
                        _timer?.cancel();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedTechnique == '2 Minute Rule'
                            ? const Color(0xFF1E293B)
                            : const Color(0xFF374151),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedTechnique == '2 Minute Rule'
                              ? const Color(0xFF4A9EFF)
                              : const Color(0xFF374151),
                        ),
                      ),
                      child: Text(
                        '2 Minute Rule',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: _selectedTechnique == '2 Minute Rule'
                              ? const Color(0xFF4A9EFF)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF374151)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.coffee, color: Color(0xFF4A9EFF)),
                      const SizedBox(width: 8),
                      Text(
                        _selectedTechnique,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF4A9EFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _techniques.firstWhere((t) => t.name == _selectedTechnique).description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF9CA3AF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 64,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF374151),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: LinearProgressIndicator(
                      value: (_totalMinutes * 60 - (_minutes * 60 + _seconds)) / (_totalMinutes * 60),
                      backgroundColor: const Color(0xFF374151),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A9EFF)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Pomodoros this cycle: 0 / 4',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A9EFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: _toggleTimer,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _isRunning ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _isRunning ? 'Pause' : 'Start',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF374151),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: _resetTimer,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.refresh, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Reset',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });

    if (_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            _isRunning = false;
            timer.cancel();
          }
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _minutes = _totalMinutes;
      _seconds = 0;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class FocusTechnique {
  final String name;
  final String description;
  final int minutes;

  FocusTechnique(this.name, this.description, this.minutes);
}