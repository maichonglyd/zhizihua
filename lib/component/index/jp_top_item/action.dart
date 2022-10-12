import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum JPTopItemAction { action }

class JPTopItemActionCreator {
  static Action onAction() {
    return const Action(JPTopItemAction.action);
  }
}
