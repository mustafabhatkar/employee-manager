import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension FormatDateExtension on DateTime {
  String toEditFormat() => DateFormat('d MMM yyyy').format(this);
  String toDisplayFormat() => DateFormat('d MMM, yyyy').format(this);
}
