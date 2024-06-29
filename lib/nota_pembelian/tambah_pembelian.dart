import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:proyek3/nota_pembelian/halaman_pembelian.dart';


class TambahPembelian extends StatefulWidget {
  const TambahPembelian({Key? key}) : super(key: key);

  @override
  State<TambahPembelian> createState() => _TambahPembelianState();
}

class _TambahPembelianState extends State<TambahPembelian> {
  final formKey = GlobalKey<FormState>();
  TextEditingController tanggal = TextEditingController();
  TextEditingController nama_petani = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController jumlah_ikan = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController total = TextEditingController();

  Future<bool> _simpan() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.2/api_proyek3/nota_pembelian/create.php'),
      body: {
        'tanggal': tanggal.text,
        'nama_petani': nama_petani.text,
        'lokasi': lokasi.text,
        'jumlah_ikan': jumlah_ikan.text,
        'harga': harga.text,
        'total': total.text,
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Format tanggal tanpa jam
        tanggal.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Nota Pembelian',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(35),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: tanggal,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    hintText: 'Tanggal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Icon(Icons.calendar_today), 
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
                  controller: nama_petani,
                  decoration: InputDecoration(
                    hintText: 'Nama Petani',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama Petani tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: lokasi,
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
                  controller: jumlah_ikan,
                  decoration: InputDecoration(
                    hintText: 'Jumlah Ikan (Kg)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Jumlah Ikan (Kg) tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: harga,
                  decoration: InputDecoration(
                    hintText: 'Harga per-kg',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harga per-kg tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: total,
                  decoration: InputDecoration(
                    hintText: 'Total Harga',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Total Harga tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 64, 182, 68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _simpan().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data berhasil disimpan'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => HalamanPembelian()),
                              ),
                              (route) => false,
                            );
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data gagal disimpan'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    },
                    child: Text(
                      'Simpan',
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
