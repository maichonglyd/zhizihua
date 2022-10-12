import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

class PtzRechargeState implements Cloneable<PtzRechargeState> {
  int money = 10;

  double ptbCnt;
  int payType = 0;
  DealPayInfoData dealPayInfoData;
  List<int> defaultMoneys = [10, 30, 50, 100, 500, 1000];
  TextEditingController priceController = TextEditingController();

  List<PayWayMod> payWayMods;

  @override
  PtzRechargeState clone() {
    return PtzRechargeState()
      ..money = money
      ..ptbCnt = ptbCnt
      ..payType = payType
      ..defaultMoneys = defaultMoneys
      ..dealPayInfoData = dealPayInfoData
      ..payWayMods = payWayMods
      ..priceController = priceController;
  }
}

PtzRechargeState initState(Map<String, dynamic> args) {
  double ptbCnt = LoginControl.getUserInfo().data.ptbCnt;
  return PtzRechargeState()..ptbCnt = ptbCnt;
}
