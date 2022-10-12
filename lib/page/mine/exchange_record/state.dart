import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/exchange_record_list_data.dart';

class ExchangeRecordState implements Cloneable<ExchangeRecordState> {
  List<ExchangeBean> list;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  ExchangeRecordState clone() {
    return ExchangeRecordState()
      ..list = list
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

ExchangeRecordState initState(Map<String, dynamic> args) {
  return ExchangeRecordState()..list = List();
}
