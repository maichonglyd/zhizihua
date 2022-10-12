import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';

import 'action.dart';
import 'state.dart';

Effect<IndexBannerState> buildEffect() {
  return combineEffects(<Object, Effect<IndexBannerState>>{
    IndexBannerAction.onClick: _onClick,
    IndexBannerAction.onIndexChange: _onIndexChange,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose
  });
}

//当前播放轮播图的角标
int currentIndex = 0;

void _onIndexChange(Action action, Context<IndexBannerState> ctx) {
  currentIndex = action.payload;
  //暂停其他视频播放
//  print("playIndex--_onIndexChange: $currentIndex");
//  EventBus eventBus = EventBusManager.getEventBus();
//  eventBus.fire(Event("switchBannerPause", index: currentIndex));
}

void _dispose(Action action, Context<IndexBannerState> ctx) {}

void _init(Action action, Context<IndexBannerState> ctx) {
//  Future.delayed(Duration(milliseconds: 500), () {
//    EventBus eventBus = EventBusManager.getEventBus();
//    eventBus.fire(Event("switchBannerPause", index: currentIndex));
//  });
}

void _onClick(Action action, Context<IndexBannerState> ctx) {
//  ctx.dispatch(HomeActionCreator.changeTab(action.payload));
  if (ctx.state.gameBannerItems[action.payload] != null) {
    String url = ctx.state.gameBannerItems[action.payload].url;
    if (url != null && url.isNotEmpty) {
      AppUtil.gotoH5Web(ctx.context, url, title: getText(name: 'textAdDetail'));
      return;
    }
//    if (ctx.state.gameBannerItems[action.payload].game != null) {
//      AppUtil.gotoGameDetailOrH5Game(
//          ctx.context, ctx.state.gameBannerItems[action.payload].game);
//    }
    if (ctx.state.gameBannerItems[action.payload].game != null) {
      //h5游戏的广告轮播图点击也跳转游戏详情
      AppUtil.gotoGameDetail(
          ctx.context, ctx.state.gameBannerItems[action.payload].game);
    }
  }
}
