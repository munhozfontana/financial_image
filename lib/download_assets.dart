import 'dart:io';

import 'package:finance_image/asset_logo.dart';
import 'package:http/http.dart' as http;

Future<void> downloadAssets(List<AssetLogo> assets) async {
  for (final asset in assets) {
    try {
      final directory = Directory(asset.folder);

      await directory.create(recursive: true);

      final file = File('${directory.path}/${asset.ticker.toUpperCase()}.jpg');

      await Future.delayed(const Duration(milliseconds: 500));

      final imageResponse = await http.get(Uri.parse(asset.logoUrl));

      if (imageResponse.statusCode != 200) {
        print('❌ ${asset.ticker}');
        continue;
      }

      await file.writeAsBytes(imageResponse.bodyBytes, flush: true);

      print('✅ ${asset.ticker}');
    } catch (e) {
      print('❌ ${asset.ticker}: $e');
    }
  }
}
