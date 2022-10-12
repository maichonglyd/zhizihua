import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameRewardBannerAction { action }

class GameRewardBannerActionCreator {
  static Action onAction() {
    return const Action(GameRewardBannerAction.action);
  }
}
