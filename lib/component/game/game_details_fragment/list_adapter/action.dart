import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameDetailsAction { action }

class GameDetailsActionCreator {
  static Action onAction() {
    return const Action(GameDetailsAction.action);
  }
}
