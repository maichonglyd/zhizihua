import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/gift_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';
import 'package:flutter_huoshu_app/page/gift/gift_details/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/GiftSuccessDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GiftListFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<GiftListFragmentState>>{
    GiftListFragmentAction.action: _onAction,
    Lifecycle.initState: _init,
    GiftListFragmentAction.getData: _getData,
    GiftListFragmentAction.gotoGiftDetails: _gotoGiftDetails,
    GiftListFragmentAction.addGift: _addGift,
  });
}

void _onAction(Action action, Context<GiftListFragmentState> ctx) {}

void _init(Action action, Context<GiftListFragmentState> ctx) {
  ctx.dispatch(GiftListFragmentActionCreator.getData(1));
}

void _getData(Action action, Context<GiftListFragmentState> ctx) {
  if (null != ctx.state.gameId && ctx.state.gameId != 0) {
    GiftService.getGiftsById(ctx.state.gameId, action.payload, 10).then((data) {
      if (data.code == 200) {
        var newData = ctx.state.refreshHelperController
            .controllerRefresh(data.data.list, ctx.state.gifts, action.payload);
        ctx.dispatch(GiftListFragmentActionCreator.updateData(newData));
      }
    });
  } else {
    GiftService.getGifts(action.payload, 10).then((data) {
      if (data.code == 200) {
        var newData = ctx.state.refreshHelperController
            .controllerRefresh(data.data.list, ctx.state.gifts, action.payload);
        ctx.dispatch(GiftListFragmentActionCreator.updateData(newData));
      }
    });
  }
}

void _gotoGiftDetails(Action action, Context<GiftListFragmentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GiftDetailsPage.pageName,
      arguments: action.payload);
}

void _addGift(Action action, Context<GiftListFragmentState> ctx) {
  Gift gift = action.payload;
  if (gift.giftCode.isNotEmpty) {
    //复制粘贴板
    showToast(getText(name: 'textCopySuccessful'));
    AppUtil.copyToClipboard(gift.giftCode);
    return;
  }
  if (gift.remainCnt == 0) {
    showToast(getText(name: 'textReceiving'));
    return;
  }
  GiftService.addGift(gift.giftId, ctx).then((data) {
    if (data["code"] == 200) {
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return GiftSuccessDialog(data["data"]["code"]);
              },
            );
          });
      ctx.dispatch(GiftListFragmentActionCreator.getData(1));
    }
  });
}
