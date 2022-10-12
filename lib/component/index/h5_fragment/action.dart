import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

//TODO replace with your own action
enum H5FragmentAction {
  action,
  createController,
  updateHomeData,
  getIndexData,
  switchData,
  createScrollController,
  getCardGameList,
  updateCardGame,
}

class H5FragmentActionCreator {
  static Action onAction() {
    return const Action(H5FragmentAction.action);
  }

  static Action getIndexData() {
    return const Action(H5FragmentAction.getIndexData);
  }

  static Action onCreateController(TabController tabController) {
    return Action(H5FragmentAction.createController, payload: tabController);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(H5FragmentAction.updateHomeData, payload: homeData);
  }

  static Action switchData(int index) {
    return Action(H5FragmentAction.switchData, payload: index);
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(H5FragmentAction.createScrollController,
        payload: scrollControler);
  }

  static Action updateCardGame(int topicId, int cardPage, List<Game> gameList) {
    return Action(H5FragmentAction.updateCardGame,
        payload: {"topicId": topicId, "cardPage": cardPage, "gameList": gameList});
  }

  static Action getCardGameList(
      int topicId, int cardPage, List<Game> gameList) {
    return Action(H5FragmentAction.getCardGameList, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList,
    });
  }
}
