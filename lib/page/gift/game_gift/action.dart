import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameGiftAction { action }

class GameGiftActionCreator {
  static Action onAction() {
    return const Action(GameGiftAction.action);
  }
}
