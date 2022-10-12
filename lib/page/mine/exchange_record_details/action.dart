import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/exchange_detail_data.dart';

//TODO replace with your own action
enum ExchangeRecordDetailsAction {
  action,
  getDetailsData,
  updateDetailData,
  copyNum
}

class ExchangeRecordDetailsActionCreator {
  static Action onAction() {
    return const Action(ExchangeRecordDetailsAction.action);
  }

  static Action getDetailsData() {
    return const Action(ExchangeRecordDetailsAction.getDetailsData);
  }

  static Action updateDetailData(ExchangeDetail exchangeDetail) {
    return Action(ExchangeRecordDetailsAction.updateDetailData,
        payload: exchangeDetail);
  }

  static Action copyNum() {
    return Action(ExchangeRecordDetailsAction.copyNum);
  }
}
