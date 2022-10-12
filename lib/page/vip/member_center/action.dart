import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/model/user/task_home.dart';
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';

//TODO replace with your own action
enum MemberCenterAction {
  action,
  updateTabs,
  showAlertDialog,
  getData,
  updateData,
  gotoFinish,
  showSign,
  gotoTaskCenter,
  gotoOpenVip,
  updateMemberData,
  getMemInfo
}

class MemberCenterActionCreator {
  static Action onAction() {
    return const Action(MemberCenterAction.action);
  }

  static Action getMemInfo() {
    return const Action(MemberCenterAction.getMemInfo);
  }

  static Action showSign() {
    return Action(MemberCenterAction.showSign);
  }

  static Action gotoOpenVip() {
    return Action(MemberCenterAction.gotoOpenVip);
  }

  static Action gotoTaskCenter() {
    return Action(MemberCenterAction.gotoTaskCenter);
  }

  static Action updateTabs(List<Item> tabs) {
    return Action(MemberCenterAction.updateTabs, payload: tabs);
  }

  static Action gotoFinish(int taskId) {
    return Action(MemberCenterAction.gotoFinish, payload: taskId);
  }

  static Action showAlertDialog(int type) {
    return Action(MemberCenterAction.showAlertDialog, payload: type);
  }

  static Action getData() {
    return const Action(MemberCenterAction.getData);
  }

  static Action updateData(TaskHome taskHome) {
    return Action(MemberCenterAction.updateData, payload: taskHome);
  }

  static Action updateMemberData(MemInfoData memInfo) {
    return Action(MemberCenterAction.updateMemberData, payload: memInfo);
  }
}
