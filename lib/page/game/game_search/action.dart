import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/search_hot_list.dart';
import 'package:flutter_huoshu_app/repository/game_history_repository.dart';

//TODO replace with your own action
enum GameSearchAction {
  action,
  select,
  updateHistory,
  clear,
  updateGameList,
  gotoGameDetail,
  getHotSearch,
  updateHotGameList
}

class GameSearchActionCreator {
  static Action onAction() {
    return const Action(GameSearchAction.action);
  }

  static Action clear() {
    return const Action(GameSearchAction.clear);
  }

  static Action select() {
    return const Action(GameSearchAction.select);
  }

  static Action updateHistory(List<GameHistory> updateHistory) {
    return Action(GameSearchAction.updateHistory, payload: updateHistory);
  }

  static Action updateGameList(List<Game> games) {
    return Action(GameSearchAction.updateGameList, payload: games);
  }

  static Action gotoGameDetail(Game game) {
    return Action(GameSearchAction.gotoGameDetail, payload: game);
  }

  static Action getHotSearch() {
    return Action(
      GameSearchAction.getHotSearch,
    );
  }

  static Action updateHotGameList(List<DataBean> hotGames) {
    return Action(GameSearchAction.updateHotGameList, payload: hotGames);
  }
}
