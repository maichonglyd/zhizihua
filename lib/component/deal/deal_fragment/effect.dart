import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_search/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<DealFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<DealFragmentState>>{
    DealFragmentAction.action: _onAction,
    Lifecycle.initState: _init,
    DealFragmentAction.gotoDealNotice: _gotoDealNotice,
    DealFragmentAction.gotoSearch: _gotoSearch,
  });
}

void _onAction(Action action, Context<DealFragmentState> ctx) {}

void _gotoSearch(Action action, Context<DealFragmentState> ctx) {
  bool isAccount = action.payload;
  AppUtil.gotoPageByName(ctx.context, DealSearchPage.pageName,
      arguments: {"type": isAccount});
}

void _gotoDealNotice(Action action, Context<DealFragmentState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  if (ctx.state.index == 0) {
    AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
      "title": getText(name: 'textTradingInstructions'),
      "url": AppConfig.baseUrl + "app/account/deal/agreement"
    });
  } else {
    AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
      "title": getText(name: 'textTradingInstructions'),
      "url": AppConfig.baseUrl + "app/material/agreement"
    });
  }
}

void _init(Action action, Context<DealFragmentState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  var tabController =
      new TabController(initialIndex: 0, length: 2, vsync: tickerProvider);
  ctx.dispatch(DealFragmentActionCreator.crateTabController(tabController));
  tabController.addListener(() {
    ctx.dispatch(DealFragmentActionCreator.switchIndex(tabController.index));
  });
}
