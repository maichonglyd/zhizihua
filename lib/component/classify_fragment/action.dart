import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum ClassifyFragmentAction {
  action,
  createController,
  updateNewGameData,
  switchTabIndex,
}

class ClassifyFragmentActionCreator {
  static Action onAction() {
    return const Action(ClassifyFragmentAction.action);
  }

  static Action createController(TabController tabController) {
    return Action(ClassifyFragmentAction.createController,
        payload: tabController);
  }

  static Action updateNewGameData(int type, List<Game> list) {
    return Action(ClassifyFragmentAction.updateNewGameData,
        payload: {"type": type, "list": list});
  }

  static Action switchTabIndex(int index) {
    return Action(ClassifyFragmentAction.switchTabIndex,
        payload: {"index": index});
  }
}
