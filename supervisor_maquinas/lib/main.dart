import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'screens/tela_login.dart';

void main() => runApp(const SupervisorApp());

class SupervisorApp extends StatelessWidget {
  const SupervisorApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Supervisor de Máquinas',
    theme: AppTheme.light,
    home: const TelaLogin(),
  );
}
