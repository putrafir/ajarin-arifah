import 'package:flutter/material.dart';
import 'package:flutter_monitoring_kehadiran/screens/detail_history.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AttendanceProvider>(context);
    var history = provider.history;

    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Kehadiran')),
      body: history.isEmpty
          ? Center(child: Text('Belum ada riwayat'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                var record = history[index];
                return ListTile(
                  title: Text(
                      'Tanggal: ${record.date.toLocal().toString().split(' ')[0]}'),
                  subtitle: Text(
                      'Hadir: ${record.presentCount}, Tidak Hadir: ${record.absentCount}'),
                  onTap: () async {
                    final updateRecord =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailHistory(
                        date: record.date,
                        student: record.student,
                      ),
                    ));
                    if (updateRecord != null) {
                      provider.updateHistory(index, updateRecord);
                    }
                  },
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Hapus Hostory'),
                            content: Text('Apakah anda yakin?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text('batal')),
                              TextButton(
                                  onPressed: () {
                                    provider.hapusHistory(index);
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text('hapus'))
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.delete)),
                );
              },
            ),
    );
  }
}
