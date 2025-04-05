// lib/screens/applications_screen.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../models/application.dart';
import '../widgets/application_card.dart';
import 'application_detail_screen.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({Key? key}) : super(key: key);

  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  final List<Application> applications = [
    Application(
      jobTitle: "Senior UI Designer",
      company: "Plainthing Studio",
      status: "Applied",
      dateApplied: "2024-01-01",
    ),
    Application(
      jobTitle: "Software Engineer",
      company: "Awesome Co.",
      status: "Interviewing",
      dateApplied: "2024-02-15",
    ),
    Application(
      jobTitle: "Product Manager",
      company: "Great Product Inc.",
      status: "Rejected",
      dateApplied: "2024-03-01",
    ),
  ];

  Future<void> _showApplyDialog(BuildContext context) async {
    String? name;
    String? email;
    String? coverLetter;
    File? resume;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Apply for Job"),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Your Name"),
                      onChanged: (value) => name = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Your Email"),
                      onChanged: (value) => email = value,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Cover Letter"),
                      onChanged: (value) => coverLetter = value,
                      maxLines: 3,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'doc', 'docx'],
                        );
                        if (result != null) {
                          setState(() {
                            resume = File(result.files.single.path!);
                          });
                        }
                      },
                      child: const Text("Upload Resume"),
                    ),
                    Text(resume != null
                        ? "Resume Uploaded: ${resume!.path.split('/').last}"
                        : "No Resume Uploaded"),
                  ],
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                if (name != null &&
                    email != null &&
                    resume != null &&
                    coverLetter != null) {
                  // Simulate submission
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Application Submitted"),
                        content: const Text(
                            "Your application has been submitted successfully!"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Incomplete Form"),
                        content: const Text(
                            "Please fill out all fields and upload your resume."),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Applications",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: applications.length,
              itemBuilder: (context, index) {
                return ApplicationCard(
                  application: applications[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ApplicationDetailScreen(application: applications[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () => _showApplyDialog(context),
              child: const Text("Apply for a Job"),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

class FileType {
  static var custom;
}

class FilePicker {
  static var platform;
}

class FilePickerResult {
  get files => null;
}
