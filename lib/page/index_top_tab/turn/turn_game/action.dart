import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';

//TODO replace with your own action
enum TurnGameAction {
  action,
  getData,
  updateData,
}

class TurnGameActionCreator {
  static Action onAction() {
    return const Action(TurnGameAction.action);
  }

  static Action getData(int page) {
    return Action(TurnGameAction.getData, payload: page);
  }

  static Action updateData(List<TurnGameBean> list) {
    return Action(TurnGameAction.updateData, payload: list);
  }
}
