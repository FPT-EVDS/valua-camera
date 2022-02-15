import 'package:flutter/material.dart';

class ViolatorListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int position;
  const ViolatorListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://picsum.photos/200?image=${position + 30}'),
          )
        ],
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      trailing: Text('Pos: ' + position.toString()),
    );
  }
}
