import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/gift/my_gift_item/component.dart';
import 'package:flutter_huoshu_app/component/gift/my_gift_item/state.dart'
    as my_gift_item_state;

import '../state.dart';
import 'reducer.dart';

class MyGiftListAdapter extends DynamicFlowAdapter<MyGiftState> {
  MyGiftListAdapter()
      : super(
          pool: <String, Component<Object>>{
            MyGiftItemComponent.componentName: MyGiftItemComponent()
          },
          connector: _MyGiftListAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _MyGiftListAdapterConnector extends ConnOp<MyGiftState, List<ItemBean>> {
  @override
  List<ItemBean> get(MyGiftState state) {
    List<ItemBean> items = List();
    if (state.gifts != null) {
      items.addAll(state.gifts
          .map((gift) => ItemBean(MyGiftItemComponent.componentName,
              my_gift_item_state.initState(gift)))
          .toList());
    }

    return items;
  }

  @override
  void set(MyGiftState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
