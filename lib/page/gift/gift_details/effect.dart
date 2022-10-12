import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/gift_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GiftDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<GiftDetailsState>>{
    GiftDetailsAction.action: _onAction,
    GiftDetailsAction.addGift: _addGift,
    GiftDetailsAction.getGift: _getGift,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GiftDetailsState> ctx) {}

void _getGift(Action action, Context<GiftDetailsState> ctx) {
  GiftService.getGiftDetails(ctx.state.gift.giftId).then((data) {
    if (data.code == 200) {
      ctx.dispatch(GiftDetailsActionCreator.updateData(data.data));
    }
  });
}

void _init(Action action, Context<GiftDetailsState> ctx) {
  GiftService.getGiftDetails(ctx.state.gift.giftId).then((data) {
    if (data.code == 200) {
      ctx.dispatch(GiftDetailsActionCreator.updateData(data.data));
    }
  });
}

void _addGift(Action action, Context<GiftDetailsState> ctx) {
  if (ctx.state.gift.giftCode != null && ctx.state.gift.giftCode.isNotEmpty) {
    //复制粘贴板
    showToast(getText(name: 'textCopySuccessful'));
    AppUtil.copyToClipboard(ctx.state.gift.giftCode);
    return;
  }
  if (ctx.state.gift.remainCnt == 0) {
    showToast(getText(name: 'textReceiving'));
    return;
  }
  GiftService.addGift(ctx.state.gift.giftId, ctx).then((data) {
    if (data["code"] == 200) {
      showToast(getText(name: 'textReceivingSuccessful'));
      ctx.dispatch(GiftDetailsActionCreator.getGift());
    }
  });
}
