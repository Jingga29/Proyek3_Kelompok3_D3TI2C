import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyek3/LHP/halaman_produk.dart';
import 'package:intl/intl.dart'; 

class UbahProduk extends StatefulWidget {
  final Map ListData;
  const UbahProduk({Key? key, required this.ListData}) : super(key: key);

  @override
  State<UbahProduk> createState() => _UbahProdukState();
}

class _UbahProdukState extends State<UbahProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_lhp = TextEditingController();
  TextEditingController id_user = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController jenis_ikan = TextEditingController();
  TextEditingController lokasi_panen = TextEditingController();
  TextEditingController pegawai_panen = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  Future<bool> _ubah() async {
    final response = await http.post(
      Uri.parse('http://192.168.70.68/JINGGA/JINGGA%20SEM%204/PEMROGRAMAN%20PERANGKAT%20BERGERAK/api_produk/proyek3/LHP/edit.php'),
      body: {
        'id_lhp': id_lhp.text,
        'id_user': id_user.text,
        'tanggal': tanggal.text,
        'jenis_ikan': jenis_ikan.text,
        'lokasi_panen': lokasi_panen.text,
        'pegawai_panen': pegawai_panen.text,
        'keterangan': keterangan.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          tanggal.text = DateFormat('yyyy-MM-dd HH:mm').format(combinedDateTime); // Format the date and time
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    id_lhp.text = widget.ListData['id_lhp'];
    id_user.text = widget.ListData['id_user'];
    tanggal.text = widget.ListData['tanggal'];
    jenis_ikan.text = widget.ListData['jenis_ikan'];
    lokasi_panen.text = widget.ListData['lokasi_panen'];
    pegawai_panen.text = widget.ListData['pegawai_panen'];
    keterangan.text = widget.ListData['keterangan'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8EEB),
        title: Text(
          'Ubah Produk',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: id_user,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'ID User',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
                    return "Jenis ikan tidak boleh kosong!";
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
                    return "Lokasi panen tidak boleh kosong!";
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
                    return "Pegawai panen tidak boleh kosong!";
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
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _ubah().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value ? 'Data Berhasil diubah' : 'Data Gagal diubah'),
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
                  'Ubah',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
