import 'package:fish_redux/fish_redux.dart';

class JPTopItemState implements Cloneable<JPTopItemState> {
  @override
  JPTopItemState clone() {
    return JPTopItemState();
  }
}

JPTopItemState initState(Map<String, dynamic> args) {
  return JPTopItemState();
}
