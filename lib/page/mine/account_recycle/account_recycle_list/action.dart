import 'dart:collection';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';

//TODO replace with your own action
enum AccountRecycleAction {
  action,
  gotoRecord,
  gotoCommit,
  getExplain,
  getRecycleList,
  updateExplain,
  updateRecycleList,
  getRecycleListMore,
}

class AccountRecycleActionCreator {
  static Action onAction() {
    return const Action(AccountRecycleAction.action);
  }

  static Action updateExplain(String explain) {
    return Action(AccountRecycleAction.updateExplain, payload: explain);
  }

  static Action updateRecycleList(List<RecycleGame> recycleGames) {
    return Action(AccountRecycleAction.updateRecycleList,
        payload: recycleGames);
  }

  static Action getExplain() {
    return const Action(AccountRecycleAction.getExplain);
  }

  static Action getRecycleList(int page) {
    return Action(AccountRecycleAction.getRecycleList, payload: page);
  }

  static Action gotoCommit(RecycleMg item) {
    return Action(AccountRecycleAction.gotoCommit, payload: item);
  }

  static Action gotoRecord() {
    return const Action(AccountRecycleAction.gotoRecord);
  }

  static Action getRecycleListMore(int page) {
    return Action(AccountRecycleAction.getRecycleListMore, payload: page);
  }
}
