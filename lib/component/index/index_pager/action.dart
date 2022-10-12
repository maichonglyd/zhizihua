import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexViewPagerAction { action }

class IndexViewPagerActionCreator {
  static Action onAction() {
    return const Action(IndexViewPagerAction.action);
  }
}
