import 'package:flutter/material.dart';

class AvatarProfile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AvatarProfile({
    required this.email,
    required this.name,
    required this.avatarUrl,
  });

  final String email;
  final String name;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(avatarUrl),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: textTheme.headline6,
        ),
        const SizedBox(height: 8),
        Text(
          email,
          style: textTheme.subtitle1!.copyWith(color: colorScheme.onBackground),
        ),
        const SizedBox(height: 16),
        Divider(color: theme.colorScheme.onBackground, height: 2),
      ],
    );
  }
}
