import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DownLoadManageAction { action }

class DownLoadManageActionCreator {
  static Action onAction() {
    return const Action(DownLoadManageAction.action);
  }
}
