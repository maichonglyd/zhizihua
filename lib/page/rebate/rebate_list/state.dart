import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_record.dart';

class RebateRecordListState implements Cloneable<RebateRecordListState> {
  List<RebateRecord> records;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  RebateRecordListState clone() {
    return RebateRecordListState()
      ..records = records
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

RebateRecordListState initState(Map<String, dynamic> args) {
  return RebateRecordListState()..records = List();
}
