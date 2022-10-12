import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

//TODO replace with your own action
enum DealBuyGameListAction { action, update, selectGame }

class DealBuyGameListActionCreator {
  static Action onAction() {
    return const Action(DealBuyGameListAction.action);
  }

  static Action update(List<PlayedGame> playedGames) {
    return Action(DealBuyGameListAction.update, payload: playedGames);
  }

  static Action selectGame(PlayedGame playedGame) {
    return Action(DealBuyGameListAction.selectGame, payload: playedGame);
  }
}
