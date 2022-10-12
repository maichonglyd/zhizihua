import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_huoshu_app/model/deal/deal_accont_server_data.dart'
    as deal_account_server;
import 'action.dart';
import 'state.dart';

Reducer<DealSellEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealSellEditState>>{
      DealSellEditAction.action: _onAction,
      DealSellEditAction.addPic: _addPic,
      DealSellEditAction.deletePic: _deletePic,
      DealSellEditAction.updateSelectGame: _updateSelectGame,
      DealSellEditAction.updateAccounts: _updateAccounts,
      DealSellEditAction.updateSelectAccount: _updateSelectAccount,
      DealSellEditAction.updateAccountServer: _updateAccountServer,
      DealSellEditAction.updateSellPrice: _updateSellPrice,
      DealSellEditAction.echoDealDetails: _echoDealDetails,
    },
  );
}

DealSellEditState _onAction(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();
  return newState;
}

DealSellEditState _addPic(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();
  newState.images.add(ImageUploadData.withFile(file: action.payload));
  return newState;
}

DealSellEditState _deletePic(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();
  newState.images.removeAt(action.payload);
  return newState;
}

DealSellEditState _updateSelectGame(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();
  newState.playedGame = action.payload;
  print("newState.playedGame:" + newState.playedGame.gameName);
  return newState;
}

DealSellEditState _updateAccounts(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();
  newState.accounts = action.payload;
  return newState;
}

DealSellEditState _updateSelectAccount(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();
  newState.selectAccounts = action.payload;
  return newState;
}

DealSellEditState _updateAccountServer(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();
  newState.accountServer = action.payload;
  return newState;
}

DealSellEditState _updateSellPrice(DealSellEditState state, Action action) {
  final DealSellEditState newState = state.clone();

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

DealSellEditState _echoDealDetails(DealSellEditState state, Action action) {
  DealSellEditState newState = state.clone();
  DealGoods dealGoods = action.payload;
  newState.images = dealGoods.image.map((url) {
    return new ImageUploadData(url: url);
  }).toList();
  newState.playedGame = new PlayedGame(
      gameId: dealGoods.gameId,
      gameIcon: dealGoods.gameIcon,
      gameName: dealGoods.gameName);
  newState.selectAccounts = new Account(
      memId: dealGoods.memId,
      mgMemId: dealGoods.mgMemId,
      nickname: dealGoods.roleName);
  newState.accountServer = new deal_account_server.Data(
      mgMemId: dealGoods.mgMemId,
      serverId: dealGoods.serverId,
      serverName: dealGoods.serverName,
      roleId: dealGoods.roleId,
      roleName: dealGoods.roleName);

//  newState.images=dealGoods.image;
  return newState;
}
