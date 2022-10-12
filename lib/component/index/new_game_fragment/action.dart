import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

//TODO replace with your own action
enum NewGameFragmentAction {
  action,
  createScrollController,
  updateHomeData,
  getIndexData,
  getCardGameList,
  updateCardGame,
  updateSwitchSelectIndex,
}

class NewGameFragmentActionCreator {
  static Action onAction() {
    return const Action(NewGameFragmentAction.action);
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(NewGameFragmentAction.createScrollController,
        payload: scrollControler);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(NewGameFragmentAction.updateHomeData, payload: homeData);
  }

  static Action getIndexData() {
    return Action(
      NewGameFragmentAction.getIndexData,
    );
  }

  static Action updateCardGame(int topicId, int cardPage, List<Game> gameList) {
    return Action(NewGameFragmentAction.updateCardGame,
        payload: {"topicId": topicId, "cardPage": cardPage, "gameList": gameList});
  }

  static Action getCardGameList(
      int topicId, int cardPage, List<Game> gameList) {
    return Action(NewGameFragmentAction.getCardGameList, payload: {
      "topicId": topicId,
      "cardPage": cardPage,
      "gameList": gameList,
    });
  }

  static Action updateSwitchSelectIndex(int index) {
    return Action(NewGameFragmentAction.updateSwitchSelectIndex, payload: index);
  }
}
