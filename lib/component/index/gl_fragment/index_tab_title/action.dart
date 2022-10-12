import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum IndexTabTitleAction {
  action,
  createController,
}

class IndexTabTitleActionCreator {
  static Action onAction() {
    return const Action(IndexTabTitleAction.action);
  }

  static Action createController(TabController tabController) {
    return Action(IndexTabTitleAction.createController, payload: tabController);
  }
}
