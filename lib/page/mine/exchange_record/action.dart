import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/exchange_record_list_data.dart';

//TODO replace with your own action
enum ExchangeRecordAction { action, getRecordData, updateData, gotoDetails }

class ExchangeRecordActionCreator {
  static Action onAction() {
    return const Action(ExchangeRecordAction.action);
  }

  static Action getRecordData(int page) {
    return Action(ExchangeRecordAction.getRecordData, payload: page);
  }

  static Action updateData(List<ExchangeBean> list) {
    return Action(ExchangeRecordAction.updateData, payload: list);
  }

  static Action gotoDetails(ExchangeBean exchangeBean) {
    return Action(ExchangeRecordAction.gotoDetails, payload: exchangeBean);
  }
}
