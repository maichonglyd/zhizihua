import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'reducer.dart';

class GameListAdapter extends DynamicFlowAdapter<GameListState> {
  GameListAdapter()
      : super(
          pool: <String, Component<Object>>{
            BTGameItemComponent.componentName: BTGameItemComponent()
          },
          connector: _GameListAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _GameListAdapterConnector extends ConnOp<GameListState, List<ItemBean>> {
  @override
  List<ItemBean> get(GameListState state) {
    List<ItemBean> items = List();
    if (state.games != null) {
      for (Game game in state.games) {
        items.add(new ItemBean(
            BTGameItemComponent.componentName, BTGameItemState()..game = game));
      }
    }

    return items;
  }

  @override
  void set(GameListState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
