import 'dart:convert';
import 'dart:io';

final class Config {
  Config._({
    required this.fetchBrFiis,
    required this.fetchBrFiisUrlImage,
    required this.fetchBrStocks,
    required this.fetchBrStocksUrlImage,
  });

  static final Config instance = _load();

  static Config _load() {
    final json =
        jsonDecode(File('config.json').readAsStringSync())
            as Map<String, dynamic>;

    return Config._(
      fetchBrFiis: json['fetch_br_fiis'] as String,
      fetchBrFiisUrlImage: json['fetch_br_fiis_url_image'] as String,
      fetchBrStocks: json['fetch_br_stocks'] as String,
      fetchBrStocksUrlImage: json['fetch_br_stocks_url_image'] as String,
    );
  }

  final String fetchBrFiis;
  final String fetchBrFiisUrlImage;
  final String fetchBrStocks;
  final String fetchBrStocksUrlImage;
}
