import 'package:flutter/material.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({
    Key? key,
    required this.email,
    required this.name,
    required this.avatarUrl,
  }) : super(key: key);

  final String email;
  final String name;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(avatarUrl),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        Text(
          email,
          style: TextStyle(fontSize: 16, color: theme.colorScheme.onBackground)
        ),
        const SizedBox(height: 16),
        Divider(color: theme.colorScheme.onBackground, height: 2),
      ],
    );
  }
}
