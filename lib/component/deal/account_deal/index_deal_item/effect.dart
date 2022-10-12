import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_details_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexDealItemState> buildEffect() {
  return combineEffects(<Object, Effect<IndexDealItemState>>{
    IndexDealItemAction.action: _onAction,
    IndexDealItemAction.gotoDealDetails: _gotoDealDetails,
  });
}

void _onAction(Action action, Context<IndexDealItemState> ctx) {}

void _gotoDealDetails(Action action, Context<IndexDealItemState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DealDetailsPage.pageName,
      arguments: ctx.state.dealGoods.goodsId);
}
