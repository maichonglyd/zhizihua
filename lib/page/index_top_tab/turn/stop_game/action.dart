import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_stop_model.dart';

//TODO replace with your own action
enum StopGameAction {
  action,
  showApplyDialog,
  getData,
  updateData,
  submitApplication,
}

class StopGameActionCreator {
  static Action onAction() {
    return const Action(StopGameAction.action);
  }

  static Action showApplyDialog(TurnGameStopBean bean) {
    return Action(StopGameAction.showApplyDialog, payload: bean);
  }

  static Action getData(int page) {
    return Action(StopGameAction.getData, payload: page);
  }

  static Action updateData(List<TurnGameStopBean> list) {
    return Action(StopGameAction.updateData, payload: list);
  }

  static Action submitApplication(num roleId, TurnGameStopBean fromGame) {
    return Action(StopGameAction.submitApplication,
        payload: {'roleId': roleId, 'fromGame': fromGame});
  }
}
