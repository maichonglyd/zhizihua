import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'action.dart';
import 'component.dart';
import 'list_adapter/action.dart';
import 'state.dart';

Effect<ZKFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<ZKFragmentState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    ZKFragmentAction.action: _onAction,
    ZKFragmentAction.getIndexData: _getIndexData,
    ZKFragmentAction.getCardGameList: _getCardGameList,
    ZKFragmentAction.getTopTabList: _getTopTabList,
  });
}

void _dispose(Action action, Context<ZKFragmentState> ctx) {
  if (ctx.state.scrollController != null) {
    ctx.state.scrollController.dispose();
  }
  if (ctx.state.tabController != null) {
    ctx.state.tabController.dispose();
  }
}

void _init(Action action, Context<ZKFragmentState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController =
      new TabController(initialIndex: 0, length: 4, vsync: tickerProvider);
  ctx.dispatch(ZkFragmentActionCreator.onCreateController(tabController));
  ctx.dispatch(ZkFragmentActionCreator.getTopTabList());

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
      ZkFragmentActionCreator.createScrollController(scrollController));
  GameService.getHomeByZk().then((HomeData homeData) {
    ctx.dispatch(ZkFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _getIndexData(Action action, Context<ZKFragmentState> ctx) {
  GameService.getHomeByZk().then((HomeData homeData) {
    ctx.state.refreshController.refreshCompleted();
    ctx.dispatch(ZkFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _onAction(Action action, Context<ZKFragmentState> ctx) {}

void _getCardGameList(Action action, Context<ZKFragmentState> ctx) {
  num topicId = action.payload['topicId'];
  List<Game> gameList = action.payload['gameList'];
  int cardPage = action.payload['cardPage'];
  ctx.dispatch(ZkFragmentActionCreator.updateCardGame(topicId, cardPage, gameList));
}

void _getTopTabList(Action action, Context<ZKFragmentState> ctx) {
  GameService.getTopTabList(ZKFragmentComponent.typeName).then((data) {
    if (200 == data.code) {
      ctx.dispatch(ZkFragmentActionCreator.updateTopTabList(data.data.list));
    }
  });
}
