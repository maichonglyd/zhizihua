import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/model/vip/vip_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

class OpenVipState implements Cloneable<OpenVipState> {
  double ptbCnt;
  //支付类型alipay
  String payType;
  int selectedVipId;
  VIPPayInfoData vipPayInfoData;
  TextEditingController priceController = TextEditingController();

  List<VIPMod> vipMods;
  List<PayWayMod> payWayMods;

  @override
  OpenVipState clone() {
    return OpenVipState()
      ..ptbCnt = ptbCnt
      ..payType = payType
      ..selectedVipId = selectedVipId
      ..vipPayInfoData = vipPayInfoData
      ..vipMods = vipMods
      ..payWayMods = payWayMods
      ..priceController = priceController;
  }
}

OpenVipState initState(Map<String, dynamic> args) {
  double ptbCnt = LoginControl.getUserInfo().data.ptbCnt;
  return OpenVipState()..ptbCnt = ptbCnt;
}
