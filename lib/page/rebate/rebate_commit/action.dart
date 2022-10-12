import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_roles.dart';

//TODO replace with your own action
enum RebateCommitAction {
  action,
  showServiceDialog,
  showRoleDialog,
  selectDate,
  updateDate,
  updateService,
  selectServer,
  selectRole,
  updateRealAmount,
  commit
}

class RebateCommitActionCreator {
  static Action onAction() {
    return const Action(RebateCommitAction.action);
  }

  static Action showRoleDialog() {
    return const Action(RebateCommitAction.showRoleDialog);
  }

  static Action selectDate(String time) {
    return Action(RebateCommitAction.selectDate, payload: time);
  }

  static Action updateDate(String time) {
    return Action(RebateCommitAction.updateDate, payload: time);
  }

  static Action updateService(List<Server> service) {
    return Action(RebateCommitAction.updateService, payload: service);
  }

  static Action selectServer(String serviceName) {
    return Action(RebateCommitAction.selectServer, payload: serviceName);
  }

  static Action selectRole(String roleName) {
    return Action(RebateCommitAction.selectRole, payload: roleName);
  }

  static Action updateRealAmount(double realAmount) {
    return Action(RebateCommitAction.updateRealAmount, payload: realAmount);
  }

  static Action commit() {
    return Action(RebateCommitAction.commit);
  }
}
