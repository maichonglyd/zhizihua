import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GMGameFragmentAction { action, getGmGameData, updateGmGameList }

class GMGameFragmentActionCreator {
  static Action onAction() {
    return const Action(GMGameFragmentAction.action);
  }

  static Action getGmGameData(int page) {
    return Action(GMGameFragmentAction.getGmGameData, payload: page);
  }

  static Action updateGmGameList(List<Game> gameList) {
    return Action(GMGameFragmentAction.updateGmGameList, payload: gameList);
  }
}
