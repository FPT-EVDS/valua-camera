import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String? label;
  final Color? labelColor;
  final Color? color;
  final VoidCallback? onPressed;

  const RoundButton({
    Key? key,
    this.color,
    this.width,
    this.height,
    this.label,
    this.labelColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          label ?? '',
          style: TextStyle(
            color: labelColor ?? Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
