import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameComingSoonAction { action }

class GameComingSoonActionCreator {
  static Action onAction() {
    return const Action(GameComingSoonAction.action);
  }
}
