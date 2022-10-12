import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameSpecialHeadAction { action, gotoSpecialList, gotoGameDetails }

class GameSpecialHeadActionCreator {
  static Action onAction() {
    return const Action(GameSpecialHeadAction.action);
  }

  static Action gotoGameDetails(int gameId) {
    return Action(GameSpecialHeadAction.gotoGameDetails, payload: gameId);
  }

  static Action gotoSpecialList() {
    return const Action(GameSpecialHeadAction.gotoSpecialList);
  }
}
