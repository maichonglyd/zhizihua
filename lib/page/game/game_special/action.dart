import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special_list.dart';

//TODO replace with your own action
enum GameSpecialPageAction {
  action,
  updateList,
  getSpecialListGame,
  updateTopicData,
}

class GameSpecialPageActionCreator {
  static Action onAction() {
    return const Action(GameSpecialPageAction.action);
  }

  static Action getSpecialListGame(int page) {
    return Action(GameSpecialPageAction.getSpecialListGame, payload: page);
  }

  static Action updateList(List<Game> games) {
    return Action(GameSpecialPageAction.updateList, payload: games);
  }

  static Action updateTopicData(TopicData data) {
    return Action(GameSpecialPageAction.updateTopicData, payload: data);
  }
}
