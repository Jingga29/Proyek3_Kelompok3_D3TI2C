import 'package:flutter/material.dart';
import 'package:proyek3/laba_rugi/halaman_laba_rugi.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Laporan Laba Rugi Harian',
      home: HalamanLabaRugi(),
    );
  }
}