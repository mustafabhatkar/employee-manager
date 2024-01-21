import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortCutButton extends StatefulWidget {
  final bool isSelected;

  final Function onTap;
  final String text;
  const ShortCutButton(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.text});

  @override
  State<ShortCutButton> createState() => _ShortCutButtonState();
}

class _ShortCutButtonState extends State<ShortCutButton> {
  late ButtonStyle myButtonStyle;
  @override
  void initState() {
    myButtonStyle = ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
            GoogleFonts.roboto(fontSize: 14.0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)))),
        elevation: MaterialStateProperty.all<double>(0.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSelected
        ? Expanded(
          child: ElevatedButton(
              style: myButtonStyle,
              onPressed: () => widget.onTap(),
              child: Text(widget.text)),
        )
        : Expanded(
          child: TextButton(
              style: myButtonStyle,
              onPressed: () => widget.onTap(),
              child: Text(widget.text)),
        );
  }
}
