import 'dart:developer';

import 'package:employee_manager/cubits/employee_cubit.dart';
import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/screens/add_edit_page.dart';
import 'package:employee_manager/ui/widgets/emp_list_item.dart';
import 'package:employee_manager/ui/widgets/emp_list_label.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              : ListView(
                  children: [
                    Visibility(
                      visible: currentEmployees.isNotEmpty,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const EmpListLabel(text: Strings.currentEmployees),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentEmployees.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(thickness: 1.0, height: 0.0),
                              itemBuilder: (contex, index) {
                                return EmpListItem(
                                    onDelete: () => context
                                        .read<EmployeeCubit>()
                                        .onDeleteEmployeee(
                                            scaffoldKey: _scaffoldKey,
                                            index: index,
                                            employee: currentEmployees[index]),
                                    employee: currentEmployees[index]);
                              }),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: previousEmployees.isNotEmpty,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const EmpListLabel(text: Strings.previousEmployees),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: previousEmployees.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(thickness: 1.0, height: 0.0),
                              itemBuilder: (context, index) => EmpListItem(
                                  onDelete: () => context
                                      .read<EmployeeCubit>()
                                      .onDeleteEmployeee(
                                          scaffoldKey: _scaffoldKey,
                                          index: index,
                                          employee: previousEmployees[index]),
                                  employee: previousEmployees[index]))
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Text(Strings.swipeLeft,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 15.0)))
                  ],
                );
        }),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddEditEmployeePage()));
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
