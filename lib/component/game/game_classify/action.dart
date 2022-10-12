import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/model/game/game_type.dart' as game_type;

//TODO replace with your own action
enum GameClassifyAction {
  action,
  selectIndex,
  selectTypeIndex,
  updateIndex,
  updateTypeIndex,
  getGameType,
  updateGameType
}

class GameClassifyActionCreator {
  static Action onAction() {
    return const Action(GameClassifyAction.action);
  }

  static Action getGameType() {
    return const Action(GameClassifyAction.getGameType);
  }

  static Action updateGameType(game_type.Data data) {
    return Action(GameClassifyAction.updateGameType, payload: data);
  }

  static Action selectTypeIndex(int index) {
    return Action(GameClassifyAction.selectTypeIndex, payload: index);
  }

  static Action selectIndex(int index) {
    return Action(GameClassifyAction.selectIndex, payload: index);
  }

  static Action updateIndex(int index) {
    return Action(GameClassifyAction.updateIndex, payload: index);
  }

  static Action updateTypeIndex(int index) {
    return Action(GameClassifyAction.updateTypeIndex, payload: index);
  }
}
