class User {
  final String id;
  final String email;
  String name;
  String? role;
  String? company;
  String? location;
  String? bio;
  String? profileImageUrl;
  List<String> skills;
  String? education;
  String? experience;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.role,
    this.company,
    this.location,
    this.bio,
    this.profileImageUrl,
    List<String>? skills,
    this.education,
    this.experience,
  }) : skills = skills ?? [];

  // Create a copy of the user with updated fields
  User copyWith({
    String? name,
    String? role,
    String? company,
    String? location,
    String? bio,
    String? profileImageUrl,
    List<String>? skills,
    String? education,
    String? experience,
  }) {
    return User(
      id: id,
      email: email,
      name: name ?? this.name,
      role: role ?? this.role,
      company: company ?? this.company,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      skills: skills ?? this.skills,
      education: education ?? this.education,
      experience: experience ?? this.experience,
    );
  }
} 