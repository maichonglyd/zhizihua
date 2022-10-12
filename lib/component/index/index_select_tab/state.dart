import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class IndexSelectTabState implements Cloneable<IndexSelectTabState> {
  TabController tabController;

  //标题栏
  List<String> tabs;

  @override
  IndexSelectTabState clone() {
    return IndexSelectTabState()
      ..tabController = tabController
      ..tabs = tabs;
  }
}

IndexSelectTabState initState(List<String> tabs) {
  return IndexSelectTabState()..tabs = tabs;
}
