import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';

class IndexTopTabComponentState
    with GlobalBaseState<IndexTopTabComponentState> {
  List<IndexTopTabBean> list = [];
  int isBT = 1;
  int isZK = 1;
  int isH5 = 1;

  @override
  IndexTopTabComponentState clone() {
    return IndexTopTabComponentState()
      ..copyGlobalFrom(this)
      ..list = list
      ..isBT = isBT
      ..isZK = isZK
      ..isH5 = isH5;
  }
}

IndexTopTabComponentState initState(List<IndexTopTabBean> list) {
  return IndexTopTabComponentState()
    ..list = list;
}
