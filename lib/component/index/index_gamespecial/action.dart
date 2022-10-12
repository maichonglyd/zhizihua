import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameSpecialAction { action, gotoGameDetails, gotoSpecialList }

class GameSpecialActionCreator {
  static Action onAction() {
    return const Action(GameSpecialAction.action);
  }

  static Action gotoGameDetails(Game game) {
    return Action(GameSpecialAction.gotoGameDetails, payload: game);
  }

  static Action gotoSpecialList() {
    return const Action(GameSpecialAction.gotoSpecialList);
  }
}
