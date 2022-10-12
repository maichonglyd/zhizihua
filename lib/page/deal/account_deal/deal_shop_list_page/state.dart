import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

class DealShopListPageState implements Cloneable<DealShopListPageState> {
  String title = "";
  PlayedGame playedGame;
  List<DealGoods> dealGoodsList;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  DealShopListPageState clone() {
    return DealShopListPageState()
      ..playedGame = playedGame
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..dealGoodsList = dealGoodsList;
  }
}

DealShopListPageState initState(PlayedGame playedGame) {
  return DealShopListPageState()
    ..playedGame = playedGame
    ..dealGoodsList = List();
}
