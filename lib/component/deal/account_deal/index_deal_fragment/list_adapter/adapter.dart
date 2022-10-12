import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/state.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_head/component.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_head/state.dart'
    as deal_head_state;
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/component.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item/state.dart'
    as deal_item_state;
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item_title/component.dart';

import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_playing/component.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_playing/state.dart'
    as deal_playing_state;
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'reducer.dart';

class IndexDealAdapter extends DynamicFlowAdapter<IndexDealFragmentState> {
  IndexDealAdapter()
      : super(
          pool: <String, Component<Object>>{
            IndexDealHeadComponent.componentName: IndexDealHeadComponent(),
            IndexDealItemComponent.componentName: IndexDealItemComponent(),
            DealItemTitleComponent.componentName: DealItemTitleComponent(),
            DealPlayingComponent.componentName: DealPlayingComponent(),
            EmptyComponent.componentName: EmptyComponent(),
          },
          connector: _IndexDealConnector(),
          reducer: buildReducer(),
        );
}

class _IndexDealConnector
    extends ConnOp<IndexDealFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(IndexDealFragmentState state) {
    List<ItemBean> items = List();
    items.add(ItemBean(IndexDealHeadComponent.componentName,
        deal_head_state.initState(state.dealIndexData)));
    if (LoginControl.isLogin() &&
        state.dealIndexData != null &&
        state.dealIndexData.data.playedGame.length > 0)
      items.add(new ItemBean(DealPlayingComponent.componentName,
          deal_playing_state.initState(state.dealIndexData.data.playedGame)));

    items.add(new ItemBean(
        DealItemTitleComponent.componentName, state.dealItemTitleState));
    if (state.dealGoods.length > 0) {
      items.addAll(state.dealGoods.map((dealGoods) => ItemBean(
          IndexDealItemComponent.componentName,
          deal_item_state.initState(dealGoods))));
    } else {
      items.add(new ItemBean(EmptyComponent.componentName, null));
    }
    return items;
  }

  @override
  void set(IndexDealFragmentState state, List<ItemBean> items) {
    for (ItemBean itemBean in items) {
      if (itemBean.type == DealItemTitleComponent.componentName) {
        state.dealItemTitleState = itemBean.data;
      }
    }
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}

class EmptyComponent extends Component<IndexDealFragmentState> {
  static String componentName = "EmptyComponent";

  EmptyComponent()
      : super(
          view: (IndexDealFragmentState state, Dispatch dispatch,
              ViewService viewService) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                  ),
                  Image.asset(
                    "images/default_nodata.png",
                    height: 180,
                    width: 218,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      getText(name: 'textNoData'),
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor2),
                    ),
                  )
                ],
              ),
            );
          },
          dependencies: Dependencies<IndexDealFragmentState>(
              slots: <String, Dependent<IndexDealFragmentState>>{}),
        );
}
