import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/component/index/bt_fragment/action.dart';
import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<IndexTabTitleState> buildEffect() {
  return combineEffects(<Object, Effect<IndexTabTitleState>>{
    IndexTabTitleAction.action: _onAction,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<IndexTabTitleState> ctx) {}

void _init(Action action, Context<IndexTabTitleState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController =
      new TabController(initialIndex: 0, length: 2, vsync: tickerProvider);
  tabController.addListener(() {
    ctx.dispatch(BtFragmentActionCreator.switchData(tabController.index));
  });
  ctx.dispatch(IndexTabTitleActionCreator.createController(tabController));
}
