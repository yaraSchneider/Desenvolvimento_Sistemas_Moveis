
import 'package:flutter/material.dart';
import 'screens/tela_resultados.dart';

void main() {
  runApp(const OrquestradorApp());
}

class OrquestradorApp extends StatelessWidget {
  const OrquestradorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orquestrador de Dados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const TelaResultados(),
    );
  }
}
