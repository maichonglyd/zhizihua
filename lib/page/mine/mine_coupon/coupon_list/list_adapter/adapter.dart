import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_item/state.dart'
    as bt_item_status;
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_item/component.dart';

import '../state.dart';
import 'reducer.dart';

class DownloadGameListAdapter extends DynamicFlowAdapter<CouponListState> {
  DownloadGameListAdapter()
      : super(
          pool: <String, Component<Object>>{
            CouponItemComponent.componentName: CouponItemComponent(),
          },
          connector: _DownloadGameListConnector(),
          reducer: buildReducer(),
        );
}

class _DownloadGameListConnector
    extends ConnOp<CouponListState, List<ItemBean>> {
  @override
  List<ItemBean> get(CouponListState state) {
    return state.testDatas
        .map((game) => ItemBean(
            CouponItemComponent.componentName, bt_item_status.initState(game)))
        .toList();
  }

  @override
  void set(CouponListState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
