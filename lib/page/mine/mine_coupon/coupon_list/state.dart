import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_bean_list.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class CouponListState implements Cloneable<CouponListState> {
  List<Game> games;
  List<String> testDatas = ["123", "456", "789"];
  List<CouponMod> coupons = [];

  int status = 1; //1 未使用 2 已使用  3.已过期
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  CouponListState clone() {
    return CouponListState()
      ..testDatas = testDatas
      ..status = status
      ..coupons = coupons
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

CouponListState initState(int status) {
  return CouponListState()..status = status;
}
