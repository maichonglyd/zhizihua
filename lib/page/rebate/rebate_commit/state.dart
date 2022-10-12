import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/BlankToolBarTool.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_list.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_roles.dart';

class RebateCommitState implements Cloneable<RebateCommitState> {
  RebateGame rebateGame;
  TextEditingController contentController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  String time = getText(name: 'textSelectTime');
  List<Server> service;
  Server curServer;
  RoleList curRole;
  double realAmount;

  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  RebateCommitState clone() {
    return RebateCommitState()
      ..rebateGame = rebateGame
      ..time = time
      ..contentController = contentController
      ..mobileController = mobileController
      ..roleController = roleController
      ..service = service
      ..curServer = curServer
      ..curRole = curRole
      ..realAmount = realAmount
      ..blankToolBarModel = blankToolBarModel;
  }
}

RebateCommitState initState(RebateGame rebateGame) {
  return RebateCommitState()
    ..rebateGame = rebateGame
    ..service = List()
    ..realAmount = 0;
}
