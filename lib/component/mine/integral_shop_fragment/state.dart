import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';

class IntegralShopFragmentState
    implements Cloneable<IntegralShopFragmentState> {
  List<Goods> goodsList;
  int isReal = 1;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  IntegralShopFragmentState clone() {
    return IntegralShopFragmentState()
      ..goodsList = goodsList
      ..refreshHelper = refreshHelper
      ..isReal = isReal
      ..refreshHelperController = refreshHelperController;
  }
}

IntegralShopFragmentState initState(int isReal) {
  return IntegralShopFragmentState()
    ..goodsList = List()
    ..isReal = isReal;
}
