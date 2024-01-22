import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/utils/hive_constants.dart';
import 'package:hive/hive.dart';

class LocalDataSource {
  final _employeeDataBox = Hive.box(HiveConstants.employeeBox);

  void addData({required Employee employee, required bool isEditing}) {
    if (!isEditing) {
      _employeeDataBox.add(employee);
    } else {
      employee.save();
    }
  }

  void deleteData(Employee employee) {
    employee.delete();
  }

  List<Employee> getData() {
    return _employeeDataBox.toMap().values.toList().cast<Employee>();
  }
}
