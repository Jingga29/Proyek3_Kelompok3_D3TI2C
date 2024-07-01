import 'package:flutter/material.dart';

class DetailLabaRugi extends StatefulWidget {
  final Map ListData;

  DetailLabaRugi({Key? key, required this.ListData}) : super(key: key);

  @override
  State<DetailLabaRugi> createState() => _DetailLabaRugiState();
}

class _DetailLabaRugiState extends State<DetailLabaRugi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Laporan Laba Rugi Harian',
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
          _buildDetailCard('Nota', widget.ListData['nota']),
          _buildDetailCard('Nominal', widget.ListData['nominal']),
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
