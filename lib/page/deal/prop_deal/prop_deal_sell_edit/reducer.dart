import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_role.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealSellEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealSellEditState>>{
      PropDealSellEditAction.action: _onAction,
      PropDealSellEditAction.addPic: _addPic,
      PropDealSellEditAction.deletePic: _deletePic,
      PropDealSellEditAction.updateGame: _updateGame,
      PropDealSellEditAction.updateServices: _updateServices,
      PropDealSellEditAction.updateCurServer: _updateCurServer,
      PropDealSellEditAction.updateRoles: _updateRoles,
      PropDealSellEditAction.updateCurRole: _updateCurRole,
      PropDealSellEditAction.updateSellPrice: _updateSellPrice,
      PropDealSellEditAction.echoDealDetails: _echoDealDetails,
    },
  );
}

PropDealSellEditState _onAction(PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  return newState;
}

PropDealSellEditState _updateSellPrice(
    PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();

  num sellPrice = num.parse(action.payload);

  num obtainPtb = (100 - state.feeRate) / 100 * sellPrice;

  if (sellPrice - obtainPtb < state.minFee) {
    obtainPtb = sellPrice - state.minFee;
  }
  if (obtainPtb < 0) {
    obtainPtb = 0;
  }
  newState.obtainPtb = obtainPtb.toStringAsFixed(2);

  return newState;
}

PropDealSellEditState _echoDealDetails(
    PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();

  Goods goods = action.payload as Goods;
  newState.playedGame = PlayedGame(
      gameId: goods.gameId,
      gameIcon: goods.gameIcon,
      gameName: goods.gameName,
      materialCnt: 0);
  newState.curRole = Role(roleId: goods.roleId, roleName: goods.roleName);
  newState.curServer =
      Service(serverId: goods.serverId, serverName: goods.serverName);
  newState.images = goods.image.map((url) {
    return new ImageUploadData(url: url);
  }).toList();
  return newState;
}

PropDealSellEditState _updateCurRole(
    PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  newState.curRole = action.payload;
  return newState;
}

PropDealSellEditState _updateRoles(PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  newState.roles = action.payload;
  return newState;
}

PropDealSellEditState _updateServices(
    PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  newState.services = action.payload;
  return newState;
}

PropDealSellEditState _updateCurServer(
    PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  newState.curServer = action.payload;
  return newState;
}

PropDealSellEditState _updateGame(PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  newState.playedGame = action.payload;
  return newState;
}

PropDealSellEditState _addPic(PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  newState.images.add(ImageUploadData.withFile(file: action.payload));
  return newState;
}

PropDealSellEditState _deletePic(PropDealSellEditState state, Action action) {
  final PropDealSellEditState newState = state.clone();
  newState.images.removeAt(action.payload);
  return newState;
}
