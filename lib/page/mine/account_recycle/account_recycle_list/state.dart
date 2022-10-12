import 'dart:collection';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';

class AccountRecycleState implements Cloneable<AccountRecycleState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  String explain;
  List<RecycleGame> gameList;
  List<RecycleGame> recycleGames;
  @override
  AccountRecycleState clone() {
    return AccountRecycleState()
      ..explain = explain
      ..gameList = gameList
      ..recycleGames = recycleGames
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

AccountRecycleState initState(Map<String, dynamic> args) {
  return AccountRecycleState()
    ..explain = ""
    ..gameList = List()
    ..recycleGames = List();
}
