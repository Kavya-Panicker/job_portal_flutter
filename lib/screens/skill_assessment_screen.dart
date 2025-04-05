import 'package:flutter/material.dart';
import 'dart:async';
import '../models/skill_assessment.dart';

class SkillAssessmentScreen extends StatefulWidget {
  final SkillAssessment assessment;

  const SkillAssessmentScreen({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  _SkillAssessmentScreenState createState() => _SkillAssessmentScreenState();
}

class _SkillAssessmentScreenState extends State<SkillAssessmentScreen> {
  int _currentQuestionIndex = 0;
  Map<String, String> _answers = {};
  late Timer _timer;
  int _remainingSeconds = 0;
  bool _isSubmitting = false;
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.assessment.timeLimit * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _submitAssessment();
        }
      });
    });
  }

  String _getLocalizedText(String key) {
    final Map<String, Map<String, String>> translations = {
      'submit': {
        'en': 'Submit',
        'hi': 'जमा करें',
        'gu': 'સબમિટ કરો',
        'ml': 'സമർപ്പിക്കുക',
      },
      'next': {
        'en': 'Next',
        'hi': 'अगला',
        'gu': 'આગળ',
        'ml': 'അടുത്തത്',
      },
      'previous': {
        'en': 'Previous',
        'hi': 'पिछला',
        'gu': 'પાછળ',
        'ml': 'മുൻപത്തേത്',
      },
      // Add more translations
    };

    return translations[key]?[_selectedLanguage] ?? translations[key]?['en'] ?? key;
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (_currentQuestionIndex + 1) / widget.assessment.questions.length,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(
          'Question ${_currentQuestionIndex + 1}/${widget.assessment.questions.length}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (question.type == QuestionType.multipleChoice)
              Column(
                children: question.options.map((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: _answers[question.id],
                    onChanged: (value) {
                      setState(() {
                        _answers[question.id] = value!;
                      });
                    },
                  );
                }).toList(),
              )
            else if (question.type == QuestionType.coding)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Code Template:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(question.codeTemplate ?? ''),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write your code here...',
                    ),
                    onChanged: (value) {
                      _answers[question.id] = value;
                    },
                  ),
                ],
              )
            else
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your answer here...',
                ),
                onChanged: (value) {
                  _answers[question.id] = value;
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitAssessment() async {
    setState(() {
      _isSubmitting = true;
    });

    // TODO: Implement submission logic
    // Calculate score
    // Save result
    // Show result screen

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.assessment.questions[_currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(_getLocalizedText('exit_confirmation')),
            content: Text(_getLocalizedText('exit_warning')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(_getLocalizedText('continue_test')),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(_getLocalizedText('exit')),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.assessment.title),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _formatTime(_remainingSeconds),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildProgressIndicator(),
              const SizedBox(height: 16),
              Expanded(
                child: _buildQuestionCard(currentQuestion),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentQuestionIndex > 0)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                      child: Text(_getLocalizedText('previous')),
                    )
                  else
                    const SizedBox.shrink(),
                  if (_currentQuestionIndex < widget.assessment.questions.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      },
                      child: Text(_getLocalizedText('next')),
                    )
                  else
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitAssessment,
                      child: _isSubmitting
                          ? const CircularProgressIndicator()
                          : Text(_getLocalizedText('submit')),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
} 