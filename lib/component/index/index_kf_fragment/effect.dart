import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/init_info_util.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/action.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<KfFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<KfFragmentState>>{
    Lifecycle.initState: _init,
    KfFragmentAction.action: _onAction,
    KfFragmentAction.switchIndex: _switchIndex,
  });
}

void _onAction(Action action, Context<KfFragmentState> ctx) {}

void _switchIndex(Action action, Context<KfFragmentState> ctx) {
  ctx.dispatch(KfFragmentActionCreator.updateIndex(action.payload));
  ctx.dispatch(GameListActionCreator.selectKfType(getKfIndex(ctx.state.tabList[action.payload])));
}

void _init(Action action, Context<KfFragmentState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController = new TabController(
      initialIndex: 0,
      length: ctx.state.tabList.length,
      vsync: tickerProvider);
  ctx.dispatch(KfFragmentActionCreator.createController(tabController));
}
