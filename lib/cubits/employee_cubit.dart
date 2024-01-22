import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/data/repositories/data_repository.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeCubit extends Cubit<List<Employee>> {
  final Repository repository;
  List<Employee> currentEmployees = [];
  List<Employee> previousEmployees = [];
  List<Employee> allEmployees = [];

  EmployeeCubit(this.repository) : super(repository.getAllEmployees()) {
    currentEmployees = repository.getCurrentEmployees();
    previousEmployees = repository.getPreviousEmployees();
  }

  void refreshData() {
    currentEmployees = repository.getCurrentEmployees();
    previousEmployees = repository.getPreviousEmployees();

    emit(repository.getAllEmployees());
  }

  void addEmployee({required Employee employee, required bool isEditing}) {
    repository.addEmployee(employee: employee, isEditing: isEditing);
    emit(repository.getAllEmployees());
  }

  void onDeleteEmployeee(
      {required int index,
      required Employee employee,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey}) async {
    scaffoldKey.currentState?.hideCurrentSnackBar();
    bool isUndo = false;
    removeEmployee(
        index: index, isCurrentEmployee: employee.resignDate.isEmpty);

    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: const Text(Strings.dataDeleted),
      action: SnackBarAction(
          label: Strings.undo,
          onPressed: () {
            isUndo = true;
            scaffoldKey.currentState?.hideCurrentSnackBar();
            refreshData();
          }),
    ));
    Future.delayed(const Duration(seconds: 4)).then((_) {
      if (!isUndo) {
        deleteEmployee(employee);
      }
    });
  }

  void removeEmployee({required int index, required bool isCurrentEmployee}) {
    if (isCurrentEmployee) {
      currentEmployees.removeAt(index);
    } else {
      previousEmployees.removeAt(index);
    }
    emit(currentEmployees + previousEmployees);
  }

  void deleteEmployee(Employee employee) {
    repository.deleteEmployee(employee);
  }
}
