import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

enum HtAdapterAction { action, update }

class HtAdapterActionCreator {
  static Action onAction() {
    return const Action(HtAdapterAction.action);
  }

  static Action update(home_bean.Data homeData) {
    return Action(HtAdapterAction.update, payload: homeData);
  }
}
