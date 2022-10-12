import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/vip/vip_privilege/state.dart'
    as vip_fun_state;
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/user/task_home.dart';
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';

class MemberCenterState with GlobalBaseState<MemberCenterState> {
  List<Item> tabs;
  TaskHome taskHome;
  MemInfoData memInfoData;

  @override
  MemberCenterState clone() {
    return MemberCenterState()
      ..tabs = tabs
      ..memInfoData = memInfoData
      ..taskHome = taskHome;
  }
}

MemberCenterState initState(Map<String, dynamic> args) {
  return MemberCenterState()..tabs = List();
}

class VIPFuncConnector
    extends ConnOp<MemberCenterState, vip_fun_state.VIPPrivilegeState> {
  @override
  void set(MemberCenterState state, vip_fun_state.VIPPrivilegeState subState) {
    super.set(state, subState);
  }

  @override
  vip_fun_state.VIPPrivilegeState get(MemberCenterState state) {
    return vip_fun_state.initState();
  }
}
