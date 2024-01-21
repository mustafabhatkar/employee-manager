import 'package:employee_manager/data/models/employee_podo.dart';
import 'package:employee_manager/ui/widgets/custom_icons.dart';
import 'package:employee_manager/ui/widgets/date_picker/my_date_picker.dart';

import 'package:employee_manager/utils/extension.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:employee_manager/utils/title_case_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEditEmployeePage extends StatefulWidget {
  final Employee? employee;
  const AddEditEmployeePage({super.key, this.employee});

  @override
  State<AddEditEmployeePage> createState() => _AddEditEmployeePageState();
}

class _AddEditEmployeePageState extends State<AddEditEmployeePage> {
  final nameTextController = TextEditingController();
  final roleTextController = TextEditingController();
  final joinDateController = TextEditingController();
  final resignDateController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    isEditing = widget.employee != null;
    joinDateController.text = Strings.today;
    if (isEditing) {
      nameTextController.text = widget.employee!.name;
      roleTextController.text = widget.employee!.role;
      joinDateController.text = widget.employee!.joinDate;
      if (widget.employee!.resignDate != null) {
        resignDateController.text = widget.employee!.resignDate!;
      }
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(children: [
              SizedBox(
                height: 40,
                child: TextFormField(
                    controller: nameTextController,
                    autofocus: !isEditing,
                    inputFormatters: [
                      TitleCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                    ],
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_sharp),
                        hintText: Strings.employeeName)),
              ),
              const SizedBox(height: 23.0),
              SizedBox(
                height: 40,
                child: TextFormField(
                    controller: roleTextController,
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.0)),
                        ),
                        builder: (context) {
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => const Divider(
                              height: 0.0,
                              thickness: 1.0,
                            ),
                            itemCount: Strings.roles.length,
                            itemBuilder: (context, index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    roleTextController.text =
                                        Strings.roles[index];
                                  },
                                  child: Text(
                                    Strings.roles[index],
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                )),
                          );
                        },
                      );
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.work_outline),
                        suffixIcon:
                            Icon(Icons.arrow_drop_down_rounded, size: 40),
                        hintText: Strings.selectRole)),
              ),
              const SizedBox(height: 23.0),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          onTap: () => showMyDatePicker(),
                          controller: joinDateController,
                          readOnly: true,
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
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                    width: 74,
                    height: 40,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(Strings.cancel))),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 74,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text(Strings.save)),
                )
              ]))
        ],
      ),
    );
  }

  showMyDatePicker({bool isJoinDate = true}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.all(16.0),
            content: MyDatePicker(
                onDateSelected: (date) {
                  if (isJoinDate) {
                    joinDateController.text = date.toEditFormat();
                  }else{
                    resignDateController.text = date.toEditFormat();
                  }
                },
                isJoinDate: isJoinDate));
      });

  @override
  void dispose() {
    nameTextController.dispose();
    roleTextController.dispose();
    joinDateController.dispose();
    resignDateController.dispose();
    super.dispose();
  }
}
