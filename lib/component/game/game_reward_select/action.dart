import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameRewardSelectAction { action }

class GameRewardSelectActionCreator {
  static Action onAction() {
    return const Action(GameRewardSelectAction.action);
  }
}
