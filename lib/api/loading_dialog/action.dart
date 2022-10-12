import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LoadingDialogAction { loadOK }

class LoadingDialogActionCreator {
  static Action loadOK() {
    return const Action(LoadingDialogAction.loadOK);
  }
}
