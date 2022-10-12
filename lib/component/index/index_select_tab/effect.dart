import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/zk_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'component.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/action.dart';

Effect<IndexSelectTabState> buildEffect() {
  return combineEffects(<Object, Effect<IndexSelectTabState>>{
    IndexSelectTabAction.action: _onAction,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _onAction(Action action, Context<IndexSelectTabState> ctx) {}

void _init(Action action, Context<IndexSelectTabState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as IndexSelectProviderStfState;
  int length = 2;
  if (ctx.state.tabs != null && ctx.state.tabs.length > 0) {
    length = ctx.state.tabs.length;
  }

  var tabController =
      new TabController(initialIndex: 0, length: length, vsync: tickerProvider);
  tabController.addListener(() {
    String type = LoginControl.getTabType();
    //ctx.state.type
    switch (type) {
      case BtFragmentComponent.typeName:
        //bt
        ctx.dispatch(BtFragmentActionCreator.switchData(tabController.index));
        break;
      case H5FragmentComponent.typeName:
        //H5
        ctx.dispatch(H5FragmentActionCreator.switchData(tabController.index));
        break;
      case ZKFragmentComponent.typeName:
        //折扣
        ctx.dispatch(ZkFragmentActionCreator.switchData(tabController.index));
        break;
      case RmbFragmentComponent.typeName:
        ctx.dispatch(RmbFragmentActionCreator.updateSwitchSelectIndex(tabController.index));
        break;
      case NewGameFragmentComponent.typeName:
        ctx.dispatch(NewGameFragmentActionCreator.updateSwitchSelectIndex(tabController.index));
        break;
      case HbFragmentComponent.typeName:
        ctx.dispatch(HbFragmentActionCreator.updateSwitchSelectIndex(tabController.index));
        break;
      default:
        break;
    }
  });

  ctx.state.tabController = tabController;
  ctx.dispatch(IndexSelectTabActionCreator.createController(tabController));
}

void _dispose(Action action, Context<IndexSelectTabState> ctx) {
  HuoLog.d("执行了IndexSelectTab _dispose");
  if (ctx.state.tabController != null) {
    ctx.state.tabController.dispose();
  }
}
