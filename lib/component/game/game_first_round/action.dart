import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameFirstRoundAction { action }

class GameFirstRoundActionCreator {
  static Action onAction() {
    return const Action(GameFirstRoundAction.action);
  }
}
