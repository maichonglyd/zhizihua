import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

enum GameCurrencyListAdapterAction { action, update }

class GameCurrencyListAdapterActionCreator {
  static Action onAction() {
    return const Action(GameCurrencyListAdapterAction.action);
  }

  static Action update(home_bean.Data homeData) {
    return Action(GameCurrencyListAdapterAction.update, payload: homeData);
  }
}
