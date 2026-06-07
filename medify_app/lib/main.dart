
import 'package:flutter/material.dart';
import 'package:medify_app/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medify',
      theme: ThemeData(
        //CONFIGURAR CORES 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const TelaPrincipal(),
      debugShowCheckedModeBanner: false, //OCULTA A FAIXA DEBUG
    );
  }
}
