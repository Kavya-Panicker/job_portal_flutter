import 'package:flutter/material.dart';

class JobPreferences {
  final List<String> savedJobs;
  final List<String> preferredCategories;
  final RangeValues salaryRange;
  final List<String> preferredLocations;
  final List<String> skills;
  final String experienceLevel;
  final String jobType;
  final String preferredLanguage;

  JobPreferences({
    this.savedJobs = const [],
    this.preferredCategories = const [],
    this.salaryRange = const RangeValues(0, 500000),
    this.preferredLocations = const [],
    this.skills = const [],
    this.experienceLevel = '',
    this.jobType = '',
    this.preferredLanguage = 'en',
  });

  JobPreferences copyWith({
    List<String>? savedJobs,
    List<String>? preferredCategories,
    RangeValues? salaryRange,
    List<String>? preferredLocations,
    List<String>? skills,
    String? experienceLevel,
    String? jobType,
    String? preferredLanguage,
  }) {
    return JobPreferences(
      savedJobs: savedJobs ?? this.savedJobs,
      preferredCategories: preferredCategories ?? this.preferredCategories,
      salaryRange: salaryRange ?? this.salaryRange,
      preferredLocations: preferredLocations ?? this.preferredLocations,
      skills: skills ?? this.skills,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      jobType: jobType ?? this.jobType,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }
} 