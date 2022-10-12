import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/coupon_service.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/app/action.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/init_info_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/nopop_info_util.dart';
import 'package:flutter_huoshu_app/common/util/protocol_info_util.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/action.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/coupon/reward_bean_list.dart';
import 'package:flutter_huoshu_app/model/home_tab_vo.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/page/game/game_classify/page.dart';
import 'package:flutter_huoshu_app/page/game/game_kaifu/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart'
    hide SingleTickerProviderStfState;
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_shop/page.dart'
    hide SingleTickerProviderStfState;
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart'
    hide SingleTickerProviderStfState;
import 'package:flutter_huoshu_app/page/mine/lottery/page.dart'
    hide SingleTickerProviderStfState;

import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:flutter_huoshu_app/page/update/page.dart';
import 'package:flutter_huoshu_app/page/update/util/update_util.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/repository/deal_history_repository.dart';
import 'package:flutter_huoshu_app/repository/game_history_repository.dart';
import 'package:flutter_huoshu_app/widget/dialog/CouponDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/HomePageAddDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/HomePushDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/ProtocolDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/UpdateAppDialog.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'action.dart';
import 'page.dart';
import 'state.dart';

Timer _timer;

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _init,
    HomeAction.onInitCheck: _onInitCheck,
    HomeAction.onInitOK: _initOK,
    HomeAction.onInitError: _onInitError,
    Lifecycle.didChangeDependencies: _didChangeDependencies,
    Lifecycle.dispose: _dispose,
    HomeAction.onLoginInvalid: _onLoginInvalid,
    HomeAction.onNotifyUpInfo: _onNotifyUpInfo,
    HomeAction.clickSplash: _clickSplash,
    HomeAction.gotoKaifu: _gotoKaifu,
    HomeAction.gotoInvite: _gotoInvite,
    HomeAction.gotoTaskCenter: _gotoTaskCenter,
    HomeAction.gotoRecycle: _gotoRecycle,
    HomeAction.gotoShop: _gotoShop,
    HomeAction.gotoLottery: _gotoLottery,
    HomeAction.gotoGameClass: _gotoGameClass,
    HomeAction.showProtocol: _showProtocol,
    HomeAction.showAddDialog: _showAddDialog,
    HomeAction.onChangeTab: _onChangeTab,
    HomeAction.showCouponDialog: _showCouponDialog,
    HomeAction.startCountDown: _startCountDown,
    HomeAction.showInitCouponDialog: _showInitCouponDialog,
    HomeAction.showPopupAdDialog: _showPopupAdDialog,
    HomeAction.switchToClassify: _switchToClassify,
    HomeAction.showDialogEvent: _showDialogEvent,
  });
}

void _didChangeDependencies(Action action, Context<HomeState> ctx) {}

void _dispose(Action action, Context<HomeState> ctx) {
  if (_timer != null) {
    _timer.cancel();
    _timer = null;
  }
//  canCelListener();
  if (ctx.state.controller != null) {
    ctx.state.controller.dispose();
  }
}

///
/// 初始化检查，如果失败，则重试
Future _onInitCheck(Action action, Context<HomeState> ctx) async {
  if (InitInfoUtil.loadStatus == LoadStatus.success) {
    InitInfoUtil.getInitInfo().then(
        (initInfo) => {ctx.dispatch(HomeActionCreator.onInitOK(initInfo))});
  } else if (InitInfoUtil.loadStatus == LoadStatus.error) {
    ctx.broadcast(AppActionCreator.onInitUserAgent());
  }
}

Future _init(Action action, Context<HomeState> ctx) {
  HuoLog.d('home page init()');

  // 获取闪屏页倒计时时间
  UpdateUtil.getSplashInfo().then((value) {
    if (null != value) {
      ctx.state.splash = value;
    }
  });

  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  TabController tabController = new TabController(
      initialIndex: ctx.state.index, length: 5, vsync: tickerProvider);
  tabController.addListener(() {
    if (ctx.state.controller.index != ctx.state.index) {
      ctx.dispatch(HomeActionCreator.onChangeTab(ctx.state.controller.index));
    }
  });
  ctx.dispatch(HomeActionCreator.createController(tabController));

  if (InitInfoUtil.loadStatus == LoadStatus.success) {
    InitInfoUtil.getInitInfo().then((initInfo) {
      ctx.dispatch(HomeActionCreator.onInitOK(initInfo));
    });
  }
}

Future _initOK(Action action, Context<HomeState> ctx) async {
  HuoLog.d("home page initOk ${ctx.state.loadStatus}");
  ProtocolInfoUtil.getInitInfo().then((value) {
    if (value == "2") {
    } else {
      ctx.dispatch(HomeActionCreator.showProtocol());
    }
  });

  if (ctx.state.loadStatus != LoadStatus.success) {
    InitInfo initInfo = action.payload;
    if (initInfo != null && initInfo.data != null) {
      ctx.dispatch(HomeActionCreator.updateLoadOK(initInfo));
      if (initInfo.data.splash != null) {
        UpdateUtil.saveSplash(initInfo.data.splash);
      }
    }
  }
}

void _onChangeTab(Action action, Context<HomeState> ctx) {
  HuoLog.d("_onChangeTab");
  int index = action.payload;
  HuoVideoManager.setViewActive(HuoVideoManager.type_home + "#${index}");
  if (index == 0) {
    ctx.dispatch(IndexBtFragmentActionCreator.getMsgCount());
  } else if (index == 4) {
    ctx.dispatch(MineFragmentActionCreator.getUserInfo());
  }
//  if (ctx.state.controller.index != 2) {
//    ctx.dispatch(HomeActionCreator.showTabFalse());
//  }
  ctx.dispatch(HomeActionCreator.changeTab(ctx.state.controller.index));
}

Future _onInitError(Action action, Context<HomeState> ctx) {
  HuoLog.d("home page _onInitError ${ctx.state.loadStatus}");
  ctx.dispatch(HomeActionCreator.initError());
}

//底部加号点击展示一个弹窗
void _showAddDialog(Action action, Context<HomeState> ctx) {
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return HomePageAddDialog(ctx.dispatch, () {
//              print("close");
//              Navigator.of(context).pop();
            });
          },
        );
      });
}

void _onLoginInvalid(Action action, Context<HomeState> ctx) {
  if (action.payload['showToast']) {
    if (LoginControl.isLogin()) {
      showToast(getText(name: 'toastLoginOutOfTime'));
    } else {
      showToast(getText(name: 'toastPleaseLogin'));
    }
  }
  LoginControl.saveLogin(false);
  if (action.payload['gotoLoginPage']) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
  }
}

void _onNotifyUpInfo(Action action, Context<HomeState> ctx) {
  showDialog<Null>(
      context: ctx.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return UpdateAppDialog(upInfo: action.payload, cancelFun: () {
              ctx.dispatch(HomeActionCreator.startCountDown());
            });
          },
        );
      });
}

void _clickSplash(Action action, Context<HomeState> ctx) {
  if (ctx.state.splash != null) {
    if (ctx.state.splash.gameId != null) {
      AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName);
    } else if (ctx.state.splash.url != null &&
        ctx.state.splash.url.isNotEmpty) {
      AppUtil.gotoH5Web(ctx.context, ctx.state.splash.url,
          title: getText(name: 'textActivityDetail'));
    }
  }
}

void _gotoKaifu(Action action, Context<HomeState> ctx) async {
  AppUtil.gotoPageByName(ctx.context, KaifuGamePage.pageName);
}

void _gotoInvite(Action action, Context<HomeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null);
}

void _gotoTaskCenter(Action action, Context<HomeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, TaskCenterPage.pageName, arguments: null);
}

void _gotoShop(Action action, Context<HomeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, IntegralShopPage.pageName,
      arguments: null);
}

void _gotoRecycle(Action action, Context<HomeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, AccountRecyclePage.pageName,
          arguments: null)
      .then((result) {
    // ctx.dispatch(MineFragmentActionCreator.getUserInfo());
  });
}

void _gotoLottery(Action action, Context<HomeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, LotteryPage.pageName, arguments: null);
}

void _gotoGameClass(Action action, Context<HomeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameClassifyPage.pageName,
      arguments: null);
}

void _showProtocol(Action action, Context<HomeState> ctx) {
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return ProtocolDialog(clickAgree: () async {
              ctx.broadcast(AppActionCreator.onInitSetting());
            },);
          },
        );
      });
}


void _showDialogEvent(Action action, Context<HomeState> ctx) {
  ctx.dispatch(HomeActionCreator.showInitCouponDialog());
  ctx.dispatch(HomeActionCreator.showPopupAdDialog());
}

void _startCountDown(Action action, Context<HomeState> ctx) {
  //对数据解析 重构才计数
  //启动定时器  计数
  const oneSec = const Duration(seconds: 1);

  _timer = Timer.periodic(oneSec, (timer) {
    if (ctx.state.splashTime > 0) {
      ctx.dispatch(HomeActionCreator.updateDownCount(--ctx.state.splashTime));
    } else {
      //如果闪屏结束，初始化还是失败，进行重试
      if (InitInfoUtil.loadStatus == LoadStatus.error) {
        ctx.dispatch(HomeActionCreator.onInitCheck());
      }
      _timer.cancel();
      ctx.dispatch(HomeActionCreator.showDialogEvent());
    }
  });
}

//初始化优惠券弹窗
void _showInitCouponDialog(Action action, Context<HomeState> ctx) {
  int scene = 3;
  _getCouponList(action, ctx, scene);
}

//新用户登录弹窗
void _showCouponDialog(Action action, Context<HomeState> ctx) {
  int scene = 0;
  HuoLog.d("btfragment_showCouponDialog");

  if (LoginControl.isLogin() && !LoginControl.isRegister()) {
    scene = 1;
  } else {
    scene = 2;
  }
  _getCouponList(action, ctx, scene);
}

void _getCouponList(Action action, Context<HomeState> ctx, int scene) {
  CouponService.getRewordList(scene).then((data) {
    if (data.code == 200 && data.data.count > 0) {
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return CouponDialog(data.data.list, () {
                  //点击领取
                  if (LoginControl.isLogin()) {
                    requestRewardAdd(action, ctx, scene);
                  } else {
                    Navigator.pop(context);
                    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
                  }
                });
              },
            );
          });
    }
  });
}

//领取奖励
void requestRewardAdd(Action action, Context<HomeState> ctx, int scene) {
  CouponService.takeReward(scene).then((data) {
    if (data["code"] == 200) {
      LoginControl.saveRegister(false);
      showToast(getText(name: 'textReceivingSuccessful'),
          position: ToastPosition.center, textPadding: EdgeInsets.all(10));
      ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      Navigator.pop(ctx.context);
    }
  });
}

void _showPopupAdDialog(Action action, Context<HomeState> ctx) {
  NoPopInfoUtil.getInitInfo().then((value) {
    if (value == AppUtil.formatDate3()) {
    } else {
      InitInfoUtil.getInitInfo().then((info) {
        if (info != null &&
            info.data.popupAd != null &&
            info.data.popupAd.img != null &&
            info.data.popupAd.img.isNotEmpty) {
          showDialog<Null>(
              context: ctx.context, //BuildContext对象
              barrierDismissible: false,
              builder: (BuildContext context) {
                return HomePushDialog(
                  image: info.data.popupAd.img,
                  confirmCallback: () {
                    if (info.data.popupAd.gameId != null &&
                        0 != info.data.popupAd.gameId) {
                      Navigator.pop(context);
                      AppUtil.gotoPageByName(
                          ctx.context, GameDetailsPage.pageName,
                          arguments: {"gameId": info.data.popupAd.gameId});
                    } else if (info.data.popupAd.url != null &&
                        info.data.popupAd.url.isNotEmpty) {
                      Navigator.pop(context);
                      AppUtil.gotoH5Web(
                        ctx.context,
                        info.data.popupAd.url,
                        title: info.data.popupAd.objectType,
                      );
                    }
                  },
                );
              });
        }
      });
    }
  });
}

void _switchToClassify(Action action, Context<HomeState> ctx) {
  HuoLog.d("HomeAction: _switchToClassify");
  ctx.state.controller.animateTo(1);
}
