import 'package:fish_redux/fish_redux.dart';

class DealNoticeState implements Cloneable<DealNoticeState> {
  @override
  DealNoticeState clone() {
    return DealNoticeState();
  }
}

DealNoticeState initState(Map<String, dynamic> args) {
  return DealNoticeState();
}
