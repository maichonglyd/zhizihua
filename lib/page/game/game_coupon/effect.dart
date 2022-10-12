import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/coupon_service.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Effect<GameCouponState> buildEffect() {
  return combineEffects(<Object, Effect<GameCouponState>>{
    Lifecycle.initState: _init,
    GameCouponAction.action: _onAction,
    GameCouponAction.getData: _getData,
    GameCouponAction.getCoupon: _getCoupon,
  });
}

void _onAction(Action action, Context<GameCouponState> ctx) {
}

void _init(Action action, Context<GameCouponState> ctx) {
  ctx.dispatch(GameCouponActionCreator.getData(1));
}

void _getData(Action action, Context<GameCouponState> ctx) {
  int page = action.payload;
  String gameName = ctx.state.gameName;
  CouponService.getCouponCenter(page: page, gameName: gameName).then((data) {
    if (200 == data.code) {
      if (null != data.data && null != data.data.list && data.data.list.length > 0) {
        var newData = ctx.state.refreshHelperController.controllerRefresh(data.data.list[0].cvCoupon, ctx.state.list, page);
        ctx.dispatch(GameCouponActionCreator.updateData(newData));
      }
    }
  });
}

void _getCoupon(Action action, Context<GameCouponState> ctx) {
  int id = action.payload;
  if (null != id) {
    CouponService.obtainCouponCenter(id: id).then((data) {
      if (200 == data.code) {
        showToast("请到个人中心-卡券中查看");
        ctx.broadcast(GameCouponActionCreator.getData(1));
      }
    });
  }
}
