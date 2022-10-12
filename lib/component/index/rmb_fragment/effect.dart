import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<RmbFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<RmbFragmentState>>{
    Lifecycle.initState: _init,
    RmbFragmentAction.action: _onAction,
    RmbFragmentAction.getIndexData: _getIndexData,
    RmbFragmentAction.getCardGameList: _getCardGameList,
    RmbFragmentAction.getTopTabList: _getTopTabList,
  });
}

void _onAction(Action action, Context<RmbFragmentState> ctx) {
}

void _init(Action action, Context<RmbFragmentState> ctx) {
  var scrollController = new ScrollController();
  ctx.dispatch(
      RmbFragmentActionCreator.createScrollController(scrollController));
  ctx.dispatch(RmbFragmentActionCreator.getTopTabList());
  scrollController.addListener(() {
    String videoType = ctx.state.videoType + "#0";
    if (ctx.state.scrollController.position.pixels >= 160 &&
        HuoVideoManager.isActive(videoType)) {
      HuoVideoManager.setViewPause(videoType);
    } else if (ctx.state.scrollController.position.pixels < 160 &&
        !HuoVideoManager.isActive(videoType)) {
      HuoVideoManager.setViewActive(videoType);
    }
  });

  GameService.getHomeByRmd().then((homeData) {
    ctx.dispatch(RmbFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _getIndexData(Action action, Context<RmbFragmentState> ctx) {
  GameService.getHomeByRmd().then((homeData) {
    ctx.state.refreshController.refreshCompleted();
    ctx.dispatch(RmbFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _getCardGameList(Action action, Context<RmbFragmentState> ctx) {
  num topicId = action.payload['topicId'];
  List<Game> gameList = action.payload['gameList'];
  int cardPage = action.payload['cardPage'];
  ctx.dispatch(RmbFragmentActionCreator.updateCardGame(topicId, cardPage, gameList));
}

void _getTopTabList(Action action, Context<RmbFragmentState> ctx) {
  GameService.getTopTabList(RmbFragmentComponent.typeName).then((data) {
    if (200 == data.code) {
      ctx.dispatch(RmbFragmentActionCreator.updateTopTabList(data.data.list));
    }
  });
}