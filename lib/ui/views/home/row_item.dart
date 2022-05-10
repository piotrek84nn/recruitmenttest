import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recrutmenttest/core/model/crypto_rate.dart';
import 'package:recrutmenttest/core/helpers/extension.dart';

class RowItem extends StatefulWidget {
  final int pos;
  final CryptoRate row;

  const RowItem({Key? key, required this.pos, required this.row})
      : super(key: key);

  @override
  _RowItemState createState() => _RowItemState();
}

class StringValue {}

class _RowItemState extends State<RowItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        height: 45,
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 3.0),
                child: Text(widget.row.symbol.toDashIfEmpty())),
          ),
          Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(left: 3.0),
                child: Text(
                  widget.row.lastPrice!.levelCurrencyFormat(),
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(left: 3.0),
                child: Text(
                  widget.row.volume.currencyFormat(),
                )),
          )
        ]));
  }
}
