import 'package:employee_manager/data/data_sources/local_data_source.dart';
import 'package:employee_manager/data/models/employee_podo.dart';

class Repository {
  final dataSource = LocalDataSource();

  void addEmployee({required Employee employee, required bool isEditing}) {
    dataSource.addData(employee: employee, isEditing: isEditing);
  }

  List<Employee> getAllEmployees() {
    return dataSource.getData();
  }

  List<Employee> getCurrentEmployees() {
    List<Employee> currentEmployees = [];
    List<Employee> allEmployees = getAllEmployees();
    for (Employee employee in allEmployees) {
      if (employee.resignDate.isEmpty) {
        currentEmployees.add(employee);
      }
    }
    return currentEmployees;
  }

  List<Employee> getPreviousEmployees() {
    List<Employee> previousEmployees = [];
    List<Employee> allEmployees = getAllEmployees();
    for (Employee employee in allEmployees) {
      if (employee.resignDate.isNotEmpty) {
        previousEmployees.add(employee);
      }
    }
    return previousEmployees;
  }

  void deleteEmployee(Employee employee) {
    dataSource.deleteData(employee);
  }
}
