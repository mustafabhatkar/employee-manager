class Strings {
  Strings._();

  //Titles
  static const appTitle = "Employee Manager";
  static const employeeList = "Employee List";
  static const addEmployee = "Add Employee Details";
  static const editEmployee = "Edit Employee Details";

  //Hints
  static const employeeName = "Employee name";
  static const selectRole = "Select role";
  static const swipeLeft = "Swipe left to delete";

  //Buttons
  static const cancel = "Cancel";
  static const save = "Save";
  static const delete = "Delete";
  static const undo = "Undo";

  //Date Picker
  static const today = "Today";
  static const noDate = "No date";
  static const nextMon = "Next Monday";
  static const nextTue = "Next Tuesday";
  static const afterWeek = "After 1 week";

  //Error
  static const mandatory = "Mandatory";
  static const errorJoinDate =
      "Invalid selection: Join date cannot be after the resign date";
  static const errorResignDate =
      "Invalid selection: Resign date cannot be before the join date";
  static const errorSameJoinResignDate =
      "Invalid selection: Jon date and resign date can't be same";

  //Success
  static const dataSaved = "Date saved successfully!";
  static const dataDeleted = "Employee data has been deleted";

  //Role sheet options
  static List roles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];

  //Employee list labels
  static const currentEmployees = "Current employees";
  static const previousEmployees = "Previous employees";
}
