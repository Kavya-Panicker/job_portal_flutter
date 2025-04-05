import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final Function(String) onLike;
  final Function(String) onComment;
  final Function(String) onShare;
  final Function(String) onSave;
  final Function()? onTap;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onSave,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author info
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.authorImageUrl),
            ),
            title: Text(
              post.authorName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.authorRole),
                Text(
                  DateFormat('MMM d').format(post.timestamp),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),

          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(post.content),
          ),

          // Job details if it's a job post
          if (post.isJobPost && post.jobDetails != null)
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.jobDetails!.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${post.jobDetails!.company} • ${post.jobDetails!.location}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.jobDetails!.salary,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        label: Text(post.jobDetails!.time),
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(post.jobDetails!.level),
                        backgroundColor: Colors.grey[200],
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Images
          if (post.imageUrls.isNotEmpty)
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: PageView.builder(
                itemCount: post.imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    post.imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

          // Engagement stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  '${post.likes} likes',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 8),
                Text(
                  '${post.comments} comments',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 8),
                Text(
                  '${post.shares} shares',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          const Divider(),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: post.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                label: 'Like',
                color: post.isLiked ? Colors.blue : Colors.grey[600]!,
                onPressed: () => onLike(post.id),
              ),
              _ActionButton(
                icon: Icons.comment_outlined,
                label: 'Comment',
                color: Colors.grey[600]!,
                onPressed: () => onComment(post.id),
              ),
              _ActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                color: Colors.grey[600]!,
                onPressed: () => onShare(post.id),
              ),
              _ActionButton(
                icon: post.isSaved ? Icons.bookmark : Icons.bookmark_outline,
                label: 'Save',
                color: post.isSaved ? Colors.black : Colors.grey[600]!,
                onPressed: () => onSave(post.id),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 