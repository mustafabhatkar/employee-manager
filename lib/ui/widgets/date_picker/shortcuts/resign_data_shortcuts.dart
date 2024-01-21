import 'package:employee_manager/cubits/date_picker_cubit.dart';
import 'package:employee_manager/data/models/my_date_time_podo.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerCubit, MyDateTime>(builder: (context, myDate) {
      return Row(
        children: [
          ShortCutButton(
            isSelected: myDate.selectedShortcut == 0,
            onTap: () => changeDate(0),
            text: Strings.noDate,
          ),
          const SizedBox(width: 16.0),
          ShortCutButton(
            isSelected: myDate.selectedShortcut == 1,
            onTap: () => changeDate(1),
            text: Strings.today,
          ),
        ],
      );
    });
  }

  changeDate(int index) {
    context
        .read<DatePickerCubit>()
        .onDateChangeByShortcut(selectedShortcut: index);
  }
}
