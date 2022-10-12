import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';

//TODO replace with your own action
enum AppAction {
  onInitSetting,
  onInitUserAgent,
}

class AppActionCreator {
  static Action onInitSetting() {
    return const Action(AppAction.onInitSetting);
  }

  static Action onInitUserAgent() {
    return const Action(AppAction.onInitUserAgent);
  }
}
