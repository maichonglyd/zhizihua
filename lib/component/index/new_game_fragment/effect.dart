import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';
import 'action.dart';
import 'state.dart';

Effect<NewGameFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<NewGameFragmentState>>{
    Lifecycle.initState: _init,
    NewGameFragmentAction.action: _onAction,
    NewGameFragmentAction.getIndexData: _getIndexData,
    NewGameFragmentAction.getCardGameList: _getCardGameList,
  });
}

void _onAction(Action action, Context<NewGameFragmentState> ctx) {
}

void _init(Action action, Context<NewGameFragmentState> ctx) {
  var scrollController = new ScrollController();
  ctx.dispatch(
      NewGameFragmentActionCreator.createScrollController(scrollController));
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

  GameService.getHomeByNew().then((homeData) {
    ctx.dispatch(NewGameFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _getIndexData(Action action, Context<NewGameFragmentState> ctx) {
  GameService.getHomeByNew().then((homeData) {
    ctx.state.refreshController.refreshCompleted();
    ctx.dispatch(NewGameFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _getCardGameList(Action action, Context<NewGameFragmentState> ctx) {
  num topicId = action.payload['topicId'];
  List<Game> gameList = action.payload['gameList'];
  int cardPage = action.payload['cardPage'];
  ctx.dispatch(NewGameFragmentActionCreator.updateCardGame(topicId, cardPage, gameList));
}