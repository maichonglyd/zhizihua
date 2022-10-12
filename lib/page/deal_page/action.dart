import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum DealAction {
  action,
  crateTabController,
  gotoDealNotice,
  gotoSearch,
  switchIndex,
}

class DealActionCreator {
  static Action onAction() {
    return const Action(DealAction.action);
  }

  static Action switchIndex(int index) {
    return Action(DealAction.switchIndex,payload:index);
  }

  static Action crateTabController(TabController tabController) {
    return Action(DealAction.crateTabController,
        payload: tabController);
  }

  static Action gotoDealNotice() {
    return const Action(DealAction.gotoDealNotice);
  }

  static Action gotoSearch() {
    return const Action(DealAction.gotoSearch);
  }
}
