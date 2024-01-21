import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmpListLabel extends StatelessWidget {
  final String text;
  const EmpListLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(text,
            style: GoogleFonts.roboto(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,fontSize: 16)));
  }
}
