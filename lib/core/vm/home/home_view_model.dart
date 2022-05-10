import 'dart:async';
import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:recrutmenttest/core/enum/type_enum.dart' as enum_type;
import 'package:recrutmenttest/core/helpers/extension.dart';
import 'package:recrutmenttest/core/model/crypto_rate.dart';
import 'package:recrutmenttest/core/vm/base_model.dart';

class HomeViewModel extends BaseViewModel {
  static const int ascendingtSort = 0;
  static const int descendingSort = 1;
  static const int defaultSort = 2;
  late TabController tabController;
  late TextEditingController _patternCtrl;

  int _sortType = ascendingtSort;
  List<CryptoRate> _data = <CryptoRate>[];

  int? _columnNumber;
  int? get columnNumber => _columnNumber;
  set columnNumber(int? value) {
    _columnNumber = value;
    notifyListeners();
  }

  List<CryptoRate> _resultList = <CryptoRate>[];
  List<CryptoRate> get resultList => _resultList;
  set resultList(List<CryptoRate> list) {
    _resultList = list;
    notifyListeners();
  }

  Future initModel(TextEditingController patCtrl) async {
    setBusy(true);
    tabController.index = 0;
    _patternCtrl = patCtrl;
    tabController.addListener(onTabChange);
    await onTabChange();
    setBusy(false);
    notifyListeners();
  }

  Future<void> _getData(int idx) async {
    var jsonText = await rootBundle.loadString('assets/data.json');
    switch (idx) {
      case 0:
        _data = cryptoRateFromJson(jsonText);
        break;
      case 1:
        _data = cryptoRateFromJson(jsonText)
            .where((element) => element.type == enum_type.Type.spot)
            .toList();
        break;
      case 2:
        _data = cryptoRateFromJson(jsonText)
            .where((element) => element.type == enum_type.Type.futures)
            .toList();
        break;
    }
  }

  void _mainSortOfData(int idx) {
    switch (idx) {
      case 0:
        _data.sort((a, b) {
          int nameComp = a.symbol.compareTo(b.symbol);
          if (nameComp == 0) {
            return a.priority.compareTo(b.priority);
          }
          return nameComp;
        });
        break;
      default:
        _data.sort((a, b) {
          int nameComp = a.priority.compareTo(b.priority);
          if (nameComp == 0) {
            return -a.volume!.compareTo(b.volume!);
          }
          return nameComp;
        });
        break;
    }
  }

  void _sortForSelectedColumn(int? columnNumber) {
    if (_sortType == defaultSort) {
      _mainSortOfData(tabController.index);
    } else {
      int mul = (_sortType == descendingSort) ? -1 : 1;
      switch (columnNumber) {
        case 0:
          _data.sort((a, b) {
            return mul *
                (a.base!.toLowerCase() +
                        a.quote!.toShortString().toLowerCase() +
                        a.type!.toShortString().toLowerCase())
                    .compareTo(a.base!.toLowerCase() +
                        a.quote!.toShortString().toLowerCase() +
                        a.type!.toShortString().toLowerCase());
          });
          break;
        case 1:
          _data.sort((a, b) {
            return mul * a.lastPrice!.compareTo(b.lastPrice!);
          });
          break;
        case 2:
          _data.sort((a, b) {
            return mul * a.volume!.compareTo(b.volume!);
          });
          break;
      }
    }
  }

  sortResultList(int columnNr) async {
    if (columnNumber != columnNr) {
      _sortType = ascendingtSort;
    }
    columnNumber = columnNr;
    await _getData(tabController.index);
    resultList.clear();
    _prepareDataForView(columnNumber);
    _sortType++;
    if(_sortType == 3) {
      _sortType = 0;
    }
    notifyListeners();
  }

  void _prepareDataForView(int? selectedColumn) {
    if (_data.isNotEmpty) {
      _sortForSelectedColumn(selectedColumn);
      for (CryptoRate element in _data) {
        resultList.add(CryptoRate.clone(element));
      }
      _data.clear();
    }
  }

  Future<void> onTabChange() async {
    _sortType = ascendingtSort;
    columnNumber = null;
    _patternCtrl.clear();
    await _getData(tabController.index);
    resultList.clear();
    _prepareDataForView(-1);
    notifyListeners();
  }

  Future filterItemsOnList(String pattern) async {
    if (pattern.isNotEmpty) {
      if(_data.isEmpty) {
        for (CryptoRate element in resultList) {
          _data.add(CryptoRate.clone(element));
        }
      }
      resultList = _data
          .where((element) =>
          element.base!.toLowerCase().contains(pattern.toLowerCase()))
          .toList();
    } else {
      if(_data.isNotEmpty) {
        resultList.clear();
        for (CryptoRate element in _data) {
          resultList.add(CryptoRate.clone(element));
        }
        _data.clear();
      }
    }
    notifyListeners();
  }

  @override
  Future<bool> backAction() async {
    return false;
  }

  @override
  void dispose() {
    tabController.dispose();
    tabController.removeListener(onTabChange);
    super.dispose();
  }
}
