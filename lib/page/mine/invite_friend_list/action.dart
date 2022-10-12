import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/share_men_list_data.dart';

//TODO replace with your own action
enum InviteListAction { action, getShareMemList, update }

class InviteListActionCreator {
  static Action onAction() {
    return const Action(InviteListAction.action);
  }

  static Action getShareMemList(int page) {
    return Action(InviteListAction.getShareMemList, payload: page);
  }

  static Action update(List<Mem> mems) {
    return Action(InviteListAction.update, payload: mems);
  }
}
