import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/screens/add_edit_page.dart';
import 'package:employee_manager/ui/widgets/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class EmpListItem extends StatelessWidget {
  final Employee employee;

  const EmpListItem({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddEditEmployeePage(employee: employee))),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: (context) {},
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
                    employee.resignDate == null
                        ? "From ${employee.joinDate}"
                        : "${employee.joinDate} - ${employee.resignDate}",
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
