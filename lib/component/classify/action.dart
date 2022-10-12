import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_mod.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum ClassifyAction {
  action,
  updateLeftTabs,
  onSelectedTabs,
  updateRightGames,
  gotoGameDetails,
  getData,
  getGameList,
  updateSelectTypeId,
  updateTypeCoverImage,
  updateGameId,
  jumpToClassifyTab,
}

class ClassifyActionCreator {
  static Action onAction() {
    return const Action(ClassifyAction.action);
  }

  static Action updateLeftTabs(List<GameClassifyType> tabs, int typeId) {
    return Action(ClassifyAction.updateLeftTabs,
        payload: {"tabs": tabs, "typeId": typeId});
  }

  static Action updateRightGames(List<Game> games) {
    return Action(ClassifyAction.updateRightGames, payload: games);
  }

  static Action onSelectedTabs(int index) {
    return Action(ClassifyAction.onSelectedTabs, payload: index);
  }

  static Action gotoGameDetails(int gameId) {
    return Action(ClassifyAction.gotoGameDetails, payload: gameId);
  }

  static Action getData() {
    return Action(ClassifyAction.getData);
  }

  static Action updateSelectTypeId(int typeId) {
    return Action(ClassifyAction.updateSelectTypeId, payload: typeId);
  }

  static Action getGameList(int page) {
    return Action(ClassifyAction.getGameList, payload: page);
  }

  static Action updateTypeCoverImage(String imageUrl) {
    return Action(ClassifyAction.updateTypeCoverImage, payload: imageUrl);
  }

  static Action updateGameId(int gameId) {
    return Action(ClassifyAction.updateGameId, payload: gameId);
  }

  static Action jumpToClassifyTab(int typeId) {
    return Action(ClassifyAction.jumpToClassifyTab, payload: typeId);
  }
}
