class Employee {
  String name;
  String role;
  String joinDate;
  String? resignDate;

  Employee(
      {required this.name,
      required this.role,
      required this.joinDate,
      this.resignDate});
}
