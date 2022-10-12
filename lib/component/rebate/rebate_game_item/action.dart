import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RebateGameItemAction {
  action,
  gotoRebateCommit,
}

class RebateGameItemActionCreator {
  static Action onAction() {
    return const Action(RebateGameItemAction.action);
  }

  static Action gotoRebateCommit() {
    return const Action(RebateGameItemAction.gotoRebateCommit);
  }
}
