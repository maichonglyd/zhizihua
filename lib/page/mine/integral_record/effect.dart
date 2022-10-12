import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/page/mine/integral_record/page.dart';
import 'action.dart';
import 'state.dart';

Effect<IntegralRecordState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralRecordState>>{
    IntegralRecordAction.action: _onAction,
    Lifecycle.initState: _initState,
  });
}

void _onAction(Action action, Context<IntegralRecordState> ctx) {}

void _initState(Action action, Context<IntegralRecordState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  TabController tabController =
      new TabController(initialIndex: 0, length: 2, vsync: tickerProvider);
  ctx.dispatch(IntegralRecordActionCreator.onCreateController(tabController));
}
