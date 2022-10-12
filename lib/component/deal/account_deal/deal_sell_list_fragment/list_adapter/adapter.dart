import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/component.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/state.dart'
    as index_deal_item_state;

import '../state.dart';
import 'reducer.dart';

class DealSellListAdapter extends DynamicFlowAdapter<DealSellListState> {
  DealSellListAdapter()
      : super(
          pool: <String, Component<Object>>{
            IndexDealItemComponent.componentName: IndexDealItemComponent()
          },
          connector: _DealSellListConnector(),
          reducer: buildReducer(),
        );
}

class _DealSellListConnector extends ConnOp<DealSellListState, List<ItemBean>> {
  @override
  List<ItemBean> get(DealSellListState state) {
    return state.dealGoodsList
        .map((dealGoods) => ItemBean(IndexDealItemComponent.componentName,
            index_deal_item_state.initState(dealGoods)))
        .toList();
  }

  @override
  void set(DealSellListState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
