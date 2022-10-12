import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_game_list.dart';

class GameDetailCouponState implements Cloneable<GameDetailCouponState> {
  CouponGameList couponGameList;

  @override
  GameDetailCouponState clone() {
    return GameDetailCouponState()..couponGameList = couponGameList;
  }
}

GameDetailCouponState initState({CouponGameList couponGameList}) {
  return GameDetailCouponState()..couponGameList = couponGameList;
}
