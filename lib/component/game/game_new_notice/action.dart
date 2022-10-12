import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameNewNoticeAction {
  action,
  gameSubscribe,
  gotoGameDetail,
}

class GameNewNoticeActionCreator {
  static Action onAction() {
    return const Action(GameNewNoticeAction.action);
  }

  static Action gameSubscribe(num gameId) {
    return Action(GameNewNoticeAction.gameSubscribe, payload: gameId);
  }

  static Action gotoGameDetail(num gameId) {
    return Action(GameNewNoticeAction.gotoGameDetail, payload: gameId);
  }
}
