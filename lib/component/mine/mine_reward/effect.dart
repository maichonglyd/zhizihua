import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/model/user/coupon_my_reward_data.dart';
import 'package:flutter_huoshu_app/widget/dialog/GetRewardSuccessDialog.dart';
import 'action.dart';
import 'state.dart';

Effect<MineRewardState> buildEffect() {
  return combineEffects(<Object, Effect<MineRewardState>>{
    MineRewardAction.action: _onAction,
    MineRewardAction.getReward: _getReward,
    MineRewardAction.getData: _getData,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<MineRewardState> ctx) {}

void _getReward(Action action, Context<MineRewardState> ctx) {
  CouponData couponData = action.payload;
  UserService.getShareSave(couponData.id).then((data) {
    if (data.code == 200) {
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return GetRewardSuccessDialog(couponData.gmCnt.toString());
              },
            );
          });
    } else {}
    ctx.dispatch(MineRewardActionCreator.getData(1));
  });
}

void _init(Action action, Context<MineRewardState> ctx) {
  ctx.dispatch(MineRewardActionCreator.getData(1));
}

void _getData(Action action, Context<MineRewardState> ctx) {
  UserService.getUserShareActlist(action.payload).then((data) {
    if (data.code == 200) {
      ctx.dispatch(MineRewardActionCreator.updateData(data.data.list));
    }
  });
}
