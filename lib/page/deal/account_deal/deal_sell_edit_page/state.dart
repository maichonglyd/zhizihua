import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/BlankToolBarTool.dart';
import 'package:flutter_huoshu_app/model/deal/deal_accont_server_data.dart'
    as deal_account_server;
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:flutter_huoshu_app/page/deal/deal_config.dart';

class DealSellEditState implements Cloneable<DealSellEditState> {
  int goodsId;
  dynamic feeRate; //	Number	交易费率（%）	5
  dynamic minFee; //	Number	最低手续费	5
  dynamic minPrice; //	Number	最低交易金额	6
  String obtainPtb; //	Number	交易获得平台币
  List<ImageUploadData> images = [];
  PlayedGame playedGame;
  List<Account> accounts;

  Account selectAccounts;
  deal_account_server.Data accountServer;

  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  DealSellEditState clone() {
    return DealSellEditState()
      ..goodsId = goodsId
      ..feeRate = feeRate
      ..minFee = minFee
      ..minPrice = minPrice
      ..obtainPtb = obtainPtb
      ..images = images
      ..playedGame = playedGame
      ..accounts = accounts
      ..selectAccounts = selectAccounts
      ..accountServer = accountServer
      ..contentController = contentController
      ..titleController = titleController
      ..priceController = priceController
      ..blankToolBarModel = blankToolBarModel;
  }
}

DealSellEditState initState(Map<String, dynamic> args) {
  DealSellEditState state = DealSellEditState()
    ..images = []
    ..accounts = List();
  state.minPrice = DealConfig.getValue(DealConfig.SP_KEY_MIN_PRICE, 0);
  state.minFee = DealConfig.getValue(DealConfig.SP_KEY_MIN_FEE, 0);
  state.feeRate = DealConfig.getValue(DealConfig.SP_KEY_FEE_RATE, 0);
  if (args != null && args.containsKey('goodsId')) {
    state.goodsId = args['goodsId'];
  }
  return state;
}
