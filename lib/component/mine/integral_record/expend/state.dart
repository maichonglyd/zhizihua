import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/gold_record.dart' as gold_record;

class IntegralExpendState implements Cloneable<IntegralExpendState> {
  List<gold_record.DataList> goldRecords;
  RefreshHelperController controller;
  RefreshHelper refreshHelper;

  @override
  IntegralExpendState clone() {
    return IntegralExpendState()
      ..refreshHelper = refreshHelper
      ..controller = controller
      ..goldRecords = goldRecords;
  }
}

IntegralExpendState initState() {
  return IntegralExpendState()
    ..controller = RefreshHelperController()
    ..goldRecords = List()
    ..refreshHelper = RefreshHelper();
}
