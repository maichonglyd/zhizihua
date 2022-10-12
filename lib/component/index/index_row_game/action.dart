import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexRowGameAction { action, gotoGameDetails }

class IndexRowGameActionCreator {
  static Action onAction() {
    return const Action(IndexRowGameAction.action);
  }

  static Action gotoGameDetails(int gameId) {
    return Action(IndexRowGameAction.gotoGameDetails, payload: gameId);
  }
}
