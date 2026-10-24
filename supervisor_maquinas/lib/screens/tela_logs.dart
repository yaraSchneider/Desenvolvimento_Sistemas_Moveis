import 'package:flutter/material.dart';
import '../models/ocorrencia_model.dart';
import '../themes/app_theme.dart';
import '../widgets/botao_acao.dart';
import 'tela_filtro.dart';

class TelaLogs extends StatefulWidget {
  const TelaLogs({super.key});
  @override
  State<TelaLogs> createState() => _TelaLogsState();
}

class _TelaLogsState extends State<TelaLogs> {
  bool _carregando = true;
  List<OcorrenciaModel> _ocorrencias = [];
  Gravidade? _filtro;

  @override
  void initState() {
    super.initState();
    _carregarOcorrencias();
  }

  Future<void> _carregarOcorrencias() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _ocorrencias = List.generate(60, (i) => OcorrenciaModel(
        id: i + 1,
        maquina: 'Máquina ${i % 8 + 1}',
        descricao: 'Evento de supervisão nº ${i + 1}',
        data: DateTime.now().subtract(Duration(minutes: i * 7)),
        gravidade: Gravidade.values[i % Gravidade.values.length],
      ));
      _carregando = false;
    });
  }

  Future<void> _abrirFiltro() async {
    final String? selecionado = await Navigator.push<String>(
      context,
      MaterialPageRoute<String>(builder: (_) => const TelaFiltro()),
    );
    if (!mounted || selecionado == null) return;

    setState(() {
      _filtro = selecionado == 'Todos'
          ? null
          : Gravidade.values.firstWhere((g) => g.rotulo == selecionado);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exibindo apenas logs do tipo: $selecionado')),
    );
  }

  Color _cor(Gravidade gravidade) {
    switch (gravidade) {
      case Gravidade.critico: return AppTheme.critical;
      case Gravidade.alerta: return AppTheme.warning;
      case Gravidade.info: return AppTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtradas = _ocorrencias.where((o) =>
      _filtro == null || o.gravidade == _filtro).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Logs de Ocorrência')),
      body: _carregando
        ? const Center(child: CircularProgressIndicator())
        : Column(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: BotaoAcao(
                texto: 'Filtrar por Gravidade',
                icone: Icons.filter_list,
                aoClicar: _abrirFiltro,
              ),
            ),
            Text('${filtradas.length} ocorrência(s) • Filtro: ${_filtro?.rotulo ?? 'Todos'}'),
            Expanded(child: ListView.builder(
              itemCount: filtradas.length,
              itemBuilder: (context, index) {
                final ocorrencia = filtradas[index];
                return ListTile(
                  key: ValueKey(ocorrencia.id),
                  leading: Icon(Icons.warning_amber,
                      color: _cor(ocorrencia.gravidade)),
                  title: Text('${ocorrencia.maquina} • ${ocorrencia.gravidade.rotulo}'),
                  subtitle: Text('${ocorrencia.descricao}\n'
                      'Registro: ${ocorrencia.data.day}/${ocorrencia.data.month} '
                      '${ocorrencia.data.hour.toString().padLeft(2, '0')}:'
                      '${ocorrencia.data.minute.toString().padLeft(2, '0')}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip: ocorrencia.reconhecida ? 'Desfazer reconhecimento' : 'Reconhecer alarme',
                    icon: Icon(ocorrencia.reconhecida
                        ? Icons.check_circle : Icons.archive_outlined),
                    color: ocorrencia.reconhecida ? AppTheme.success : null,
                    onPressed: () => setState(() =>
                        ocorrencia.reconhecida = !ocorrencia.reconhecida),
                  ),
                );
              },
            )),
          ]),
    );
  }
}
