import 'dart:convert';

import 'package:finance_image/asset_image_path.dart';
import 'package:finance_image/asset_logo.dart';
import 'package:finance_image/config.dart';
import 'package:http/http.dart' as http;

Future<List<AssetLogo>> fetchBrFiis() async {
  final response = await http.get(
    Uri.parse(Config.instance.fetchBrFiis),
    headers: const {
      'accept': 'application/json',
      'x-requested-with': 'XMLHttpRequest',
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
                '${Config.instance.fetchBrFiisUrlImage}/${item['companyid']}.jpg',
            folder: AssetImagePath.brFiis.path,
          ),
        )
        .toList();
  }

  return [];
}
