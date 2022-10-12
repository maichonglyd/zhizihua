import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<GmFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<GmFragmentState>>{
    GmFragmentAction.action: _onAction,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<GmFragmentState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController =
      new TabController(initialIndex: 0, length: 2, vsync: tickerProvider);
  ctx.dispatch(GmFragmentActionCreator.createController(tabController));

  GameService.getHomeByGM().then((HomeData homeData) {
    ctx.dispatch(GmFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _onAction(Action action, Context<GmFragmentState> ctx) {}
