import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/deal/deal_my_order_list_data.dart';

class MyBuyListState implements Cloneable<MyBuyListState> {
  List<Order> orders;

  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  MyBuyListState clone() {
    return MyBuyListState()
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper
      ..orders = orders;
  }
}

MyBuyListState initState(Map<String, dynamic> args) {
  return MyBuyListState()
    ..refreshHelperController = RefreshHelperController()
    ..refreshHelper = RefreshHelper()
    ..orders = List();
}
