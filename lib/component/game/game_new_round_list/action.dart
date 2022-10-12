import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameNewRoundListAction {
  action,
  getData,
  updateData,
}

class GameNewRoundListActionCreator {
  static Action onAction() {
    return const Action(GameNewRoundListAction.action);
  }

  static Action getData(int page) {
    return Action(GameNewRoundListAction.getData, payload: page);
  }

  static Action updateData(List<Game> list) {
    return Action(GameNewRoundListAction.updateData, payload: list);
  }
}
