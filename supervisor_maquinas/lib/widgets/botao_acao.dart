import 'package:flutter/material.dart';

class BotaoAcao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final VoidCallback? aoClicar;

  const BotaoAcao({
    super.key,
    required this.texto,
    required this.icone,
    required this.aoClicar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: aoClicar,
        icon: Icon(icone),
        label: Text(texto),
      ),
    );
  }
}
