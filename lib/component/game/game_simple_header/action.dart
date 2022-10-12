import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameSimpleHeaderAction { action, gotoSpecialList, }

class GameSimpleHeaderActionCreator {
  static Action onAction() {
    return const Action(GameSimpleHeaderAction.action);
  }

  static Action gotoSpecialList() {
    return const Action(GameSimpleHeaderAction.gotoSpecialList);
  }
}
