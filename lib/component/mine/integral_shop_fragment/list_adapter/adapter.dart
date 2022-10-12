import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/gift/my_gift_item/component.dart';
import 'package:flutter_huoshu_app/component/mine/integral_shop_fragment/state.dart';
import 'package:flutter_huoshu_app/component/mine/integral_shop_item/component.dart';
import 'package:flutter_huoshu_app/component/mine/integral_shop_item/state.dart'
    as integral_shop_state;

import 'reducer.dart';

class IntegralShopListAdapter
    extends DynamicFlowAdapter<IntegralShopFragmentState> {
  IntegralShopListAdapter()
      : super(
          pool: <String, Component<Object>>{
            IntegralShopItemComponent.componentName: IntegralShopItemComponent()
          },
          connector: _IntegralShopListConnector(),
          reducer: buildReducer(),
        );
}

class _IntegralShopListConnector
    extends ConnOp<IntegralShopFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(IntegralShopFragmentState state) {
    return state.goodsList
        .map((goods) => ItemBean(IntegralShopItemComponent.componentName,
            integral_shop_state.initState(goods)))
        .toList();
  }

  @override
  void set(IntegralShopFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
