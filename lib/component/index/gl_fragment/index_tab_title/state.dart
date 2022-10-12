import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class IndexTabTitleState implements Cloneable<IndexTabTitleState> {
//  TabController tabController;
  int index = 0;
  @override
  IndexTabTitleState clone() {
    return IndexTabTitleState()
//      ..tabController = tabController
      ..index = index;
  }
}

IndexTabTitleState initState() {
  return IndexTabTitleState();
//  ..index = index;
}
