import 'package:flutter/material.dart';

class ModalBottomSheetItem {
  String title;
  Color color;
  IconData iconData;
  Function() onTap;

  ModalBottomSheetItem({
    required this.title,
    required this.color,
    required this.iconData,
    required this.onTap,
  });
}
