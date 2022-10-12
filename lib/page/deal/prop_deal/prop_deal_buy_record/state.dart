import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_list.dart';

class PropDealBuyRecordState implements Cloneable<PropDealBuyRecordState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<Order> orders;

  @override
  PropDealBuyRecordState clone() {
    return PropDealBuyRecordState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..orders = orders;
  }
}

PropDealBuyRecordState initState(Map<String, dynamic> args) {
  return PropDealBuyRecordState()..orders = List();
}
