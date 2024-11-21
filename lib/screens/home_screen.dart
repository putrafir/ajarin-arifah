import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../widgets/student_list_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AttendanceProvider>(context);
    var students = provider.students;

    return Scaffold(
      appBar: AppBar(title: Text('Presensi Siswa')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentListItem(index: index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.students.isEmpty ? null : provider.saveAttendance,
        child: Icon(Icons.save),
        backgroundColor:
            provider.students.isEmpty ? Colors.grey : Colors.blue,
      ),
    );
  }
}
