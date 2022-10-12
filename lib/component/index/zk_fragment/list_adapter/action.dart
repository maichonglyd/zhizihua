import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

enum BtAdapterAction { action, update }

class BtAdapterActionCreator {
  static Action onAction() {
    return const Action(BtAdapterAction.action);
  }

  static Action update(home_bean.Data homeData) {
    return Action(BtAdapterAction.update, payload: homeData);
  }
}
