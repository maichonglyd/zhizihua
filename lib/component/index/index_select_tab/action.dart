import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum IndexSelectTabAction { action, createController, }

class IndexSelectTabActionCreator {
  static Action onAction() {
    return const Action(IndexSelectTabAction.action);
  }

  static Action createController(TabController tabController) {
    return Action(IndexSelectTabAction.createController,
        payload: tabController);
  }
}
