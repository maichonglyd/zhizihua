import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';

class PropDealItemState implements Cloneable<PropDealItemState> {
  Goods goods;

  @override
  PropDealItemState clone() {
    return PropDealItemState()..goods = goods;
  }
}

PropDealItemState initState(Goods goods) {
  return PropDealItemState()..goods = goods;
}
