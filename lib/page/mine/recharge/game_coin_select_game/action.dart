import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameCoinSelectGameAction {
  action,
  searchGame,
  updateGameList,
  selectGameChannel,
}

class GameCoinSelectGameActionCreator {
  static Action onAction() {
    return const Action(GameCoinSelectGameAction.action);
  }

  static Action updateGameList(List<Game> games) {
    return Action(GameCoinSelectGameAction.updateGameList, payload: games);
  }

  static Action selectGameChannel(Game game) {
    return Action(GameCoinSelectGameAction.selectGameChannel, payload: game);
  }

  static Action searchGame(int page) {
    return Action(GameCoinSelectGameAction.searchGame, payload: page);
  }
}
