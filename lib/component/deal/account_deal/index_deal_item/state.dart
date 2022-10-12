import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';

class IndexDealItemState implements Cloneable<IndexDealItemState> {
  DealGoods dealGoods;
  @override
  IndexDealItemState clone() {
    return IndexDealItemState()..dealGoods = dealGoods;
  }
}

IndexDealItemState initState(DealGoods dealGoods) {
  return IndexDealItemState()..dealGoods = dealGoods;
}
