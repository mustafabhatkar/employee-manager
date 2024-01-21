import 'package:employee_manager/cubits/date_picker_cubit.dart';
import 'package:employee_manager/data/models/my_date_time_podo.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerCubit, MyDateTime>(builder: (context, myDate) {
      return Column(children: [
        Row(
          children: [
            ShortCutButton(
              isSelected: myDate.selectedShortcut == 0,
              onTap: () => changeDate(0),
              text: Strings.today,
            ),
            const SizedBox(width: 16.0),
            ShortCutButton(
              isSelected: myDate.selectedShortcut == 1,
              onTap: () => changeDate(1),
              text: Strings.nextMon,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            ShortCutButton(
              isSelected: myDate.selectedShortcut == 2,
              onTap: () => changeDate(2),
              text: Strings.nextTue,
            ),
            const SizedBox(width: 16.0),
            ShortCutButton(
              isSelected: myDate.selectedShortcut == 3,
              onTap: () => changeDate(3),
              text: Strings.afterWeek,
            ),
          ],
        )
      ]);
    });
  }

  changeDate(int index) {
    context
        .read<DatePickerCubit>()
        .onDateChangeByShortcut(selectedShortcut: index);
  }
}
