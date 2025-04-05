import 'package:flutter/material.dart';

enum WorkplaceType {
  remote,
  hybrid,
  office,
  flexible
}

enum CompanySize {
  startup, // 1-50
  small, // 51-200
  medium, // 201-1000
  large, // 1001-5000
  enterprise // 5000+
}

class CultureValue {
  final String name;
  final String description;
  final double rating; // 1-5 scale
  final Map<String, String> localizedDescriptions;

  CultureValue({
    required this.name,
    required this.description,
    required this.rating,
    required this.localizedDescriptions,
  });
}

class EmployeeTestimonial {
  final String employeeId;
  final String name;
  final String role;
  final String content;
  final DateTime joinedDate;
  final String? photoUrl;
  final String? videoUrl;
  final Map<String, String> localizedContent; // Multilingual support

  EmployeeTestimonial({
    required this.employeeId,
    required this.name,
    required this.role,
    required this.content,
    required this.joinedDate,
    this.photoUrl,
    this.videoUrl,
    required this.localizedContent,
  });
}

class CompanyCulture {
  final String companyId;
  final String mission;
  final String vision;
  final List<CultureValue> values;
  final List<String> officePhotos;
  final String? officeVideoUrl;
  final List<EmployeeTestimonial> testimonials;
  final WorkplaceType workplaceType;
  final CompanySize size;
  final Map<String, double> benefits; // Key: benefit name, Value: rating
  final Map<String, String> localizedContent;
  final List<String> diversityInitiatives;
  final Map<String, double> workLifeBalanceMetrics;
  final List<String> teamActivities;
  final Map<String, int> growthOpportunities; // Key: opportunity type, Value: count

  CompanyCulture({
    required this.companyId,
    required this.mission,
    required this.vision,
    required this.values,
    required this.officePhotos,
    this.officeVideoUrl,
    required this.testimonials,
    required this.workplaceType,
    required this.size,
    required this.benefits,
    required this.localizedContent,
    required this.diversityInitiatives,
    required this.workLifeBalanceMetrics,
    required this.teamActivities,
    required this.growthOpportunities,
  });

  double calculateCultureMatchScore(Map<String, double> candidatePreferences) {
    double score = 0;
    double maxScore = 0;

    // Calculate match based on workplace type
    if (candidatePreferences.containsKey('workplace_type')) {
      maxScore += 5;
      if (workplaceType.toString() == candidatePreferences['workplace_type'].toString()) {
        score += 5;
      }
    }

    // Calculate match based on company values
    if (candidatePreferences.containsKey('values')) {
      for (var value in values) {
        maxScore += 5;
        double candidateRating = candidatePreferences['value_${value.name}'] ?? 0;
        double difference = (value.rating - candidateRating).abs();
        score += 5 - difference;
      }
    }

    // Calculate match based on benefits
    benefits.forEach((benefit, rating) {
      if (candidatePreferences.containsKey('benefit_$benefit')) {
        maxScore += 5;
        double candidateRating = candidatePreferences['benefit_$benefit'] ?? 0;
        double difference = (rating - candidateRating).abs();
        score += 5 - difference;
      }
    });

    // Calculate match based on work-life balance
    workLifeBalanceMetrics.forEach((metric, rating) {
      if (candidatePreferences.containsKey('worklife_$metric')) {
        maxScore += 5;
        double candidateRating = candidatePreferences['worklife_$metric'] ?? 0;
        double difference = (rating - candidateRating).abs();
        score += 5 - difference;
      }
    });

    return (score / maxScore) * 100;
  }

  Map<String, String> getMatchAnalysis(Map<String, double> candidatePreferences) {
    Map<String, String> analysis = {};
    
    // Analyze workplace type match
    analysis['workplace'] = _getWorkplaceMatchAnalysis(candidatePreferences);
    
    // Analyze values match
    analysis['values'] = _getValuesMatchAnalysis(candidatePreferences);
    
    // Analyze benefits match
    analysis['benefits'] = _getBenefitsMatchAnalysis(candidatePreferences);
    
    // Analyze work-life balance match
    analysis['worklife'] = _getWorkLifeMatchAnalysis(candidatePreferences);

    return analysis;
  }

  String _getWorkplaceMatchAnalysis(Map<String, double> preferences) {
    if (!preferences.containsKey('workplace_type')) return 'No workplace preference specified';
    return workplaceType.toString() == preferences['workplace_type'].toString()
        ? 'Workplace type matches your preference'
        : 'Different workplace type than preferred';
  }

  String _getValuesMatchAnalysis(Map<String, double> preferences) {
    List<String> matchingValues = [];
    List<String> differingValues = [];

    for (var value in values) {
      double candidateRating = preferences['value_${value.name}'] ?? 0;
      if ((value.rating - candidateRating).abs() <= 1) {
        matchingValues.add(value.name);
      } else {
        differingValues.add(value.name);
      }
    }

    return 'Matching values: ${matchingValues.join(", ")}\n'
           'Different values: ${differingValues.join(", ")}';
  }

  String _getBenefitsMatchAnalysis(Map<String, double> preferences) {
    List<String> strongMatches = [];
    List<String> weakMatches = [];

    benefits.forEach((benefit, rating) {
      double candidateRating = preferences['benefit_$benefit'] ?? 0;
      if ((rating - candidateRating).abs() <= 1) {
        strongMatches.add(benefit);
      } else {
        weakMatches.add(benefit);
      }
    });

    return 'Strong benefit matches: ${strongMatches.join(", ")}\n'
           'Weak benefit matches: ${weakMatches.join(", ")}';
  }

  String _getWorkLifeMatchAnalysis(Map<String, double> preferences) {
    double averageMatch = 0;
    int count = 0;

    workLifeBalanceMetrics.forEach((metric, rating) {
      if (preferences.containsKey('worklife_$metric')) {
        double candidateRating = preferences['worklife_$metric'] ?? 0;
        averageMatch += 5 - (rating - candidateRating).abs();
        count++;
      }
    });

    if (count == 0) return 'No work-life balance preferences specified';
    averageMatch = averageMatch / count;

    return averageMatch >= 4 ? 'Excellent work-life balance match' :
           averageMatch >= 3 ? 'Good work-life balance match' :
           'Moderate work-life balance match';
  }
} 