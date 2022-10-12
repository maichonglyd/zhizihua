import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/gift_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/gift/game_details_gift/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/gift/gift_details/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'action.dart';
import 'state.dart';

Effect<GiftItemState> buildEffect() {
  return combineEffects(<Object, Effect<GiftItemState>>{
    GiftItemAction.action: _onAction,
    GiftItemAction.gotoGiftDetails: _gotoGiftDetails,
    GiftItemAction.addGift: _addGift,
  });
}

void _onAction(Action action, Context<GiftItemState> ctx) {}

void _gotoGiftDetails(Action action, Context<GiftItemState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GiftDetailsPage.pageName,
      arguments: ctx.state.gift);
}

void _addGift(Action action, Context<GiftItemState> ctx) {
  if (ctx.state.gift.giftCode.isNotEmpty) {
    //复制粘贴板
    showToast(getText(name: 'textCopySuccessful'));
    AppUtil.copyToClipboard(ctx.state.gift.giftCode);
    return;
  }
  if (ctx.state.gift.remainCnt == 0) {
    showToast(getText(name: 'textReceiving'));
    return;
  }
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName, arguments: null);
    return;
  }
  GiftService.addGift(ctx.state.gift.giftId, ctx).then((data) {
    if (data["code"] == 200) {
      showToast(getText(name: 'textReceivingSuccessful'));
      ctx.dispatch(GameDetailsGiftFragmentActionCreator.getGift(1));
    }
  });
}
