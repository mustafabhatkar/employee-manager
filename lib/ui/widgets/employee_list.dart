import 'package:employee_manager/cubits/employee_cubit.dart';
import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/widgets/emp_list_item.dart';
import 'package:employee_manager/ui/widgets/emp_list_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeList extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final List<Employee> employees;
  final int allEmployeesCount;

  const EmployeeList(
      {super.key,
      required this.title,
      required this.employees,
      required this.allEmployeesCount,
      required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: employees.isNotEmpty,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmpListLabel(text: title),
          Container(
            color: allEmployeesCount > 5 ? Colors.white : null,
            height: allEmployeesCount > 5
                ? MediaQuery.of(context).size.height * 0.33
                : null,
            child: Scrollbar(
              child: ListView.separated(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: employees.length,
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 1.0, height: 0.0),
                  itemBuilder: (contex, index) {
                    return EmpListItem(
                      index: index,
                      onDelete: () => context
                          .read<EmployeeCubit>()
                          .onDeleteEmployeee(
                              scaffoldKey: scaffoldKey,
                              index: index,
                              employee: employees[index]),
                      employee: employees[index],
                      scaffoldKey: scaffoldKey,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
