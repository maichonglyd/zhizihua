import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:video_player/video_player.dart';
import 'action.dart';
import 'state.dart';

Effect<GameDetailsComponentState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailsComponentState>>{
    GameDetailsAction.action: _onAction,
    GameDetailsAction.getComments: _getComments,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    Lifecycle.deactivate: _deactivate,
  });
}

void _onAction(Action action, Context<GameDetailsComponentState> ctx) {}
void _getComments(Action action, Context<GameDetailsComponentState> ctx) {
  GameService.getComments(ctx.state.gameId).then((data) {
    ctx.dispatch(GameDetailsActionCreator.updateComments(data.data.list));
  });
}

//不可见的时候暂停播放
void _deactivate(Action action, Context<GameDetailsComponentState> ctx) {
  try {
    if (ctx.state.videoPlayerController.value.isPlaying) {
      ctx.state.videoPlayerController.pause();
    }
  } catch (e) {}
}

void _dispose(Action action, Context<GameDetailsComponentState> ctx) {
  //释放播放器资源
  try {
    ctx.state.videoPlayerController.dispose();
  } catch (e) {}
}

void _init(Action action, Context<GameDetailsComponentState> ctx) {
  GameService.getComments(ctx.state.gameId).then((data) {
    ctx.dispatch(GameDetailsActionCreator.updateComments(data.data.list));
  });

  ScrollController scrollController = new ScrollController();
  scrollController.addListener(() {
    print("滑动距离：" + scrollController.offset.toString());
    //超过一定距离更新图标和显示游戏名称 颜色
    if (scrollController.offset > 100) {
      EventBus eventBus = EventBusManager.getEventBus();
      eventBus.fire(Event("switchPause", switchBol: true));
    }
    if (scrollController.offset < 100) {
      EventBus eventBus = EventBusManager.getEventBus();
      eventBus.fire(Event("switchPause", switchBol: false));
    }
  });
  ctx.dispatch(GameDetailsActionCreator.onCreateController(scrollController));
  _initVideo(action, ctx);
}

void _initVideo(Action action, Context<GameDetailsComponentState> ctx) {
//  if (ctx.state.news != null && ctx.state.news.length > 0) {
//    print("_initVideo${ctx.state.news}");
//    VideoPlayerController _controller =
//    VideoPlayerController.network(ctx.state.news[0].videoUrl);
//    _controller
//      ..initialize().then((_) {
//        _controller.play();
//      })
//      ..setLooping(false).then((_) {});
//    ctx.dispatch(
//        GameDetailsActionCreator.onCreatePlayController(_controller));
//      //首次进入没有声音
//      ctx.state.videoPlayerController.setVolume(1);
//  }
}
