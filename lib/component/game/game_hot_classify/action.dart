import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameHotClassifyAction { action, gotoClassify, }

class GameHotClassifyActionCreator {
  static Action onAction() {
    return const Action(GameHotClassifyAction.action);
  }

  static Action gotoClassify(int typeId) {
    return Action(GameHotClassifyAction.gotoClassify, payload: typeId);
  }
}
