// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../widgets/profile_edit_dialog.dart';

class ProfileScreen extends StatefulWidget {
  final Function(String) onProfilePictureChanged;

  const ProfileScreen({Key? key, required this.onProfilePictureChanged})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late UserProfile _userProfile;
  late TabController _tabController;

  // Dummy data for posts and connections
  final int _postsCount = 15;
  final int _followersCount = 1234;
  final int _followingCount = 890;

  final List<String> _posts = [
    "https://picsum.photos/200/200?random=1",
    "https://picsum.photos/200/200?random=2",
    "https://picsum.photos/200/200?random=3",
    "https://picsum.photos/200/200?random=4",
    "https://picsum.photos/200/200?random=5",
    "https://picsum.photos/200/200?random=6",
    "https://picsum.photos/200/200?random=7",
    "https://picsum.photos/200/200?random=8",
    "https://picsum.photos/200/200?random=9",
    // Add more dummy post images
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _userProfile = UserProfile(
      name: "Marco Polo",
      email: "marco.polo@example.com",
      phone: "123-456-7890",
      location: "San Francisco, CA",
      bio:
          "Experienced UI/UX Designer passionate about creating user-friendly interfaces.",
      profilePictureUrl: "https://randomuser.me/api/portraits/men/46.jpg",
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _editProfile(BuildContext context) async {
    final updatedProfile = await showDialog<UserProfile>(
      context: context,
      builder: (BuildContext context) {
        return ProfileEditDialog(userProfile: _userProfile);
      },
    );

    if (updatedProfile != null) {
      setState(() {
        _userProfile = updatedProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _userProfile.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () => _editProfile(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Info Row
                Row(
                  children: [
                    // Profile Picture
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(_userProfile.profilePictureUrl),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              final newProfilePictureUrl =
                                  await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text("Change Profile Picture"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: "Enter image URL",
                                          ),
                                          onChanged: (value) {
                                            _userProfile.profilePictureUrl = value;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Update"),
                                        onPressed: () {
                                          widget.onProfilePictureChanged(
                                              _userProfile.profilePictureUrl);
                                          setState(() {
                                          });
                                          Navigator.of(context)
                                              .pop(_userProfile.profilePictureUrl);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (newProfilePictureUrl != null) {
                                setState(() {
                                  _userProfile.profilePictureUrl =
                                      newProfilePictureUrl;
                                });
                                widget
                                    .onProfilePictureChanged(newProfilePictureUrl);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit,
                                  size: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    // Stats
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn('Posts', _postsCount),
                          _buildStatColumn('Followers', _followersCount),
                          _buildStatColumn('Following', _followingCount),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Bio Section
                Text(
                  _userProfile.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userProfile.bio,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  _userProfile.location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                // Edit Profile Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _editProfile(context),
                    child: const Text('Edit Profile'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tab Bar
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Grid View
                GridView.builder(
                  padding: const EdgeInsets.all(1),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      _posts[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
                // List View
                ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            _posts[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.favorite_border),
                                    SizedBox(width: 8),
                                    Icon(Icons.chat_bubble_outline),
                                    SizedBox(width: 8),
                                    Icon(Icons.send),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Posted on ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildStatColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
