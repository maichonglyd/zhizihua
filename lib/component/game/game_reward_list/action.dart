import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameRewardListAction { action }

class GameRewardListActionCreator {
  static Action onAction() {
    return const Action(GameRewardListAction.action);
  }
}
