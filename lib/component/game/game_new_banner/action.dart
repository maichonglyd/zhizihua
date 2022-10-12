import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameNewBannerAction { action }

class GameNewBannerActionCreator {
  static Action onAction() {
    return const Action(GameNewBannerAction.action);
  }
}
