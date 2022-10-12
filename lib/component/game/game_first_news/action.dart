import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameFirstNewsAction { action }

class GameFirstNewsActionCreator {
  static Action onAction() {
    return const Action(GameFirstNewsAction.action);
  }
}
