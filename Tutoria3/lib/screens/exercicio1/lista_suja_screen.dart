import 'package:flutter/material.dart';

class ListaSujaScreen extends StatelessWidget {
  final List<String> itens = List.generate(
    100,
    (index) => 'Registro de Máquina #${index + 1}',
  );

  ListaSujaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs Industriais'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        itemCount: itens.length,

        itemBuilder: (context, index) {
          final item = itens[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ListTile(
              leading: const Icon(
                Icons.history_toggle_off,
                color: Colors.green,
              ),
              title: Text(item),
              subtitle: const Text(
                'Status: Sincronizado na Memória',
              ),
            ),
          );
        },
      ),
    );
  }
}