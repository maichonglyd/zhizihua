import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameStrategyMoneyAction { action, clickButton, }

class GameStrategyMoneyActionCreator {
  static Action onAction() {
    return const Action(GameStrategyMoneyAction.action);
  }

  static Action clickButton(int type) {
    return Action(GameStrategyMoneyAction.clickButton, payload: type);
  }
}
