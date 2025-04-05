// lib/models/message.dart
class Message {
  String senderName;
  String messageText;
  String time;
  String profileImage;
  Message? replyTo; // Message being replied to
  String? replyToText; // Preview text of the message being replied to

  Message({
    required this.senderName,
    required this.messageText,
    required this.time,
    required this.profileImage,
    this.replyTo,
    this.replyToText,
  });
}
