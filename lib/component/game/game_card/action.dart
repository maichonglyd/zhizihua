import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameCardAction { action, getCardGameList, }

class GameCardActionCreator {
  static Action onAction() {
    return const Action(GameCardAction.action);
  }

  static Action getCardGameList() {
    return const Action(GameCardAction.getCardGameList);
  }
}
