import 'package:flutter/material.dart';

class DetailLaba extends StatefulWidget {
  final Map ListData;

  DetailLaba({Key? key, required this.ListData}) : super(key: key);

  @override
  State<DetailLaba> createState() => _DetailLabaState();
}

class _DetailLabaState extends State<DetailLaba> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Laba',
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
          _buildDetailCard('Jumlah', widget.ListData['jumlah']),
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
