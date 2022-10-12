import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/exchange_detail_data.dart';
import 'package:flutter_huoshu_app/model/user/exchange_record_list_data.dart';

class ExchangeRecordDetailsState
    implements Cloneable<ExchangeRecordDetailsState> {
  ExchangeBean exchangeBean;
  ExchangeDetail exchangeDetail;
  @override
  ExchangeRecordDetailsState clone() {
    return ExchangeRecordDetailsState()
      ..exchangeBean = exchangeBean
      ..exchangeDetail = exchangeDetail;
  }
}

ExchangeRecordDetailsState initState(ExchangeBean exchangeBean) {
  return ExchangeRecordDetailsState()..exchangeBean = exchangeBean;
}
