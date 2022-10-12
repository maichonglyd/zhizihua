import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum JPGameItemAction { action, gotoDetails }

class JPGameItemActionCreator {
  static Action onAction() {
    return const Action(JPGameItemAction.action);
  }

  static Action gotoDetails(int gameId) {
    return Action(JPGameItemAction.gotoDetails, payload: gameId);
  }
}
