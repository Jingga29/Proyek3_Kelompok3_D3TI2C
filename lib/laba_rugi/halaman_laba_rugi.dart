import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyek3/laba_rugi/detail_laba_rugi.dart';
import 'package:proyek3/laba_rugi/edit_laba_rugi.dart';
import 'package:proyek3/laba_rugi/tambah_laba_rugi.dart';

class HalamanLabaRugi extends StatefulWidget {
  const HalamanLabaRugi({super.key});

  @override
  State<HalamanLabaRugi> createState() => _HalamanLabaRugiState();
}

class _HalamanLabaRugiState extends State<HalamanLabaRugi> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon = await http
          .get(Uri.parse('http://192.168.0.2/api_proyek3/laba_rugi/read.php'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final respon = await http.post(
          Uri.parse('http://192.168.0.2/api_proyek3/laba_rugi/delete.php'),
          body: {"id_laba": id});
      if (respon.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laporan Laba Rugi Harian',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailLabaRugi(
                                    ListData: {
                                      'tanggal': _listdata[index]['tanggal'],
                                      'nota': _listdata[index]['nota'],
                                      'nominal': _listdata[index]['nominal'],
                                    },
                                  )));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: Icon(Icons.note, color: Colors.blue),
                      title: Text(_listdata[index]['tanggal']),
                      subtitle: Text(_listdata[index]['nota']),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit, color: Color.fromARGB(255, 38, 132, 42)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UbahLabaRugi(
                                            ListData: {
                                              'tanggal':
                                                  _listdata[index]['tanggal'],
                                              'nota': _listdata[index]
                                                  ['nota'],
                                              'nominal': _listdata[index]
                                                  ['nominal'],
                                            },
                                          )));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Color.fromARGB(255, 189, 39, 28)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content: Text('Hapus data ini?'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _hapus(_listdata[index]
                                                    ['id_laba_rugi'])
                                                .then((value) {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        HalamanLabaRugi())),
                                                (route) => false,
                                              );
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(255, 189, 39, 28),
                                          ),
                                          child: Text(
                                            'Hapus',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(255, 38, 132, 42),
                                          ),
                                          child: Text(
                                            'Batal',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  }));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahLabaRugi()),
          );
        },
        backgroundColor: Colors.blue,
        tooltip: 'Tambah Laba Rugi Harian',
        child: Icon(
          Icons.add,
          color: Colors.white, // Warna ikon putih
        ),
      ),
    );
  }
}
