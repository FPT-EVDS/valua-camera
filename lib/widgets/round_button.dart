import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final Color? labelColor;
  final Color? color;
  final VoidCallback? onPressed;
  final bool isLoading;

  const RoundButton({
    Key? key,
    this.color,
    this.width,
    this.height,
    this.label = '',
    this.labelColor,
    this.isLoading = false,
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
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : Text(
                label,
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
