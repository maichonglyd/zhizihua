import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/ptb_recharge_record.dart';

class PtzIncomeState implements Cloneable<PtzIncomeState> {
  List<Recharge> records;
  RefreshHelper refreshHelper = new RefreshHelper();
  RefreshHelperController refreshHelperController =
      new RefreshHelperController();

  @override
  PtzIncomeState clone() {
    return PtzIncomeState()
      ..records = records
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

PtzIncomeState initState(Map<String, dynamic> args) {
  return PtzIncomeState()..records = List();
}
