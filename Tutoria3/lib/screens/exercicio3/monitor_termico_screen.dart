import 'dart:async';

import 'package:flutter/material.dart';

class MonitorTermicoScreen extends StatefulWidget {
  const MonitorTermicoScreen({super.key});

  @override
  State<MonitorTermicoScreen> createState() =>
      _MonitorTermicoScreenState();
}

class _MonitorTermicoScreenState
    extends State<MonitorTermicoScreen> {

  Timer? _timerTelemetria;

  double _temperaturaWEG = 45.0;

  @override
  void initState() {
    super.initState();

    _timerTelemetria = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          return;
        }

        setState(() {
          _temperaturaWEG =
              45.0 + (timer.tick % 5) * 0.4;
        });

        debugPrint(
          '[SISTEMA ATIVO] '
          'Temperatura: $_temperaturaWEG°C',
        );
      },
    );
  }

  @override
  void dispose() {
    _timerTelemetria?.cancel();

    debugPrint(
      '[HIGIENE DE MEMÓRIA] '
      'Timer destruído com sucesso!',
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor Térmico'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.thermostat,
              size: 80,
              color: Colors.orange,
            ),

            const SizedBox(height: 16),

            const Text(
              'Sensor Motor Principal (WEG)',

              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${_temperaturaWEG.toStringAsFixed(1)} °C',

              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),

              child: Text(
                'A temperatura é atualizada a cada segundo. '
                'Ao sair desta tela, o dispose() cancela o Timer.',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}