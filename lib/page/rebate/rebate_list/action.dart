import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_record.dart';

//TODO replace with your own action
enum RebateRecordListAction { action, getRecords, updateRecords }

class RebateRecordListActionCreator {
  static Action onAction() {
    return const Action(RebateRecordListAction.action);
  }

  static Action getRecords(int page) {
    return Action(RebateRecordListAction.getRecords, payload: page);
  }

  static Action updateRecords(List<RebateRecord> records) {
    return Action(RebateRecordListAction.updateRecords, payload: records);
  }
}
