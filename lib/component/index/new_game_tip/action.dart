import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NewGameTipAction { action }

class NewGameTipActionCreator {
  static Action onAction() {
    return const Action(NewGameTipAction.action);
  }
}
