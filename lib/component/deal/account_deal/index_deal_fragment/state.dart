import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item_title/state.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_item_title/state.dart'
    as deal_title_state;

class IndexDealFragmentState implements Cloneable<IndexDealFragmentState> {
  List<DealGoods> dealGoods;
  DealIndexData dealIndexData;
  DealItemTitleState dealItemTitleState;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  IndexDealFragmentState clone() {
    return IndexDealFragmentState()
      ..dealGoods = dealGoods
      ..dealIndexData = dealIndexData
      ..dealItemTitleState = dealItemTitleState
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

IndexDealFragmentState initState() {
  return IndexDealFragmentState()
    ..dealGoods = List()
    ..dealItemTitleState = deal_title_state.initState(getText(name: 'textLatestSale'));
}
