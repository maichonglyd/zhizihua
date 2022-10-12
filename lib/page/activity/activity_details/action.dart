import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/newsdetails_bean.dart';

//TODO replace with your own action
enum ActivityDetailsAction {
  action,
  getNewDetails,
  updateData,
  getGameListByGameName,
  updateGames,
  showDownDialog,
  gotoGameDetails
}

class ActivityDetailsActionCreator {
  static Action onAction() {
    return const Action(ActivityDetailsAction.action);
  }

  static Action getNewDetails() {
    return const Action(ActivityDetailsAction.getNewDetails);
  }

  static Action updateData(NewsDetailsData newsDetailsData) {
    return Action(ActivityDetailsAction.updateData, payload: newsDetailsData);
  }

  static Action getGameListByGameName(String gameName) {
    return Action(ActivityDetailsAction.getGameListByGameName,
        payload: gameName);
  }

  static Action updateGames(List<Game> games) {
    return Action(ActivityDetailsAction.updateGames, payload: games);
  }

  static Action showDownDialog() {
    return Action(
      ActivityDetailsAction.showDownDialog,
    );
  }

  static Action gotoGameDetails() {
    return Action(
      ActivityDetailsAction.gotoGameDetails,
    );
  }
}
