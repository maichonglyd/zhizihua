import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/ptb_recharge_record.dart';

//TODO replace with your own action
enum PtzIncomeAction { action, getData, updateData }

class PtzIncomeActionCreator {
  static Action onAction() {
    return const Action(PtzIncomeAction.action);
  }

  static Action updateData(List<Recharge> records) {
    return Action(PtzIncomeAction.updateData, payload: records);
  }

  static Action getData(int page) {
    return Action(PtzIncomeAction.getData, payload: page);
  }
}
