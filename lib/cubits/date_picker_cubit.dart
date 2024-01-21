import 'package:employee_manager/data/models/my_date_time_podo.dart';
import 'package:employee_manager/utils/extension.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerCubit extends Cubit<MyDateTime> {
  final bool isJoinDate;
  DatePickerCubit({required this.isJoinDate})
      : super(isJoinDate
            ? MyDateTime(
                date: null,
                dateString: DateTime.now().toEditFormat(),
                selectedShortcut: 0)
            : MyDateTime(
                date: null, dateString: Strings.noDate, selectedShortcut: 0));

  void onDateChangeManually({required DateTime date}) {
    DateTime currentDate = DateTime.now();
    var daysUntilMonday = (DateTime.monday - currentDate.weekday + 7) % 7;
    DateTime nextMonday = currentDate.add(Duration(days: daysUntilMonday));

    int daysUntilTuesday = (DateTime.tuesday - currentDate.weekday + 7) % 7;
    DateTime nextTuesday = currentDate.add(Duration(days: daysUntilTuesday));

    DateTime nextWeek = currentDate.add(const Duration(days: 7));

    int selectedShortcut = -1;
    if (isJoinDate) {
      if (compareOnlyDates(date, currentDate)) {
        selectedShortcut = 0;
      } else if (compareOnlyDates(date, nextMonday)) {
        selectedShortcut = 1;
      } else if (compareOnlyDates(date, nextTuesday)) {
        selectedShortcut = 2;
      } else if (compareOnlyDates(date, nextWeek)) {
        selectedShortcut = 3;
      }
    } else {
      if (compareOnlyDates(date, currentDate)) {
        selectedShortcut = 1;
      }
    }

    emit(MyDateTime(
        date: date,
        dateString: date.toEditFormat(),
        selectedShortcut: selectedShortcut));
  }

  void onDateChangeByShortcut({required int selectedShortcut}) {
    DateTime currentDate = DateTime.now();
    late MyDateTime myDateTime;
    if (isJoinDate) {
      switch (selectedShortcut) {
        case 0:
          myDateTime = MyDateTime(
              date: null,
              dateString: currentDate.toEditFormat(),
              selectedShortcut: 0);

          break;
        case 1:
          var daysUntilMonday = (DateTime.monday - currentDate.weekday + 7) % 7;
          DateTime nextMonday =
              currentDate.add(Duration(days: daysUntilMonday));
          myDateTime = MyDateTime(
              date: nextMonday,
              dateString: nextMonday.toEditFormat(),
              selectedShortcut: 1);

          break;
        case 2:
          int daysUntilTuesday =
              (DateTime.tuesday - currentDate.weekday + 7) % 7;
          DateTime nextTuesday =
              currentDate.add(Duration(days: daysUntilTuesday));
          myDateTime = MyDateTime(
              date: nextTuesday,
              dateString: nextTuesday.toEditFormat(),
              selectedShortcut: 2);
          break;
        case 3:
          DateTime nextWeek = currentDate.add(const Duration(days: 7));
          myDateTime = MyDateTime(
              date: nextWeek,
              dateString: nextWeek.toEditFormat(),
              selectedShortcut: 3);
          break;
      }
    } else {
      switch (selectedShortcut) {
        case 0:
          myDateTime = MyDateTime(
              date: null, dateString: Strings.noDate, selectedShortcut: 0);
          break;
        case 1:
          myDateTime = MyDateTime(
              date: currentDate,
              dateString: currentDate.toEditFormat(),
              selectedShortcut: 1);
          break;
      }
    }
    emit(myDateTime);
  }

  bool compareOnlyDates(DateTime date1, DateTime date2) {
    DateTime newDate1 = DateTime(date1.year, date1.month, date1.day);
    DateTime newDate2 = DateTime(date2.year, date2.month, date2.day);

    return newDate1.isAtSameMomentAs(newDate2);
  }
}
