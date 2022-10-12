import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/coupon_service.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';
import 'action.dart';
import 'state.dart';

Effect<CouponListState> buildEffect() {
  return combineEffects(<Object, Effect<CouponListState>>{
    CouponListAction.action: _onAction,
    CouponListAction.getCouponList: _getCouponList,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<CouponListState> ctx) {}

void _getCouponList(Action action, Context<CouponListState> ctx) {
  print("_getCouponList");
  CouponService.getCouponList(action.payload, ctx.state.status).then((data) {
    if (200 == data.code) {
      var newList = ctx.state.refreshHelperController.controllerRefresh(data.data.list, ctx.state.coupons, action.payload);
      ctx.dispatch(CouponListActionCreator.updateGameList(newList));
    }
  });
}

void _init(Action action, Context<CouponListState> ctx) {
  ctx.dispatch(CouponListActionCreator.getCouponList(1));
}
