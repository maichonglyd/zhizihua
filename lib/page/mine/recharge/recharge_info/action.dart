import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RechargeInfoAction { action, gotoRechargeInfo }

class RechargeInfoActionCreator {
  static Action onAction() {
    return const Action(RechargeInfoAction.action);
  }

  static Action gotoRechargeInfo() {
    return const Action(RechargeInfoAction.gotoRechargeInfo);
  }
}
