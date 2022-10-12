import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/BlankToolBarTool.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_role.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:flutter_huoshu_app/page/deal/deal_config.dart';

class PropDealSellEditState implements Cloneable<PropDealSellEditState> {
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  List<ImageUploadData> images = [];

  PlayedGame playedGame;

  List<Service> services;
  Service curServer;
  List<Role> roles;
  Role curRole;

  num minPrice;
  num minFee;
  num feeRate;
  String obtainPtb; //	Number	交易获得平台币
  int goodsId;

  @override
  PropDealSellEditState clone() {
    return PropDealSellEditState()
      ..priceController = priceController
      ..titleController = titleController
      ..contentController = contentController
      ..blankToolBarModel = blankToolBarModel
      ..playedGame = playedGame
      ..goodsId = goodsId
      ..minPrice = minPrice
      ..images = images
      ..services = services
      ..curServer = curServer
      ..roles = roles
      ..curRole = curRole
      ..minFee = minFee
      ..obtainPtb = obtainPtb
      ..feeRate = feeRate;
  }
}

PropDealSellEditState initState(Map<String, dynamic> args) {
  return PropDealSellEditState()
    ..services = List()
    ..goodsId = args != null ? args["goodsId"] : null
    ..minPrice = DealConfig.getValue(DealConfig.SP_KEY_PROP_MIN_PRICE, 0)
    ..minFee = DealConfig.getValue(DealConfig.SP_KEY_PROP_MIN_FEE, 0)
    ..feeRate = DealConfig.getValue(DealConfig.SP_KEY_PROP_FEE_RATE, 0);
  ;
}
