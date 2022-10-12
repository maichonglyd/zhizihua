import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';

class DealItemTitleState implements Cloneable<DealItemTitleState> {
  String title;
  List<String> types = [getText(name: 'textShelfToNew'), getText(name: 'textHighToLowPrice'), getText(name: 'textLowToHighPrice')];
  int typeIndex = 0;
  @override
  DealItemTitleState clone() {
    return DealItemTitleState()
      ..title = title
      ..types = types;
  }
}

DealItemTitleState initState(String title) {
  return DealItemTitleState()..title = title;
}
