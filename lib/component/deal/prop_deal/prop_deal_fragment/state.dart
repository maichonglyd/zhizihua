import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_filter/state.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_filter/state.dart'
    as filter_state;

class PropDealFragmentState implements Cloneable<PropDealFragmentState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  DealPropIndexData dealPropIndexData;
  PropDealFilterState propDealFilterState;
  List<Goods> goodsList;

  @override
  PropDealFragmentState clone() {
    return PropDealFragmentState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..dealPropIndexData = dealPropIndexData
      ..propDealFilterState = propDealFilterState
      ..goodsList = goodsList;
  }
}

PropDealFragmentState initState() {
  return PropDealFragmentState()
    ..propDealFilterState = filter_state.initState(null)
    ..goodsList = List();
}
