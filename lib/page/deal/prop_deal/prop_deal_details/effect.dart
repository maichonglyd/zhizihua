import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_buy_edit/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_sell_edit/page.dart';
import 'package:flutter_huoshu_app/page/game/game_pic_gallery/page.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealDetailsState>>{
    PropDealDetailsAction.action: _onAction,
    PropDealDetailsAction.gotoBuy: _gotoBuy,
    PropDealDetailsAction.getGoodsDetails: _getGoodsDetails,
    Lifecycle.initState: _init,
    PropDealDetailsAction.gotoEdit: _gotoEdit,
    PropDealDetailsAction.init: _init,
    PropDealDetailsAction.cancelGoods: _cancelGoods,
    PropDealDetailsAction.gotoGallery: _gotoGallery,
  });
}

void _onAction(Action action, Context<PropDealDetailsState> ctx) {}

void _cancelGoods(Action action, Context<PropDealDetailsState> ctx) {
  DealService.cancelMaterialGoods(ctx.state.goodsId).then((data) {
    ctx.dispatch(PropDealDetailsActionCreator.getGoodsDetails());
  });
}

void _gotoGallery(Action action, Context<PropDealDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GalleryPage.pageName, arguments: {
    'urls': ctx.state.goods.image.map((image) => image).toList(),
    "initIndex": action.payload
  });
}

void _gotoEdit(Action action, Context<PropDealDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealSellEditPage.pageName,
      arguments: {"goodsId": action.payload}).then((data) {
    ctx.dispatch(PropDealDetailsActionCreator.getGoodsDetails());
  });
}

void _init(Action action, Context<PropDealDetailsState> ctx) {
  ctx.dispatch(PropDealDetailsActionCreator.getGoodsDetails());
}

void _getGoodsDetails(Action action, Context<PropDealDetailsState> ctx) {
  DealService.getMaterialGoodsDetails(ctx.state.goodsId).then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      ctx.dispatch(PropDealDetailsActionCreator.updateData(data.data));
    }
  });
}

void _gotoBuy(Action action, Context<PropDealDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealBuyPage.pageName,arguments: ctx.state.goods).then((data) {
    if (null != data && 2 == data['status']) {
      Navigator.of(ctx.context).pop();
    }
  });
}
