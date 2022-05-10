import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:recrutmenttest/core/enum/quote_enum.dart';
import 'package:recrutmenttest/core/enum/type_enum.dart' as type_enum;

extension Extension on Object? {
  String toDashIfEmpty() {
    if (this == null) {
      return '-';
    } else if (this == 'null' || this == "null") {
      return '-';
    } else if (this is num) {
      return toString();
    } else if (this is String) {
      return toString();
    } else {
      return '-';
    }
  }
}

extension QuoteToString on Quote {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension TypeToString on type_enum.Type {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension DoubleExtension on double? {
  String currencyFormat() {
    if (this == null) return '-';

    double value = this!;
    return FlutterMoneyFormatter(amount: value).output.compactSymbolOnLeft;
  }

  String levelCurrencyFormat() {
    if (this == null) return '-';

    double value = this!;
    return FlutterMoneyFormatter(amount: value).output.symbolOnLeft;
  }
}
