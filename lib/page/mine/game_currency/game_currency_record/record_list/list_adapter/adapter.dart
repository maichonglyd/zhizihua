import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_item/state.dart'
    as bt_item_status;
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_item/component.dart';

import '../state.dart';
import 'reducer.dart';

class DownloadGameListAdapter extends DynamicFlowAdapter<CurrRecordListState> {
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
    extends ConnOp<CurrRecordListState, List<ItemBean>> {
  @override
  List<ItemBean> get(CurrRecordListState state) {
    return state.testDatas
        .map((game) => ItemBean(
            CouponItemComponent.componentName, bt_item_status.initState(game)))
        .toList();
  }

  @override
  void set(CurrRecordListState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
