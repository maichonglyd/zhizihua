import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum DealFragmentAction {
  action,
  crateTabController,
  gotoDealNotice,
  gotoSearch,
  switchIndex,
}

class DealFragmentActionCreator {
  static Action onAction() {
    return const Action(DealFragmentAction.action);
  }

  static Action switchIndex(int index) {
    return Action(DealFragmentAction.switchIndex, payload: index);
  }

  static Action crateTabController(TabController tabController) {
    return Action(DealFragmentAction.crateTabController,
        payload: tabController);
  }

  static Action gotoDealNotice() {
    return const Action(DealFragmentAction.gotoDealNotice);
  }

  static Action gotoSearch(bool isAccount) {
    return  Action(DealFragmentAction.gotoSearch,payload: isAccount);
  }
}
