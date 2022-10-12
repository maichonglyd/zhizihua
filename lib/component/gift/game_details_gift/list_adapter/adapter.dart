import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/gift/gift_item/component.dart';
import 'package:flutter_huoshu_app/component/gift/gift_item/state.dart'
    as gift_item_state;
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';

import '../state.dart';
import 'reducer.dart';

class GiftListAdapter extends DynamicFlowAdapter<GameDetailsGiftFragmentState> {
  GiftListAdapter()
      : super(
          pool: <String, Component<Object>>{
            GiftItemComponent.componentName: GiftItemComponent(),
            IndexRowGameComponent.componentName: IndexRowGameComponent(),
          },
          connector: _GiftListConnector(),
          reducer: buildReducer(),
        );
}

class _GiftListConnector
    extends ConnOp<GameDetailsGiftFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(GameDetailsGiftFragmentState state) {
    List<ItemBean> items = List();
    if (state.gifts != null) {
      items.addAll(state.gifts
          .map((gift) => ItemBean(
              GiftItemComponent.componentName, gift_item_state.initState(gift)))
          .toList());
    }
    items
        .add(ItemBean(IndexRowGameComponent.componentName, state.rowGameState));
    return items;
  }

  @override
  void set(GameDetailsGiftFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
