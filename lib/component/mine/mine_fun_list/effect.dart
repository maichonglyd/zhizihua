import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_security/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_setting/page.dart';
import 'package:flutter_huoshu_app/page/mine/service/page.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import '../../../app_config.dart';
import 'action.dart';
import 'state.dart';

Effect<MineFunListState> buildEffect() {
  return combineEffects(<Object, Effect<MineFunListState>>{
    MineFunListAction.action: _onAction,
    MineFunListAction.gotoSetting: _gotoSetting,
    MineFunListAction.gotoInvite: _gotoInvite,
    MineFunListAction.gotoInviteList: _gotoInviteList,
    MineFunListAction.gotoRebate: _gotoRebate,
    MineFunListAction.gotoSecurity: _gotoSecurity,
    MineFunListAction.gotoService: _gotoService,
    MineFunListAction.gotoRecycle: _gotoRecycle,
    MineFunListAction.gotoActivityNews: _gotoActivityNews,
    MineFunListAction.gotoDisclaimer: _gotoDisclaimer,
    MineFunListAction.gotoDisputeResolution: _gotoDisputeResolution,
  });
}

void _onAction(Action action, Context<MineFunListState> ctx) {}

void _gotoSetting(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, SettingPage.pageName, arguments: null)
      .then((result) {
    ctx.dispatch(MineFragmentActionCreator.getUserInfo());
  });
}

void _gotoRecycle(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, AccountRecyclePage.pageName,
          arguments: null)
      .then((result) {
    ctx.dispatch(MineFragmentActionCreator.getUserInfo());
  });
}

void _gotoInvite(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null);
}

void _gotoInviteList(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InviteListPage.pageName, arguments: null);
}

void _gotoRebate(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, RebateApplyPage.pageName,
      arguments: null);
}

void _gotoSecurity(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, SecurityPage.pageName, arguments: null);
}

void _gotoService(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ServicePage.pageName, arguments: null);
}

void _gotoActivityNews(Action action, Context<MineFunListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ActivityNewsPage.pageName,
      arguments: null);
}

void _gotoDisclaimer(Action action, Context<MineFunListState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textResponsibility'),
    "url": AppConfig.baseUrl + "app/app/disclaimer"
  });
}

void _gotoDisputeResolution(Action action, Context<MineFunListState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textDispute'),
    "url": AppConfig.baseUrl + "app/reg/dispute_resolution"
  });
}
