import 'package:flutter/material.dart';
import 'package:recrutmenttest/core/model/crypto_rate.dart';
import 'package:recrutmenttest/ui/helpers/ui_helpers.dart';
import 'package:recrutmenttest/ui/views/home/list_header.dart';
import 'package:recrutmenttest/ui/views/home/row_item.dart';

class ContentList extends StatefulWidget {
  final List<CryptoRate> data;
  final Function(int columnNumber) sortFunction;
  final int? selectedColumn;

  const ContentList({
    Key? key,
    required this.data, required this.sortFunction, this.selectedColumn,
  }) : super(key: key);

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          ListHeader(columnNames: const ['Symbol', 'Last Price', 'Volume'], sortAction: widget.sortFunction, selectedColumn: widget.selectedColumn),
          Expanded(
            child: (widget.data.isEmpty)
                ? UIHelper.getTableEmptyLine('No items to view !')
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return RowItem(pos: (index + 1), row: widget.data[index]);
                    },
                  )),
        ],
      );
  }
}
