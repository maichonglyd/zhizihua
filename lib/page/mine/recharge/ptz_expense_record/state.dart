import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/ptb_consume_record.dart';

class PtbExpenseState implements Cloneable<PtbExpenseState> {
  List<Consume> consumes;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  PtbExpenseState clone() {
    return PtbExpenseState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..consumes = consumes;
  }
}

PtbExpenseState initState(Map<String, dynamic> args) {
  return PtbExpenseState()..consumes = List();
}
