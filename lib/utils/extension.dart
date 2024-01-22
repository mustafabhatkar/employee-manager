import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  DateTime toDateTime() => DateFormat('d MMM yyyy').parse(this);
}

extension FormatDateExtension on DateTime {
  String toEditFormat() => DateFormat('d MMM yyyy').format(this);
  String toDisplayFormat() => DateFormat('d MMM, yyyy').format(this);

  bool compareOnlyDateTo(DateTime date2) {
    DateTime newDate1 = DateTime(year, month, day);
    DateTime newDate2 = DateTime(date2.year, date2.month, date2.day);
    return newDate1.isAtSameMomentAs(newDate2);
  }
}
