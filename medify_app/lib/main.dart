
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
      home: const PaginaSaude(),
      debugShowCheckedModeBanner: false, //OCULTA A FAIXA DEBUG
    );
  }
}

// isto é para configurar as rotas, para navegar entre telas usando Navigator.pushNamed(context, 'nome_da_rota')
/*
routes: {
  'ubss_screen': (context) => const UBSsScreen(),
  'hospitais_screen': (context) => const HospitaisScreen(),
  // ... etc
}
*/