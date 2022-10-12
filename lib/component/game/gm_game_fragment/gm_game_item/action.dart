import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GmGameItemAction { action, gotoGm }

class GmGameItemActionCreator {
  static Action onAction() {
    return const Action(GmGameItemAction.action);
  }

  static Action gotoGm() {
    return const Action(GmGameItemAction.gotoGm);
  }
}
