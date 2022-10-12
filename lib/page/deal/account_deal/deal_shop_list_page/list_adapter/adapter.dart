import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/component.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/state.dart'
    as index_deal_state;

import '../state.dart';
import 'reducer.dart';

class DealListAdapter extends DynamicFlowAdapter<DealShopListPageState> {
  DealListAdapter()
      : super(
          pool: <String, Component<Object>>{
            IndexDealItemComponent.componentName: IndexDealItemComponent(),
          },
          connector: _DealListConnector(),
          reducer: buildReducer(),
        );
}

class _DealListConnector extends ConnOp<DealShopListPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(DealShopListPageState state) {
    return state.dealGoodsList
        .map((dealGoods) => ItemBean(IndexDealItemComponent.componentName,
            index_deal_state.initState(dealGoods)))
        .toList();
  }

  @override
  void set(DealShopListPageState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
