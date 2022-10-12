import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

//TODO replace with your own action
enum GmFragmentAction { action, createController, updateHomeData }

class GmFragmentActionCreator {
  static Action onAction() {
    return const Action(GmFragmentAction.action);
  }

  static Action createController(TabController tabController) {
    return Action(GmFragmentAction.createController, payload: tabController);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(GmFragmentAction.updateHomeData, payload: homeData);
  }
}
