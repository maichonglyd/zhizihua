import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/app/page.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/init_info_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/share_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/page/mine/integral_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_rule/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<InviteState> buildEffect() {
  return combineEffects(<Object, Effect<InviteState>>{
    InviteAction.action: _onAction,
    InviteAction.showShare: _showShare,
    InviteAction.notifyShare: _notifyShare,
    InviteAction.gotoReward: _gotoReward,
    InviteAction.gotoRule: _gotoRule,
    Lifecycle.initState: _init,
    LoginAction.loginOK: _loginOK,
  });
}

void _onAction(Action action, Context<InviteState> ctx) {}

void _gotoReward(Action action, Context<InviteState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }
  AppUtil.gotoPageByName(ctx.context, IntegralRecordPage.pageName);
}

void _notifyShare(Action action, Context<InviteState> ctx) {
  UserService.notifyShare(ctx.state.shareInfo.data.shareId, action.payload)
      .then((data) {
    showToast(getText(name: 'textShareSuccessful'));
    //通知个人中心更新
    ctx.broadcast(MineFragmentActionCreator.getUserInfo());
    Navigator.of(ctx.context).pop();
  });
}

void _showShare(Action action, Context<InviteState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }
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
                  print("启动微信好友分享");
                  //等待dialog
                  showToast(getText(name: 'toastStartShare'));
                  shareToWechat(context, ctx.state.shareInfo, (type) {
                    ctx.dispatch(InviteActionCreator.notifyShare(type));
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
                          color: AppTheme.colors.textSubColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("启动微信朋友圈分享");
                  shareToWechatFavorites(context, ctx.state.shareInfo, (type) {
                    ctx.dispatch(InviteActionCreator.notifyShare(type));
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
                          color: AppTheme.colors.textSubColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("启动QQ好友分享");
                  showToast(getText(name: 'toastStartShare'));
                  shareQQCustom(context, ctx.state.shareInfo, (type) {
                    ctx.dispatch(InviteActionCreator.notifyShare(type));
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
                          color: AppTheme.colors.textSubColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        );
      });
}

void _init(Action action, Context<InviteState> ctx) {
  UserService.getShareDataByApp(
          type: ctx.state.shareType, lotteryId: ctx.state.lotteryId)
      .then((data) {
    ctx.dispatch(InviteActionCreator.update(data));
  });
}

void _loginOK(Action action, Context<InviteState> ctx) {
  UserService.getShareDataByApp(
          type: ctx.state.shareType, lotteryId: ctx.state.lotteryId)
      .then((data) {
    ctx.dispatch(InviteActionCreator.update(data));
  });
}

void _gotoRule(Action action, Context<InviteState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InviteRulePage.pageName,
      arguments: ctx.state.shareInfo.data.rule);
}
