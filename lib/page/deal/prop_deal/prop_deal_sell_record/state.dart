import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';

class PropDealSellRecordState implements Cloneable<PropDealSellRecordState> {
  List<Goods> goodsList;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  PropDealSellRecordState clone() {
    return PropDealSellRecordState()
      ..goodsList = goodsList
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

PropDealSellRecordState initState(Map<String, dynamic> args) {
  return PropDealSellRecordState()..goodsList = List();
}
