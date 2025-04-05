import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/interview_schedule.dart';

class InterviewSchedulerScreen extends StatefulWidget {
  final String jobId;
  final String employerId;

  const InterviewSchedulerScreen({
    Key? key,
    required this.jobId,
    required this.employerId,
  }) : super(key: key);

  @override
  _InterviewSchedulerScreenState createState() => _InterviewSchedulerScreenState();
}

class _InterviewSchedulerScreenState extends State<InterviewSchedulerScreen> {
  String _selectedLanguage = 'en';
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<TimeSlot> _selectedTimeSlots = [];
  InterviewType _selectedType = InterviewType.video;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isGoogleCalendarLinked = false;
  bool _isZoomLinked = false;

  String _getLocalizedText(String key) {
    final Map<String, Map<String, String>> translations = {
      'schedule_interview': {
        'en': 'Schedule Interview',
        'hi': 'साक्षात्कार शेड्यूल करें',
        'gu': 'ઇન્ટરવ્યુ શેડ્યૂલ કરો',
        'ml': 'അഭിമുഖം ഷെഡ്യൂൾ ചെയ്യുക',
      },
      'select_time_slots': {
        'en': 'Select Available Time Slots',
        'hi': 'उपलब्ध समय स्लॉट चुनें',
        'gu': 'ઉપલબ્ધ સમય સ્લોટ પસંદ કરો',
        'ml': 'ലഭ്യമായ സമയ സ്ലോട്ടുകൾ തിരഞ്ഞെടുക്കുക',
      },
      // Add more translations
    };

    return translations[key]?[_selectedLanguage] ?? translations[key]?['en'] ?? key;
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 60)),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getLocalizedText('select_time_slots'),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (int hour = 9; hour <= 17; hour++)
              _buildTimeSlotChip(
                TimeSlot(
                  startTime: DateTime(_selectedDay.year, _selectedDay.month,
                      _selectedDay.day, hour),
                  endTime: DateTime(_selectedDay.year, _selectedDay.month,
                      _selectedDay.day, hour + 1),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSlotChip(TimeSlot slot) {
    final bool isSelected = _selectedTimeSlots
        .any((selected) => selected.startTime == slot.startTime);
    final timeFormat = TimeOfDay.fromDateTime(slot.startTime).format(context);

    return FilterChip(
      label: Text(timeFormat),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedTimeSlots.add(slot);
          } else {
            _selectedTimeSlots.removeWhere(
                (selected) => selected.startTime == slot.startTime);
          }
        });
      },
    );
  }

  Widget _buildInterviewTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getLocalizedText('interview_type'),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SegmentedButton<InterviewType>(
          segments: [
            ButtonSegment(
              value: InterviewType.video,
              label: Text(_getLocalizedText('video')),
              icon: const Icon(Icons.videocam),
            ),
            ButtonSegment(
              value: InterviewType.phone,
              label: Text(_getLocalizedText('phone')),
              icon: const Icon(Icons.phone),
            ),
            ButtonSegment(
              value: InterviewType.inPerson,
              label: Text(_getLocalizedText('in_person')),
              icon: const Icon(Icons.person),
            ),
          ],
          selected: {_selectedType},
          onSelectionChanged: (Set<InterviewType> selected) {
            setState(() {
              _selectedType = selected.first;
            });
          },
        ),
      ],
    );
  }

  Widget _buildIntegrationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getLocalizedText('integrations'),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/a/a5/Google_Calendar_icon_%282020%29.svg',
            width: 24,
            height: 24,
          ),
          title: Text(_getLocalizedText('google_calendar')),
          trailing: Switch(
            value: _isGoogleCalendarLinked,
            onChanged: (value) {
              setState(() {
                _isGoogleCalendarLinked = value;
              });
              if (value) {
                _linkGoogleCalendar();
              }
            },
          ),
        ),
        if (_selectedType == InterviewType.video)
          ListTile(
            leading: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Zoom_Communications_Logo.svg/1200px-Zoom_Communications_Logo.svg.png',
              width: 24,
              height: 24,
            ),
            title: Text(_getLocalizedText('zoom')),
            trailing: Switch(
              value: _isZoomLinked,
              onChanged: (value) {
                setState(() {
                  _isZoomLinked = value;
                });
                if (value) {
                  _linkZoom();
                }
              },
            ),
          ),
      ],
    );
  }

  Future<void> _linkGoogleCalendar() async {
    // TODO: Implement Google Calendar OAuth
  }

  Future<void> _linkZoom() async {
    // TODO: Implement Zoom OAuth
  }

  Future<void> _createSchedule() async {
    if (_selectedTimeSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getLocalizedText('select_slots_warning')),
        ),
      );
      return;
    }

    // TODO: Create interview schedule
    // TODO: Send notifications
    // TODO: Create calendar events if integrated
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getLocalizedText('schedule_interview')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: _getLocalizedText('interview_title'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: _getLocalizedText('description'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            _buildCalendar(),
            const SizedBox(height: 24),
            _buildTimeSlotSelector(),
            const SizedBox(height: 24),
            _buildInterviewTypeSelector(),
            const SizedBox(height: 24),
            if (_selectedType == InterviewType.inPerson)
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: _getLocalizedText('location'),
                  border: const OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 24),
            _buildIntegrationSection(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _createSchedule,
          child: Text(_getLocalizedText('create_schedule')),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
} 