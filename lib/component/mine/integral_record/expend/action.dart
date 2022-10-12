import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/gold_record.dart' as gold_record;

//TODO replace with your own action
enum IntegralExpendAction {
  action,
  getGoldRecord,
  updateData,
}

class IntegralExpendActionCreator {
  static Action onAction() {
    return const Action(IntegralExpendAction.action);
  }

  static Action getGoldRecord(int page) {
    return Action(IntegralExpendAction.getGoldRecord, payload: page);
  }

  static Action updateData(int page, List<gold_record.DataList> data) {
    return Action(IntegralExpendAction.updateData, payload: data);
  }
}
