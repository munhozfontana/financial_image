import 'dart:convert';

import 'package:finance_image/asset_image_path.dart';
import 'package:finance_image/asset_logo.dart';
import 'package:finance_image/config.dart';
import 'package:http/http.dart' as http;

Future<List<AssetLogo>> fetchBrStocks() async {
  final response = await http.get(
    Uri.parse(Config.instance.fetchBrStocks),
    headers: const {
      'accept': 'application/json',
      'x-requested-with': 'XMLHttpRequest',
      'User-Agent': 'Mozilla/5.0',
    },
  );

  final decoded = jsonDecode(response.body);

  if (decoded case {'list': final List<dynamic> list}) {
    return list
        .where((item) => item['ticker'] != null && item['companyid'] != null)
        .map(
          (item) => AssetLogo(
            ticker: item['ticker'],
            logoUrl:
                '${Config.instance.fetchBrStocksUrlImage}/${item['companyid']}.jpg',
            folder: AssetImagePath.brStocks.path,
          ),
        )
        .toList();
  }

  return [];
}
