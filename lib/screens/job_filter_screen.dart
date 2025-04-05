import 'package:flutter/material.dart';
import '../models/job_preferences.dart';

class JobFilterScreen extends StatefulWidget {
  final JobPreferences initialPreferences;

  const JobFilterScreen({Key? key, required this.initialPreferences}) : super(key: key);

  @override
  _JobFilterScreenState createState() => _JobFilterScreenState();
}

class _JobFilterScreenState extends State<JobFilterScreen> {
  late JobPreferences _preferences;
  final List<String> _languages = ['English', 'हिंदी', 'ગુજરાતી', 'മലയാളം'];
  final List<String> _languageCodes = ['en', 'hi', 'gu', 'ml'];

  @override
  void initState() {
    super.initState();
    _preferences = widget.initialPreferences;
  }

  Widget _buildLanguageSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Language / भाषा चुनें / ભાષા પસંદ કરો / ഭാഷ തിരഞ്ഞെടുക്കുക',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(
            _languages.length,
            (index) => ChoiceChip(
              label: Text(_languages[index]),
              selected: _preferences.preferredLanguage == _languageCodes[index],
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _preferences = _preferences.copyWith(
                      preferredLanguage: _languageCodes[index],
                    );
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSalaryRangeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _preferences.preferredLanguage == 'hi'
              ? 'वेतन सीमा'
              : _preferences.preferredLanguage == 'gu'
                  ? 'પગાર શ્રેણી'
                  : _preferences.preferredLanguage == 'ml'
                      ? 'ശമ്പള പരിധി'
                      : 'Salary Range',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        RangeSlider(
          values: _preferences.salaryRange,
          min: 0,
          max: 500000,
          divisions: 50,
          labels: RangeLabels(
            '\$${_preferences.salaryRange.start.round()}',
            '\$${_preferences.salaryRange.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _preferences = _preferences.copyWith(salaryRange: values);
            });
          },
        ),
      ],
    );
  }

  Widget _buildSkillsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _preferences.preferredLanguage == 'hi'
              ? 'कौशल'
              : _preferences.preferredLanguage == 'gu'
                  ? 'કૌશલ્યો'
                  : _preferences.preferredLanguage == 'ml'
                      ? 'കഴിവുകൾ'
                      : 'Skills',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8,
          children: [
            ..._preferences.skills.map(
              (skill) => Chip(
                label: Text(skill),
                onDeleted: () {
                  setState(() {
                    _preferences = _preferences.copyWith(
                      skills: List.from(_preferences.skills)..remove(skill),
                    );
                  });
                },
              ),
            ),
            ActionChip(
              label: const Icon(Icons.add),
              onPressed: () => _showAddSkillDialog(),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showAddSkillDialog() async {
    final TextEditingController controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          _preferences.preferredLanguage == 'hi'
              ? 'कौशल जोड़ें'
              : _preferences.preferredLanguage == 'gu'
                  ? 'કૌશલ્ય ઉમેરો'
                  : _preferences.preferredLanguage == 'ml'
                      ? 'കഴിവ് ചേർക്കുക'
                      : 'Add Skill',
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter skill',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _preferences.preferredLanguage == 'hi'
                  ? 'रद्द करें'
                  : _preferences.preferredLanguage == 'gu'
                      ? 'રદ કરો'
                      : _preferences.preferredLanguage == 'ml'
                          ? 'റദ്ദാക്കുക'
                          : 'Cancel',
            ),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _preferences = _preferences.copyWith(
                    skills: List.from(_preferences.skills)..add(controller.text),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: Text(
              _preferences.preferredLanguage == 'hi'
                  ? 'जोड़ें'
                  : _preferences.preferredLanguage == 'gu'
                      ? 'ઉમેરો'
                      : _preferences.preferredLanguage == 'ml'
                          ? 'ചേർക്കുക'
                          : 'Add',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _preferences.preferredLanguage == 'hi'
              ? 'उन्नत फ़िल्टर'
              : _preferences.preferredLanguage == 'gu'
                  ? 'એડવાન્સ્ડ ફિલ્ટર્સ'
                  : _preferences.preferredLanguage == 'ml'
                      ? 'വിപുലമായ ഫിൽട്ടറുകൾ'
                      : 'Advanced Filters',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, _preferences);
            },
            child: Text(
              _preferences.preferredLanguage == 'hi'
                  ? 'लागू करें'
                  : _preferences.preferredLanguage == 'gu'
                      ? 'લાગુ કરો'
                      : _preferences.preferredLanguage == 'ml'
                          ? 'പ്രയോഗിക്കുക'
                          : 'Apply',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLanguageSelector(),
            const SizedBox(height: 24),
            _buildSalaryRangeSlider(),
            const SizedBox(height: 24),
            _buildSkillsInput(),
          ],
        ),
      ),
    );
  }
} 