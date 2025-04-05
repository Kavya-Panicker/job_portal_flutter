// lib/models/user_profile.dart
class UserProfile {
  String name;
  String email;
  String phone;
  String location;
  String bio;
  String profilePictureUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.bio,
    required this.profilePictureUrl,
  });
}
