import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/state.dart';

class JpFragmentState implements Cloneable<JpFragmentState> {
  List<JPGameItemState> jpGameStates;
  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;
  int index;

  @override
  JpFragmentState clone() {
    return JpFragmentState()
      ..jpGameStates = jpGameStates
      ..index = index
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

JpFragmentState initState() {
  return JpFragmentState()
    ..jpGameStates = new List()
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController();
}
