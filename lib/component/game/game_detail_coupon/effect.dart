import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/coupon_service.dart';
import 'package:flutter_huoshu_app/page/game_details_page/action.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GameDetailCouponState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailCouponState>>{
    GameDetailCouponAction.action: _onAction,
    GameDetailCouponAction.getCoupon: _getCoupon,
  });
}

void _onAction(Action action, Context<GameDetailCouponState> ctx) {
}

void _getCoupon(Action action, Context<GameDetailCouponState> ctx) {
  int id = action.payload;
  if (null != id) {
    CouponService.obtainCoupon(id: id).then((data) {
      if (200 == data.code) {
        showToast("请到个人中心-卡券中查看");
        ctx.dispatch(GameDetailsActionCreator.getCouponList());
      }
    });
  }
}
