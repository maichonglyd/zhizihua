import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';

//TODO replace with your own action
enum PropDealSelectGameAction { action, selectGame, getGames, updateGames }

class PropDealSelectGameActionCreator {
  static Action onAction() {
    return const Action(PropDealSelectGameAction.action);
  }

  static Action getGames(int page) {
    return Action(PropDealSelectGameAction.getGames, payload: page);
  }

  static Action updateGames(List<PlayedGame> games) {
    return Action(PropDealSelectGameAction.updateGames, payload: games);
  }
}
