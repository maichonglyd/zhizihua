import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';

//TODO replace with your own action
enum BtFragmentAction {
  action,
  createController,
  updateHomeData,
  switchData,
  getHomeData,
  createScrollController,
  getCardGameList,
  updateCardGame,
  getTopTabList,
  updateTopTabList,
}

class BtFragmentActionCreator {
  static Action onAction() {
    return const Action(BtFragmentAction.action);
  }

  static Action getHomeData() {
    return const Action(BtFragmentAction.getHomeData);
  }

  static Action onCreateController(TabController tabController) {
    return Action(BtFragmentAction.createController, payload: tabController);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(BtFragmentAction.updateHomeData, payload: homeData);
  }

  static Action switchData(int index) {
    return Action(BtFragmentAction.switchData, payload: index);
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(BtFragmentAction.createScrollController,
        payload: scrollControler);
  }

  static Action updateCardGame(int topicId, int cardPage, List<Game> gameList) {
    return Action(BtFragmentAction.updateCardGame,
        payload: {"topicId": topicId, "cardPage": cardPage, "gameList": gameList});
  }

  static Action getCardGameList(
      int topicId, int cardPage, List<Game> gameList) {
    return Action(BtFragmentAction.getCardGameList, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList,
    });
  }

  static Action getTopTabList() {
    return const Action(BtFragmentAction.getTopTabList);
  }

  static Action updateTopTabList(List<IndexTopTabBean> list) {
    return Action(BtFragmentAction.updateTopTabList, payload: list);
  }
}
