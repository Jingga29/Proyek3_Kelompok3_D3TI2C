import 'package:flutter/material.dart';
import 'package:proyek3/LHP/halaman_produk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Aplikasi Produk',
      home: HalamanProduk(),
    );
  }
}