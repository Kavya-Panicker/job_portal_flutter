import 'job.dart';

class Post {
  final String id;
  final String authorName;
  final String authorRole;
  final String authorImageUrl;
  final String content;
  final DateTime timestamp;
  final List<String> imageUrls;
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final bool isSaved;
  final Job? jobDetails; // null if it's a regular post
  final bool isJobPost;

  Post({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.authorImageUrl,
    required this.content,
    required this.timestamp,
    required this.imageUrls,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.isSaved = false,
    this.jobDetails,
    this.isJobPost = false,
  });
} 