import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum DownloadGameItemAction { action, deleteGame, gotoGameDetails }

class DownloadGameItemActionCreator {
  static Action onAction() {
    return const Action(DownloadGameItemAction.action);
  }

  static Action gotoGameDetails(Game game) {
    return Action(DownloadGameItemAction.gotoGameDetails, payload: game);
  }

  static Action deleteGame() {
    return const Action(DownloadGameItemAction.deleteGame);
  }
}
