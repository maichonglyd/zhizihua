import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GMGameFragmentState implements Cloneable<GMGameFragmentState> {
  int type = 0; //0 gm游戏 1 gm助手
  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;
  List<Game> gameList = List();

  @override
  GMGameFragmentState clone() {
    return GMGameFragmentState()
      ..type = type
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..gameList = gameList;
  }
}

GMGameFragmentState initState(int type) {
  return GMGameFragmentState()
    ..gameList = List()
    ..type = type
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController();
}
