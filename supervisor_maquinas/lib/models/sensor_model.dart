class SensorModel {
  final String nome;
  final String unidade;
  final double valor;
  final String maquina;
  final bool alerta;

  const SensorModel({
    required this.nome,
    required this.unidade,
    required this.valor,
    required this.maquina,
    required this.alerta,
  });
}
