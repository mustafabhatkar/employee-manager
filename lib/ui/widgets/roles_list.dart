import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';

class RolesList extends StatelessWidget {
  final Function(String) onRoleSelected;
  const RolesList({super.key, required this.onRoleSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        height: 0.0,
        thickness: 1.0,
      ),
      itemCount: Strings.roles.length,
      itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: InkWell(
            onTap: () {
              onRoleSelected(Strings.roles[index]);
              Navigator.pop(context);
            },
            child: Text(
              Strings.roles[index],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )),
    );
  }
}
