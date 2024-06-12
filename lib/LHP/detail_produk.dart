import 'package:flutter/material.dart';

class DetailProduk extends StatefulWidget {
  final Map ListData;
  DetailProduk({Key? key, required this.ListData}) : super(key: key);
  //const DetailProduk({super.key});

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_lhp = TextEditingController();
  TextEditingController id_user = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController jenis_ikan = TextEditingController();
  TextEditingController lokasi_panen = TextEditingController();
  TextEditingController pegawai_panen = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id_lhp.text = widget.ListData['id_lhp'];
    id_user.text = widget.ListData['id_user'];
    tanggal.text = widget.ListData['tanggal'];
    jenis_ikan.text = widget.ListData['jenis_ikan'];
    lokasi_panen.text = widget.ListData['lokasi_panen'];
    pegawai_panen.text = widget.ListData['pegawai_panen'];
    keterangan.text = widget.ListData['keterangan'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Produk',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF0F8EEB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          color: Color.fromARGB(255, 202, 233, 255),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                title: Text('ID LHP'),
                subtitle: Text(widget.ListData['id_lhp']),
              ),
              ListTile(
                title: Text('ID User'),
                subtitle: Text(widget.ListData['id_user']),
              ),
              ListTile(
                title: Text('Tanggal'),
                subtitle: Text(widget.ListData['tanggal']),
              ),
              ListTile(
                title: Text('Jenis Ikan'),
                subtitle: Text(widget.ListData['jenis_ikan']),
              ),
              ListTile(
                title: Text('Keterangan'),
                subtitle: Text(widget.ListData['keterangan']),
              ),
            ],),
          ),
        ),
      ),
    );
  }
}