import 'package:flutter/material.dart';

class Student {
  String name;
  bool isPresent;

  Student({required this.name, this.isPresent = false});
}

class AttendanceRecord {
  final DateTime date;
  final int presentCount;
  final int absentCount;
  final List<Map<String, dynamic>> student;

  AttendanceRecord({
    required this.date,
    required this.presentCount,
    required this.absentCount,
    required this.student,
  });
}

class AttendanceProvider with ChangeNotifier {
  // Menggunakan data statis sesuai permintaan
  List<Student> _students = [
    Student(name: 'Ali', isPresent: false),
    Student(name: 'Budi', isPresent: false),
    Student(name: 'Citra', isPresent: false),
    Student(name: 'Arifah', isPresent: false),
    Student(name: 'Mona', isPresent: false),
    Student(name: 'Fitria', isPresent: false),
    Student(name: 'Annisa', isPresent: false),
    Student(name: 'Arfira', isPresent: false),
    Student(name: 'Anggita', isPresent: false),
    Student(name: 'Syifa', isPresent: false),
  ];

  List<AttendanceRecord> _history = [];

  List<Student> get students => _students;
  List<AttendanceRecord> get history => _history;

  void toggleAttendance(int index) {
    _students[index].isPresent = !_students[index].isPresent;
    notifyListeners();
  }

  void saveAttendance() {
    int presentCount = _students.where((s) => s.isPresent).length;
    int absentCount = _students.length - presentCount;
    _history.insert(
      0,
      AttendanceRecord(
        date: DateTime.now(),
        presentCount: presentCount,
        absentCount: absentCount,
        student: _students
            .map(
              (s) => {
                'nama': s.name,
                'isPresent': s.isPresent,
              },
            )
            .toList(),
      ),
    );

    // Reset kehadiran siswa setelah pencatatan
    for (var student in _students) {
      student.isPresent = false;
    }
    notifyListeners();
  }

  void hapusHistory(int index) {
    _history.removeAt(index);
    notifyListeners();
  }

  void updateHistory(int index, AttendanceRecord updateRecord) {
    history[index] = AttendanceRecord(
        date: updateRecord.date,
        presentCount: updateRecord.presentCount,
        absentCount: updateRecord.absentCount,
        student: updateRecord.student);
    notifyListeners();
  }
}
