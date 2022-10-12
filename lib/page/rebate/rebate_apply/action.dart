import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_list.dart';

//TODO replace with your own action
enum RebateApplyAction {
  action,
  getData,
  gotoRebateCommit,
  gotoRebateRecord,
  update,
}

class RebateApplyActionCreator {
  static Action onAction() {
    return const Action(RebateApplyAction.action);
  }

  static Action getData(int page) {
    return Action(RebateApplyAction.getData, payload: page);
  }

  static Action gotoRebateCommit() {
    return const Action(RebateApplyAction.gotoRebateCommit);
  }

  static Action gotoRebateRecord() {
    return const Action(RebateApplyAction.gotoRebateRecord);
  }

  static Action update(List<RebateGame> rebateGames) {
    return Action(RebateApplyAction.update, payload: rebateGames);
  }
}
