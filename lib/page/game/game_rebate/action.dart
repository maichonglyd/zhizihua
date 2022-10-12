import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';

//TODO replace with your own action
enum GameRebateAction {
  action,
  getData,
  updateData,
  applyRebate,
}

class GameRebateActionCreator {
  static Action onAction() {
    return const Action(GameRebateAction.action);
  }

  static Action getData(int page) {
    return Action(GameRebateAction.getData, payload: page);
  }

  static Action updateData(List<New> list) {
    return Action(GameRebateAction.updateData, payload: list);
  }

  static Action applyRebate(num id) {
    return Action(GameRebateAction.applyRebate, payload: id);
  }
}
