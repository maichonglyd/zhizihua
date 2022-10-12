import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

class VipOpenState implements Cloneable<VipOpenState> {
  List<VIPMod> vipMods;
  List<PayWayMod> payWayMods;
  MemInfoData memInfoData;
  VIPPayInfoData vipPayInfoData;
  List<RecordMod> recordList;

  @override
  VipOpenState clone() {
    return VipOpenState()
      ..vipMods = vipMods
      ..memInfoData = memInfoData
      ..recordList = recordList
      ..vipPayInfoData = vipPayInfoData
      ..payWayMods = payWayMods;
  }
}

VipOpenState initState(Map<String, dynamic> args) {
  return VipOpenState();
}
