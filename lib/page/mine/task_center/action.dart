import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/model/user/task_home.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

//TODO replace with your own action
enum TaskCenterAction {
  action,
  getData,
  updateData,
  updateUserInfo,
  updateTabs,
  gotoFinish,
  showSign,
  gotoIntegralShop,
  gotoInvite,
  gotoLottery
}

class TaskCenterActionCreator {
  static Action onAction() {
    return const Action(TaskCenterAction.action);
  }

  static Action getData() {
    return const Action(TaskCenterAction.getData);
  }

  static Action updateData(TaskHome taskHome) {
    return Action(TaskCenterAction.updateData, payload: taskHome);
  }

  static Action gotoLottery() {
    return Action(TaskCenterAction.gotoLottery);
  }

  static Action gotoInvite() {
    return const Action(TaskCenterAction.gotoInvite);
  }

  static Action updateTabs(List<Item> tabs) {
    return Action(TaskCenterAction.updateTabs, payload: tabs);
  }

  static Action gotoFinish(int taskId) {
    return Action(TaskCenterAction.gotoFinish, payload: taskId);
  }

  static Action showSign() {
    return Action(TaskCenterAction.showSign);
  }

  static Action updateUserInfo(UserInfo userInfo) {
    return Action(TaskCenterAction.updateUserInfo, payload: userInfo);
  }

  static Action gotoIntegralShop() {
    return Action(TaskCenterAction.gotoIntegralShop);
  }
}
