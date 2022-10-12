import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action,Page;
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_search/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'action.dart';
import 'state.dart';

Effect<DealState> buildEffect() {
  return combineEffects(<Object, Effect<DealState>>{
    DealAction.action: _onAction,
    Lifecycle.initState: _init,
    DealAction.gotoDealNotice: _gotoDealNotice,
    DealAction.gotoSearch: _gotoSearch,
  });
}

void _onAction(Action action, Context<DealState> ctx) {}

void _gotoSearch(Action action, Context<DealState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DealSearchPage.pageName);
}

void _gotoDealNotice(Action action, Context<DealState> ctx) {

//  if (ctx.state.index == 0) {
//    AppUtil.gotoPageByName(ctx.context, WebPage.pageName, arguments: {
//      "title": "交易须知",
//      "url": AppConfig.baseUrl + "app/account/deal/agreement"
//    });
//  } else {
//    AppUtil.gotoPageByName(ctx.context, WebPage.pageName, arguments: {
//      "title": "交易须知",
//      "url": AppConfig.baseUrl + "app/material/agreement"
//    });
//  }
}

void _init(Action action, Context<DealState> ctx) {
}
