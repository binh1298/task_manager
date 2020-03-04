import 'package:flutter/material.dart';
import 'package:task_manager/models/role_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class DropdownButtonRole extends StatefulWidget {
  final Function updateState;
  DropdownButtonRole({this.updateState});

  @override
  _DropdownButtonRoleState createState() => _DropdownButtonRoleState();
}

class _DropdownButtonRoleState extends State<DropdownButtonRole> {
  List<Role> rolesList;
  Role dropDownRole;

  @override
  void initState() {
    super.initState();
    rolesList = fetchRolesListSync();
    dropDownRole = rolesList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButton<Role>(
          
          value: dropDownRole,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: colorPrimary,
          ),
          isExpanded: true,
          onChanged: (Role newRole) {
            setState(() {
              dropDownRole = newRole;
            });
            widget.updateState(newRole.roleId);
          },
          items: rolesList
              .map<DropdownMenuItem<Role>>(
                (role) => DropdownMenuItem(
                  value: role,
                  child: Text(
                    capitalize(role.roleName),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
