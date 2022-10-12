import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameNewNoticeAction {
  action,
  getData,
  updateData,
  gameSubscribe,
}

class GameNewNoticeActionCreator {
  static Action onAction() {
    return const Action(GameNewNoticeAction.action);
  }

  static Action getData(int page) {
    return Action(GameNewNoticeAction.getData, payload: page);
  }

  static Action updateData(List<Game> games) {
    return Action(GameNewNoticeAction.updateData, payload: games);
  }

  static Action gameSubscribe(num gameId) {
    return Action(GameNewNoticeAction.gameSubscribe, payload: gameId);
  }
}
