import 'package:employee_manager/ui/widgets/date_picker/leading_date.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.displayedDate,
    required this.onDateTap,
    required this.onNextPage,
    required this.onPreviousPage,
    required this.slidersColor,
    required this.slidersSize,
    required this.leadingDateTextStyle,
  });

  final String displayedDate;

  final TextStyle leadingDateTextStyle;

  final VoidCallback onDateTap;

  final VoidCallback onNextPage;

  final VoidCallback onPreviousPage;

  final Color slidersColor;

  final double slidersSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPreviousPage,
          child: Icon(
            Icons.arrow_left_rounded,
            size: slidersSize,
            color: slidersColor,
          ),
        ),
        LeadingDate(
          onTap: onDateTap,
          displayedText: displayedDate,
          displayedTextStyle: leadingDateTextStyle,
        ),
        GestureDetector(
          onTap: onNextPage,
          child: Icon(
            Icons.arrow_right_rounded,
            size: slidersSize,
            color: slidersColor,
          ),
        ),
      ],
    );
  }
}
