import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/share_util.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/action.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/download/download_manage/page.dart';
import 'package:flutter_huoshu_app/page/game/game_comment/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_recharge/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/recharge_info/page.dart';
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'package:flutter_huoshu_app/utils/coin_recharge_firstcome_util.dart';
import 'package:flutter_huoshu_app/widget/dialog/GameReserveSuccessDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/ServiceDialog.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'action.dart';
import 'state.dart';

Effect<GameDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailsState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    GameDetailsAction.action: _onAction,
    GameDetailsAction.back: _onBack,
    GameDetailsAction.gotoWeb: _gotoWeb,
    GameDetailsAction.gotoAddQQGroup: _gotoAddQQGroup,
    GameDetailsAction.gotoDownload: _gotoDownload,
    GameDetailsAction.showShare: _showShare,
    GameDetailsAction.notifyShare: _notifyShare,
    GameDetailsAction.showMoreSer: _showMoreSer,
    GameDetailsAction.init: _init,
    GameDetailsAction.getVideoData: _getVideoData,
    GameDetailsAction.showVideoView: _showVideoView,
    GameDetailsAction.showDownDialog: _showDownDialog,
    GameDetailsAction.showRechargeDialog: _showRechargeDialog,
    GameDetailsAction.gotoRecharge: _gotoRecharge,
    GameDetailsAction.showVideoView: _showVideoView,
    GameDetailsAction.subscribe: _subscribe,
    GameDetailsAction.gotoPlay: _gotoPlay,
    GameDetailsAction.getCouponList: _getCouponList,
    GameDetailsAction.gotoGameComment: _gotoGameComment,
  });
}

Future _gotoRecharge(Action action, Context<GameDetailsState> ctx) async {
  var isFirst = await ComeRechargeFirstComeUtil.getSaveInfo();
  if (isFirst == null || isFirst) {
    AppUtil.gotoPageByName(ctx.context, RechargeInfoPage.pageName,
        arguments: {"game": action.payload, "game_id": ctx.state.gameId});
    ComeRechargeFirstComeUtil.saveInfo(false);
    return;
  }
  AppUtil.gotoPageByName(ctx.context, GameCoinRechargePage.pageName,
      arguments: {"game": action.payload, "game_id": ctx.state.gameId});
}

void _init(Action action, Context<GameDetailsState> ctx) {
  ScrollController scrollController = new ScrollController();
  scrollController.addListener(() {
  });
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController =
      new TabController(initialIndex: 0, length: 4, vsync: tickerProvider);
  ctx.dispatch(GameDetailsActionCreator.onCreateController(
      tabController, scrollController));

  ctx.dispatch(GameDetailsActionCreator.getVideoData());
  //这个平台跟游戏相关,要传一个游戏id过去
  GameService.getCpsGame(1, ctx.state.gameId).then((data) {
    if (data.code == 200) {
      if (data.data.list != null && data.data.list.length > 0) {
        ctx.dispatch(GameDetailsActionCreator.updateGames(data.data.list));
      }
    }
  });
}

//获取平台游戏
void _getGameListByGameName(Action action, Context<GameDetailsState> ctx) {
  GameService.getGamesByGameName(action.payload).then((data) {
    if (data.code == 200) {
      if (data.data.list != null && data.data.list.length > 0) {
        ctx.dispatch(GameDetailsActionCreator.updateGames(data.data.list));
      }
    } else {
      //更新err
      ctx.dispatch(GameDetailsActionCreator.err());
//      Navigator.pop(ctx.context);
    }
  });
}

void _showDownDialog(Action action, Context<GameDetailsState> ctx) {
  double itemHeight = 82;
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
//          height: 211,
          height: itemHeight * ctx.state.channelGames.length + 47.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Container(
                height: 47.5,
                alignment: Alignment.centerLeft,
                child: Text(
                  getText(name: 'textSelectDownloadPlatform'),
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.textColor,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                      child: ListView(
                children: ctx.state.channelGames.map((game) {
                  return game.cps != null
                      ? Container(
                          height: 82,
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.only(right: 8),
                                child: HuoNetImage(
//                                  imageUrl: game.cpsInfo.image,
                                  imageUrl: game.cps.cpsImage,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
//                                    Text(game.cpsInfo.channelName),
                                    Text(game.cps.cpsName),
                                    Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "images/gm_pic_shou.png",
                                          height: 15,
                                          width: 15,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Text(
                                            "${game.firstMemRate * 10}${getText(name: 'textDiscount')}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFF35A58)),
                                          ),
                                        ),
                                        Image.asset(
                                          "images/gm_pic_xu.png",
                                          height: 15,
                                          width: 15,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Text(
//                                            "${game.cpsRate * 10}折",
                                            "${game.memRate * 10}${getText(name: 'textDiscount')}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppTheme
                                                    .colors.textSubColor3),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 27,
                                width: 55,
                                decoration: BoxDecoration(
                                    color: AppTheme.colors.themeColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: DownView(
                                    game: game, type: TYPE_GAME_DETAILS_DIALOG),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        )
                      : Container();
                }).toList(),
              ))),
            ],
          ),
        );
      });
}

void _showRechargeDialog(Action action, Context<GameDetailsState> ctx) {
  double itemHeight = 82;
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: itemHeight * ctx.state.channelGames.length + 47.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Container(
                height: 47.5,
                alignment: Alignment.centerLeft,
                child: Text(
                  getText(name: 'textSelectRechargePlatform'),
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.textColor,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                height: itemHeight * ctx.state.channelGames.length,
                child: ListView(
                  children: ctx.state.channelGames.map((game) {
                    return game.cps != null
                        ? Container(
                            height: itemHeight,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 8),
                                  child: HuoNetImage(
//                                    imageUrl: game.cpsInfo.image,
                                    imageUrl: game.cps.cpsImage,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
//                                      Text(game.cpsInfo.channelName),
                                      Text(game.cps.cpsName),
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "images/gm_pic_shou.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
//                                              "${game.cpsFirstRate * 10}折",
                                              "${game.firstMemRate * 10}${getText(name: 'textDiscount')}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFFF35A58)),
                                            ),
                                          ),
                                          Image.asset(
                                            "images/gm_pic_xu.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
//                                              "${game.cpsRate * 10}折",
                                              "${game.memRate * 10}${getText(name: 'textDiscount')}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppTheme
                                                      .colors.textSubColor3),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ctx.dispatch(
                                        GameDetailsActionCreator.gotoRecharge(
                                            game));
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 77,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFF842F),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      getText(name: 'textRechargeNow'),
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffe5e5e5)))),
                          )
                        : Container();
                  }).toList(),
                ),
              )),
            ],
          ),
        );
      });
}

void _onAction(Action action, Context<GameDetailsState> ctx) {}

void _dispose(Action action, Context<GameDetailsState> ctx) {
  HuoLog.d("GameDetailsPage: _dispose");
//  if (ctx.state.videoPlayerController != null) {
//    ctx.state.videoPlayerController.dispose();
//  }
}

void _showMoreSer(Action action, Context<GameDetailsState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ServiceDialog(ctx.state.gameDetail.serlist.list);
      });
}

void _notifyShare(Action action, Context<GameDetailsState> ctx) {
  UserService.notifyShare(ctx.state.shareInfo.data.shareId, action.payload)
      .then((data) {
    showToast(getText(name: 'textShareSuccessful'));
  });
}

void _showShare(Action action, Context<GameDetailsState> ctx) {
  UserService.getShareDataByGame(ctx.state.gameId).then((data) {
    if (data.code == 200) {
      ctx.state.shareInfo = data;
      showModalBottomSheet(
          context: ctx.context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: 150,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      HuoLog.d("启动微信好友分享");
                      //等待dialog
                      showToast(getText(name: 'toastStartShare'));
                      shareToWechat(context, ctx.state.shareInfo, (type) {
                        ctx.dispatch(
                            GameDetailsActionCreator.notifyShare(type));
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "images/share_wechat.png",
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          getText(name: 'textWxFriend'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HuoLog.d("启动微信朋友圈分享");
                      shareToWechatFavorites(context, ctx.state.shareInfo,
                          (type) {
                        ctx.dispatch(
                            GameDetailsActionCreator.notifyShare(type));
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "images/share_circle.png",
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          getText(name: 'textFriendGroup'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HuoLog.d("启动QQ好友分享");
                      showToast(getText(name: 'toastStartShare'));
                      shareQQCustom(context, ctx.state.shareInfo, (type) {
                        ctx.dispatch(
                            GameDetailsActionCreator.notifyShare(type));
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "images/share_qq.png",
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          getText(name: 'textQQ'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
            );
          });
    }
  });
}

void _gotoDownload(Action action, Context<GameDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DownLoadManagePage.pageName);
}

void _gotoAddQQGroup(Action action, Context<GameDetailsState> ctx) {
  HuoLog.d("qq链接：" + ctx.state.gameDetail.qqGroup);
  launch(ctx.state.gameDetail.qqGroup);
}

void _gotoWeb(Action action, Context<GameDetailsState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: action.payload);
}

void _onBack(Action action, Context<GameDetailsState> ctx) {
  Navigator.pop(ctx.context);
}

void _getVideoData(Action action, Context<GameDetailsState> ctx) {
  GameService.getNewListByGameId(ctx.state.gameId, 12, 1, 200).then((data) {
    ctx.dispatch(GameDetailsActionCreator.updateVideoData(data.data.list));
    //请求完视频详情接口了然后再请求视频详情接口
    GameService.getGameDetails(ctx.state.gameId).then((data) {
      if (data.code == 200) {
        ctx.dispatch(GameDetailsActionCreator.updateGameData(data.data));
      } else {
        //更新err
        ctx.dispatch(GameDetailsActionCreator.err());
      }
    });
  });
}

void _showVideoView(Action action, Context<GameDetailsState> ctx) {
  HuoLog.d("显示videoview");
  AppUtil.gotoPageByName(ctx.context, VideoPlayPage.pageName,
      arguments: ctx.state.videoPlayerController);
}

void _subscribe(Action action, Context<GameDetailsState> ctx) {
  GameService.subscribe(ctx.state.gameDetail.gameId).then((data) {
    if (data.code == 200) {
      showToast(getText(name: 'textAppointmentSuccessful'));
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return GameReserveSuccessDialog();
              },
            );
          });
      GameService.getCpsGame(1, ctx.state.gameId).then((data) {
        if (data.code == 200) {
          if (data.data.list != null && data.data.list.length > 0) {
            ctx.dispatch(GameDetailsActionCreator.updateGames(data.data.list));
          }
        }
      });
    } else {
      showToast(getText(name: 'textAppointmentFailed'));
    }
  });
}

void _gotoPlay(Action action, Context<GameDetailsState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    //暂停视频播放,回到页面再播放
//    HuoVideoManager.pauseByType(HuoVideoManager.type_game_detail);
    AppUtil.gotoH5Game(ctx.context, ctx.state.gameDetail.downUrl,
            ctx.state.gameDetail.direction,
            gameName: ctx.state.gameDetail.gameName)
        .then((value) {
//      HuoVideoManager.playByType(HuoVideoManager.type_game_detail);
      ctx.broadcast(H5FragmentActionCreator.getIndexData());
    });
  });
}

//发送广播
void postEvent(int i) {
  EventBus eventBus = EventBusManager.getEventBus();
  if (i == 1) {
    //暂停播放
    eventBus.fire(Event("switchPause", switchBol: true));
  } else {
    //开始播放
    eventBus.fire(Event("switchPause", switchBol: false));
  }
}

void _getCouponList(Action action, Context<GameDetailsState> ctx) {
//  CouponService.getGameCouponList(
//      gameId: ctx.state.gameId
//  ).then((data) {
//    if (200 == data.code) {
//      ctx.dispatch(GameDetailsActionCreator.updateCouponList(data));
//    }
//  });
}

void _gotoGameComment(Action action, Context<GameDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameCommitCommentPage.pageName,
      arguments: ctx.state.gameId)
      .then((data) {});
}