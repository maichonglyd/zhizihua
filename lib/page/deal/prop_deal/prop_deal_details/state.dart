import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/base/BaseState.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';

class PropDealDetailsState extends BaseState
    implements Cloneable<PropDealDetailsState> {
  int goodsId;
  Goods goods;
  @override
  PropDealDetailsState clone() {
    return PropDealDetailsState()
      ..goodsId = goodsId
      ..goods = goods;
  }
}

PropDealDetailsState initState(int goodsId) {
  return PropDealDetailsState()..goodsId = goodsId;
}
