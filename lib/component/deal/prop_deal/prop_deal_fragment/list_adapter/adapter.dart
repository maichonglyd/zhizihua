import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_filter/component.dart';

import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_head/component.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_head/state.dart'
    as head_state;
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_item/component.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_item/state.dart'
    as item_state;

import '../state.dart';
import 'reducer.dart';

class PropDealListAdapter extends DynamicFlowAdapter<PropDealFragmentState> {
  PropDealListAdapter()
      : super(
          pool: <String, Component<Object>>{
            PropDealHeadComponent.componentName: PropDealHeadComponent(),
            PropDealItemComponent.componentName: PropDealItemComponent(),
            PropDealFilterComponent.componentName: PropDealFilterComponent(),
          },
          connector: _PropDealListAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _PropDealListAdapterConnector
    extends ConnOp<PropDealFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(PropDealFragmentState state) {
    List<ItemBean> items = <ItemBean>[
      ItemBean(PropDealHeadComponent.componentName,
          head_state.initState(state.dealPropIndexData)),
      ItemBean(
          PropDealFilterComponent.componentName, state.propDealFilterState),
    ];
    items.addAll(state.goodsList
        .map((goods) => ItemBean(
            PropDealItemComponent.componentName, item_state.initState(goods)))
        .toList());
    return items;
  }

  @override
  void set(PropDealFragmentState state, List<ItemBean> items) {
    for (ItemBean item in items) {
      if (item.type == PropDealFilterComponent.componentName) {
        state.propDealFilterState = item.data;
      }
    }
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
