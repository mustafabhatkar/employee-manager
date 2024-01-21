import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/screens/add_edit_page.dart';
import 'package:employee_manager/ui/widgets/emp_list_item.dart';
import 'package:employee_manager/ui/widgets/emp_list_label.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool tempIsDataAvailable = true;
  late Employee tempCurrentEmp;
  late Employee tempPreviousEmp;

  @override
  void initState() {
    tempCurrentEmp = Employee(
        name: "Samantha Lee",
        role: "Flutter Developer",
        joinDate: "21 Sept, 2022");
    tempPreviousEmp = Employee(
        name: "Jason Patel",
        role: "Flutter Developer",
        joinDate: "21 Sept, 2022",
        resignDate: "22 Jun, 2023");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.employeeList), elevation: 0.0),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: !tempIsDataAvailable
          ? Center(child: SvgPicture.asset("assets/placeholders/no_data.svg"))
          : ListView(
              children: [
                const EmpListLabel(text: Strings.currentEmployees),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1.0, height: 0.0),
                    itemBuilder: (context, index) =>
                        EmpListItem(employee: tempCurrentEmp)),
                const EmpListLabel(text: Strings.previousEmployees),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1.0, height: 0.0),
                    itemBuilder: (context, index) =>
                        EmpListItem(employee: tempPreviousEmp)),
              ],
            ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddEditEmployeePage())),
        tooltip: Strings.addEmployee,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
