import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'dart:io';

import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_accont_server_data.dart'
    as deal_account_server;

//TODO replace with your own action
enum DealSellEditAction {
  action,
  selectPic,
  addPic,
  deletePic,
  showDialog,
  gotoSelectGame,
  updateSelectGame,
  selectAccount,
  updateAccounts,
  updateSelectAccount,
  updateAccountServer,
  updateSellPrice,
  sell,
  echoDealDetails,
  onEditOK,
}

class DealSellEditActionCreator {
  static Action onAction() {
    return const Action(DealSellEditAction.action);
  }

  static Action selectPic() {
    return const Action(DealSellEditAction.selectPic);
  }

  static Action showDialog() {
    return const Action(DealSellEditAction.showDialog);
  }

  static Action addPic(File newFile) {
    return Action(DealSellEditAction.addPic, payload: newFile);
  }

  static Action deletePic(int index) {
    return Action(DealSellEditAction.deletePic, payload: index);
  }

  static Action gotoSelectGame() {
    return Action(DealSellEditAction.gotoSelectGame);
  }

  static Action updateSelectGame(PlayedGame playedGame) {
    return Action(DealSellEditAction.updateSelectGame, payload: playedGame);
  }

  static Action selectAccount() {
    return Action(DealSellEditAction.selectAccount);
  }

  static Action updateAccounts(List<Account> accounts) {
    return Action(DealSellEditAction.updateAccounts, payload: accounts);
  }

  static Action updateSelectAccount(Account account) {
    return Action(DealSellEditAction.updateSelectAccount, payload: account);
  }

  static Action updateAccountServer(deal_account_server.Data accountServer) {
    return Action(DealSellEditAction.updateAccountServer,
        payload: accountServer);
  }

  static Action sell() {
    return Action(DealSellEditAction.sell);
  }

  static Action updateSellPrice(String value) {
    return Action(DealSellEditAction.updateSellPrice, payload: value);
  }

  static Action echoDealDetails(DealGoods dealGoods) {
    return Action(DealSellEditAction.echoDealDetails, payload: dealGoods);
  }

  static Action onEditOK() {
    return Action(DealSellEditAction.onEditOK);
  }
}
