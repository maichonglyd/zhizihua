import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';

class PropDealFilterState implements Cloneable<PropDealFilterState> {
  PlayedGame playedGame;
  List<Service> servers;
  Service curServer;
  int sortType;
  GlobalKey anchorKey = GlobalKey();
  @override
  PropDealFilterState clone() {
    return PropDealFilterState()
      ..playedGame = playedGame
      ..servers = servers
      ..curServer = curServer
      ..sortType = sortType
      ..anchorKey = anchorKey;
  }
}

PropDealFilterState initState(Map<String, dynamic> args) {
  return PropDealFilterState()
    ..servers = List()
    ..sortType = 1;
}
