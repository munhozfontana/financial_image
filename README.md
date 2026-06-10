# Asset Logo Downloader

Script responsável por baixar e armazenar localmente as logos dos ativos.

## Estrutura de pastas

As imagens são salvas automaticamente na seguinte estrutura:

```text
images/
├── br/
│   ├── stocks/
│   ├── fiis/
│   └── etf/
└── us/
    ├── stocks/
    └── etf/
```

O nome de cada arquivo é o ticker em lowercase.

Exemplos:

```text
images/br/stocks/petr4.jpg
images/br/stocks/vale3.jpg
images/br/fiis/xplg11.jpg
images/us/stocks/aapl.jpg
images/us/stocks/msft.jpg
```

## Pré-requisitos

* Dart SDK 3.0+

Verifique a instalação:

```bash
dart --version
```

## Dependências

Instale a dependência HTTP:

```bash
dart pub add http
```

Ou adicione manualmente ao `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.5.0
```

Depois execute:

```bash
dart pub get
```

## Executando

Execute o script:

```bash
dart run lib/finance_image.dart
```

(dependendo do local onde o arquivo foi salvo)

## Como funciona

1. Consome as APIs configuradas.
2. Obtém ticker e URL da logo.
3. Cria as pastas automaticamente caso não existam.
4. Verifica se a imagem já foi baixada.
5. Baixa apenas as logos faltantes.
6. Salva a imagem utilizando o ticker em lowercase.

## Adicionando uma nova API

Crie um novo método retornando uma lista de `AssetLogo`:

```dart
Future<List<AssetLogo>> fetchMyApi() async {
  final response = await http.get(
    Uri.parse('https://minha-api.com/assets'),
  );

  final List<dynamic> list = jsonDecode(response.body);

  return list.map((item) {
    return AssetLogo(
      ticker: item['ticker'],
      logoUrl: item['logo'],
      folder: 'images/br/stocks',
    );
  }).toList();
}
```

Adicione a chamada no `main()`:

```dart
assets.addAll(await fetchMyApi());
```

## Logs

Durante a execução serão exibidos:

```text
✅ PETR4
✅ VALE3
⏭ ITUB4
❌ ABCD3
```

Onde:

* ✅ Download realizado com sucesso
* ⏭ Arquivo já existente
* ❌ Erro ao baixar a imagem

```

## Observações

- As imagens existentes não são sobrescritas.
- Os diretórios são criados automaticamente.
- O script pode ser executado quantas vezes forem necessárias.
- Apenas logos inexistentes serão baixadas novamente.
```
