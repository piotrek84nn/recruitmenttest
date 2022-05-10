import 'package:flutter/material.dart';
import 'package:recrutmenttest/core/enum/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  Future<bool> backAction() async {
    return true;
  }

  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setBusy(bool isBusy) {
    _state = isBusy ? ViewState.busy : ViewState.idle;
    notifyListeners();
  }
}
