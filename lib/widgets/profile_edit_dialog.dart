// lib/widgets/profile_edit_dialog.dart
import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ProfileEditDialog extends StatefulWidget {
  final UserProfile userProfile;

  const ProfileEditDialog({Key? key, required this.userProfile})
      : super(key: key);

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _phoneController = TextEditingController(text: widget.userProfile.phone);
    _locationController =
        TextEditingController(text: widget.userProfile.location);
    _bioController = TextEditingController(text: widget.userProfile.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Profile"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: "Bio"),
              maxLines: 3,
            ),
          ],
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
          child: const Text("Save"),
          onPressed: () {
            final updatedProfile = UserProfile(
              name: _nameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              location: _locationController.text,
              bio: _bioController.text,
              profilePictureUrl: widget.userProfile.profilePictureUrl,
            );
            Navigator.of(context).pop(updatedProfile);
          },
        ),
      ],
    );
  }
}
