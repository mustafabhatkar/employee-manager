import 'package:employee_manager/cubits/date_label_change_cubit.dart';
import 'package:employee_manager/ui/widgets/date_picker/shortcuts/shortcut_button.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResignDateShortcuts extends StatefulWidget {
  const ResignDateShortcuts({super.key});

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
          onTap: () => changeDate(0),
          text: Strings.noDate,
        ),
        const SizedBox(width: 16.0),
        ShortCutButton(
          isSelected: selected == 1,
          onTap: () => changeDate(1),
          text: Strings.today,
        ),
      ],
    );
  }

  changeDate(int index) {
    setState(() {
      selected = index;
    });
    context
        .read<DateLabelChangeCubit>()
        .onDateChangeByShortcut(selectedShortcut: index);
  }
}
