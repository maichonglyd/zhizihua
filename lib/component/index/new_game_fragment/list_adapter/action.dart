import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NewGameAction { action }

class NewGameActionCreator {
  static Action onAction() {
    return const Action(NewGameAction.action);
  }
}
