import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/component/classify_fragment/component.dart';

import 'action.dart';
import 'state.dart';

Effect<ClassifyFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<ClassifyFragmentState>>{
    Lifecycle.initState: _init,
    ClassifyFragmentAction.action: _onAction,
    ClassifyFragmentAction.switchTabIndex: _switchTabIndex,
  });
}

void _onAction(Action action, Context<ClassifyFragmentState> ctx) {}

void _init(Action action, Context<ClassifyFragmentState> ctx) {
  TickerProvider tickerProvider =
  ctx.stfState as ClassifyFragmentTickerProviderStfState;
  var tabController =
  new TabController(initialIndex: 0, length: 4, vsync: tickerProvider);
  ctx.dispatch(ClassifyFragmentActionCreator.createController(tabController));
}

void _switchTabIndex(Action action, Context<ClassifyFragmentState> ctx) {
  int index = action.payload['index'];
  if (null != index) {
    ctx.state.tabController?.animateTo(index);
  }
}
