import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';

//TODO replace with your own action
enum ZKFragmentAction {
  action,
  createController,
  getIndexData,
  updateHomeData,
  switchData,
  createScrollController,
  getCardGameList,
  updateCardGame,
  getTopTabList,
  updateTopTabList,
}

class ZkFragmentActionCreator {
  static Action onAction() {
    return const Action(ZKFragmentAction.action);
  }

  static Action getIndexData() {
    return const Action(ZKFragmentAction.getIndexData);
  }

  static Action onCreateController(TabController tabController) {
    return Action(ZKFragmentAction.createController, payload: tabController);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(ZKFragmentAction.updateHomeData, payload: homeData);
  }

  static Action switchData(int index) {
    return Action(ZKFragmentAction.switchData, payload: index);
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(ZKFragmentAction.createScrollController,
        payload: scrollControler);
  }

  static Action updateCardGame(int topicId, int cardPage, List<Game> gameList) {
    return Action(ZKFragmentAction.updateCardGame,
        payload: {"topicId": topicId, "cardPage": cardPage, "gameList": gameList});
  }

  static Action getCardGameList(
      int topicId, int cardPage, List<Game> gameList) {
    return Action(ZKFragmentAction.getCardGameList, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList,
    });
  }

  static Action getTopTabList() {
    return const Action(ZKFragmentAction.getTopTabList);
  }

  static Action updateTopTabList(List<IndexTopTabBean> list) {
    return Action(ZKFragmentAction.updateTopTabList, payload: list);
  }
}
