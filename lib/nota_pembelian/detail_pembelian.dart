import 'package:flutter/material.dart';

class DetailPembelian extends StatefulWidget {
  final Map ListData;

  DetailPembelian({Key? key, required this.ListData}) : super(key: key);

  @override
  State<DetailPembelian> createState() => _DetailPembelianState();
}

class _DetailPembelianState extends State<DetailPembelian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Nota Pembelian',
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildDetailCard('Tanggal', widget.ListData['tanggal']),
          _buildDetailCard('Nama Petani', widget.ListData['nama_petani']),
          _buildDetailCard('Lokasi Panen', widget.ListData['lokasi']),
          _buildDetailCard('Jumlah Ikan (Kg)', widget.ListData['jumlah_ikan']),
          _buildDetailCard('Harga per-kg', widget.ListData['harga']),
          _buildDetailCard('Total Harga', widget.ListData['total']),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String subtitle) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
