import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum IntegralRecordAction { action, createController }

class IntegralRecordActionCreator {
  static Action onAction() {
    return const Action(IntegralRecordAction.action);
  }

  static Action onCreateController(TabController tabController) {
    return Action(IntegralRecordAction.createController,
        payload: tabController);
  }
}
