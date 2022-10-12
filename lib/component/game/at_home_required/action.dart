import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AtHomeRequiredAction { action, gotoSpecialList }

class AtHomeRequiredActionCreator {
  static Action onAction() {
    return const Action(AtHomeRequiredAction.action);
  }

  static Action gotoSpecialList() {
    return const Action(AtHomeRequiredAction.gotoSpecialList);
  }
}
