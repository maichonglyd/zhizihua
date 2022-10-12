import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/lottery_service.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryAddressDialog.dart';

import 'action.dart';
import 'state.dart';

Effect<LotteryRewardState> buildEffect() {
  return combineEffects(<Object, Effect<LotteryRewardState>>{
    Lifecycle.initState: _init,
    LotteryRewardAction.action: _onAction,
    LotteryRewardAction.getData: _getData,
    LotteryRewardAction.showAddressDialog: _showAddressDialog,
  });
}

void _onAction(Action action, Context<LotteryRewardState> ctx) {
}

void _init(Action action, Context<LotteryRewardState> ctx) {
  ctx.dispatch(LotteryRewardActionCreator.getData(1));
}

void _getData(Action action, Context<LotteryRewardState> ctx) {
  int page = action.payload;
  LotteryService.getMyRewardList(page).then((data) {
    if (200 == data.code) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.list, page);
      ctx.dispatch(LotteryRewardActionCreator.updateData(newData));
    }
  });
}

void _showAddressDialog(Action action, Context<LotteryRewardState> ctx) {
  String orderId = action.payload;
  showDialog<Null>(
    context: ctx.context,
    barrierDismissible: false,
    builder: (context) {
      return LotteryAddressDialog(
        submitCallback: (name, address, phone) {
          LotteryService.createAddress(orderId, name, address, phone)
              .then((data) {
            if (200 == data.code) {
              LotteryService.getMyRewardList(1).then((data) {
                if (200 == data.code) {
                  ctx.dispatch(LotteryRewardActionCreator.getData(1));
                }
              });
            }
          });
        },
      );
    },
  );
}
