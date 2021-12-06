import 'package:flutter/material.dart';

class AvatarWithTitle extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double radius;

  const AvatarWithTitle({
    Key? key,
    required this.imageUrl,
    this.title = '',
    this.subtitle = '',
    this.radius = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: radius,
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
