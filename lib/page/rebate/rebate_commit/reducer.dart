import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_roles.dart';

import 'action.dart';
import 'state.dart';

Reducer<RebateCommitState> buildReducer() {
  return asReducer(
    <Object, Reducer<RebateCommitState>>{
      RebateCommitAction.action: _onAction,
      RebateCommitAction.selectServer: _selectServer,
      RebateCommitAction.updateDate: _updateDate,
      RebateCommitAction.updateService: _updateService,
      RebateCommitAction.selectRole: _selectRole,
      RebateCommitAction.updateRealAmount: _updateRealAmount,
    },
  );
}

RebateCommitState _updateRealAmount(RebateCommitState state, Action action) {
  final RebateCommitState newState = state.clone();
  newState.realAmount = action.payload;
  return newState;
}

RebateCommitState _selectRole(RebateCommitState state, Action action) {
  final RebateCommitState newState = state.clone();
  String roleName = action.payload;
  for (RoleList roleList in state.curServer.roleList) {
    if (roleList.roleName == roleName) {
      newState.curRole = roleList;
      break;
    }
  }
  state.roleController.text = newState.curRole.roleId;
  return newState;
}

RebateCommitState _onAction(RebateCommitState state, Action action) {
  final RebateCommitState newState = state.clone();
  return newState;
}

RebateCommitState _selectServer(RebateCommitState state, Action action) {
  final RebateCommitState newState = state.clone();
  String serverName = action.payload;
  for (Server server in state.service) {
    if (server.serverName == serverName) {
      newState.curServer = server;
      break;
    }
  }
  return newState;
}

RebateCommitState _updateService(RebateCommitState state, Action action) {
  final RebateCommitState newState = state.clone();
  newState.service = action.payload;
  return newState;
}

RebateCommitState _updateDate(RebateCommitState state, Action action) {
  final RebateCommitState newState = state.clone();
  newState.time = action.payload;
  return newState;
}
