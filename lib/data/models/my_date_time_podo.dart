class MyDateTime {
  DateTime? date;
  String dateString;
  int selectedShortcut;
  bool isValid;
  String errorMessage;
  MyDateTime(
      {required this.date,
      required this.dateString,
      required this.selectedShortcut,
      required this.isValid,
      this.errorMessage = ""});
}
