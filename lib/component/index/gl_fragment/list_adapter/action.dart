import 'package:fish_redux/fish_redux.dart';

//这个类都要不然联系不上adapter
enum GlAdapterAction { action }

class GlAdapterActionCreator {
  static Action onAction() {
    return const Action(GlAdapterAction.action);
  }
}
