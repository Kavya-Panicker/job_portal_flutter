import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class JobAnalyticsScreen extends StatefulWidget {
  const JobAnalyticsScreen({Key? key}) : super(key: key);

  @override
  _JobAnalyticsScreenState createState() => _JobAnalyticsScreenState();
}

class _JobAnalyticsScreenState extends State<JobAnalyticsScreen> {
  String _selectedLanguage = 'en';
  int _touchedIndex = -1;

  String _getLocalizedText(String key) {
    final Map<String, Map<String, String>> translations = {
      'job_analytics': {
        'en': 'Job Analytics',
        'hi': 'नौकरी विश्लेषण',
        'gu': 'નોકરી વિશ્લેષણ',
        'ml': 'ജോലി വിശകലനം',
      },
      'applications': {
        'en': 'Applications',
        'hi': 'आवेदन',
        'gu': 'અરજીઓ',
        'ml': 'അപേക്ഷകൾ',
      },
      // Add more translations
    };

    return translations[key]?[_selectedLanguage] ?? translations[key]?['en'] ?? key;
  }

  Widget _buildApplicationStatusChart() {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                _getLocalizedText('application_status'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex =
                              pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sections: [
                      PieChartSectionData(
                        color: Colors.blue,
                        value: 40,
                        title: '40%',
                        radius: _touchedIndex == 0 ? 60 : 50,
                        titleStyle: const TextStyle(color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: Colors.green,
                        value: 30,
                        title: '30%',
                        radius: _touchedIndex == 1 ? 60 : 50,
                        titleStyle: const TextStyle(color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: Colors.red,
                        value: 15,
                        title: '15%',
                        radius: _touchedIndex == 2 ? 60 : 50,
                        titleStyle: const TextStyle(color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: Colors.grey,
                        value: 15,
                        title: '15%',
                        radius: _touchedIndex == 3 ? 60 : 50,
                        titleStyle: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildLegend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem(Colors.blue, _getLocalizedText('pending')),
        _buildLegendItem(Colors.green, _getLocalizedText('accepted')),
        _buildLegendItem(Colors.red, _getLocalizedText('rejected')),
        _buildLegendItem(Colors.grey, _getLocalizedText('no_response')),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildApplicationTrendsChart() {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                _getLocalizedText('application_trends'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 3),
                          const FlSpot(1, 1),
                          const FlSpot(2, 4),
                          const FlSpot(3, 2),
                          const FlSpot(4, 5),
                          const FlSpot(5, 3),
                          const FlSpot(6, 4),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsMatchChart() {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                _getLocalizedText('skills_match'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barTouchData: BarTouchData(
                      enabled: false,
                    ),
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: 85,
                            color: Colors.blue,
                            width: 16,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: 70,
                            color: Colors.blue,
                            width: 16,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: 95,
                            color: Colors.blue,
                            width: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getLocalizedText('job_analytics')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildApplicationStatusChart(),
            const SizedBox(height: 24),
            _buildApplicationTrendsChart(),
            const SizedBox(height: 24),
            _buildSkillsMatchChart(),
          ],
        ),
      ),
    );
  }
} 