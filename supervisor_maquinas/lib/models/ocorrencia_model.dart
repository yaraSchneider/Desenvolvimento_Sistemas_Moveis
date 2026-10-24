enum Gravidade { critico, alerta, info }

extension GravidadeTexto on Gravidade {
  String get rotulo {
    switch (this) {
      case Gravidade.critico: return 'Crítico';
      case Gravidade.alerta: return 'Alerta';
      case Gravidade.info: return 'Info';
    }
  }
}

class OcorrenciaModel {
  final int id;
  final String maquina;
  final String descricao;
  final DateTime data;
  final Gravidade gravidade;
  bool reconhecida;

  OcorrenciaModel({
    required this.id,
    required this.maquina,
    required this.descricao,
    required this.data,
    required this.gravidade,
    this.reconhecida = false,
  });
}
