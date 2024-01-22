import 'package:employee_manager/cubits/employee_cubit.dart';
import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/screens/add_edit_page.dart';

import 'package:employee_manager/ui/widgets/employee_list.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(title: const Text(Strings.employeeList), elevation: 0.0),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<EmployeeCubit, List<Employee>>(
            builder: (context, employees) {
          List<Employee> currentEmployees =
              context.read<EmployeeCubit>().currentEmployees;
          List<Employee> previousEmployees =
              context.read<EmployeeCubit>().previousEmployees;
        
          return employees.isEmpty
              ? Center(
                  child: SvgPicture.asset("assets/placeholders/no_data.svg"))
              : SlidableAutoCloseBehavior(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      EmployeeList(
                          title: Strings.currentEmployees,
                          employees: currentEmployees,
                          scaffoldKey: _scaffoldKey,
                          allEmployeesCount: currentEmployees.length +
                              previousEmployees.length),
                      EmployeeList(
                          title: Strings.previousEmployees,
                          employees: previousEmployees,
                          scaffoldKey: _scaffoldKey,
                          allEmployeesCount: currentEmployees.length +
                              previousEmployees.length),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Text(Strings.swipeLeft,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 15.0)))
                    ],
                  ),
                );
        }),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () async {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEditEmployeePage()))
                .then((result) {
              if (result != null &&
                  result is String &&
                  result == Strings.save) {
                _scaffoldKey.currentState?.showSnackBar(
                    const SnackBar(content: Text(Strings.dataSaved)));
              }
            });
          },
          tooltip: Strings.addEmployee,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
