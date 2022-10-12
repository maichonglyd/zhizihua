import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';

class ActivityListState implements Cloneable<ActivityListState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  List<New> dataList = [];
  int type = 0;

  @override
  ActivityListState clone() {
    return ActivityListState()
      ..dataList = dataList
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper
      ..type = type;
  }
}

ActivityListState initState(Map<String, dynamic> args) {
  return ActivityListState()
    ..dataList = List()
    ..refreshHelperController = RefreshHelperController()
    ..refreshHelper = RefreshHelper();
}
