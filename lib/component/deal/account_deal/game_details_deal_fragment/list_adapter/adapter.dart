import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/component.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/state.dart'
    as index_deal_item;
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';

import '../state.dart';
import 'reducer.dart';

class DealListAdapter extends DynamicFlowAdapter<GameDetailsDealFragmentState> {
  DealListAdapter()
      : super(
          pool: <String, Component<Object>>{
            IndexDealItemComponent.componentName: IndexDealItemComponent(),
            IndexRowGameComponent.componentName: IndexRowGameComponent(),
          },
          connector: _DealListConnector(),
          reducer: buildReducer(),
        );
}

class _DealListConnector
    extends ConnOp<GameDetailsDealFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(GameDetailsDealFragmentState state) {
    List<ItemBean> items = state.dealGoods
        .map((dealGoods) => ItemBean(IndexDealItemComponent.componentName,
            index_deal_item.initState(dealGoods)))
        .toList();

    items
        .add(ItemBean(IndexRowGameComponent.componentName, state.rowGameState));
    return items;
  }

  @override
  void set(GameDetailsDealFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
