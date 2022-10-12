import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/gold_record.dart' as gold_record;

class IntegralIncomeState implements Cloneable<IntegralIncomeState> {
  List<gold_record.DataList> goldRecords;
  RefreshHelperController controller;
  RefreshHelper refreshHelper;

  @override
  IntegralIncomeState clone() {
    return IntegralIncomeState()
      ..controller = controller
      ..goldRecords = goldRecords
      ..refreshHelper = refreshHelper;
  }
}

IntegralIncomeState initState() {
  return IntegralIncomeState()
    ..controller = RefreshHelperController()
    ..goldRecords = List()
    ..refreshHelper = RefreshHelper();
}
