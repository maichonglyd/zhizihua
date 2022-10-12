import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/nopop_info_util.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart'
    hide SingleTickerProviderStfState;
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/HomePushDialog.dart';
import 'action.dart';
import 'state.dart';

Effect<BtFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<BtFragmentState>>{
    BtFragmentAction.action: _onAction,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    BtFragmentAction.getHomeData: _getHomeData,
    BtFragmentAction.getCardGameList: _getCardGameList,
    BtFragmentAction.getTopTabList: _getTopTabList,
  });
}

void _init(Action action, Context<BtFragmentState> ctx) {
  GameService.getHomeByBt().then((HomeData homeData) {
    ctx.dispatch(BtFragmentActionCreator.updateHomeData(homeData.data));
  });
  var scrollController = new ScrollController();

  scrollController.addListener(() {
    //暂停视频
    String videoType = ctx.state.videoType + "#0";
    if (ctx.state.scrollController.position.pixels >= 160 &&
        HuoVideoManager.isActive(videoType)) {
      HuoVideoManager.setViewPause(videoType);
    } else if (ctx.state.scrollController.position.pixels < 160 &&
        !HuoVideoManager.isActive(videoType)) {
      HuoVideoManager.setViewActive(videoType);
    }
  });
  ctx.dispatch(
      BtFragmentActionCreator.createScrollController(scrollController));

  ctx.dispatch(BtFragmentActionCreator.getTopTabList());
}

void _onAction(Action action, Context<BtFragmentState> ctx) {}

void _dispose(Action action, Context<BtFragmentState> ctx) {
  if (ctx.state.scrollController != null) {
    ctx.state.scrollController.dispose();
  }
  if (ctx.state.tabController != null) {
    ctx.state.tabController.dispose();
  }
}

void _getHomeData(Action action, Context<BtFragmentState> ctx) {
  GameService.getHomeByBt().then((HomeData homeData) {
    ctx.state.refreshController.refreshCompleted();
    ctx.dispatch(BtFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _getCardGameList(Action action, Context<BtFragmentState> ctx) {
  num topicId = action.payload['topicId'];
  List<Game> gameList = action.payload['gameList'];
  int cardPage = action.payload['cardPage'];
  ctx.dispatch(BtFragmentActionCreator.updateCardGame(topicId, cardPage, gameList));
}

void _getTopTabList(Action action, Context<BtFragmentState> ctx) {
  GameService.getTopTabList(BtFragmentComponent.typeName).then((data) {
    if (200 == data.code) {
      ctx.dispatch(BtFragmentActionCreator.updateTopTabList(data.data.list));
    }
  });
}
