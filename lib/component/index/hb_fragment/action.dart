import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

//TODO replace with your own action
enum HbFragmentAction {
  action,
  createScrollController,
  isShowBackTop,
  updateHomeData,
  getIndexData,
  getCardGameList,
  updateCardGame,
  updateSwitchSelectIndex,
}

class HbFragmentActionCreator {
  static Action onAction() {
    return const Action(HbFragmentAction.action);
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(HbFragmentAction.createScrollController,
        payload: scrollControler);
  }

  static Action isShowBackTop(bool isShowBackTop) {
    return Action(HbFragmentAction.isShowBackTop, payload: isShowBackTop);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(HbFragmentAction.updateHomeData, payload: homeData);
  }

  static Action getIndexData() {
    return Action(HbFragmentAction.getIndexData,);
  }

  static Action updateCardGame(int topicId, int cardPage, List<Game> gameList) {
    return Action(HbFragmentAction.updateCardGame, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList
    });
  }

  static Action getCardGameList(
      int topicId, int cardPage, List<Game> gameList) {
    return Action(HbFragmentAction.getCardGameList, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList,
    });
  }

  static Action updateSwitchSelectIndex(int index) {
    return Action(HbFragmentAction.updateSwitchSelectIndex, payload: index);
  }
}
