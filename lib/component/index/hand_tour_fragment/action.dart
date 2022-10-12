import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

//TODO replace with your own action
enum HtFragmentAction {
  action,
  createController,
  updateHomeData,
  switchData,
  getHomeData,
  showPushDialog,
  createScrollController
}

class HtFragmentActionCreator {
  static Action onAction() {
    return const Action(HtFragmentAction.action);
  }

  static Action getHomeData() {
    return const Action(HtFragmentAction.getHomeData);
  }

  static Action onCreateController(TabController tabController) {
    return Action(HtFragmentAction.createController, payload: tabController);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(HtFragmentAction.updateHomeData, payload: homeData);
  }

  static Action switchData(int index) {
    return Action(HtFragmentAction.switchData, payload: index);
  }

  static Action showPushDialog() {
    return Action(
      HtFragmentAction.showPushDialog,
    );
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(HtFragmentAction.createScrollController,
        payload: scrollControler);
  }
}
