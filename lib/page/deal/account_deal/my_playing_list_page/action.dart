import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

//TODO replace with your own action
enum PlayingListAction {
  action,
  gotoShopList,
  updatePlayedGames,
}

class PlayingListActionCreator {
  static Action onAction() {
    return const Action(PlayingListAction.action);
  }

  static Action gotoShopList(PlayedGame playedGame) {
    return Action(PlayingListAction.gotoShopList, payload: playedGame);
  }

  static Action playedGames(List<PlayedGame> playedGames) {
    return Action(PlayingListAction.updatePlayedGames, payload: playedGames);
  }
}
