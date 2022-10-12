import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/component.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/state.dart'
    as index_deal_item_state;

import '../state.dart';
import 'reducer.dart';

class GameListAdapter extends DynamicFlowAdapter<DealSearchState> {
  GameListAdapter()
      : super(
          pool: <String, Component<Object>>{
            IndexDealItemComponent.componentName: IndexDealItemComponent(),
          },
          connector: _ListAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _ListAdapterConnector extends ConnOp<DealSearchState, List<ItemBean>> {
  @override
  List<ItemBean> get(DealSearchState state) {
    return state.dealGoods
        .map((dealGoods) => ItemBean(IndexDealItemComponent.componentName,
            index_deal_item_state.initState(dealGoods)))
        .toList();
  }

  @override
  void set(DealSearchState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
