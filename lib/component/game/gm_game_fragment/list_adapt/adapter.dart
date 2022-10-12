import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/gm_game_fragment/gm_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/gm_game_fragment/gm_game_item/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import '../state.dart';
import 'reducer.dart';

class GmGameAdapter extends DynamicFlowAdapter<GMGameFragmentState> {
  GmGameAdapter()
      : super(
          pool: <String, Component<Object>>{
            GmGameItemComponent.componentName: GmGameItemComponent(),
          },
          connector: _GmGameConnector(),
          reducer: buildReducer(),
        );
}

class _GmGameConnector extends ConnOp<GMGameFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(GMGameFragmentState state) {
    List<ItemBean> itemBeans = <ItemBean>[];
    if (state.gameList != null) {
      for (Game game in state.gameList) {
        itemBeans.add(new ItemBean(
            GmGameItemComponent.componentName,
            GmGameItemState()
              ..game = game
              ..type = state.type));
      }
    }
    return itemBeans;
  }

  @override
  void set(GMGameFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
