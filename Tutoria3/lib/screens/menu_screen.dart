import 'package:flutter/material.dart';

import 'exercicio1/lista_suja_screen.dart';
import 'exercicio2/dashboard_grid_screen.dart';
import 'exercicio3/monitor_termico_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercícios Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Escolha um exercício',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ListaSujaScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Exercício 1 - ListView.builder',
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DashboardGridScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Exercício 2 - GridView.builder',
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MonitorTermicoScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Exercício 3 - dispose()',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}