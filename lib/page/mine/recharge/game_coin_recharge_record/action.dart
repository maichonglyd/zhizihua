import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/cps_recharge_record.dart';

//TODO replace with your own action
enum GameCoinRechargeRecordAction {
  action,
  switchHead,
  getRecords,
  updateRecords,
  pop,
  rechargeAgain
}

class GameCoinRechargeRecordActionCreator {
  static Action onAction() {
    return const Action(GameCoinRechargeRecordAction.action);
  }

  static Action pop() {
    return const Action(GameCoinRechargeRecordAction.pop);
  }

  static Action updateRecords(List<Record> records) {
    return Action(GameCoinRechargeRecordAction.updateRecords, payload: records);
  }

  static Action switchHead() {
    return const Action(GameCoinRechargeRecordAction.switchHead);
  }

  static Action getRecords(int page) {
    return Action(GameCoinRechargeRecordAction.getRecords, payload: page);
  }

  static Action rechargeAgain(Record record) {
    return Action(GameCoinRechargeRecordAction.rechargeAgain, payload: record);
  }
}
