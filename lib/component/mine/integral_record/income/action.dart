import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/gold_record.dart' as gold_record;

//TODO replace with your own action
enum IntegralIncomeAction {
  action,
  getGoldRecord,
  updateData,
}

class IntegralIncomeActionCreator {
  static Action onAction() {
    return const Action(IntegralIncomeAction.action);
  }

  static Action getGoldRecord(int page) {
    return Action(IntegralIncomeAction.getGoldRecord, payload: page);
  }

  static Action updateData(int page, List<gold_record.DataList> data) {
    return Action(IntegralIncomeAction.updateData, payload: data);
  }
}
