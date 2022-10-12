import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';

class DealDetailsState implements Cloneable<DealDetailsState> {
  int goodsId;
  DealGoods dealGoods;
  DealPayInfoData dealPayInfoData;

  @override
  DealDetailsState clone() {
    return DealDetailsState()
      ..goodsId = goodsId
      ..dealPayInfoData = dealPayInfoData
      ..dealGoods = dealGoods;
  }
}

DealDetailsState initState(int goodsId) {
  return DealDetailsState()..goodsId = goodsId;
}
