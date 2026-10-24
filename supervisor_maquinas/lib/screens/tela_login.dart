import 'package:flutter/material.dart';
import '../widgets/botao_acao.dart';
import 'tela_dashboard.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});
  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _form = GlobalKey<FormState>();
  final _usuario = TextEditingController();
  final _senha = TextEditingController();

  void _entrar() {
    if (!_form.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const TelaDashboard()),
    );
  }

  @override
  void dispose() {
    _usuario.dispose();
    _senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portal de Acesso')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.precision_manufacturing, size: 64),
                  const SizedBox(height: 12),
                  Text('Supervisor de Máquinas',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _usuario,
                    decoration: const InputDecoration(labelText: 'Usuário',
                        prefixIcon: Icon(Icons.person_outline)),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Informe o usuário' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _senha,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock_outline)),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Informe a senha' : null,
                  ),
                  const SizedBox(height: 20),
                  BotaoAcao(texto: 'Entrar', icone: Icons.login, aoClicar: _entrar),
                  const SizedBox(height: 8),
                  const Text('Acesso demonstrativo: use qualquer usuário e senha.',
                    textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
