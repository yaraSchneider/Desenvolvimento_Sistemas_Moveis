import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/sensor_model.dart';
import '../widgets/card_sensor.dart';
import '../widgets/botao_acao.dart';
import 'tela_logs.dart';

class TelaDashboard extends StatefulWidget {
  const TelaDashboard({super.key});
  @override
  State<TelaDashboard> createState() => _TelaDashboardState();
}

class _TelaDashboardState extends State<TelaDashboard> {
  final _random = Random();
  Timer? _atualizador;
  late List<SensorModel> _sensores;

  @override
  void initState() {
    super.initState();
    _sensores = _gerarSensores();
    _atualizador = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) setState(() => _sensores = _gerarSensores());
    });
  }

  List<SensorModel> _gerarSensores() {
    const nomes = ['Temperatura', 'Vibração', 'Pressão',
      'Corrente', 'Rotação', 'Tensão', 'Umidade', 'Potência'];
    const unidades = ['°C', 'mm/s', 'bar', 'A', 'rpm', 'V', '%', 'kW'];
    const bases = [65.0, 3.0, 5.0, 18.0, 1500.0, 220.0, 45.0, 12.0];
    return List.generate(nomes.length, (i) {
      final valor = bases[i] * (0.85 + _random.nextDouble() * 0.35);
      return SensorModel(
        nome: nomes[i], unidade: unidades[i], valor: valor,
        maquina: 'Máquina ${i ~/ 2 + 1}', alerta: valor > bases[i] * 1.1,
      );
    });
  }

  @override
  void dispose() {
    _atualizador?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard de Sensores')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Leituras simuladas atualizadas a cada 3 segundos',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final colunas = constraints.maxWidth >= 800 ? 4
                    : constraints.maxWidth >= 500 ? 3 : 2;
                return GridView.builder(
                  itemCount: _sensores.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: colunas,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 175,
                  ),
                  itemBuilder: (context, index) =>
                      CardSensor(sensor: _sensores[index]),
                );
              }),
            ),
            const SizedBox(height: 12),
            BotaoAcao(
              texto: 'Ver logs de ocorrência',
              icone: Icons.receipt_long,
              aoClicar: () => Navigator.push(context,
                MaterialPageRoute<void>(builder: (_) => const TelaLogs())),
            ),
          ],
        ),
      ),
    );
  }
}
