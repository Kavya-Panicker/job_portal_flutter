import 'package:flutter/material.dart';

enum InterviewType {
  inPerson,
  video,
  phone
}

enum InterviewStatus {
  pending,
  confirmed,
  completed,
  cancelled,
  rescheduled
}

class TimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;
  final String? bookedBy;

  TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
    this.bookedBy,
  });

  bool get isOverlapping => false; // TODO: Implement overlap checking

  Duration get duration => endTime.difference(startTime);
}

class InterviewSchedule {
  final String id;
  final String jobId;
  final String employerId;
  final String? candidateId;
  final String title;
  final String description;
  final InterviewType type;
  final InterviewStatus status;
  final TimeSlot selectedSlot;
  final List<TimeSlot> availableSlots;
  final String? meetingLink; // For video interviews
  final String? location; // For in-person interviews
  final Map<String, String> localizedInstructions; // Multilingual instructions
  final bool isReminderSet;
  final List<DateTime> reminderTimes;
  final Map<String, dynamic>? calendarEvent; // For calendar integration

  InterviewSchedule({
    required this.id,
    required this.jobId,
    required this.employerId,
    this.candidateId,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.selectedSlot,
    required this.availableSlots,
    this.meetingLink,
    this.location,
    required this.localizedInstructions,
    this.isReminderSet = false,
    this.reminderTimes = const [],
    this.calendarEvent,
  });

  InterviewSchedule copyWith({
    String? candidateId,
    InterviewStatus? status,
    TimeSlot? selectedSlot,
    String? meetingLink,
    bool? isReminderSet,
    List<DateTime>? reminderTimes,
    Map<String, dynamic>? calendarEvent,
  }) {
    return InterviewSchedule(
      id: id,
      jobId: jobId,
      employerId: employerId,
      candidateId: candidateId ?? this.candidateId,
      title: title,
      description: description,
      type: type,
      status: status ?? this.status,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      availableSlots: availableSlots,
      meetingLink: meetingLink ?? this.meetingLink,
      location: location,
      localizedInstructions: localizedInstructions,
      isReminderSet: isReminderSet ?? this.isReminderSet,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      calendarEvent: calendarEvent ?? this.calendarEvent,
    );
  }
}

class InterviewReminder {
  final String interviewId;
  final DateTime reminderTime;
  final String recipientId;
  final String message;
  final bool isSent;
  final DateTime? sentAt;

  InterviewReminder({
    required this.interviewId,
    required this.reminderTime,
    required this.recipientId,
    required this.message,
    this.isSent = false,
    this.sentAt,
  });
} 