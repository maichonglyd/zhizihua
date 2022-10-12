import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

//TODO replace with your own action
enum PtzRechargeAction {
  action,
  selectPrice,
  updatePrice,
  selectPayType,
  updatePayType,
  ptzPay,
  updatePayInfoData,
  queryOrder,
  selectPayTypeList,
  updatePayWayList
}

class PtzRechargeActionCreator {
  static Action onAction() {
    return const Action(PtzRechargeAction.action);
  }

  static Action updatePayInfoData(DealPayInfoData dealPayInfoData) {
    return Action(PtzRechargeAction.updatePayInfoData,
        payload: dealPayInfoData);
  }

  static Action updatePayWayList(List<PayWayMod> payWayMods) {
    return Action(PtzRechargeAction.updatePayWayList,
        payload: {"PayWayModList": payWayMods});
  }

  static Action selectPrice(int i) {
    return Action(PtzRechargeAction.selectPrice, payload: i);
  }

  static Action updatePrice(int price) {
    return Action(PtzRechargeAction.updatePrice, payload: price);
  }

  static Action selectPayType(int i) {
    return Action(PtzRechargeAction.selectPayType, payload: i);
  }

  static Action updatePayType(int payType) {
    return Action(PtzRechargeAction.updatePayType, payload: payType);
  }

  static Action ptzPay() {
    return Action(
      PtzRechargeAction.ptzPay,
    );
  }

  static Action queryOrder() {
    return Action(
      PtzRechargeAction.queryOrder,
    );
  }

  static Action selectPayTypeList(int i) {
    return Action(PtzRechargeAction.selectPayTypeList, payload: i);
  }
}
