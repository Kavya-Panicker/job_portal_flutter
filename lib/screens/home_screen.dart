import 'dart:io';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';
import '../models/job.dart';
import 'applications_screen.dart';
import 'messages_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'create_post_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _profilePictureUrl = "https://randomuser.me/api/portraits/men/46.jpg";
  int _notificationCount = 5;

  // Dummy jobs converted to posts
  List<Post> posts = [
    // Regular post example
    Post(
      id: '1',
      authorName: 'Sarah Wilson',
      authorRole: 'Senior Software Engineer at Google',
      authorImageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      content: 'Excited to share that I\'ve just completed a major project using Flutter and Firebase! #Flutter #MobileApp #Development',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      imageUrls: ['https://picsum.photos/500/300'],
      likes: 128,
      comments: 14,
      shares: 5,
      isLiked: false,
      isSaved: false,
    ),
    // Job post example
    Post(
      id: '2',
      authorName: 'Google',
      authorRole: 'Technology Company',
      authorImageUrl: 'https://i.imgur.com/DQvDq1H.png',
      content: 'We\'re looking for a talented Frontend Developer to join our team!',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      imageUrls: [],
      likes: 256,
      comments: 28,
      shares: 42,
      isLiked: false,
      isSaved: true,
      isJobPost: true,
      jobDetails: Job(
        company: "Google",
        title: "Frontend Developer",
        location: "Mountain View, CA",
        time: "Full-time",
        salary: r"\$140,000 - $180,000",
        level: "Mid-Senior Level",
        bookmarked: false,
        logoUrl: "https://i.imgur.com/DQvDq1H.png",
        category: "Frontend",
      ),
    ),
    // Another regular post
    Post(
      id: '3',
      authorName: 'John Doe',
      authorRole: 'Tech Lead at Microsoft',
      authorImageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      content: 'Just published my article on best practices for React Native development. Check it out! #ReactNative #Development #BestPractices',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      imageUrls: ['https://picsum.photos/500/301', 'https://picsum.photos/500/302'],
      likes: 89,
      comments: 12,
      shares: 3,
      isLiked: true,
      isSaved: false,
    ),
    // Another job post
    Post(
      id: '4',
      authorName: 'Microsoft',
      authorRole: 'Technology Company',
      authorImageUrl: 'https://i.imgur.com/j9oEQKn.png',
      content: 'Join our cloud services team as a Backend Developer!',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      imageUrls: [],
      likes: 189,
      comments: 23,
      shares: 31,
      isLiked: false,
      isSaved: false,
      isJobPost: true,
      jobDetails: Job(
        company: "Microsoft",
        title: "Backend Developer",
        location: "Redmond, WA",
        time: "Full-time",
        salary: r"\$150,000 - $200,000",
        level: "Senior Level",
        bookmarked: false,
        logoUrl: "https://i.imgur.com/j9oEQKn.png",
        category: "Backend",
      ),
    ),
  ];

  void _handleLike(String postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = posts[postIndex];
        posts[postIndex] = Post(
          id: post.id,
          authorName: post.authorName,
          authorRole: post.authorRole,
          authorImageUrl: post.authorImageUrl,
          content: post.content,
          timestamp: post.timestamp,
          imageUrls: post.imageUrls,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
          comments: post.comments,
          shares: post.shares,
          isLiked: !post.isLiked,
          isSaved: post.isSaved,
          jobDetails: post.jobDetails,
          isJobPost: post.isJobPost,
        );
      }
    });
  }

  void _handleComment(String postId) {
    // TODO: Implement comment functionality
  }

  void _handleShare(String postId) {
    // TODO: Implement share functionality
  }

  void _handleSave(String postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = posts[postIndex];
        posts[postIndex] = Post(
          id: post.id,
          authorName: post.authorName,
          authorRole: post.authorRole,
          authorImageUrl: post.authorImageUrl,
          content: post.content,
          timestamp: post.timestamp,
          imageUrls: post.imageUrls,
          likes: post.likes,
          comments: post.comments,
          shares: post.shares,
          isLiked: post.isLiked,
          isSaved: !post.isSaved,
          jobDetails: post.jobDetails,
          isJobPost: post.isJobPost,
        );
      }
    });
  }

  // For bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Profile picture updater
  void _updateProfilePicture(String newProfilePictureUrl) {
    setState(() {
      _profilePictureUrl = newProfilePictureUrl;
    });
  }

  // Dynamic screen loader
  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const SearchScreen();
      case 2:
        return ApplicationsScreen();
      case 3:
        return NotificationsScreen();
      case 4:
        return ProfileScreen(
          onProfilePictureChanged: _updateProfilePicture,
        );
      default:
        return const Center(child: Text("Unknown Screen"));
    }
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          expandedHeight: 60,
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text(
            "SkillSync",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_box_outlined, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePostScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.message, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessagesScreen()),
                );
              },
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: Divider(height: 1),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final post = posts[index];
              return PostCard(
                post: post,
                onLike: _handleLike,
                onComment: _handleComment,
                onShare: _handleShare,
                onSave: _handleSave,
                onTap: post.isJobPost ? () => _showApplyDialog(context, post.jobDetails!) : null,
              );
            },
            childCount: posts.length,
          ),
        ),
      ],
    );
  }

  // Application Form Dialog
  Future<void> _showApplyDialog(BuildContext context, Job job) async {
    String? name;
    String? email;
    String? coverLetter;
    File? resume;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Apply for ${job.title} at ${job.company}"),
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
                      decoration: const InputDecoration(labelText: "Cover Letter"),
                      onChanged: (value) => coverLetter = value,
                      maxLines: 3,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        file_picker.FilePickerResult? result =
                            await file_picker.FilePicker.platform.pickFiles(
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
      body: SafeArea(
        child: _getBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('$_notificationCount'),
              child: const Icon(Icons.notifications),
            ),
            label: 'Notifications',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
