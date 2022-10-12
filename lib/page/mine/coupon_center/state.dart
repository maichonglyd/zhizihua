import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';

class CouponCenterState implements Cloneable<CouponCenterState> {
  RefreshHelperController refreshHelperController = RefreshHelperController();
  RefreshHelper refreshHelper = RefreshHelper();
  TextEditingController contentController = TextEditingController();
  List<CouponCenter> gameCouponList = [];

  @override
  CouponCenterState clone() {
    return CouponCenterState()
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper
      ..contentController = contentController
      ..gameCouponList = gameCouponList;
  }
}

CouponCenterState initState(Map<String, dynamic> args) {
  return CouponCenterState();
}
