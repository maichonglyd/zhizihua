import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameRewardMarqueeAction { action }

class GameRewardMarqueeActionCreator {
  static Action onAction() {
    return const Action(GameRewardMarqueeAction.action);
  }
}
