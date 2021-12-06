import 'package:flutter/material.dart';

class RichTextItem extends StatelessWidget {
  final String title;
  final String content;
  final double fontSize;

  const RichTextItem({
    Key? key,
    required this.title,
    required this.content,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: DefaultTextStyle.of(context).style.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
        children: <TextSpan>[
          TextSpan(
            text: content,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
