import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexNewsAction { action, gotoWeb }

class IndexNewsActionCreator {
  static Action onAction() {
    return const Action(IndexNewsAction.action);
  }

  static Action gotoWeb(String title, String url) {
    return Action(IndexNewsAction.gotoWeb,
        payload: {"title": title, "url": url});
  }
}
