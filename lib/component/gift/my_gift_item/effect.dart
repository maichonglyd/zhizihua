import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/gift/gift_details/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<MyGiftItemState> buildEffect() {
  return combineEffects(<Object, Effect<MyGiftItemState>>{
    MyGiftItemAction.action: _onAction,
    MyGiftItemAction.gotoGiftDetails: _gotoGiftDetails,
    MyGiftItemAction.copy: _copy,
  });
}

void _onAction(Action action, Context<MyGiftItemState> ctx) {}
void _copy(Action action, Context<MyGiftItemState> ctx) {
  showToast(getText(name: 'textCopySuccessful'));
  AppUtil.copyToClipboard(ctx.state.gift.giftCode);
}

void _gotoGiftDetails(Action action, Context<MyGiftItemState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GiftDetailsPage.pageName,
      arguments: ctx.state.gift);
}
