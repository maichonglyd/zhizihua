import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<HbFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<HbFragmentState>>{
    Lifecycle.initState: _init,
    HbFragmentAction.action: _onAction,
    HbFragmentAction.getIndexData: _getIndexData,
  });
}

void _onAction(Action action, Context<HbFragmentState> ctx) {
}

void _init(Action action, Context<HbFragmentState> ctx) {
  var scrollController = new ScrollController();
  ctx.dispatch(
      HbFragmentActionCreator.createScrollController(scrollController));
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

  GameService.getHomeByRp().then((homeData) {
    ctx.dispatch(HbFragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _getIndexData(Action action, Context<HbFragmentState> ctx) {
  GameService.getHomeByRp().then((homeData) {
    ctx.state.refreshController.refreshCompleted();
    ctx.dispatch(HbFragmentActionCreator.updateHomeData(homeData.data));
  });
}
