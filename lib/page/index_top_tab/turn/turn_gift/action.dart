import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_gift_model.dart';

//TODO replace with your own action
enum TurnGiftAction {
  action,
  getData,
  updateData,
}

class TurnGiftActionCreator {
  static Action onAction() {
    return const Action(TurnGiftAction.action);
  }

  static Action getData(int page) {
    return Action(TurnGiftAction.getData, payload: page);
  }

static Action updateData(List<TurnGiftBean> list) {
  return Action(TurnGiftAction.updateData, payload: list);
}
}
