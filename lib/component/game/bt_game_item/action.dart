import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum BTGameItemAction { action, deleteGame, gotoGameDetails }

class BTGameItemActionCreator {
  static Action onAction() {
    return const Action(BTGameItemAction.action);
  }

  static Action gotoGameDetails(Game game) {
    return Action(BTGameItemAction.gotoGameDetails, payload: game);
  }

  static Action deleteGame() {
    return const Action(BTGameItemAction.deleteGame);
  }
}
