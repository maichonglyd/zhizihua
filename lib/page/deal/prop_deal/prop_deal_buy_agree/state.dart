import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';

class PropDealBuyAgreeState implements Cloneable<PropDealBuyAgreeState> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int goodsId;
  int gameId;
  String serverId;
  String serverName;
  String roleId;
  String roleName;
  String price;
  List<ImageUploadData> images;
  String title;
  String description;

  @override
  PropDealBuyAgreeState clone() {
    return PropDealBuyAgreeState()
      ..mobileController = mobileController
      ..passwordController = passwordController
      ..goodsId = goodsId
      ..gameId = gameId
      ..serverId = serverId
      ..serverName = serverName
      ..roleId = roleId
      ..roleName = roleName
      ..price = price
      ..images = images
      ..title = title
      ..description = description;
  }
}

PropDealBuyAgreeState initState(Map<String, dynamic> args) {
  return PropDealBuyAgreeState()
    ..goodsId = args["goodsId"]
    ..gameId = args["gameId"]
    ..serverId = args["serverId"]
    ..serverName = args["serverName"]
    ..roleId = args["roleId"]
    ..roleName = args["roleName"]
    ..price = args["price"]
    ..images = args["images"]
    ..title = args["title"]
    ..description = args["description"];
}
