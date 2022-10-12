import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_detail_model.dart';

//TODO replace with your own action
enum TurnGameDetailAction {
  action,
  getData,
  updateData,
  getStopGame,
  updateBottomButton,
}

class TurnGameDetailActionCreator {
  static Action onAction() {
    return const Action(TurnGameDetailAction.action);
  }

  static Action getData() {
    return const Action(TurnGameDetailAction.getData);
  }

  static Action updateData(TurnGameDetailModel model) {
    return Action(TurnGameDetailAction.updateData, payload: model);
  }

  static Action getStopGame() {
    return const Action(TurnGameDetailAction.getStopGame);
  }

  static Action updateBottomButton(bool isHas) {
    return Action(TurnGameDetailAction.updateBottomButton, payload: isHas);
  }
}
