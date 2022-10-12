import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/page/deal/account_deal/my_sell_list_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MySellListState> buildEffect() {
  return combineEffects(<Object, Effect<MySellListState>>{
    MySellListAction.action: _onAction,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<MySellListState> ctx) {}

void _init(Action action, Context<MySellListState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController =
      new TabController(initialIndex: 0, length: 3, vsync: tickerProvider);
  tabController.index = ctx.state.index;
  ctx.state.tabController = tabController;
}
