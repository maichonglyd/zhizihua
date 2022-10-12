import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';
import 'package:flutter_huoshu_app/page/download/download_manage/page.dart';
import 'package:flutter_huoshu_app/page/gift/my_gift/page.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_shop/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_feedback/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_setting/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/page/mine/service/page.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MineCommonFuncState> buildEffect() {
  return combineEffects(<Object, Effect<MineCommonFuncState>>{
    MineCommonFuncAction.action: _onAction,
    MineCommonFuncAction.gotoMyGift: _gotoMyGift,
    MineCommonFuncAction.gotoIntegralShop: _gotoIntegralShop,
    MineCommonFuncAction.gotoRecharge: _gotoRecharge,
    MineCommonFuncAction.gotoDownload: _gotoDownload,
    MineCommonFuncAction.gotoRebate: _gotoRebate,
    MineCommonFuncAction.gotoActivityNews: _gotoActivityNews,
    MineCommonFuncAction.gotoFeedback: _gotoFeedback,
    MineCommonFuncAction.gotoRegisterAgreement: _gotoRegisterAgreement,
    MineCommonFuncAction.gotoUseInstructions: _gotoUseInstructions,
    MineCommonFuncAction.gotoUserPrivacy: _gotoUserPrivacy,
    MineCommonFuncAction.gotoInvite: _gotoInvite,
    MineCommonFuncAction.gotoService: _gotoService,
    MineCommonFuncAction.gotoSetting: _gotoSetting,
    MineCommonFuncAction.gotoInviteList: _gotoInviteList,
    MineCommonFuncAction.gotoCoupon: _gotoCoupon,
    MineCommonFuncAction.gotoDisclaimer: _gotoDisclaimer,
    MineCommonFuncAction.gotoDisputeResolution: _gotoDisputeResolution,
    MineCommonFuncAction.gotoGameCurrencyList: _gotoGameCurrencyList,
  });
}

void _gotoCoupon(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MineCouponPage.pageName, arguments: null);
}

void _gotoInviteList(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InviteListPage.pageName, arguments: null);
}

void _gotoSetting(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, SettingPage.pageName, arguments: null)
      .then((result) {
    ctx.dispatch(MineFragmentActionCreator.getUserInfo());
  });
}

void _gotoService(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ServicePage.pageName, arguments: null);
}

void _gotoInvite(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null);
}

void _gotoFeedback(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, FeedbackPage.pageName, arguments: null);
}

void _onAction(Action action, Context<MineCommonFuncState> ctx) {}

void _gotoRebate(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, RebateApplyPage.pageName,
      arguments: null);
}

void _gotoActivityNews(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ActivityNewsPage.pageName,
      arguments: null);
}

void _gotoMyGift(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MyGiftPage.pageName, arguments: null);
}

void _gotoIntegralShop(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, IntegralShopPage.pageName,
      arguments: null);
}

void _gotoRecharge(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MyWalletPage.pageName).then((result) {
    ctx.broadcast(MineFragmentActionCreator.getUserInfo());
  });
}

void _gotoDownload(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DownLoadManagePage.pageName,
      arguments: null);
}

void _gotoRegisterAgreement(Action action, Context<MineCommonFuncState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textRegisterAgreement'),
    "url": AppConfig.baseUrl + "app/reg/agreement"
  });
}

void _gotoUserPrivacy(Action action, Context<MineCommonFuncState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textPrivateProtocol'),
    "url": AppConfig.baseUrl + "app/app/userprivacy"
  });
}

void _gotoDisclaimer(Action action, Context<MineCommonFuncState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textResponsibility'),
    "url": AppConfig.baseUrl + "app/app/disclaimer"
  });
}

void _gotoDisputeResolution(Action action, Context<MineCommonFuncState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textDispute'),
    "url": AppConfig.baseUrl + "app/reg/dispute_resolution"
  });
}

//使用指南
void _gotoUseInstructions(Action action, Context<MineCommonFuncState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": getText(name: 'textOperatorGuide'),
    "url": AppConfig.baseUrl + "app/app/instructions"
  });
}

//跳转游戏币页面
void _gotoGameCurrencyList(Action action, Context<MineCommonFuncState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameCurrencyListPage.pageName,
      arguments: null);
}
