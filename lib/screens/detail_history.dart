import 'package:flutter/material.dart';
import 'package:flutter_monitoring_kehadiran/providers/attendance_provider.dart';

class DetailHistory extends StatefulWidget {
  final DateTime date;
  final List<Map<String, dynamic>> student;

  const DetailHistory({super.key, required this.date, required this.student});

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  late List<Map<String, dynamic>> editableStudent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editableStudent = List<Map<String, dynamic>>.from(widget.student);
  }

  void togglePresent(int index) {
    setState(() {
      editableStudent[index]['isPresent'] =
          !editableStudent[index]['isPresent'];
    });
  }

  void saveChange(BuildContext content) {
    final presentCount =
        editableStudent.where((student) => student['isPresent']).length;
    final absentCunt = editableStudent.length - presentCount;

    // Navigator.of(context).pop({
    //   'date': widget.date,
    //   'present': presentCount,
    //   'absent': absentCunt,
    //   'student': editableStudent
    // });

    Navigator.of(context).pop(AttendanceRecord(
        date: widget.date,
        presentCount: presentCount,
        absentCount: absentCunt,
        student: editableStudent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail (${widget.date.toString()})'),
        actions: [
          IconButton(
              onPressed: () => saveChange(context), icon: Icon(Icons.save))
        ],
      ),
      body: ListView.builder(
        itemCount: widget.student.length,
        itemBuilder: (context, index) {
          final student = widget.student[index];
          return ListTile(
            title: Text(student['nama']),
            trailing: IconButton(
              onPressed: () => togglePresent(index),
              icon: Icon(
                student['isPresent'] ? Icons.check_circle : Icons.cancel,
                color: student['isPresent'] ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
