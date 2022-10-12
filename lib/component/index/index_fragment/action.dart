import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

enum IndexFragmentAction {
  changeTab,
  createController,
}

class IndexFragmentActionCreator {
  static Action changeTab(int index) {
    return Action(IndexFragmentAction.changeTab, payload: index);
  }

  static Action createController(TabController tabController) {
    return Action(IndexFragmentAction.createController, payload: tabController);
  }
}
