import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'package:proyek3/nota_pembelian/halaman_pembelian.dart';

class UbahPembelian extends StatefulWidget {
  final Map ListData;
  const UbahPembelian({Key? key, required this.ListData}) : super(key: key);

  @override
  State<UbahPembelian> createState() => _UbahPembelianState();
}

class _UbahPembelianState extends State<UbahPembelian> {
  final formKey = GlobalKey<FormState>();
  TextEditingController tanggal = TextEditingController();
  TextEditingController namaPetani = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController jumlahIkan = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController total = TextEditingController();

  @override
  void initState() {
    super.initState();
    tanggal.text = widget.ListData['tanggal'];
    namaPetani.text = widget.ListData['nama_petani'];
    lokasi.text = widget.ListData['lokasi'];
    jumlahIkan.text = widget.ListData['jumlah_ikan'];
    harga.text = widget.ListData['harga'];
    total.text = widget.ListData['total'];
  }

  Future<bool> _ubah() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.2/api_proyek3/nota_pembelian/edit.php'),
      body: {
        'tanggal': tanggal.text,
        'nama_petani': namaPetani.text,
        'lokasi': lokasi.text,
        'jumlah_ikan': jumlahIkan.text,
        'harga': harga.text,
        'total': total.text,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateFormat('yyyy-MM-dd').parse(tanggal.text),
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
          'Edit Nota Pembelian',
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
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(35),
            child: Column(
              children: [
                TextFormField(
                  controller: tanggal,
                  readOnly: true, // Membuat input tidak dapat diedit langsung
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    hintText: 'Tanggal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Icon(Icons.calendar_today), // Icon tanggal
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
                  controller: namaPetani,
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
                  controller: jumlahIkan,
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
                      _ubah().then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                            content: const Text('Data berhasil diubah'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('Data gagal diubah'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HalamanPembelian())),
                        (route) => false,
                      );
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
