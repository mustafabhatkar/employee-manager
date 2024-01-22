
import 'package:employee_manager/data/models/my_date_time_podo.dart';
import 'package:employee_manager/utils/extension.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerCubit extends Cubit<MyDateTime> {
  final bool isJoinDate;
  final DateTime? joinDate;
  final DateTime? resignDate;
  DatePickerCubit(
      {required this.joinDate,
      required this.resignDate,
      required this.isJoinDate})
      : super(isJoinDate
            ? MyDateTime(
                isValid: true,
                date: DateTime.now(),
                dateString: DateTime.now().toEditFormat(),
                selectedShortcut: 0,
              )
            : MyDateTime(
                isValid: true,
                date: null,
                dateString: Strings.noDate,
                selectedShortcut: 0,
              ));

  void onDateChangeManually({required DateTime date}) {
    DateTime currentDate = DateTime.now();
    var daysUntilMonday = (DateTime.monday - currentDate.weekday + 7) % 7;

    DateTime nextMonday = currentDate
        .add(Duration(days: daysUntilMonday == 0 ? 7 : daysUntilMonday));

    int daysUntilTuesday = (DateTime.tuesday - currentDate.weekday + 7) % 7;
    DateTime nextTuesday = currentDate
        .add(Duration(days: daysUntilTuesday == 0 ? 7 : daysUntilTuesday));

    DateTime nextWeek = currentDate.add(const Duration(days: 7));

    int selectedShortcut = -1;
    if (isJoinDate) {
      if (date.isSameDateAs(currentDate)) {
        selectedShortcut = 0;
      } else if (date.isSameDateAs(nextMonday)) {
        selectedShortcut = 1;
      } else if (date.isSameDateAs(nextTuesday)) {
        selectedShortcut = 2;
      } else if (date.isSameDateAs(nextWeek)) {
        selectedShortcut = 3;
      }
    } else {
      if (date.isSameDateAs(currentDate)) {
        selectedShortcut = 1;
      }
    }

    emit(MyDateTime(
        date: date,
        isValid: validateDate(date),
        dateString: date.toEditFormat(),
        selectedShortcut: selectedShortcut,
        errorMessage: validationErrorMessage(date)));
  }

  bool validateDate(DateTime selectedDate) {
    if (isJoinDate && resignDate != null) {
      if (selectedDate.isAfter(resignDate!)) {
        return false;
      } else if (selectedDate.isSameDateAs(resignDate!)) {
        return false;
      }
    } else if (!isJoinDate) {
      if (selectedDate.isBefore(joinDate!)) {
        return false;
      } else if (selectedDate.isSameDateAs(joinDate!)) {
        return false;
      }
    }
    return true;
  }

  String validationErrorMessage(DateTime selectedDate) {
    if (isJoinDate && resignDate != null) {
      if (selectedDate.isAfter(resignDate!)) {
        return Strings.errorJoinDate;
      } else if (selectedDate.isSameDateAs(resignDate!)) {
        return Strings.errorSameJoinResignDate;
      }
    } else if (!isJoinDate) {
      if (selectedDate.isBefore(joinDate!)) {
        return Strings.errorResignDate;
      } else if (selectedDate.isSameDateAs(joinDate!)) {
        return Strings.errorSameJoinResignDate;
      }
    }
    return "";
  }

  void onDateChangeByShortcut({required int selectedShortcut}) {
    DateTime currentDate = DateTime.now();
    late MyDateTime myDateTime;
    if (isJoinDate) {
      switch (selectedShortcut) {
        case 0:
          myDateTime = MyDateTime(
              date: null,
              errorMessage: validationErrorMessage(currentDate),
              isValid: validateDate(currentDate),
              dateString: currentDate.toEditFormat(),
              selectedShortcut: 0);

          break;
        case 1:
          var daysUntilMonday = (DateTime.monday - currentDate.weekday + 7) % 7;
          DateTime nextMonday = currentDate
              .add(Duration(days: daysUntilMonday == 0 ? 7 : daysUntilMonday));
          myDateTime = MyDateTime(
              date: nextMonday,
              errorMessage: validationErrorMessage(nextMonday),
              isValid: validateDate(nextMonday),
              dateString: nextMonday.toEditFormat(),
              selectedShortcut: 1);

          break;
        case 2:
          int daysUntilTuesday =
              (DateTime.tuesday - currentDate.weekday + 7) % 7;
          DateTime nextTuesday = currentDate.add(
              Duration(days: daysUntilTuesday == 0 ? 7 : daysUntilTuesday));
          myDateTime = MyDateTime(
              date: nextTuesday,
              errorMessage: validationErrorMessage(nextTuesday),
              isValid: validateDate(nextTuesday),
              dateString: nextTuesday.toEditFormat(),
              selectedShortcut: 2);
          break;
        case 3:
          DateTime nextWeek = currentDate.add(const Duration(days: 7));
          myDateTime = MyDateTime(
              date: nextWeek,
              errorMessage: validationErrorMessage(nextWeek),
              isValid: validateDate(nextWeek),
              dateString: nextWeek.toEditFormat(),
              selectedShortcut: 3);
          break;
      }
    } else {
      switch (selectedShortcut) {
        case 0:
          myDateTime = MyDateTime(
              isValid: true,
              date: null,
              dateString: Strings.noDate,
              selectedShortcut: 0);
          break;
        case 1:
          myDateTime = MyDateTime(
              isValid: validateDate(currentDate),
              date: currentDate,
              errorMessage: validationErrorMessage(currentDate),
              dateString: currentDate.toEditFormat(),
              selectedShortcut: 1);
          break;
      }
    }
    emit(myDateTime);
  }
}
