
import 'package:flutter/material.dart';
import '../models/filtro_model.dart';

class TelaFiltros extends StatefulWidget {
  final FiltroModel filtroInicial;
  final ValueChanged<FiltroModel> aoAplicar;

  const TelaFiltros({
    super.key,
    required this.filtroInicial,
    required this.aoAplicar,
  });

  @override
  State<TelaFiltros> createState() => _TelaFiltrosState();
}

class _TelaFiltrosState extends State<TelaFiltros> {
  late final TextEditingController controller;
  late String statusSelecionado;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.filtroInicial.veiculo,
    );
    statusSelecionado = widget.filtroInicial.status;
  }

  void aplicarFiltros() {
    final novoFiltro = FiltroModel(
      veiculo: controller.text.trim(),
      status: statusSelecionado,
    );

    widget.aoAplicar(novoFiltro);

    Navigator.pop(context, true);
  }

  void cancelar() {
    Navigator.pop(context, false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtros de Pesquisa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Identificação do veículo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              initialValue: statusSelecionado,
              decoration: const InputDecoration(
                labelText: 'Status do veículo',
                border: OutlineInputBorder(),
              ),
              items: [
                'Todos',
                'Ativo',
                'Manutenção',
                'Inativo',
              ].map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    statusSelecionado = valor;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: aplicarFiltros,
              icon: const Icon(Icons.check),
              label: const Text('Aplicar filtros'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: cancelar,
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
