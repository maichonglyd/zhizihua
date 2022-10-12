import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/nopop_info_util.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart'
    hide SingleTickerProviderStfState;
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/HomePushDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/TipDialog.dart';
import 'action.dart';
import 'list_adapter/action.dart';
import 'state.dart';

Effect<HtFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<HtFragmentState>>{
    HtFragmentAction.action: _onAction,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    HtFragmentAction.getHomeData: _getHomeData,
    HtFragmentAction.showPushDialog: _showPushDialog,
  });
}

void _dispose(Action action, Context<HtFragmentState> ctx) {
  if (ctx.state.scrollController != null) {
    ctx.state.scrollController.dispose();
  }
  if (ctx.state.tabController != null) {
    ctx.state.tabController.dispose();
  }
}

//这个地方太坑人了,搞了我两个小时,拷贝过来的代码真的坑人
void _init(Action action, Context<HtFragmentState> ctx) {
//  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
//  var tabController =
//      new TabController(initialIndex: 0, length: 4, vsync: tickerProvider);
//  ctx.dispatch(HtFragmentActionCreator.onCreateController(tabController));
  if (ctx.state.type == HtFragmentState.TYPE_HT) {
    GameService.getHomeByHt().then((HomeData homeData) {
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  } else if (ctx.state.type == HtFragmentState.TYPE_BT) {
    GameService.getHomeByBt().then((HomeData homeData) {
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  } else if (ctx.state.type == HtFragmentState.TYPE_ZK) {
    GameService.getHomeByZk().then((HomeData homeData) {
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  } else if (ctx.state.type == HtFragmentState.TYPE_H5) {
    GameService.getHomeByH5().then((HomeData homeData) {
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  }

  var scrollController = new ScrollController();

  scrollController.addListener(() {
    //暂停视频
    if (ctx.state.scrollController.position.pixels > 160) {
      //暂停视频
      String videoType = ctx.state.videoType + "#0";
      if (ctx.state.scrollController.position.pixels >= 160 &&
          HuoVideoManager.isActive(videoType)) {
        HuoVideoManager.setViewPause(videoType);
      } else if (ctx.state.scrollController.position.pixels < 160 &&
          !HuoVideoManager.isActive(videoType)) {
        HuoVideoManager.setViewActive(videoType);
      }
    }
  });
  ctx.dispatch(
      HtFragmentActionCreator.createScrollController(scrollController));
}

void _onAction(Action action, Context<HtFragmentState> ctx) {}
void _getHomeData(Action action, Context<HtFragmentState> ctx) {
  if (ctx.state.type == HtFragmentState.TYPE_HT) {
    GameService.getHomeByHt().then((HomeData homeData) {
      ctx.state.refreshHelperController.finishRefresh(success: true);
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  } else if (ctx.state.type == HtFragmentState.TYPE_BT) {
    GameService.getHomeByBt().then((HomeData homeData) {
      ctx.state.refreshHelperController.finishRefresh(success: true);
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  } else if (ctx.state.type == HtFragmentState.TYPE_ZK) {
    GameService.getHomeByZk().then((HomeData homeData) {
      ctx.state.refreshHelperController.finishRefresh(success: true);
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  } else if (ctx.state.type == HtFragmentState.TYPE_H5) {
    GameService.getHomeByH5().then((HomeData homeData) {
      ctx.state.refreshHelperController.finishRefresh(success: true);
      ctx.dispatch(HtFragmentActionCreator.updateHomeData(homeData.data));
    });
  }
}

void _showPushDialog(Action action, Context<HtFragmentState> ctx) {
  NoPopInfoUtil.getInitInfo().then((value) {
    if (value == AppUtil.formatDate3()) {
    } else {
      if (ctx.state.homeData != null &&
          ctx.state.homeData.homePush != null &&
          ctx.state.homeData.homePush.image != null &&
          ctx.state.homeData.homePush.image.isNotEmpty) {
        showDialog<Null>(
            context: ctx.context, //BuildContext对象
            barrierDismissible: false,
            builder: (BuildContext context) {
              return HomePushDialog(
                image: ctx.state.homeData.homePush.image,
                confirmCallback: () {
                  if (ctx.state.homeData.homePush.appId != null &&
                      ctx.state.homeData.homePush.appId.toString().isNotEmpty) {
                    Navigator.pop(context);
                    AppUtil.gotoPageByName(
                        ctx.context, GameDetailsPage.pageName,
                        arguments: ctx.state.homeData.homePush.appId);
                  } else if (ctx.state.homeData.homePush.newsUrl != null &&
                      ctx.state.homeData.homePush.newsUrl
                          .toString()
                          .isNotEmpty) {
                    Navigator.pop(context);
                    var pageName = WebPluginPage.pageName;
                    if (Platform.isAndroid) {
                      pageName = WebPage.pageName;
                    }
                    AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
                      "title": ctx.state.homeData.homePush.newsTitle,
                      "url": ctx.state.homeData.homePush.newsUrl
                    });
                  }
                },
              );
            });
      }
    }
  });
}
