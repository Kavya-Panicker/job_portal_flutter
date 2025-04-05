import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final DateTime time;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.time,
  });
}

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "New Jobs Available",
      subtitle: "5 new jobs match your profile",
      icon: Icons.work_outline,
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationItem(
      title: "New Follower",
      subtitle: "Sarah Wilson started following you",
      icon: Icons.person_add,
      time: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    NotificationItem(
      title: "Application Update",
      subtitle: "Google reviewed your application",
      icon: Icons.description,
      time: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      title: "New Follower",
      subtitle: "John Smith started following you",
      icon: Icons.person_add,
      time: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationItem(
      title: "New Jobs Available",
      subtitle: "3 new jobs in Backend Development",
      icon: Icons.work_outline,
      time: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    NotificationItem(
      title: "Profile Views",
      subtitle: "Your profile was viewed by 12 recruiters",
      icon: Icons.visibility,
      time: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(notification.icon, color: Colors.black),
              ),
              title: Text(
                notification.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                notification.subtitle,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getTimeAgo(notification.time),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
} 