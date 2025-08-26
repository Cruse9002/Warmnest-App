import 'package:flutter/material.dart';

class TaskAssessmentScreen extends StatefulWidget {
  const TaskAssessmentScreen({super.key});

  @override
  State<TaskAssessmentScreen> createState() => _TaskAssessmentScreenState();
}

class _TaskAssessmentScreenState extends State<TaskAssessmentScreen> {
  final List<AssessmentQuestion> _questions = [
    AssessmentQuestion(
      'How mentally challenging was the task?',
      'Not challenging',
      'Very challenging',
      50.0,
    ),
    AssessmentQuestion(
      'How physically demanding was the task?',
      'Not demanding',
      'Very demanding',
      50.0,
    ),
    AssessmentQuestion(
      'How rushed or time-pressured did you feel?',
      'Not rushed',
      'Very rushed',
      50.0,
    ),
    AssessmentQuestion(
      'How successful do you think you were?',
      'Not successful',
      'Very successful',
      50.0,
    ),
    AssessmentQuestion(
      'How hard did you have to work to accomplish the task?',
      'Very little effort',
      'Very hard work',
      50.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F),
        title: const Text(
          'Task Assessment',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Assessment',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF4A9EFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rate your experience with the task you just completed.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 32),
            ..._questions.map((question) => _buildQuestionCard(question)),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: _submitAssessment,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A9EFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Submit Assessment',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(AssessmentQuestion question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF4A9EFF),
              inactiveTrackColor: const Color(0xFF374151),
              thumbColor: const Color(0xFF4A9EFF),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayColor: const Color(0xFF4A9EFF).withValues(alpha: 0.2),
              trackHeight: 4,
            ),
            child: Slider(
              value: question.value,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  question.value = value;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question.minLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF374151)),
                ),
                child: Text(
                  '${question.value.round()}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF4A9EFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                question.maxLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitAssessment() {
    // Calculate average score
    double totalScore = 0;
    for (var question in _questions) {
      totalScore += question.value;
    }
    double averageScore = totalScore / _questions.length;

    // Show results dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            'Assessment Complete!',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your average score: ${averageScore.round()}',
                style: const TextStyle(
                  color: Color(0xFF4A9EFF),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _getAssessmentFeedback(averageScore),
                style: const TextStyle(color: Color(0xFF9CA3AF)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Reset all questions to default values
                setState(() {
                  for (var question in _questions) {
                    question.value = 50.0;
                  }
                });
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  String _getAssessmentFeedback(double score) {
    if (score >= 80) {
      return 'Excellent! You handled this task very well.';
    } else if (score >= 60) {
      return 'Good job! You managed the task effectively.';
    } else if (score >= 40) {
      return 'Fair effort. Consider what could be improved next time.';
    } else {
      return 'This task was challenging. Remember, every experience is a learning opportunity.';
    }
  }
}

class AssessmentQuestion {
  final String title;
  final String minLabel;
  final String maxLabel;
  double value;

  AssessmentQuestion(this.title, this.minLabel, this.maxLabel, this.value);
}