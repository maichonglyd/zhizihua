import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

//TODO replace with your own action
enum OpenVipAction {
  action,
  selectCard,
  selectPayType,
  updatePayType,
  ptzPay,
  updatePayInfoData,
  gotoPaySuccess,
  gotoOpenRecordList,
  updateVipList,
  updateVipId,
  gotoPay,
  selectVipType,
}

class OpenVipActionCreator {
  static Action onAction() {
    return const Action(OpenVipAction.action);
  }

  static Action updateVipList(
      List<VIPMod> vipMods, List<PayWayMod> payWayMods) {
    return Action(OpenVipAction.updateVipList,
        payload: {"VIPModList": vipMods, "PayWayModList": payWayMods});
  }

  static Action updateVipId(int id) {
    return Action(OpenVipAction.updateVipId, payload: id);
  }

  static Action updatePayType(String payType) {
    return Action(OpenVipAction.updatePayType, payload: payType);
  }

  static Action gotoPay() {
    return Action(OpenVipAction.gotoPay);
  }

  static Action gotoPaySuccess() {
    return Action(OpenVipAction.gotoPaySuccess);
  }

  static Action gotoOpenRecordList() {
    return Action(OpenVipAction.gotoOpenRecordList);
  }

  static Action updatePayInfoData(VIPPayInfoData vipPayInfoData) {
    return Action(OpenVipAction.updatePayInfoData, payload: vipPayInfoData);
  }

  static Action selectVipType(int i) {
    return Action(OpenVipAction.selectVipType, payload: i);
  }

  static Action selectPayType(int i) {
    return Action(OpenVipAction.selectPayType, payload: i);
  }

  static Action ptzPay() {
    return Action(
      OpenVipAction.ptzPay,
    );
  }
}
