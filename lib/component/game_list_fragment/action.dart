import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameListAction {
  action,
  selectClassify,
  updateGameList,
  selectKfType,
  getData,
  updateType,
  updateTagId,
}

class GameListActionCreator {
  static Action onAction() {
    return const Action(GameListAction.action);
  }

  static Action getData(int page) {
    return Action(GameListAction.getData, payload: page);
  }

  static Action selectKfType(int type) {
    return Action(GameListAction.selectKfType, payload: type);
  }

  static Action selectClassify(int type, int tagId) {
    return Action(GameListAction.selectClassify,
        payload: {"type": type, "tagId": tagId});
  }

  static Action updateClassify(int type, int tagId) {
    return Action(GameListAction.updateTagId,
        payload: {"type": type, "tagId": tagId});
  }

  static Action updateType(int type) {
    return Action(GameListAction.updateType, payload: type);
  }

  static Action updateGameList(List<Game> games) {
    return Action(GameListAction.updateGameList, payload: games);
  }
}
