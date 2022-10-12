import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AccountRecycleCommitAction { action, commit, close }

class AccountRecycleCommitActionCreator {
  static Action onAction() {
    return const Action(AccountRecycleCommitAction.action);
  }

  static Action commit(int mgMemId) {
    return Action(AccountRecycleCommitAction.commit, payload: mgMemId);
  }

  static Action close() {
    return Action(AccountRecycleCommitAction.close);
  }
}
