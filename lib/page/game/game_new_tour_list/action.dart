import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameNewTourListAction {
  action,
  updateData,
}

class GameNewTourListActionCreator {
  static Action onAction() {
    return const Action(GameNewTourListAction.action);
  }

  static Action updateData(int type, List<Game> list) {
    return Action(GameNewTourListAction.updateData, payload: {"type": type, "list": list});
  }
}
