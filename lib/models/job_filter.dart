import 'package:temp_job_portal/models/job_type.dart';

class JobFilter {
  final List<EmploymentType>? employmentTypes;
  final bool? isRemoteOnly;
  final bool? isHybridOnly;
  final int? minHoursPerWeek;
  final int? maxHoursPerWeek;
  final double? minSalary;
  final double? maxSalary;
  final String? salaryPeriod;
  final DateTime? postedAfter;
  final bool? isFlexibleSchedule;
  final String? searchQuery;

  JobFilter({
    this.employmentTypes,
    this.isRemoteOnly,
    this.isHybridOnly,
    this.minHoursPerWeek,
    this.maxHoursPerWeek,
    this.minSalary,
    this.maxSalary,
    this.salaryPeriod,
    this.postedAfter,
    this.isFlexibleSchedule,
    this.searchQuery,
  });

  Map<String, dynamic> toJson() {
    return {
      'employmentTypes': employmentTypes?.map((e) => e.toString()).toList(),
      'isRemoteOnly': isRemoteOnly,
      'isHybridOnly': isHybridOnly,
      'minHoursPerWeek': minHoursPerWeek,
      'maxHoursPerWeek': maxHoursPerWeek,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'salaryPeriod': salaryPeriod,
      'postedAfter': postedAfter?.toIso8601String(),
      'isFlexibleSchedule': isFlexibleSchedule,
      'searchQuery': searchQuery,
    };
  }

  factory JobFilter.fromJson(Map<String, dynamic> json) {
    return JobFilter(
      employmentTypes: (json['employmentTypes'] as List<String>?)?.map(
        (e) => EmploymentType.values.firstWhere(
          (type) => type.toString() == e,
        ),
      ).toList(),
      isRemoteOnly: json['isRemoteOnly'],
      isHybridOnly: json['isHybridOnly'],
      minHoursPerWeek: json['minHoursPerWeek'],
      maxHoursPerWeek: json['maxHoursPerWeek'],
      minSalary: json['minSalary'],
      maxSalary: json['maxSalary'],
      salaryPeriod: json['salaryPeriod'],
      postedAfter: json['postedAfter'] != null
          ? DateTime.parse(json['postedAfter'])
          : null,
      isFlexibleSchedule: json['isFlexibleSchedule'],
      searchQuery: json['searchQuery'],
    );
  }

  JobFilter copyWith({
    List<EmploymentType>? employmentTypes,
    bool? isRemoteOnly,
    bool? isHybridOnly,
    int? minHoursPerWeek,
    int? maxHoursPerWeek,
    double? minSalary,
    double? maxSalary,
    String? salaryPeriod,
    DateTime? postedAfter,
    bool? isFlexibleSchedule,
    String? searchQuery,
  }) {
    return JobFilter(
      employmentTypes: employmentTypes ?? this.employmentTypes,
      isRemoteOnly: isRemoteOnly ?? this.isRemoteOnly,
      isHybridOnly: isHybridOnly ?? this.isHybridOnly,
      minHoursPerWeek: minHoursPerWeek ?? this.minHoursPerWeek,
      maxHoursPerWeek: maxHoursPerWeek ?? this.maxHoursPerWeek,
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      salaryPeriod: salaryPeriod ?? this.salaryPeriod,
      postedAfter: postedAfter ?? this.postedAfter,
      isFlexibleSchedule: isFlexibleSchedule ?? this.isFlexibleSchedule,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
} 