import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum JpAdapterAction { action }

class JpAdapterActionCreator {
  static Action onAction() {
    return const Action(JpAdapterAction.action);
  }
}
