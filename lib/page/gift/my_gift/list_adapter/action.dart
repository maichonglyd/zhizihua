import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MyGiftLiatAdapterAction { action }

class MyGiftLiatAdapterActionCreator {
  static Action onAction() {
    return const Action(MyGiftLiatAdapterAction.action);
  }
}
