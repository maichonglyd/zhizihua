import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/rebate/rebate_game_item/component.dart';
import 'package:flutter_huoshu_app/component/rebate/rebate_game_item/state.dart'
    as rebate_game_item_state;

import 'reducer.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/state.dart';

class RebateGameListAdapter extends DynamicFlowAdapter<RebateApplyState> {
  RebateGameListAdapter()
      : super(
          pool: <String, Component<Object>>{
            RebateGameItemComponent.componentName: RebateGameItemComponent(),
          },
          connector: _RebateGameListConnector(),
          reducer: buildReducer(),
        );
}

class _RebateGameListConnector
    extends ConnOp<RebateApplyState, List<ItemBean>> {
  @override
  List<ItemBean> get(RebateApplyState state) {
    List<ItemBean> items = List();
    if (state.rebateGames != null) {
      items.addAll(state.rebateGames
          .map((rebateGame) => ItemBean(RebateGameItemComponent.componentName,
              rebate_game_item_state.initState(rebateGame)))
          .toList());
    }
    return items;
  }

  @override
  void set(RebateApplyState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
