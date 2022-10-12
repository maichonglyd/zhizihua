import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameQualitySelectAction { action }

class GameQualitySelectActionCreator {
  static Action onAction() {
    return const Action(GameQualitySelectAction.action);
  }
}
