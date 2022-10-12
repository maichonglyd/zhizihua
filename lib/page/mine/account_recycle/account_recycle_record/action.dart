import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/recycle_explain.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';

//TODO replace with your own action
enum AccountRecycleRecordAction {
  action,
  getOrders,
  update,
  payback,
  pay,
  getExplain,
  updateExplain,
}

class AccountRecycleRecordActionCreator {
  static Action onAction() {
    return const Action(AccountRecycleRecordAction.action);
  }

  static Action getOrders(int page) {
    return Action(AccountRecycleRecordAction.getOrders, payload: page);
  }

  static Action pay(String orderId, String payWay) {
    return Action(AccountRecycleRecordAction.action,
        payload: {"orderId": orderId, "payWay": payWay});
  }

  static Action payback(int id) {
    return Action(AccountRecycleRecordAction.payback, payload: id);
  }

  static Action update(RecycleList recycleList) {
    return Action(AccountRecycleRecordAction.update, payload: recycleList);
  }

  static Action updateExplain(RecycleExplain explain) {
    return Action(AccountRecycleRecordAction.updateExplain, payload: explain);
  }

  static Action getExplain() {
    return const Action(AccountRecycleRecordAction.getExplain);
  }
}
