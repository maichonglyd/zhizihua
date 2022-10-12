import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';

//TODO replace with your own action
enum ActivityListAction { action, getData, updateData }

class ActivityListActionCreator {
  static Action onAction() {
    return const Action(ActivityListAction.action);
  }

  static Action getData(int page) {
    return Action(ActivityListAction.getData, payload: page);
  }

  static Action updateData(List<New> dataList) {
    return Action(ActivityListAction.updateData, payload: dataList);
  }
}
