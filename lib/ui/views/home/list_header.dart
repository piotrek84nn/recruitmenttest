import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ListHeader extends StatefulWidget {
  final List<String> columnNames;
  final Function(int columnNumber) sortAction;
  final int? selectedColumn;

  const ListHeader(
      {Key? key,
      required this.columnNames,
      required this.sortAction,
      this.selectedColumn})
      : super(key: key);

  @override
  _ListHeaderState createState() => _ListHeaderState();
}

class StringValue {}

class _ListHeaderState extends State<ListHeader> {
  Color bgColor = Colors.transparent;

  List<Widget> _createHeaderList() {
    List<Widget> result = [];
    for (int i = 0; i < widget.columnNames.length; i++) {
      result.add(Expanded(
        flex: 1,
        child: InkWell(
            onTap: () => {
                  bgColor = Colors.lightBlueAccent,
                  widget.sortAction(i),
                },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              color: widget.selectedColumn == null
                  ? Colors.transparent
                  : i == widget.selectedColumn
                      ? Colors.lightBlueAccent
                      : Colors.transparent,
              child: Row(
                mainAxisAlignment:
                    i == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(
                    widget.columnNames[i],
                    style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                      onPressed: null,
                      icon: const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.compare_arrows, size: 26)),
                      label: const Text('')),
                ],
              ),
            )),
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
        height: 45,
        child: Row(children: _createHeaderList()));
  }
}
