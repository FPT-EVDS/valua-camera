import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int leadingNumber;
  final bool attended;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.leadingNumber,
    required this.attended,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(leadingNumber.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(width: 20),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://picsum.photos/200?image=${leadingNumber + 30}'),
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
        trailing: attended
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              ));
  }
}
