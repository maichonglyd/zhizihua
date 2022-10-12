import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<H5FragmentState> buildEffect() {
  return combineEffects(<Object, Effect<H5FragmentState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    H5FragmentAction.action: _onAction,
    H5FragmentAction.getIndexData: _getIndexData,
    H5FragmentAction.getCardGameList: _getCardGameList,
  });
}

void _init(Action action, Context<H5FragmentState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController =
      new TabController(initialIndex: 0, length: 4, vsync: tickerProvider);
  ctx.dispatch(H5FragmentActionCreator.onCreateController(tabController));
  GameService.getHomeByH5().then((HomeData homeData) {
    ctx.dispatch(H5FragmentActionCreator.updateHomeData(homeData.data));
  });

  EventBus eventBus = EventBusManager.getEventBus();
  ctx.state.subscription = eventBus.on<RefreshH5Event>().listen((event) {
    if (event.tag == "refreshH5" && event.refresh) {
      _getIndexData(action, ctx);
    }
  });

  var scrollController = new ScrollController();

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
  ctx.dispatch(
      H5FragmentActionCreator.createScrollController(scrollController));
}

void _getIndexData(Action action, Context<H5FragmentState> ctx) {
  GameService.getHomeByH5().then((HomeData homeData) {
    ctx.state.refreshController.refreshCompleted();
    ctx.dispatch(H5FragmentActionCreator.updateHomeData(homeData.data));
  });
}

void _onAction(Action action, Context<H5FragmentState> ctx) {}

void _dispose(Action action, Context<H5FragmentState> ctx) {
  ctx.state.subscription.cancel();
  if (ctx.state.scrollController != null) {
    ctx.state.scrollController.dispose();
  }
  if (ctx.state.tabController != null) {
    ctx.state.tabController.dispose();
  }
}

void _getCardGameList(Action action, Context<H5FragmentState> ctx) {
  num topicId = action.payload['topicId'];
  List<Game> gameList = action.payload['gameList'];
  int cardPage = action.payload['cardPage'];
  ctx.dispatch(H5FragmentActionCreator.updateCardGame(topicId, cardPage, gameList));
}
