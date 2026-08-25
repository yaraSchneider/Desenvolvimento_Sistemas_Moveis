# Exercícios Flutter — Listas, Grids e Gerenciamento de Memória

Projeto desenvolvido para resolver três exercícios de Flutter relacionados a **renderização eficiente de listas**, **criação de dashboards em grade** e **gerenciamento do ciclo de vida de widgets**.

---

## 📁 Estrutura do Projeto

```text
lib/
├── main.dart
│
└── screens/
    ├── menu_screen.dart
    │
    ├── exercicio1/
    │   └── lista_suja_screen.dart
    │
    ├── exercicio2/
    │   ├── dashboard_grid_screen.dart
    │   └── sensor_model.dart
    │
    └── exercicio3/
        └── monitor_termico_screen.dart
```

### Organização

* `main.dart`: ponto de entrada da aplicação.
* `menu_screen.dart`: menu para acessar os três exercícios.
* `exercicio1/`: implementação do `ListView.builder`.
* `exercicio2/`: implementação do `GridView.builder` e modelo dos sensores.
* `exercicio3/`: implementação do `Timer` e gerenciamento com `dispose()`.

---

# Exercício 1 — O Otimizador de Listas

## 📌 Problema

O código original utilizava:

```dart
SingleChildScrollView(
  child: Column(
    children: itens.map((item) {
      // ...
    }).toList(),
  ),
)
```

Essa abordagem cria todos os elementos da lista de uma vez.

No exercício existem 100 registros, mas em uma aplicação real poderiam existir milhares ou até milhões de registros.

Isso pode causar:

* maior consumo de memória;
* maior processamento inicial;
* renderização desnecessária;
* perda de desempenho em listas grandes.

---

## ✅ Solução

A solução foi substituir o `SingleChildScrollView` com `Column` pelo:

```dart
ListView.builder
```

No arquivo:

```text
lib/screens/exercicio1/lista_suja_screen.dart
```

A implementação utiliza:

```dart
ListView.builder(
  itemCount: itens.length,
  itemBuilder: (context, index) {
    final item = itens[index];

    return Card(
      child: ListTile(
        title: Text(item),
      ),
    );
  },
)
```

---

## 🔎 Como funciona?

O `ListView.builder` cria os elementos da lista **sob demanda**.

Isso significa que o Flutter não precisa criar todos os 100 elementos imediatamente.

O `itemBuilder` é chamado conforme os itens são necessários para a área visível da lista.

### Exemplo

```text
Lista com 100 registros

┌───────────────────────────┐
│ Registro #1               │
│ Registro #2               │
│ Registro #3               │
│ Registro #4               │
│ Registro #5               │
└───────────────────────────┘
            ↓
        Viewport
            ↓
     Itens necessários
```

Quando o usuário rola a tela, novos itens podem ser construídos conforme entram na região de visualização.

---

## 🧠 Viewport

O **viewport** representa a área da lista que está sendo visualizada naquele momento.

O uso de `ListView.builder` permite que o Flutter trabalhe de forma mais eficiente com essa região, evitando a necessidade de construir toda a lista de uma vez.

É importante destacar que isso não significa que **somente os pixels atualmente visíveis** podem existir na memória. O Flutter pode manter elementos próximos ao viewport para melhorar a rolagem.

---

## 🎯 Conceito principal

O objetivo do exercício foi demonstrar que:

```text
SingleChildScrollView + Column
          ↓
Criação de todos os widgets
          ↓
Maior custo inicial
```

Enquanto:

```text
ListView.builder
          ↓
Construção sob demanda
          ↓
Melhor desempenho
```

---

# Exercício 2 — O Dashboard em Grade

## 📌 Problema

O objetivo deste exercício é criar um painel para apresentar informações de sensores industriais.

Cada sensor possui:

* nome;
* valor atual;
* status ativo/inativo.

O dashboard deve apresentar os sensores em uma grade com **duas colunas**.

---

## ✅ Solução

Foi utilizado:

```dart
GridView.builder
```

junto com:

```dart
SliverGridDelegateWithFixedCrossAxisCount
```

O código está dividido em dois arquivos:

```text
lib/screens/exercicio2/
├── dashboard_grid_screen.dart
└── sensor_model.dart
```

---

# SensorModel

O arquivo:

```text
sensor_model.dart
```

é responsável por representar os dados de um sensor.

```dart
class SensorModel {
  final String nome;
  final String valor;
  final bool statusAtivo;

  SensorModel({
    required this.nome,
    required this.valor,
    required this.statusAtivo,
  });
}
```

A classe possui três propriedades:

### `nome`

Representa o nome do sensor.

Exemplo:

```text
Temperatura Motor A (WEG)
```

### `valor`

Representa o valor atual do sensor.

Exemplo:

```text
74.5°C
```

### `statusAtivo`

Indica se o sensor está ativo.

```dart
true
```

ou:

```dart
false
```

---

# GridView.builder

No arquivo:

```text
dashboard_grid_screen.dart
```

é utilizado:

```dart
GridView.builder(
  itemCount: sensores.length,

  gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.1,
  ),

  itemBuilder: (context, index) {
    // ...
  },
)
```

---

## 🔎 SliverGridDelegateWithFixedCrossAxisCount

Esse delegate define como os elementos serão organizados na grade.

### `crossAxisCount`

```dart
crossAxisCount: 2
```

Define que a grade terá duas colunas.

Visualmente:

```text
┌──────────────┬──────────────┐
│   Sensor 1   │   Sensor 2   │
├──────────────┼──────────────┤
│   Sensor 3   │   Sensor 4   │
├──────────────┼──────────────┤
│   Sensor 5   │   Sensor 6   │
└──────────────┴──────────────┘
```

### `crossAxisSpacing`

```dart
crossAxisSpacing: 12
```

Define o espaço horizontal entre as colunas.

### `mainAxisSpacing`

```dart
mainAxisSpacing: 12
```

Define o espaço vertical entre as linhas.

### `childAspectRatio`

```dart
childAspectRatio: 1.1
```

Define a proporção entre largura e altura dos cards.

---

# Status do Sensor

O status é representado por uma pequena bolinha.

```dart
Container(
  width: 12,
  height: 12,
  decoration: BoxDecoration(
    color: sensor.statusAtivo
        ? Colors.green
        : Colors.red,
    shape: BoxShape.circle,
  ),
)
```

A expressão:

```dart
sensor.statusAtivo ? Colors.green : Colors.red
```

é um operador ternário.

Significa:

```text
Se statusAtivo == true
        ↓
     Verde

Se statusAtivo == false
        ↓
     Vermelho
```

Além disso, o texto também informa:

```dart
sensor.statusAtivo
    ? 'Ativo'
    : 'Inativo'
```

---

## 🎯 Conceito principal

O exercício demonstra como criar um dashboard utilizando uma grade dinâmica.

```text
GridView.builder
       ↓
Criação dinâmica dos itens
       ↓
SliverGridDelegate
       ↓
Organização da grade
       ↓
2 colunas
       ↓
Cards dos sensores
```

O `GridView.builder` também utiliza construção sob demanda, sendo adequado para grades que podem possuir muitos elementos.

---

# Exercício 3 — O Guardião de Memória

## 📌 Problema

O exercício simula um sistema de monitoramento industrial.

Um `Timer` é iniciado para simular a leitura contínua de um sensor:

```dart
Timer.periodic(
  const Duration(seconds: 1),
  (timer) {
    // atualização
  },
);
```

O problema seria deixar esse timer executando mesmo depois que o usuário saísse da tela.

Isso poderia causar:

* consumo desnecessário de recursos;
* execução de código em uma tela que já não está sendo utilizada;
* chamadas de `setState()` após o widget ser destruído;
* possíveis vazamentos de memória.

---

# initState()

O timer é iniciado dentro do:

```dart
initState()
```

Exemplo:

```dart
@override
void initState() {
  super.initState();

  _timerTelemetria = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      if (!mounted) {
        return;
      }

      setState(() {
        _temperaturaWEG =
            45.0 + (timer.tick % 5) * 0.4;
      });
    },
  );
}
```

O `initState()` é chamado quando o `State` do widget é criado.

Nesse momento o timer começa a atualizar a temperatura a cada segundo.

---

# dispose()

Quando o usuário sai da tela, o Flutter pode destruir o `State`.

Nesse momento é necessário liberar os recursos utilizados.

Por isso foi implementado:

```dart
@override
void dispose() {
  _timerTelemetria?.cancel();

  debugPrint(
    '[HIGIENE DE MEMÓRIA] '
    'Timer destruído com sucesso!',
  );

  super.dispose();
}
```

A parte mais importante é:

```dart
_timerTelemetria?.cancel();
```

Ela cancela o timer.

---

# Ciclo de vida

O funcionamento pode ser representado assim:

```text
Widget criado
      ↓
initState()
      ↓
Timer iniciado
      ↓
Atualização a cada 1 segundo
      ↓
Usuário sai da tela
      ↓
dispose()
      ↓
Timer.cancel()
      ↓
Recurso liberado
```

---

# mounted

O código também utiliza:

```dart
if (!mounted) {
  return;
}
```

O `mounted` informa se o `State` ainda está associado à árvore de widgets.

Isso evita tentar executar:

```dart
setState()
```

quando o widget já foi removido.

Portanto:

```dart
if (!mounted) {
  return;
}
```

significa:

> Se o widget não estiver mais ativo, não continue a atualização.

---

# 🎯 Conceito principal

O exercício demonstra a importância de liberar recursos no ciclo de vida do Flutter.

```text
initState()
    ↓
Inicia recursos

dispose()
    ↓
Libera recursos
```

Sempre que um `StatefulWidget` utiliza recursos como:

* `Timer`;
* `Stream`;
* `AnimationController`;
* `TextEditingController`;
* `ScrollController`;
* listeners;

é importante verificar se esses recursos precisam ser encerrados no `dispose()`.

---

# 📊 Comparação dos Exercícios

| Exercício | Tecnologia         | Objetivo                 |
| --------- | ------------------ | ------------------------ |
| 1         | `ListView.builder` | Otimizar listas          |
| 2         | `GridView.builder` | Criar dashboard em grade |
| 3         | `dispose()`        | Liberar recursos         |

---

# 🧠 Conceitos aprendidos

## 1. Construção sob demanda

`ListView.builder` e `GridView.builder` permitem criar elementos conforme necessário.

Isso é especialmente importante para grandes quantidades de dados.

---

## 2. Viewport

O viewport representa a região da interface que está sendo exibida.

Os widgets de scroll podem trabalhar de maneira eficiente com essa região e com elementos próximos dela.

---

## 3. Delegates

O:

```dart
SliverGridDelegateWithFixedCrossAxisCount
```

é responsável por definir a organização da grade.

---

## 4. Ciclo de vida

Um `StatefulWidget` possui diferentes etapas durante sua existência.

Neste projeto foram utilizados principalmente:

```dart
initState()
```

para inicialização e:

```dart
dispose()
```

para limpeza dos recursos.

---

## 5. Gerenciamento de memória

O objetivo não é apenas fazer a aplicação funcionar, mas também garantir que recursos utilizados sejam liberados quando não forem mais necessários.

---

# ▶️ Como executar

Com o Flutter instalado, abra o terminal na pasta do projeto e execute:

```bash
flutter pub get
```

Depois:

```bash
flutter run
```

Também é possível executar pelo botão **Run** do VS Code ou Android Studio.

---

# 📱 Funcionamento da aplicação

Ao iniciar o aplicativo, será apresentado um menu:

```text
Exercícios Flutter

[ Exercício 1 - ListView.builder ]

[ Exercício 2 - GridView.builder ]

[ Exercício 3 - dispose() ]
```

Cada botão abre o exercício correspondente.

---

# 🏭 Contexto dos exercícios

Os exemplos foram adaptados para um cenário de **monitoramento industrial**, utilizando conceitos como:

* registros de máquinas;
* sensores;
* temperatura;
* pressão;
* vibração;
* consumo de energia;
* status de equipamentos.

Dessa forma, os conceitos de Flutter são aplicados em um contexto próximo de uma aplicação real de telemetria industrial.

---

# ✅ Conclusão

Os três exercícios trabalham diferentes aspectos importantes do Flutter:

**Exercício 1** demonstra como otimizar listas utilizando `ListView.builder`.

**Exercício 2** demonstra como criar dashboards utilizando `GridView.builder` e `SliverGridDelegateWithFixedCrossAxisCount`.

**Exercício 3** demonstra como gerenciar corretamente recursos durante o ciclo de vida de um `StatefulWidget`, utilizando `dispose()` para cancelar um `Timer`.

Juntos, os exercícios mostram que uma aplicação Flutter eficiente não depende apenas da criação da interface, mas também de uma boa organização dos widgets, gerenciamento dos recursos e preocupação com desempenho.
