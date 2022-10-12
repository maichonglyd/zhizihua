import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DealNoticeAction { action }

class DealNoticeActionCreator {
  static Action onAction() {
    return const Action(DealNoticeAction.action);
  }
}
