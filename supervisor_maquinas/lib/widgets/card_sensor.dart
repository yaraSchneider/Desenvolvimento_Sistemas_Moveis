import 'package:flutter/material.dart';
import '../models/sensor_model.dart';
import '../themes/app_theme.dart';

class CardSensor extends StatelessWidget {
  final SensorModel sensor;
  const CardSensor({super.key, required this.sensor});

  @override
  Widget build(BuildContext context) {
    final cor = sensor.alerta ? AppTheme.critical : AppTheme.success;
    final texto = sensor.valor.toStringAsFixed(1);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sensor.maquina, style: Theme.of(context).textTheme.labelMedium),
            Text(sensor.nome,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('$texto ${sensor.unidade}',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Row(
              children: [
                Icon(sensor.alerta ? Icons.warning_amber : Icons.check_circle,
                    size: 16, color: cor),
                const SizedBox(width: 5),
                Flexible(child: Text(sensor.alerta ? 'Atenção' : 'Normal',
                    style: TextStyle(color: cor))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
