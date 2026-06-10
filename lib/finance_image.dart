import 'package:finance_image/asset_logo.dart';
import 'package:finance_image/download_assets.dart';
import 'package:finance_image/fetchs/fetch_br_fiis.dart';
import 'package:finance_image/fetchs/fetch_br_stocks.dart';

Future<void> main() async {
  final stopwatch = Stopwatch()..start();

  final assets = <AssetLogo>[];

  assets.addAll(await fetchBrStocks());
  assets.addAll(await fetchBrFiis());

  await downloadAssets(assets);

  stopwatch.stop();

  print('Finalizado em ${stopwatch.elapsed.inSeconds}s');
}
