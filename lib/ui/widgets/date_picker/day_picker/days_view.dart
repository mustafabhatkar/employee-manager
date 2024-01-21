// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:employee_manager/ui/widgets/date_picker/picker_grid_delegate.dart';
import 'package:employee_manager/utils/extension.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

const double _dayPickerRowHeight = 42.0;

class DaysView extends StatelessWidget {
  DaysView({
    super.key,
    required this.currentDate,
    required this.onChanged,
    required this.minDate,
    required this.maxDate,
    this.selectedDate,
    required this.displayedMonth,
    required this.daysOfTheWeekTextStyle,
    required this.enabledCellsTextStyle,
    required this.enabledCellsDecoration,
    required this.disbaledCellsTextStyle,
    required this.disbaledCellsDecoration,
    required this.currentDateTextStyle,
    required this.currentDateDecoration,
    required this.selectedDayTextStyle,
    required this.selectedDayDecoration,
    required this.highlightColor,
    required this.splashColor,
    this.splashRadius,
  }) {
    assert(!minDate.isAfter(maxDate), "minDate can't be after maxDate");

    assert(() {
      if (selectedDate == null) return true;
      final min = DateTime(minDate.year, minDate.month, minDate.day);
      final max = DateTime(maxDate.year, maxDate.month, maxDate.day);
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

  final DateTime displayedMonth;

  final TextStyle daysOfTheWeekTextStyle;

  final TextStyle enabledCellsTextStyle;

  final BoxDecoration enabledCellsDecoration;

  final TextStyle disbaledCellsTextStyle;

  final BoxDecoration disbaledCellsDecoration;

  final TextStyle currentDateTextStyle;

  final BoxDecoration currentDateDecoration;

  final TextStyle selectedDayTextStyle;

  final BoxDecoration selectedDayDecoration;

  final Color splashColor;

  final Color highlightColor;

  final double? splashRadius;

  List<Widget> _dayHeaders(
    TextStyle headerStyle,
    Locale locale,
    MaterialLocalizations localizations,
  ) {
    final List<Widget> result = <Widget>[];
    final weekdayNames =
        intl.DateFormat('', locale.toString()).dateSymbols.SHORTWEEKDAYS;

    for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      // to save space in arabic as arabic don't has short week days.
      final String weekday = weekdayNames[i].replaceFirst('ال', '');
      result.add(
        ExcludeSemantics(
          child: Center(
            child: Text(
              weekday.toTitleCase(),
              style: daysOfTheWeekTextStyle,
            ),
          ),
        ),
      );
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) {
        break;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    //
    //
    //

    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int daysInMonth = DateUtils.getDaysInMonth(year, month);
    final int dayOffset = DateUtils.firstDayOffset(year, month, localizations);

    final _maxDate = DateUtils.dateOnly(maxDate);
    final _minDate = DateUtils.dateOnly(minDate);

    final List<Widget> dayItems = _dayHeaders(
      daysOfTheWeekTextStyle,
      Localizations.localeOf(context),
      MaterialLocalizations.of(context),
    );

    int day = -dayOffset;
    while (day < daysInMonth) {
      day++;
      if (day < 1) {
        dayItems.add(const SizedBox.shrink());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        final bool isDisabled =
            dayToBuild.isAfter(_maxDate) || dayToBuild.isBefore(_minDate);

        final bool isSelectedDay =
            DateUtils.isSameDay(selectedDate, dayToBuild);

        final bool isCurrent = DateUtils.isSameDay(currentDate, dayToBuild);
        //
        //
        BoxDecoration decoration = enabledCellsDecoration;
        TextStyle style = enabledCellsTextStyle;

        if (isCurrent) {
          //
          //
          style = currentDateTextStyle;
          decoration = currentDateDecoration;
        }

        if (isSelectedDay) {
          //
          //
          style = selectedDayTextStyle;
          decoration = selectedDayDecoration;
        }

        if (isDisabled) {
          style = disbaledCellsTextStyle;
          decoration = disbaledCellsDecoration;
        }

        if (isCurrent && isDisabled) {
          //
          //
          style = disbaledCellsTextStyle;
          decoration = currentDateDecoration;
        }

        Widget dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Text(
              localizations.formatDecimal(day),
              style: style,
            ),
          ),
        );

        if (isDisabled) {
          dayWidget = ExcludeSemantics(
            child: dayWidget,
          );
        } else {
          dayWidget = InkResponse(
            onTap: () => onChanged(dayToBuild),
            radius: splashRadius ?? _dayPickerRowHeight / 2 + 4,
            splashColor: splashColor,
            highlightColor: highlightColor,
            child: Semantics(
              // We want the day of month to be spoken first irrespective of the
              // locale-specific preferences or TextDirection. This is because
              // an accessibility user is more likely to be interested in the
              // day of month before the rest of the date, as they are looking
              // for the day of month. To do that we prepend day of month to the
              // formatted full date.
              label:
                  '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}',
              selected: isSelectedDay,
              excludeSemantics: true,
              child: dayWidget,
            ),
          );
        }

        dayItems.add(dayWidget);
      }
    }

    return Column(
      children: [
        GridView.custom(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const PickerGridDelegate(
            columnCount: DateTime.daysPerWeek,
            columnPadding: 4,
            rowPadding: 4,
            rowExtent: _dayPickerRowHeight,
            rowStride: _dayPickerRowHeight,
          ),
          childrenDelegate: SliverChildListDelegate(
            addRepaintBoundaries: false,
            dayItems,
          ),
        ),
      ],
    );
  }
}
