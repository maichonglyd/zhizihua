import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameRankAction { action }

class GameRankActionCreator {
  static Action onAction() {
    return const Action(GameRankAction.action);
  }
}
