import 'package:fish_redux/fish_redux.dart';

class MustPlayDailyState implements Cloneable<MustPlayDailyState> {
  @override
  MustPlayDailyState clone() {
    return MustPlayDailyState();
  }
}

MustPlayDailyState initState(Map<String, dynamic> args) {
  return MustPlayDailyState();
}
