import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/game/game_classify/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_shop/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/lottery/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/SignDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<TaskCenterState> buildEffect() {
  return combineEffects(<Object, Effect<TaskCenterState>>{
    TaskCenterAction.action: _onAction,
    Lifecycle.initState: _init,
    TaskCenterAction.getData: _getData,
    TaskCenterAction.gotoFinish: _gotoFinish,
    TaskCenterAction.showSign: _showSign,
    TaskCenterAction.gotoIntegralShop: _gotoIntegralShop,
    TaskCenterAction.gotoInvite: _gotoInvite,
    TaskCenterAction.gotoLottery: _gotoLottery,
  });
}

void _onAction(Action action, Context<TaskCenterState> ctx) {}

void _getData(Action action, Context<TaskCenterState> ctx) {
  UserService.getTaskHome().then((data) {
    ctx.dispatch(TaskCenterActionCreator.updateData(data));
  });
  UserService.getUserInfo().then((UserInfo userInfo) {
    //  userInfo.data.myIntegral;
    ctx.dispatch(TaskCenterActionCreator.updateUserInfo(userInfo));
  });
}

void _gotoLottery(Action action, Context<TaskCenterState> ctx) {
  AppUtil.gotoPageByName(ctx.context, LotteryPage.pageName, arguments: null);
}

void _gotoInvite(Action action, Context<TaskCenterState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null);
}

void _gotoIntegralShop(Action action, Context<TaskCenterState> ctx) {
  AppUtil.gotoPageByName(ctx.context, IntegralShopPage.pageName,
      arguments: null);
}

Future _init(Action action, Context<TaskCenterState> ctx) async {
  List<Item> tabs = initCommonTabs();
  ctx.dispatch(TaskCenterActionCreator.updateTabs(tabs));
  ctx.dispatch(TaskCenterActionCreator.getData());
}

//初始化vip功能项
List<Item> initCommonTabs() {
  List<String> tabNames = [
    getText(name: 'textShop'),
    getText(name: 'textInviteMoney'),
    getText(name: 'textLottery'),
  ];
  List<String> images = [
    "images/ic_shopping.png",
    "images/icon_invited.png",
    "images/ic_luckdraw.png",
  ];
  List<Item> tabs = [];
  tabs.clear();
  for (int i = 0; i < tabNames.length; i++) {
    Item game = Item(tabNames[i], tabNames[i], i, images[i]);
    tabs.add(game);
  }
  return tabs;
}

void _gotoFinish(Action action, Context<TaskCenterState> ctx) {
  int taskId = action.payload;
//  UserService.getTaskHome().then((data) {
//    ctx.dispatch(TaskCenterActionCreator.updateData(data));
//  });
  switch (taskId) {
    case 1:
      ctx.dispatch(TaskCenterActionCreator.showSign());
      break;
    case 2:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;

    case 23:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;
    case 9:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;
    case 7:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;

    case 5:
      AppUtil.gotoPageByName(ctx.context, MyWalletPage.pageName).then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;

    case 6:
      AppUtil.gotoPageByName(ctx.context, MyWalletPage.pageName).then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;
    case 14:
      AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null)
          .then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;
    case 24:
      AppUtil.gotoPageByName(ctx.context, GameClassifyPage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(TaskCenterActionCreator.getData());
      });
      break;

    default:
      break;
  }
}

void _showSign(Action action, Context<TaskCenterState> ctx) {
  if (LoginControl.isLogin()) {
    UserService.getSignList().then((data) {
      if (data.code == 200) {
        showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, state) {
              return SignDialog(data.data, () {
                UserService.addSign().then((data) {
                  if (data['code'] == 200) {
                    showToast(getText(name: 'textSignSuccessful'));
                    Navigator.of(context).pop();
                    //更新用户积分
                    UserInfo userInfo = LoginControl.getUserInfo();
                    userInfo.data.myIntegral = AppUtil.stringToNum(data['data']['my_integral'].toString());
                    LoginControl.saveUserInfo(json.encode(userInfo));
                  }
                  ctx.dispatch(TaskCenterActionCreator.getData());
                });
              });
            });
          },
        );
      }
    });
  } else {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
  }
}
