import 'package:flutter/material.dart';

import 'sensor_model.dart';

class DashboardGridScreen extends StatelessWidget {
  final List<SensorModel> sensores = [
    SensorModel(
      nome: 'Temperatura Motor A (WEG)',
      valor: '74.5°C',
      statusAtivo: true,
    ),
    SensorModel(
      nome: 'Pressão Caldeira 02',
      valor: '12.4 Bar',
      statusAtivo: true,
    ),
    SensorModel(
      nome: 'Vibração Tear Malwee',
      valor: '0.2 mm/s',
      statusAtivo: false,
    ),
    SensorModel(
      nome: 'Consumo KWh Painel 3',
      valor: '450 KWh',
      statusAtivo: true,
    ),
    SensorModel(
      nome: 'Fluxo Entrada Hidráulica',
      valor: '15 L/min',
      statusAtivo: true,
    ),
    SensorModel(
      nome: 'Nível Solução Química',
      valor: '15%',
      statusAtivo: false,
    ),
  ];

  DashboardGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telemetria Industrial',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: GridView.builder(
          itemCount: sensores.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),

          itemBuilder: (context, index) {
            final sensor = sensores[index];

            return Card(
              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        const Icon(
                          Icons.sensors,
                          color: Colors.blue,
                        ),

                        Container(
                          width: 12,
                          height: 12,

                          decoration: BoxDecoration(
                            color: sensor.statusAtivo
                                ? Colors.green
                                : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Text(
                      sensor.nome,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      sensor.valor,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      sensor.statusAtivo
                          ? 'Ativo'
                          : 'Inativo',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                        color: sensor.statusAtivo
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}