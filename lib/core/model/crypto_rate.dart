import 'dart:convert';

import 'package:recrutmenttest/core/enum/quote_enum.dart';
import 'package:recrutmenttest/core/enum/type_enum.dart';
import 'package:recrutmenttest/core/helpers/extension.dart';

List<CryptoRate> cryptoRateFromJson(String str) =>
    List<CryptoRate>.from(json.decode(str).map((x) => CryptoRate.fromJson(x)));

class CryptoRate {
  String? base;
  Quote? quote;
  Type? type;
  double? lastPrice;
  double? volume;
  int priority = 0;
  String symbol = '-';

  CryptoRate(
      {required this.base,
      required this.quote,
      required this.type,
      required this.lastPrice,
      required this.volume,
      this.priority = 0,
      this.symbol = ''});

  CryptoRate.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    quote = quoteValues.map[json["quote"]];
    type = typeValues.map[json["type"]];
    lastPrice = json['lastPrice'];
    volume = json['volume'];
    priority = _setPriority();
    symbol = _setSymbol();
  }

  int _setPriority() {
    if ((base == 'BTC' || base == 'ETH' || base == 'WOO')) {
      return 1;
    } else if (base == 'USDT') {
      return 2;
    } else if (base == 'USDC') {
      return 3;
    } else {
      return 4;
    }
  }

  String _setSymbol() {
    switch (type) {
      case Type.spot:
        return '${base!}/${quote!.toShortString()}';
      default:
        return '${base!}-PERP';
    }
  }

  factory CryptoRate.clone(CryptoRate source) {
    return CryptoRate(
        base: source.base,
        quote: source.quote,
        type: source.type,
        lastPrice: source.lastPrice,
        volume: source.volume,
        priority: source.priority,
        symbol: source.symbol);
  }
}
