
import 'package:flutter/material.dart';
import '../models/filtro_model.dart';
import 'tela_filtros.dart';

class TelaResultados extends StatefulWidget {
  const TelaResultados({super.key});

  @override
  State<TelaResultados> createState() =>
      _TelaResultadosState();
}

class _TelaResultadosState extends State<TelaResultados> {
  FiltroModel filtro = const FiltroModel(
    veiculo: '',
    status: 'Todos',
  );

  final List<Map<String, String>> veiculos = [
    {'nome': 'WEG-001', 'status': 'Ativo'},
    {'nome': 'WEG-002', 'status': 'Manutenção'},
    {'nome': 'WEG-003', 'status': 'Ativo'},
    {'nome': 'WEG-004', 'status': 'Inativo'},
  ];

  List<Map<String, String>> get resultados {
    return veiculos.where((veiculo) {
      final correspondeNome = veiculo['nome']!
          .toLowerCase()
          .contains(filtro.veiculo.toLowerCase());

      final correspondeStatus =
          filtro.status == 'Todos' ||
          veiculo['status'] == filtro.status;

      return correspondeNome && correspondeStatus;
    }).toList();
  }

 
Future<void> abrirFiltros() async {
  FiltroModel? filtroConfirmado;

  final bool? aplicado = await Navigator.push<bool>(
    context,
    MaterialPageRoute<bool>(
      builder: (_) => TelaFiltros(
        filtroInicial: filtro,
        aoAplicar: (novoFiltro) {
          filtroConfirmado = novoFiltro;
        },
      ),
    ),
  );

  if (!mounted) return;

  if (aplicado == true && filtroConfirmado != null) {
    setState(() {
      filtro = filtroConfirmado!;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    final lista = resultados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orquestrador de Dados'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Monitoramento de Veículos Elétricos',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text('Veículos encontrados: ${lista.length}'),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: abrirFiltros,
              icon: const Icon(Icons.filter_list),
              label: const Text('Filtrar veículos'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  final veiculo = lista[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.electric_car),
                      title: Text(veiculo['nome']!),
                      subtitle: Text(
                        'Status: ${veiculo['status']}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
