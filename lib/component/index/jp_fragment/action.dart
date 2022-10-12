import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum JpFragmentAction { action, update, getHomeByJp }

class JpFragmentActionCreator {
  static Action onAction() {
    return const Action(JpFragmentAction.action);
  }

  static Action getHomeByJp(int page) {
    return Action(JpFragmentAction.getHomeByJp, payload: page);
  }

  static Action update(List<Game> games) {
    return Action(JpFragmentAction.update, payload: games);
  }
}
