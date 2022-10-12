import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/api/vip_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/game/game_classify/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:flutter_huoshu_app/page/vip/open_vip/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/GiftSuccessDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/SignDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/VIPPrivilegeDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<MemberCenterState> buildEffect() {
  return combineEffects(<Object, Effect<MemberCenterState>>{
    MemberCenterAction.action: _onAction,
    MemberCenterAction.showAlertDialog: _showAlertDialog,
    MemberCenterAction.getData: _getData,
    MemberCenterAction.getMemInfo: _getMemInfo,
    MemberCenterAction.gotoFinish: _gotoFinish,
    MemberCenterAction.showSign: _showSign,
    MemberCenterAction.gotoTaskCenter: _gotoTaskCenter,
    MemberCenterAction.gotoOpenVip: _gotoOpenVip,
    Lifecycle.initState: _init
  });
}

void _gotoOpenVip(Action action, Context<MemberCenterState> ctx) {
  AppUtil.gotoPageByName(ctx.context, OpenVipPage.pageName, arguments: null);
}

void _gotoTaskCenter(Action action, Context<MemberCenterState> ctx) {
  AppUtil.gotoPageByName(ctx.context, TaskCenterPage.pageName, arguments: null);
}

void _getData(Action action, Context<MemberCenterState> ctx) {
  UserService.getTaskHome().then((data) {
    ctx.dispatch(MemberCenterActionCreator.updateData(data));
  });

  ctx.dispatch(MemberCenterActionCreator.getMemInfo());
//  UserService.getUserInfo().then((UserInfo userInfo) {
//    //  userInfo.data.myIntegral;
//    ctx.dispatch(TaskCenterActionCreator.updateUserInfo(userInfo));
//  });
}

void _getMemInfo(Action action, Context<MemberCenterState> ctx) {
  //获取vip用户信息
  VIPService.getMemInfo().then((data) {
    if (data.code == 200) {
      ctx.dispatch(MemberCenterActionCreator.updateMemberData(data.data));
    }
  });
}

void _gotoFinish(Action action, Context<MemberCenterState> ctx) {
  int taskId = action.payload;
//  UserService.getTaskHome().then((data) {
//    ctx.dispatch(TaskCenterActionCreator.updateData(data));
//  });
  switch (taskId) {
    case 1:
      ctx.dispatch(MemberCenterActionCreator.showSign());
      break;
    case 2:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;

    case 23:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;
    case 9:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;
    case 7:
      AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;

    case 5:
      AppUtil.gotoPageByName(ctx.context, MyWalletPage.pageName).then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;

    case 6:
      AppUtil.gotoPageByName(ctx.context, MyWalletPage.pageName).then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;
    case 14:
      AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null)
          .then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;
    case 24:
      AppUtil.gotoPageByName(ctx.context, GameClassifyPage.pageName,
              arguments: null)
          .then((result) {
        ctx.dispatch(MemberCenterActionCreator.getData());
        //通知个人中心更新
        ctx.broadcast(MineFragmentActionCreator.getUserInfo());
      });
      break;
    default:
      break;
  }
}

//签到
void _showSign(Action action, Context<MemberCenterState> ctx) {
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
                    userInfo.data.myIntegral = data['data']['my_integral'];
                    LoginControl.saveUserInfo(json.encode(userInfo));
                  }
                  ctx.dispatch(MemberCenterActionCreator.getData());
                  //通知个人中心更新
                  ctx.broadcast(MineFragmentActionCreator.getUserInfo());
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

//弹窗
void _showAlertDialog(Action action, Context<MemberCenterState> ctx) {
  int type = action.payload;
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return VIPPrivilegeDialog(type);
          },
        );
      });
}

void _onAction(Action action, Context<MemberCenterState> ctx) {}

void _init(Action action, Context<MemberCenterState> ctx) {
  List<Item> tabs = initCommonTabs();
  ctx.dispatch(MemberCenterActionCreator.updateTabs(tabs));
  ctx.dispatch(MemberCenterActionCreator.getData());
}

//初始化vip功能项
List<Item> initCommonTabs() {
  List<String> tabNames = [
    getText(name: 'textTag'),
    getText(name: 'textNickname'),
    getText(name: 'textSignAddition'),
    getText(name: 'textTask'),
  ];
  List<String> images = [
    "images/vip_ic_vbs.png",
    "images/vip_ic_name.png",
    "images/vip_ic_sign.png",
    "images/vip_ic_task.png",
  ];
  List<Item> tabs = [];
  tabs.clear();
//  Game game;
  for (int i = 0; i < tabNames.length; i++) {
    Item game = Item(tabNames[i], tabNames[i], i, images[i]);
    tabs.add(game);
  }
  return tabs;
}
