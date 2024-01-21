import 'package:employee_manager/cubits/date_label_change_cubit.dart';
import 'package:employee_manager/ui/widgets/date_picker/shortcuts/shortcut_button.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinDateShortcuts extends StatefulWidget {
  const JoinDateShortcuts({super.key});

  @override
  State<JoinDateShortcuts> createState() => _JoinDateShortcutsState();
}

class _JoinDateShortcutsState extends State<JoinDateShortcuts> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          ShortCutButton(
            isSelected: selected == 0,
            onTap: () => changeDate(0),
            text: Strings.today,
          ),
          const SizedBox(width: 16.0),
          ShortCutButton(
            isSelected: selected == 1,
            onTap: () => changeDate(1),
            text: Strings.nextMon,
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Row(
        children: [
          ShortCutButton(
            isSelected: selected == 2,
            onTap: () => changeDate(2),
            text: Strings.nextTue,
          ),
          const SizedBox(width: 16.0),
          ShortCutButton(
            isSelected: selected == 3,
            onTap: () => changeDate(3),
            text: Strings.afterWeek,
          ),
        ],
      )
    ]);
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
