import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/user/cps_recharge_record.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';

class GameCoinRechargeState implements Cloneable<GameCoinRechargeState> {
  Game game;
  int gameId;
  int payType = 0;
  int amount = 0;
  int type = 0;
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController pswController = TextEditingController();

  //区服
  TextEditingController serverController = TextEditingController();
  TextEditingController roleNameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  List<ImageUploadData> images = [];
  Record record;
  num rate = 1;

  @override
  GameCoinRechargeState clone() {
    return GameCoinRechargeState()
      ..game = game
      ..gameId = gameId
      ..accountController = accountController
      ..amountController = amountController
      ..pswController = pswController
      ..serverController = serverController
      ..roleNameController = roleNameController
      ..remarkController = remarkController
      ..amount = amount
      ..images = images
      ..record = record
      ..rate = rate;
  }
}

GameCoinRechargeState initState(Map<String, dynamic> args) {
  return GameCoinRechargeState()
    ..images = []
    ..game = (args != null && args['game'] != null) ? args['game'] : null
    ..gameId =
        (args != null && args['game_id'] != null) ? args['game_id'] : null
    ..record = (args != null && args['record'] != null) ? args['record'] : null;
}
