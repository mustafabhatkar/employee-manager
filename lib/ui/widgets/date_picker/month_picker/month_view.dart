import 'package:employee_manager/ui/widgets/date_picker/picker_grid_delegate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthView extends StatelessWidget {
  MonthView({
    super.key,
    required this.currentDate,
    this.selectedDate,
    required this.displayedDate,
    required this.onChanged,
    required this.minDate,
    required this.maxDate,
    required this.enabledCellsTextStyle,
    required this.enabledCellsDecoration,
    required this.disbaledCellsTextStyle,
    required this.disbaledCellsDecoration,
    required this.currentDateTextStyle,
    required this.currentDateDecoration,
    required this.selectedCellTextStyle,
    required this.selectedCellDecoration,
    required this.highlightColor,
    required this.splashColor,
    this.splashRadius,
  }) {
    assert(!minDate.isAfter(maxDate), "minDate can't be after maxDate");
    assert(() {
      if (selectedDate == null) return true;
      final max = DateTime(maxDate.year, maxDate.month);
      final min = DateTime(minDate.year, minDate.month);
      final selected = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      );

      return (selected.isAfter(min) || selected.isAtSameMomentAs(min)) &&
          (selected.isBefore(max) || selected.isAtSameMomentAs(max));
    }(), "selected date should be in the range of min date & max date");
  }

  final DateTime? selectedDate;

  final DateTime currentDate;

  final ValueChanged<DateTime> onChanged;

  final DateTime minDate;

  final DateTime maxDate;

  final DateTime displayedDate;

  final TextStyle enabledCellsTextStyle;

  final BoxDecoration enabledCellsDecoration;

  final TextStyle disbaledCellsTextStyle;

  final BoxDecoration disbaledCellsDecoration;

  final TextStyle currentDateTextStyle;

  final BoxDecoration currentDateDecoration;

  final TextStyle selectedCellTextStyle;

  final BoxDecoration selectedCellDecoration;

  final Color splashColor;

  final Color highlightColor;

  final double? splashRadius;

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final locale = Localizations.localeOf(context);

    final int year = displayedDate.year;
    // we get rid of the day because if there is any day allowed in
    // in the month we should not gray it out.
    final DateTime startMonth = DateTime(minDate.year, minDate.month);
    final DateTime endMonth = DateTime(maxDate.year, maxDate.month);
    DateTime? selectedMonth;

    if (selectedDate != null) {
      selectedMonth = DateTime(selectedDate!.year, selectedDate!.month);
    }

    final monthsNames =
        DateFormat('', locale.toString()).dateSymbols.STANDALONESHORTMONTHS;
    final monthsWidgetList = <Widget>[];

    int month = 0;
    while (month < 12) {
      final DateTime monthToBuild = DateTime(year, month + 1);

      final bool isDisabled =
          monthToBuild.isAfter(endMonth) || monthToBuild.isBefore(startMonth);

      final bool isCurrentMonth =
          monthToBuild == DateTime(currentDate.year, currentDate.month);

      final bool isSelected = monthToBuild == selectedMonth;
      //
      //
      BoxDecoration decoration = enabledCellsDecoration;
      TextStyle style = enabledCellsTextStyle;

      if (isCurrentMonth) {
        //
        //
        style = currentDateTextStyle;
        decoration = currentDateDecoration;
      }
      if (isSelected) {
        //
        //
        style = selectedCellTextStyle;
        decoration = selectedCellDecoration;
      }

      if (isDisabled) {
        style = disbaledCellsTextStyle;
        decoration = disbaledCellsDecoration;
      }

      Widget monthWidget = Container(
        decoration: decoration,
        child: Center(
          child: Text(
            monthsNames[month],
            style: style,
          ),
        ),
      );

      if (isDisabled) {
        monthWidget = ExcludeSemantics(
          child: monthWidget,
        );
      } else {
        monthWidget = InkResponse(
          onTap: () => onChanged(monthToBuild),
          radius: splashRadius ?? 60 / 2 + 4,
          splashColor: splashColor,
          highlightColor: highlightColor,
          child: Semantics(
            label: localizations.formatMediumDate(monthToBuild),
            selected: isSelected,
            excludeSemantics: true,
            child: monthWidget,
          ),
        );
      }

      monthsWidgetList.add(monthWidget);
      month++;
    }

    return GridView.custom(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const PickerGridDelegate(
        columnCount: 3,
        rowPadding: 3,
        rowExtent: 60,
        rowStride: 80,
      ),
      childrenDelegate: SliverChildListDelegate(
        monthsWidgetList,
        addRepaintBoundaries: false,
      ),
    );
  }
}
