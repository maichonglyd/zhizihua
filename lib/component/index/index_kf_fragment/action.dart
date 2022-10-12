import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum KfFragmentAction {
  action,
  createController,
  switchIndex,
  updateIndex,
}

class KfFragmentActionCreator {
  static Action onAction() {
    return const Action(KfFragmentAction.action);
  }

  static Action createController(TabController tabController) {
    return Action(KfFragmentAction.createController, payload: tabController);
  }

  static Action switchIndex(int index) {
    return Action(KfFragmentAction.switchIndex, payload: index);
  }

  static Action updateIndex(int index) {
    return Action(KfFragmentAction.updateIndex, payload: index);
  }
}
