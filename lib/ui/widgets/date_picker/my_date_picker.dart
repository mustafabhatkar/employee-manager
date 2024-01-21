import 'package:employee_manager/cubits/date_picker_cubit.dart';
import 'package:employee_manager/data/models/my_date_time_podo.dart';
import 'package:employee_manager/ui/widgets/custom_icons.dart';
import 'package:employee_manager/ui/widgets/date_picker/my_calendar.dart';
import 'package:employee_manager/ui/widgets/date_picker/shortcuts/join_date_shortcuts.dart';
import 'package:employee_manager/ui/widgets/date_picker/shortcuts/resign_data_shortcuts.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDatePicker extends StatefulWidget {
  final bool isJoinDate;
  final Function(DateTime) onDateSelected;
  const MyDatePicker(
      {super.key, this.isJoinDate = true, required this.onDateSelected});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 24.0, left: 16.0, right: 16.0, bottom: 0.0),
            child: Column(
              children: [
                widget.isJoinDate
                    ? const JoinDateShortcuts()
                    : const ResignDateShortcuts(),
                const SizedBox(height: 25.0),
                BlocBuilder<DatePickerCubit, MyDateTime>(
                    builder: (context, myDate) {
                  return MyCalendar(
                    selectedDate: myDate.date,
                    padding: EdgeInsets.zero,
                    currentDateDecoration: myDate.dateString == Strings.noDate
                        ? const BoxDecoration()
                        : null,
                    minDate: DateTime(2000, 1, 1),
                    maxDate: DateTime.now().add(const Duration(days: 182)),
                    slidersColor: const Color(0xff949C9E),
                    slidersSize: 45,
                    disbaledCellsTextStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            fontSize: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.30)),
                    currentDateTextStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.secondary),
                    enabledCellsTextStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15),
                    selectedCellTextStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15, color: Colors.white),
                    leadingDateTextStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Theme.of(context).textTheme.titleMedium!.color),
                    daysOfTheWeekTextStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15),
                    onDateSelected: (date) {
                      currentDate = date;
                      context
                          .read<DatePickerCubit>()
                          .onDateChangeManually(date: date);
                    },
                  );
                })
              ],
            ),
          ),
          const Divider(thickness: 2.0, height: 0.0),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(CustomIcons.calendar),
                const SizedBox(width: 12.0),
                BlocBuilder<DatePickerCubit, MyDateTime>(
                    builder: (context, myDate) {
                  return Text(myDate.dateString,
                      style: Theme.of(context).textTheme.titleMedium);
                }),
                const Spacer(),
                SizedBox(
                  width: 74,
                  height: 40,
                  child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(Strings.cancel)),
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                    width: 74,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onDateSelected(currentDate);
                        },
                        child: const Text(Strings.save))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
