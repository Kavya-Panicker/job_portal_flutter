import 'package:flutter/material.dart';
import '../../models/skill_assessment.dart';

class ManageAssessmentsScreen extends StatefulWidget {
  const ManageAssessmentsScreen({Key? key}) : super(key: key);

  @override
  _ManageAssessmentsScreenState createState() => _ManageAssessmentsScreenState();
}

class _ManageAssessmentsScreenState extends State<ManageAssessmentsScreen> {
  String _selectedLanguage = 'en';
  List<SkillAssessment> _assessments = []; // TODO: Fetch from backend

  String _getLocalizedText(String key) {
    final Map<String, Map<String, String>> translations = {
      'manage_assessments': {
        'en': 'Manage Assessments',
        'hi': 'मूल्यांकन प्रबंधित करें',
        'gu': 'મૂલ્યાંકન મેનેજ કરો',
        'ml': 'വിലയിരുത്തലുകൾ നിയന്ത്രിക്കുക',
      },
      'create_assessment': {
        'en': 'Create Assessment',
        'hi': 'मूल्यांकन बनाएं',
        'gu': 'મૂલ્યાંકન બનાવો',
        'ml': 'വിലയിരുത്തൽ സൃഷ്ടിക്കുക',
      },
      // Add more translations
    };

    return translations[key]?[_selectedLanguage] ?? translations[key]?['en'] ?? key;
  }

  Widget _buildAssessmentCard(SkillAssessment assessment) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(assessment.title),
        subtitle: Text(
          '${assessment.domain} • ${assessment.difficulty} • ${assessment.timeLimit} mins',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _editAssessment(assessment);
                break;
              case 'delete':
                _deleteAssessment(assessment);
                break;
              case 'view_results':
                _viewResults(assessment);
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text(_getLocalizedText('edit')),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text(_getLocalizedText('delete')),
            ),
            PopupMenuItem(
              value: 'view_results',
              child: Text(_getLocalizedText('view_results')),
            ),
          ],
        ),
      ),
    );
  }

  void _createAssessment() {
    // TODO: Navigate to assessment creation screen
  }

  void _editAssessment(SkillAssessment assessment) {
    // TODO: Navigate to assessment edit screen
  }

  void _deleteAssessment(SkillAssessment assessment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_getLocalizedText('delete_confirmation')),
        content: Text(_getLocalizedText('delete_warning')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_getLocalizedText('cancel')),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete logic
              Navigator.pop(context);
            },
            child: Text(
              _getLocalizedText('delete'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _viewResults(SkillAssessment assessment) {
    // TODO: Navigate to results screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getLocalizedText('manage_assessments')),
      ),
      body: _assessments.isEmpty
          ? Center(
              child: Text(_getLocalizedText('no_assessments')),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _assessments.length,
              itemBuilder: (context, index) {
                return _buildAssessmentCard(_assessments[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createAssessment,
        icon: const Icon(Icons.add),
        label: Text(_getLocalizedText('create_assessment')),
      ),
    );
  }
} 