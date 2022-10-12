import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GmGameAction { action }

class GmGameActionCreator {
  static Action onAction() {
    return const Action(GmGameAction.action);
  }
}
