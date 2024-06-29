import 'package:flutter/material.dart';
import 'package:proyek3/nota_pembelian/halaman_pembelian.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Nota Pembelian',
      home: HalamanPembelian(),
    );
  }
}