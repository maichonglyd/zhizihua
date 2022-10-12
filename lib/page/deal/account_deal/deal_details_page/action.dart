import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';

//TODO replace with your own action
enum DealDetailsAction {
  action,
  updateDetails,
  showBuyAgreementDialog,
  buy,
  gotoGame,
  gotoGallery,
  updatePayInfoData
}

class DealDetailsActionCreator {
  static Action onAction() {
    return const Action(DealDetailsAction.action);
  }

  static Action updatePayInfoData(DealPayInfoData dealPayInfoData) {
    return Action(DealDetailsAction.updatePayInfoData,
        payload: dealPayInfoData);
  }

  static Action gotoGame() {
    return const Action(DealDetailsAction.gotoGame);
  }

  static Action updateDetails(DealGoods dealGoods) {
    return Action(DealDetailsAction.updateDetails, payload: dealGoods);
  }

  static Action showBuyAgreementDialog() {
    return Action(DealDetailsAction.showBuyAgreementDialog);
  }

  static Action gotoGallery(int index) {
    return Action(DealDetailsAction.gotoGallery, payload: index);
  }
}
