import 'package:employee_manager/cubits/date_picker_cubit.dart';
import 'package:employee_manager/cubits/employee_cubit.dart';
import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/widgets/custom_icons.dart';
import 'package:employee_manager/ui/widgets/date_picker/my_date_picker.dart';
import 'package:employee_manager/ui/widgets/roles_list.dart';

import 'package:employee_manager/utils/extension.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:employee_manager/utils/title_case_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditEmployeePage extends StatefulWidget {
  final Employee? employee;
  const AddEditEmployeePage({super.key, this.employee});

  @override
  State<AddEditEmployeePage> createState() => _AddEditEmployeePageState();
}

class _AddEditEmployeePageState extends State<AddEditEmployeePage> {
  final _saveformKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final roleTextController = TextEditingController();
  final joinDateController = TextEditingController();
  final resignDateController = TextEditingController();
  bool isEditing = false;
  late Employee employee;

  @override
  void initState() {
    isEditing = widget.employee != null;
    joinDateController.text = Strings.today;
    if (isEditing) {
      employee = widget.employee!;
      nameTextController.text = employee.name;
      roleTextController.text = employee.role;
      joinDateController.text = employee.joinDate;
      if (widget.employee!.resignDate.isNotEmpty) {
        resignDateController.text = employee.resignDate;
      }
    } else {
      employee = Employee(name: "", role: "", joinDate: "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? Strings.editEmployee : Strings.addEmployee),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          Visibility(
            visible: isEditing,
            child: IconButton(
                onPressed: () {}, icon: const Icon(CustomIcons.delete)),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _saveformKey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(children: [
                SizedBox(
                  height: 60,
                  child: TextFormField(
                      controller: nameTextController,
                      autofocus: !isEditing,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        TitleCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      ],
                      onSaved: (value) => employee.name = value!,
                      validator: (value) =>
                          value!.isEmpty ? Strings.mandatory : null,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_sharp),
                          hintText: Strings.employeeName)),
                ),
                const SizedBox(height: 14.0),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                      controller: roleTextController,
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value) => employee.role = value!,
                      validator: (value) =>
                          value!.isEmpty ? Strings.mandatory : null,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.0)),
                          ),
                          builder: (context) {
                            return RolesList(onRoleSelected: (selectedRole) {
                              roleTextController.text = selectedRole;
                            });
                          },
                        );
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.work_outline),
                          suffixIcon:
                              Icon(Icons.arrow_drop_down_rounded, size: 40),
                          hintText: Strings.selectRole)),
                ),
                const SizedBox(height: 14.0),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            onTap: () => showMyDatePicker(),
                            controller: joinDateController,
                            readOnly: true,
                            onSaved: (value) {
                              if (value == Strings.today) {
                                employee.joinDate =
                                    DateTime.now().toEditFormat();
                              } else {
                                employee.joinDate = value!;
                              }
                            },
                            validator: (value) =>
                                value!.isEmpty ? Strings.mandatory : null,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(CustomIcons.calendar),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Icon(CustomIcons.arrowRight),
                      ),
                      Expanded(
                        child: TextFormField(
                            onTap: () => showMyDatePicker(isJoinDate: false),
                            onSaved: (value) {
                              if (value == Strings.today) {
                                employee.joinDate =
                                    DateTime.now().toEditFormat();
                              } else {
                                employee.resignDate = value!;
                              }
                            },
                            controller: resignDateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(CustomIcons.calendar),
                                hintText: Strings.noDate)),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            const Spacer(),
            const Divider(thickness: 2.0, height: 0.0),
            Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SizedBox(
                      width: 74,
                      height: 40,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(Strings.cancel))),
                  const SizedBox(width: 16.0),
                  SizedBox(
                    width: 74,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_saveformKey.currentState!.validate()) {
                            _saveformKey.currentState!.save();
                            context.read<EmployeeCubit>().addEmployee(
                                employee: employee, isEditing: isEditing);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(Strings.dataSaved)));
                            context.read<EmployeeCubit>().refreshData();
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Text(Strings.save)),
                  )
                ]))
          ],
        ),
      ),
    );
  }

  showMyDatePicker({bool isJoinDate = true}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.all(16.0),
              content: BlocProvider(
                create: (_) => DatePickerCubit(isJoinDate: isJoinDate),
                child: MyDatePicker(
                    onDateSelected: (date) {
                      if (isJoinDate) {
                        if (date != null) {
                          joinDateController.text =
                              DateTime.now().compareOnlyDateTo(date)
                                  ? Strings.today
                                  : date.toEditFormat();
                        }
                      } else {
                        resignDateController.text = date != null
                            ? (DateTime.now().compareOnlyDateTo(date)
                                ? Strings.today
                                : date.toEditFormat())
                            : "";
                      }
                    },
                    isJoinDate: isJoinDate),
              ));
        });
  }

  @override
  void dispose() {
    nameTextController.dispose();
    roleTextController.dispose();
    joinDateController.dispose();
    resignDateController.dispose();
    super.dispose();
  }
}
