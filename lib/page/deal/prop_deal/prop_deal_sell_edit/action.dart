import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_role.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';

//TODO replace with your own action
enum PropDealSellEditAction {
  action,
  selectPic,
  addPic,
  deletePic,
  showAgree,
  gotoSelectGame,
  updateGame,
  updateServices,
  getRoles,
  updateRoles,
  selectServer,
  updateCurServer,
  selectRole,
  updateCurRole,

  echoDealDetails,
  updateSellPrice,
  commit,
}

class PropDealSellEditActionCreator {
  static Action onAction() {
    return const Action(PropDealSellEditAction.action);
  }

  static Action updateSellPrice(String value) {
    return Action(PropDealSellEditAction.updateSellPrice, payload: value);
  }

  static Action commit() {
    return const Action(PropDealSellEditAction.commit);
  }

  static Action updateRoles(List<Role> roles) {
    return Action(PropDealSellEditAction.updateRoles, payload: roles);
  }

  static Action getRoles() {
    return const Action(PropDealSellEditAction.getRoles);
  }

  static Action selectServer(String serverName) {
    return Action(PropDealSellEditAction.selectServer, payload: serverName);
  }

  static Action updateCurServer(Service curServer) {
    return Action(PropDealSellEditAction.updateCurServer, payload: curServer);
  }

  static Action selectRole(String roleName) {
    return Action(PropDealSellEditAction.selectRole, payload: roleName);
  }

  static Action updateCurRole(Role curRole) {
    return Action(PropDealSellEditAction.updateCurRole, payload: curRole);
  }

  static Action updateServices(List<Service> services) {
    return Action(PropDealSellEditAction.updateServices, payload: services);
  }

  static Action updateGame(PlayedGame playedGame) {
    return Action(PropDealSellEditAction.updateGame, payload: playedGame);
  }

  static Action gotoSelectGame() {
    return const Action(PropDealSellEditAction.gotoSelectGame);
  }

  static Action showAgree() {
    return const Action(PropDealSellEditAction.showAgree);
  }

  static Action selectPic() {
    return const Action(PropDealSellEditAction.selectPic);
  }

  static Action addPic(File newFile) {
    return Action(PropDealSellEditAction.addPic, payload: newFile);
  }

  static Action deletePic(int index) {
    return Action(PropDealSellEditAction.deletePic, payload: index);
  }

  static Action echoDealDetails(Goods goods) {
    return Action(PropDealSellEditAction.echoDealDetails, payload: goods);
  }
}
