import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/page/deal/deal_config.dart';

class PropDealBuyState implements Cloneable<PropDealBuyState> {
  Goods goods;
  List<TextEditingController> textEditingControllers;

  @override
  PropDealBuyState clone() {
    return PropDealBuyState()
      ..goods = goods
      ..textEditingControllers = textEditingControllers;
  }
}

PropDealBuyState initState(Goods goods) {
  var edits = [1, 2, 3, 4, 5, 6];
  return PropDealBuyState()
    ..goods = goods
    ..textEditingControllers = List()
    ..textEditingControllers
        .addAll(edits.map((index) => TextEditingController()).toList());
}
