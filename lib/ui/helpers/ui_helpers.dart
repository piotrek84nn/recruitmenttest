import 'package:flutter/material.dart';

class UIHelper {
  static Widget mainScreenContainer(Widget child) {
    return Stack(alignment: Alignment.center, children: <Widget>[child]);
  }

  static Widget getTableEmptyLine(String text) {
    return Container(
      padding: const EdgeInsets.all(6),
      alignment: Alignment.topLeft,
      child: Text(text,
          style: const TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.black)),
    );
  }

  static Widget getCircularProgressIndicator() {
    return const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue)));
  }
}
