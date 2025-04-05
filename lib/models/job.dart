// lib/models/job.dart
class Job {
  String company;
  String title;
  String location;
  String time;
  String salary;
  String level;
  bool bookmarked;
  String logoUrl;

  Job({
    required this.company,
    required this.title,
    required this.location,
    required this.time,
    required this.salary,
    required this.level,
    required this.bookmarked,
    required this.logoUrl, required String category,
  });

  get category => null;
}
