import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum MustPlayDailyAction { action, gotoDetails, gotoSpecialList }

class MustPlayDailyActionCreator {
  static Action onAction() {
    return const Action(MustPlayDailyAction.action);
  }

  static Action gotoDetails(Game game) {
    return Action(MustPlayDailyAction.gotoDetails, payload: game);
  }

  static Action gotoSpecialList() {
    return const Action(MustPlayDailyAction.gotoSpecialList);
  }
}
