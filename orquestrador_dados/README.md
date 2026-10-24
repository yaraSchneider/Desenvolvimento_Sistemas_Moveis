# Orquestrador de Dados — Flutter

## Descrição do Projeto

Aplicativo desenvolvido em Flutter para a atividade acadêmica **O Orquestrador de Dados**.

O sistema simula uma plataforma de monitoramento de veículos elétricos, permitindo pesquisar e filtrar veículos por identificação e status operacional.

## Funcionalidades

- Listagem de veículos elétricos.
- Pesquisa por identificação do veículo.
- Filtragem por status: Ativo, Inativo e Manutenção.
- Navegação entre telas com passagem de objetos.
- Aplicação e cancelamento de filtros.
- Tratamento de retornos nulos da navegação.

## Tecnologias

- Flutter
- Dart
- Material Design 3

## Requisitos Técnicos Implementados

### 1. Modelagem de Dados

Utilização da classe `FiltroModel` com parâmetros nomeados e obrigatórios:

```dart
class FiltroModel {
  final String veiculo;
  final String status;

  const FiltroModel({
    required this.veiculo,
    required this.status,
  });
}
```

### 2. Navegação Assíncrona

A navegação utiliza `Navigator.push<bool>` e `await`, aguardando o retorno da tela de filtros:

```dart
final bool? aplicado = await Navigator.push<bool>(
  context,
  MaterialPageRoute<bool>(
    builder: (_) => TelaFiltros(
      filtroInicial: filtro,
      aoAplicar: (novoFiltro) {
        filtroConfirmado = novoFiltro;
      },
    ),
  ),
);
```

O objeto `FiltroModel` é transferido à tela de destino através do construtor.

### 3. Controle do Retorno

Quando os filtros são confirmados:

```dart
Navigator.pop(context, true);
```

Quando a operação é cancelada:

```dart
Navigator.pop(context, false);
```

### 4. Tratamento de Nulidade

O retorno é armazenado em `bool?` e validado antes de atualizar os resultados.

```dart
if (aplicado == true && filtroConfirmado != null) {
  setState(() {
    filtro = filtroConfirmado!;
  });
}
```

Assim, ao utilizar o botão nativo de voltar, nenhuma alteração é aplicada.

## Estrutura do Projeto

```text
lib/
├── main.dart
├── models/
│   └── filtro_model.dart
└── screens/
    ├── tela_resultados.dart
    └── tela_filtros.dart
```

## Como Executar

```bash
flutter pub get
flutter run -d chrome
```

Caso as dependências já estejam resolvidas localmente:

```bash
flutter run -d chrome --no-pub
```

## Considerações Finais

O projeto demonstra a utilização de objetos entre rotas, navegação assíncrona, tratamento de nulidade e gerenciamento de estado em Flutter.

Os dados dos veículos são simulados localmente para fins acadêmicos.