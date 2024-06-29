import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyek3/LHP/detail_produk.dart';
import 'package:proyek3/LHP/edit_produk.dart';
import 'package:proyek3/LHP/tambah_produk.dart';

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({Key? key}) : super(key: key);

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon = await http.get(Uri.parse(
          'http://192.168.70.68/JINGGA/JINGGA%20SEM%204/PEMROGRAMAN%20PERANGKAT%20BERGERAK/api_produk/proyek3/LHP/read.php'));
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
        Uri.parse(
            'http://192.168.70.68/JINGGA/JINGGA%20SEM%204/PEMROGRAMAN%20PERANGKAT%20BERGERAK/api_produk/proyek3/LHP/delete.php'),
        body: {
          "id_lhp": id,
        },
      );
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
        title: Center(
          child: Text(
            'Laporan Harian Panen',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFF0F8EEB),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color.fromARGB(255, 202, 233, 255), 
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProduk(
                            ListData: {
                              'id_lhp': _listdata[index]['id_lhp'] ?? '',
                              'id_user': _listdata[index]['id_user'] ?? '',
                              'tanggal': _listdata[index]['tanggal'] ?? '',
                              'jenis_ikan': _listdata[index]['jenis_ikan'] ?? '',
                              'lokasi_panen': _listdata[index]['lokasi_panen'] ?? '',
                              'pegawai_panen': _listdata[index]['pegawai_panen'] ?? '',
                              'keterangan': _listdata[index]['keterangan'] ?? '',
                            },
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['tanggal']),
                      subtitle: Text(
                        '${_listdata[index]['jenis_ikan']}\n${_listdata[index]['lokasi_panen']}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UbahProduk(
                                    ListData: {
                                      'id_lhp': _listdata[index]['id_lhp'] ?? '',
                                      'id_user': _listdata[index]['id_user'] ?? '',
                                      'tanggal': _listdata[index]['tanggal'] ?? '',
                                      'jenis_ikan': _listdata[index]['jenis_ikan'] ?? '',
                                      'lokasi_panen': _listdata[index]['lokasi_panen'] ?? '',
                                      'pegawai_panen': _listdata[index]['pegawai_panen'] ?? '',
                                      'keterangan': _listdata[index]['keterangan'] ?? '',
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text('Hapus data ini ?'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _hapus(_listdata[index]['id_lhp']).then((value) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => HalamanProduk(),
                                              ),
                                              (route) => false,
                                            );
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        child: Text(
                                          'Hapus',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        child: Text(
                                          'Batal',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          '+',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahProduk()),
          );
        },
      ),
    );
  }
}
