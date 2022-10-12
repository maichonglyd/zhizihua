import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/redux_connector/private_action_mixin.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/action.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';
import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<GlFragmentState> buildEffect() {
  return privateCombineEffects(<Object, Effect<GlFragmentState>>{
    Lifecycle.initState: _init,
    Lifecycle.deactivate: _deactivate,
    Lifecycle.dispose: _dispose,
    GlFragmentAction.getHomeByGl: _getHomeByGl,
    GlFragmentAction.changeVideoVolume: _changeVideoVolume,
    GlFragmentAction.getTopTabList: _getTopTabList,
//    IndexBtFragmentAction.updateIndex: _updateIndex
  });
}

void _updateIndex(Action action, Context<GlFragmentState> ctx) {
  ctx.dispatch(GlFragmentActionCreator.updateIndex(action.payload));
}

void _getHomeByGl(Action action, Context<GlFragmentState> ctx) {
  GameService.getModGame(action.payload, 10, ctx.state.type).then((data) {
    if (data.code == 200) {
      print("_getHomeByGl");
      var newGames = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.games, action.payload);
      ctx.dispatch(GlFragmentActionCreator.update(newGames));
    }
  });
}

//tab切换的时候会调用这个初始化方法
void _init(Action action, Context<GlFragmentState> ctx) {
  ctx.dispatch(GlFragmentActionCreator.getHomeByGl(1));
  GameService.getHomeByCustom(ctx.state.type).then((HomeData homeData) {
    ctx.dispatch(GlFragmentActionCreator.updateHomeData(homeData.data));
  });
  ctx.dispatch(GlFragmentActionCreator.getTopTabList());
  ScrollController scrollController = createScrollController(ctx);
  ctx.dispatch(GlFragmentActionCreator.onCreateController(scrollController));
  _initVideo(action, ctx);
}

ScrollController createScrollController(Context<GlFragmentState> ctx) {
  ScrollController scrollController = new ScrollController();
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
  return scrollController;
}

//不可见的时候暂停播放
void _deactivate(Action action, Context<GlFragmentState> ctx) {}

void _dispose(Action action, Context<GlFragmentState> ctx) {}

void _changeVideoVolume(Action action, Context<GlFragmentState> ctx) {}

VideoPlayerController _controller;

void _initVideo(Action action, Context<GlFragmentState> ctx) async {}

//监听播放进度
void listener() {
  if (_controller != null) {
    if (_controller.value.isInitialized) {
      var oPosition = _controller.value.position;
      var oDuration = _controller.value.duration;
      if (_controller.value.isPlaying) {
      } else {
        if (oPosition >= oDuration) {
          resetVideoPlayer(_controller);
        }
      }
    }
  }
}

void resetVideoPlayer(VideoPlayerController controller) {
  controller.value = VideoPlayerValue(duration: null);
}

void _getTopTabList(Action action, Context<GlFragmentState> ctx) {
  GameService.getTopTabList(GlFragmentComponent.typeName).then((data) {
    if (200 == data.code) {
      ctx.dispatch(GlFragmentActionCreator.updateTopTabList(data.data.list));
    }
  });
}
