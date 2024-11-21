import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class StudentListItem extends StatelessWidget {
  final int index;

  StudentListItem({required this.index});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AttendanceProvider>(context);
  var student = provider.students[index];

    return ListTile(
      title: Text(student.name),
      trailing: Checkbox(
        value: student.isPresent,
        onChanged: (value) {
          provider.toggleAttendance(index);
        },
      ),
    );
  }
}
