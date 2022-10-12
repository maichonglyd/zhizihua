import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

//TODO replace with your own action
enum VipOpenAction {
  action,
  showPayTypeDialog,
  updateVipList,
  updateMemberData,
  getMemInfo,
  updatePayInfoData,
  reward,
  updateRecordList,
  showRecordDialog,
  getRecordList,
  getVipList,
  showRewardDialog
}

class VipOpenActionCreator {
  static Action onAction() {
    return const Action(VipOpenAction.action);
  }

  static Action showPayTypeDialog(List<PayWayMod> payWayMods, VIPMod vipMod) {
    return Action(VipOpenAction.showPayTypeDialog,
        payload: {"payWayMods": payWayMods, "vipMod": vipMod});
  }

  static Action showRewardDialog() {
    return const Action(VipOpenAction.showRewardDialog);
  }

  static Action getMemInfo() {
    return const Action(VipOpenAction.getMemInfo);
  }

  static Action updateVipList(
      List<VIPMod> vipMods, List<PayWayMod> payWayMods) {
    return Action(VipOpenAction.updateVipList,
        payload: {"VIPModList": vipMods, "PayWayModList": payWayMods});
  }

  static Action updateMemberData(MemInfoData memInfo) {
    return Action(VipOpenAction.updateMemberData, payload: memInfo);
  }

  static Action updatePayInfoData(VIPPayInfoData vipPayInfoData) {
    return Action(VipOpenAction.updatePayInfoData, payload: vipPayInfoData);
  }

  static Action reward(int vipId) {
    return Action(VipOpenAction.reward, payload: vipId);
  }

  static Action updateRecordList(List<RecordMod> recordList) {
    return Action(VipOpenAction.updateRecordList, payload: recordList);
  }

  static Action showRecordDialog(List<RecordMod> recordList) {
    return Action(VipOpenAction.showRecordDialog, payload: recordList);
  }

  static Action getRecordList() {
    return Action(VipOpenAction.getRecordList);
  }

  static Action getVipList() {
    return Action(VipOpenAction.getVipList);
  }
}
