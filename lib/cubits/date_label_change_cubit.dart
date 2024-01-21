import 'package:employee_manager/utils/extension.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateLabelChangeCubit extends Cubit<String> {
  final bool isJoinDate;
  DateLabelChangeCubit({required this.isJoinDate})
      : super(isJoinDate ? DateTime.now().toEditFormat() : Strings.noDate);

  void onDateChangeManually({required DateTime date}) {
    emit(date.toEditFormat());
  }

  void onDateChangeByShortcut({required int selectedShortcut}) {
    DateTime currentDate = DateTime.now();
    if (isJoinDate) {
      switch (selectedShortcut) {
        case 0:
          emit(currentDate.toEditFormat());
          break;
        case 1:
          var daysUntilMonday = (DateTime.monday - currentDate.weekday + 7) % 7;
          DateTime nextMonday =
              currentDate.add(Duration(days: daysUntilMonday));

          emit(nextMonday.toEditFormat());
          break;
        case 2:
          int daysUntilTuesday =
              (DateTime.tuesday - currentDate.weekday + 7) % 7;

          DateTime nextTuesday =
              currentDate.add(Duration(days: daysUntilTuesday));
          emit(nextTuesday.toEditFormat());
          break;
        case 3:
          DateTime nextWeek = currentDate.add(const Duration(days: 7));
          emit(nextWeek.toEditFormat());
          break;
      }
    } else {
      switch (selectedShortcut) {
        case 0:
          emit(Strings.noDate);
          break;
        case 1:
          emit(DateTime.now().toEditFormat());
          break;
      }
    }
  }
}
