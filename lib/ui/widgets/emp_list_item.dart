import 'package:employee_manager/cubits/employee_cubit.dart';
import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/screens/add_edit_page.dart';
import 'package:employee_manager/ui/widgets/custom_icons.dart';
import 'package:employee_manager/utils/extension.dart';
import 'package:employee_manager/utils/strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class EmpListItem extends StatelessWidget {
  final Employee employee;
  final int index;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final Function onDelete;
  const EmpListItem(
      {super.key,
      required this.employee,
      required this.onDelete,
      required this.index,
      required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddEditEmployeePage(employee: employee))).then((result) {
        if (result != null && result is String && result == Strings.delete) {
          context.read<EmployeeCubit>().onDeleteEmployeee(
              index: index, employee: employee, scaffoldKey: scaffoldKey);
        } else if (result != null &&
            result is String &&
            result == Strings.save) {
          scaffoldKey.currentState
              ?.showSnackBar(const SnackBar(content: Text(Strings.dataSaved)));
        }
      }),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: (context) => onDelete(),
              backgroundColor: const Color(0xFFF34642),
              foregroundColor: Colors.white,
              icon: CustomIcons.delete,
            ),
          ],
        ),
        child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(employee.name,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Theme.of(context).textTheme.titleMedium!.color)),
                const SizedBox(height: 6.0),
                Text(employee.role,
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 6.0),
                Text(
                    employee.resignDate.isEmpty
                        ? "From ${employee.joinDate.toDateTime().toDisplayFormat()}"
                        : "${employee.joinDate.toDateTime().toDisplayFormat()} - ${employee.resignDate.toDateTime().toDisplayFormat()}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12)),
              ],
            )),
      ),
    );
  }
}
