import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyek3/LHP/halaman_produk.dart';
import 'package:intl/intl.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({Key? key}) : super(key: key);

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id_user = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController jenis_ikan = TextEditingController();
  TextEditingController lokasi_panen = TextEditingController();
  TextEditingController pegawai_panen = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  Future<bool> _simpan() async {
    final response = await http.post(
      Uri.parse('http://192.168.70.68/JINGGA/JINGGA%20SEM%204/PEMROGRAMAN%20PERANGKAT%20BERGERAK/api_produk/proyek3/LHP/create.php'),
      body: {
        'id_user': id_user.text,
        'tanggal': tanggal.text,
        'jenis_ikan': jenis_ikan.text,
        'lokasi_panen': lokasi_panen.text,
        'pegawai_panen': pegawai_panen.text,
        'keterangan': keterangan.text,
      },
    );
    return response.statusCode == 200;
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime dateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
        setState(() {
          tanggal.text = DateFormat('yyyy-MM-dd HH:mm').format(dateTime); 
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8EEB),
        title: Text(
          'Form Laporan Harian Panen',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: id_user,
                  decoration: InputDecoration(
                    hintText: 'id_user',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "id_user tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: tanggal,
                  readOnly: true, // Make the field read-only
                  decoration: InputDecoration(
                    hintText: 'Tanggal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDateTime(context);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tanggal tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: jenis_ikan,
                  decoration: InputDecoration(
                    hintText: 'Jenis Ikan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Jenis Ikan tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: lokasi_panen,
                  decoration: InputDecoration(
                    hintText: 'Lokasi Panen',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lokasi Panen tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: pegawai_panen,
                  decoration: InputDecoration(
                    hintText: 'Pegawai Panen',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Pegawai Panen tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: keterangan,
                  decoration: InputDecoration(
                    hintText: 'Keterangan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Keterangan tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _simpan().then((value) {
                        final snackBar = SnackBar(
                          content: Text(value ? 'Data Berhasil disimpan' : 'Data Gagal disimpan'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        if (value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HalamanProduk()),
                            (route) => false,
                          );
                        }
                      });
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
