import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum SingleGameListAction { action, getData, updateData, getGameListByGameName }

class SingleGameListActionCreator {
  static Action onAction(Game game) {
    return Action(SingleGameListAction.action, payload: game);
  }

  static Action getGameListByGameName(String gameName) {
    return Action(SingleGameListAction.getGameListByGameName,
        payload: gameName);
  }

  static Action getData(int page) {
    return Action(SingleGameListAction.getData, payload: page);
  }

  static Action updateData(List<Game> games) {
    return Action(SingleGameListAction.updateData, payload: games);
  }
}
