import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';

class GameCouponState implements Cloneable<GameCouponState> {
  String gameName;
  List<CvCouponBean> list = [];
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  GameCouponState clone() {
    return GameCouponState()
      ..gameName = gameName
      ..list = list
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

GameCouponState initState(Map<String, dynamic> args) {
  return GameCouponState()..gameName = args['gameName'];
}
