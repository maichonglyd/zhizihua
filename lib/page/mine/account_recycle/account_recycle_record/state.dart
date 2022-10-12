import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/recycle_explain.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';

class AccountRecycleRecordState
    implements Cloneable<AccountRecycleRecordState> {
  RecycleList recycleList;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  RecycleExplain recycleExplain;

  @override
  AccountRecycleRecordState clone() {
    return AccountRecycleRecordState()
      ..recycleList = recycleList
      ..refreshHelper = refreshHelper
      ..recycleExplain = recycleExplain
      ..refreshHelperController = refreshHelperController;
  }
}

AccountRecycleRecordState initState(Map<String, dynamic> args) {
  return AccountRecycleRecordState();
}
