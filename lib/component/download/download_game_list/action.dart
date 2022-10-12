import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum DownLoadGameListAction { action, updateGameList, onGetGameList }

class DownLoadGameListActionCreator {
  static Action onAction() {
    return const Action(DownLoadGameListAction.action);
  }

  static Action onGetGameList() {
    return const Action(DownLoadGameListAction.onGetGameList);
  }

  static Action updateGameList(List<Game> games) {
    return Action(DownLoadGameListAction.updateGameList, payload: games);
  }
}
