import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';

//TODO replace with your own action
enum RmbFragmentAction {
  action,
  createScrollController,
  isShowBackTop,
  updateHomeData,
  getIndexData,
  getCardGameList,
  updateCardGame,
  updateSwitchSelectIndex,
  getTopTabList,
  updateTopTabList,
}

class RmbFragmentActionCreator {
  static Action onAction() {
    return const Action(RmbFragmentAction.action);
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(RmbFragmentAction.createScrollController,
        payload: scrollControler);
  }

  static Action isShowBackTop(bool isShowBackTop) {
    return Action(RmbFragmentAction.isShowBackTop, payload: isShowBackTop);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(RmbFragmentAction.updateHomeData, payload: homeData);
  }

  static Action getIndexData() {
    return Action(
      RmbFragmentAction.getIndexData,
    );
  }

  static Action updateCardGame(int topicId, int cardPage, List<Game> gameList) {
    return Action(RmbFragmentAction.updateCardGame, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList
    });
  }

  static Action getCardGameList(
      int topicId, int cardPage, List<Game> gameList) {
    return Action(RmbFragmentAction.getCardGameList, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList,
    });
  }

  static Action updateSwitchSelectIndex(int index) {
    return Action(RmbFragmentAction.updateSwitchSelectIndex, payload: index);
  }

  static Action getTopTabList() {
    return const Action(RmbFragmentAction.getTopTabList);
  }

  static Action updateTopTabList(List<IndexTopTabBean> list) {
    return Action(RmbFragmentAction.updateTopTabList, payload: list);
  }
}
