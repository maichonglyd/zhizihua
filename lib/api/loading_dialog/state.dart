import 'package:fish_redux/fish_redux.dart';

class LoadingDialogState implements Cloneable<LoadingDialogState> {

  bool loading=true;

  @override
  LoadingDialogState clone() {
    return LoadingDialogState()
    ..loading  = loading;
  }
}

LoadingDialogState initState(Map<String, dynamic> args) {
  return new LoadingDialogState();
}
