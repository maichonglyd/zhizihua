import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameReserveAction {
  action,
  getData,
  updateData,
  subscribe,
  gotoGame,
  cancel
}

class GameReserveActionCreator {
  static Action onAction() {
    return const Action(GameReserveAction.action);
  }

  static Action gotoGame(int gameId) {
    return Action(GameReserveAction.gotoGame, payload: gameId);
  }

  static Action subscribe(int gameId) {
    return Action(GameReserveAction.subscribe, payload: gameId);
  }

  static Action cancel(int gameId) {
    return Action(GameReserveAction.cancel, payload: gameId);
  }

  static Action getData(int page) {
    return Action(GameReserveAction.getData, payload: page);
  }

  static Action updateData(List<Game> games) {
    return Action(GameReserveAction.updateData, payload: games);
  }
}
