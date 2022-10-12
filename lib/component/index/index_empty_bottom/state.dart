import 'package:fish_redux/fish_redux.dart';

class IndexEmptyBottomState implements Cloneable<IndexEmptyBottomState> {

  @override
  IndexEmptyBottomState clone() {
    return IndexEmptyBottomState();
  }
}

IndexEmptyBottomState initState(Map<String, dynamic> args) {
  return IndexEmptyBottomState();
}
