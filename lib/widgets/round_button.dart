import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final Color? labelColor;
  final Color? color;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;

  const RoundButton({
    Key? key,
    this.color,
    this.width,
    this.height,
    this.label = '',
    this.labelColor,
    this.isLoading = false,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  Widget renderButtonContent(isLoading) {
    return isLoading
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
          );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: icon!,
              label: renderButtonContent(isLoading),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: renderButtonContent(isLoading),
            ),
    );
  }
}
