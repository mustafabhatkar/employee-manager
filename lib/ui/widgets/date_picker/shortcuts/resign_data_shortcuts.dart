import 'package:employee_manager/ui/widgets/date_picker/shortcuts/shortcut_button.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';

class ResignDateShortcuts extends StatefulWidget {
  final Function(int) onSelected;
  const ResignDateShortcuts({super.key, required this.onSelected});

  @override
  State<ResignDateShortcuts> createState() => _ResignDateShortcutsState();
}

class _ResignDateShortcutsState extends State<ResignDateShortcuts> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShortCutButton(
          isSelected: selected == 0,
          onTap: () {
            setState(() {
              selected = 0;
              widget.onSelected(0);
            });
          },
          text: Strings.noDate,
        ),
        const SizedBox(width: 16.0),
        ShortCutButton(
          isSelected: selected == 1,
          onTap: () {
            setState(() {
              selected = 1;
              widget.onSelected(1);
            });
          },
          text: Strings.today,
        ),
      ],
    );
  }
}
