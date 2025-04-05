import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ResumeBuilderScreen extends StatefulWidget {
  const ResumeBuilderScreen({Key? key}) : super(key: key);

  @override
  _ResumeBuilderScreenState createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedLanguage = 'en';
  
  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  List<TextEditingController> _experienceControllers = [];
  List<TextEditingController> _educationControllers = [];
  List<String> _skills = [];

  @override
  void initState() {
    super.initState();
    _addExperienceField();
    _addEducationField();
  }

  void _addExperienceField() {
    setState(() {
      _experienceControllers.add(TextEditingController());
    });
  }

  void _addEducationField() {
    setState(() {
      _educationControllers.add(TextEditingController());
    });
  }

  String _getLocalizedText(String key) {
    final Map<String, Map<String, String>> translations = {
      'resume_builder': {
        'en': 'Resume Builder',
        'hi': 'रेज्यूमे बिल्डर',
        'gu': 'રેઝ્યુમે બિલ્ડર',
        'ml': 'റെസ്യൂമെ ബിൽഡർ',
      },
      'personal_info': {
        'en': 'Personal Information',
        'hi': 'व्यक्तिगत जानकारी',
        'gu': 'વ્યક્તિગત માહિતી',
        'ml': 'വ്യക്തിഗത വിവരങ്ങൾ',
      },
      // Add more translations as needed
    };

    return translations[key]?[_selectedLanguage] ?? translations[key]?['en'] ?? key;
  }

  Future<void> _generateResume() async {
    if (!_formKey.currentState!.validate()) return;

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(_nameController.text,
                    style: pw.TextStyle(fontSize: 24)),
              ),
              pw.Paragraph(text: _emailController.text),
              pw.Paragraph(text: _phoneController.text),
              pw.Header(
                level: 1,
                child: pw.Text('Professional Summary'),
              ),
              pw.Paragraph(text: _summaryController.text),
              pw.Header(
                level: 1,
                child: pw.Text('Experience'),
              ),
              pw.Column(
                children: _experienceControllers
                    .map((controller) => pw.Paragraph(text: controller.text))
                    .toList(),
              ),
              pw.Header(
                level: 1,
                child: pw.Text('Education'),
              ),
              pw.Column(
                children: _educationControllers
                    .map((controller) => pw.Paragraph(text: controller.text))
                    .toList(),
              ),
              pw.Header(
                level: 1,
                child: pw.Text('Skills'),
              ),
              pw.Wrap(
                spacing: 5,
                children: _skills
                    .map((skill) => pw.Container(
                          padding: const pw.EdgeInsets.all(4),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            borderRadius:
                                const pw.BorderRadius.all(pw.Radius.circular(4)),
                          ),
                          child: pw.Text(skill),
                        ))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/resume.pdf');
    await file.writeAsBytes(await pdf.save());

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getLocalizedText('resume_generated')),
          action: SnackBarAction(
            label: _getLocalizedText('view'),
            onPressed: () {
              // TODO: Implement PDF viewer
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getLocalizedText('resume_builder')),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _generateResume,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _getLocalizedText('personal_info'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: _getLocalizedText('name'),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty == true ? _getLocalizedText('required') : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: _getLocalizedText('email'),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty == true ? _getLocalizedText('required') : null,
              ),
              // Add more form fields for experience, education, skills, etc.
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(_getLocalizedText('add_section')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(_getLocalizedText('experience')),
                    onTap: () {
                      _addExperienceField();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(_getLocalizedText('education')),
                    onTap: () {
                      _addEducationField();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _summaryController.dispose();
    for (var controller in _experienceControllers) {
      controller.dispose();
    }
    for (var controller in _educationControllers) {
      controller.dispose();
    }
    super.dispose();
  }
} 