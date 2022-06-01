import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp_test/components/constants.dart';


class AlternativeWayText extends StatelessWidget {
  const AlternativeWayText({
    Key? key,
    required this.text,
    required this.highlightText,
    this.fontSize = kFontSize + 1,
    this.color = Colors.grey,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String highlightText;
  final double fontSize;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: ' ' + highlightText,
            style: TextStyle(
              color: Colors.blue,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
