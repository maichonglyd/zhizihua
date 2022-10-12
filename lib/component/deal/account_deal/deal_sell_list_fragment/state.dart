import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/state.dart'
    as deal_item_state;
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';

class DealSellListState implements Cloneable<DealSellListState> {
  int type = 0; //0 全部，1正在出售 2已经出售
  List<DealGoods> dealGoodsList;

  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;

  @override
  DealSellListState clone() {
    return DealSellListState()
      ..type = type
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..dealGoodsList = dealGoodsList;
  }
}

DealSellListState initState(int type) {
  return DealSellListState()
    ..type = type
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController()
    ..dealGoodsList = List();
}

class DealItemConnector
    extends ConnOp<DealSellListState, deal_item_state.IndexDealItemState> {
  @override
  void set(
      DealSellListState state, deal_item_state.IndexDealItemState subState) {
//    super.set(state, subState);
  }

  @override
  deal_item_state.IndexDealItemState get(DealSellListState state) {
    return deal_item_state.initState(null);
  }
}
