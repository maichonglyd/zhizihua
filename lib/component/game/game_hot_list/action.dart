import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameHotListAction { action }

class GameHotListActionCreator {
  static Action onAction() {
    return const Action(GameHotListAction.action);
  }
}
