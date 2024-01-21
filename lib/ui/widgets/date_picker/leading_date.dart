import 'package:flutter/material.dart';

class LeadingDate extends StatelessWidget {
  const LeadingDate({
    Key? key,
    required this.displayedText,
    required this.onTap,
    required this.displayedTextStyle,
  }) : super(key: key);

  final String displayedText;

  final TextStyle displayedTextStyle;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        displayedText,
        style: displayedTextStyle,
      ),
    );
  }
}
