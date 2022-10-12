import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart'
    as game_item_state;

import '../state.dart';
import 'reducer.dart';

class GameListAdapter extends DynamicFlowAdapter<GameSearchState> {
  GameListAdapter()
      : super(
          pool: <String, Component<Object>>{
            BTGameItemComponent.componentName: BTGameItemComponent(),
          },
          connector: _ListAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _ListAdapterConnector extends ConnOp<GameSearchState, List<ItemBean>> {
  @override
  List<ItemBean> get(GameSearchState state) {
    return state.games
        .map((game) => ItemBean(
            BTGameItemComponent.componentName, game_item_state.initState(game)))
        .toList();
  }

  @override
  void set(GameSearchState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
