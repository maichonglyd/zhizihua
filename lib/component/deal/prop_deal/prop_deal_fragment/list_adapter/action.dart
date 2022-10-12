import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PropDealListAdapterAction { action }

class PropDealListAdapterActionCreator {
  static Action onAction() {
    return const Action(PropDealListAdapterAction.action);
  }
}
