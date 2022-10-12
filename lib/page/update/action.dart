import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';

//TODO replace with your own action
enum UpdatePageAction {
  updateStatus,
  onClick,
  clickCancel,
}

class UpdatePageActionCreator {
  static Action updateStatus(int status, double curProgress) {
    return Action(UpdatePageAction.updateStatus,
        payload: {"status": status, "curProgress": curProgress});
  }

  static Action onClick() {
    return Action(UpdatePageAction.onClick);
  }

  static Action clickCancel() {
    return Action(UpdatePageAction.clickCancel);
  }
}
