import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameListAdapterAction { action }

class GameListAdapterActionCreator {
  static Action onAction() {
    return const Action(GameListAdapterAction.action);
  }
}
