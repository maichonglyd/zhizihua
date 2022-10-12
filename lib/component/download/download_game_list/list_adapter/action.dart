import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DownloadGameListAction { action }

class DownloadGameListActionCreator {
  static Action onAction() {
    return const Action(DownloadGameListAction.action);
  }
}
