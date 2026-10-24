import 'package:flutter/material.dart';
import '../models/ocorrencia_model.dart';

class TelaFiltro extends StatelessWidget {
  const TelaFiltro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtrar por Gravidade')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Todos'),
            onTap: () => Navigator.pop<String>(context, 'Todos'),
          ),
          ...Gravidade.values.map((g) => ListTile(
            leading: const Icon(Icons.filter_alt),
            title: Text(g.rotulo),
            onTap: () => Navigator.pop<String>(context, g.rotulo),
          )),
        ],
      ),
    );
  }
}
