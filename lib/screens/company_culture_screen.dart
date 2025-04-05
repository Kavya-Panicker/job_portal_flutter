import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import '../models/company_culture.dart';

class CompanyCultureScreen extends StatefulWidget {
  final CompanyCulture culture;
  final Map<String, double>? candidatePreferences;

  const CompanyCultureScreen({
    Key? key,
    required this.culture,
    this.candidatePreferences,
  }) : super(key: key);

  @override
  _CompanyCultureScreenState createState() => _CompanyCultureScreenState();
}

class _CompanyCultureScreenState extends State<CompanyCultureScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  VideoPlayerController? _videoController;
  String _selectedLanguage = 'en';
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    if (widget.culture.officeVideoUrl != null) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.network(widget.culture.officeVideoUrl!);
    await _videoController!.initialize();
    setState(() {
      _isVideoInitialized = true;
    });
  }

  String _getLocalizedText(String key) {
    final Map<String, Map<String, String>> translations = {
      'overview': {
        'en': 'Overview',
        'hi': 'अवलोकन',
        'gu': 'ઝાંખી',
        'ml': 'അവലോകനം',
      },
      'values': {
        'en': 'Values',
        'hi': 'मूल्य',
        'gu': 'મૂલ્યો',
        'ml': 'മൂല്യങ്ങൾ',
      },
      // Add more translations
    };

    return translations[key]?[_selectedLanguage] ?? translations[key]?['en'] ?? key;
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getLocalizedText('mission'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(widget.culture.mission),
          const SizedBox(height: 24),
          Text(
            _getLocalizedText('vision'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(widget.culture.vision),
          const SizedBox(height: 24),
          if (widget.culture.officePhotos.isNotEmpty) ...[
            Text(
              _getLocalizedText('office_photos'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
              ),
              items: widget.culture.officePhotos.map((photo) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(photo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
          if (_isVideoInitialized) ...[
            const SizedBox(height: 24),
            Text(
              _getLocalizedText('office_tour'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoController!),
                  IconButton(
                    icon: Icon(
                      _videoController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 48,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _videoController!.value.isPlaying
                            ? _videoController!.pause()
                            : _videoController!.play();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildValuesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.culture.values.length,
      itemBuilder: (context, index) {
        final value = widget.culture.values[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(value.localizedDescriptions[_selectedLanguage] ??
                    value.description),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: value.rating / 5,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestimonialsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.culture.testimonials.length,
      itemBuilder: (context, index) {
        final testimonial = widget.culture.testimonials[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              ListTile(
                leading: testimonial.photoUrl != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(testimonial.photoUrl!),
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                title: Text(testimonial.name),
                subtitle: Text(testimonial.role),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  testimonial.localizedContent[_selectedLanguage] ??
                      testimonial.content,
                ),
              ),
              if (testimonial.videoUrl != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Show video testimonial
                    },
                    icon: const Icon(Icons.play_circle),
                    label: Text(_getLocalizedText('watch_testimonial')),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBenefitsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (var entry in widget.culture.benefits.entries)
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: entry.value / 5,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMatchScoreTab() {
    if (widget.candidatePreferences == null) {
      return Center(
        child: Text(_getLocalizedText('no_preferences')),
      );
    }

    final score = widget.culture.calculateCultureMatchScore(
        widget.candidatePreferences!);
    final analysis = widget.culture.getMatchAnalysis(widget.candidatePreferences!);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '${score.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _getLocalizedText('culture_match'),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          for (var entry in analysis.entries) ...[
            Card(
              child: ListTile(
                title: Text(_getLocalizedText(entry.key)),
                subtitle: Text(entry.value),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getLocalizedText('company_culture')),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: _getLocalizedText('overview')),
            Tab(text: _getLocalizedText('values')),
            Tab(text: _getLocalizedText('testimonials')),
            Tab(text: _getLocalizedText('benefits')),
            Tab(text: _getLocalizedText('match_score')),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildValuesTab(),
          _buildTestimonialsTab(),
          _buildBenefitsTab(),
          _buildMatchScoreTab(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController?.dispose();
    super.dispose();
  }
} 