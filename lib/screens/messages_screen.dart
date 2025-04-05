// lib/screens/messages_screen.dart
import 'package:flutter/material.dart';
import '../models/message.dart';
import '../widgets/message_card.dart';
import 'message_detail_screen.dart';

class MessagesScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
      senderName: "John Doe",
      messageText: "Hello! How is your application going?",
      time: "10:30 AM",
      profileImage: "https://randomuser.me/api/portraits/men/1.jpg",
    ),
    Message(
      senderName: "Jane Smith",
      messageText: "We would like to schedule an interview with you.",
      time: "Yesterday",
      profileImage: "https://randomuser.me/api/portraits/women/2.jpg",
    ),
    Message(
      senderName: "Mike Johnson",
      messageText: "Thank you for your interest in our company.",
      time: "2 days ago",
      profileImage: "https://randomuser.me/api/portraits/men/3.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageCard(
            message: messages[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MessageDetailScreen(message: messages[index]),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
