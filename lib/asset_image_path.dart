enum AssetImagePath {
  brStocks,
  brFiis;

  String get path {
    switch (this) {
      case AssetImagePath.brStocks:
        return 'images/br/stocks';
      case AssetImagePath.brFiis:
        return 'images/br/fiis';
    }
  }
}
