import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/component.dart';
import 'package:flutter_huoshu_app/component/index/jp_top_item/component.dart';

import 'reducer.dart';

class JpAdapter extends DynamicFlowAdapter<JpFragmentState> {
  JpAdapter()
      : super(
          pool: <String, Component<Object>>{
            "jp_item": JPGameItemComponent(),
            JPTopItemComponent.componentName: JPTopItemComponent(),
          },
          connector: _JpAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _JpAdapterConnector extends ConnOp<JpFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(JpFragmentState state) {
    List<ItemBean> itemBeans = List();
    int i = 0;
    for (JPGameItemState state in state.jpGameStates) {
      if (i == 0) {
        itemBeans.add(ItemBean(JPTopItemComponent.componentName, state));
      } else {
        itemBeans.add(ItemBean("jp_item", state));
      }
      i++;
    }
    return itemBeans;
  }

  @override
  void set(JpFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
