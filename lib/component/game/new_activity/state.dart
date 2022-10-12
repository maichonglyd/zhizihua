import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

class NewActivityState implements Cloneable<NewActivityState> {
  List<HomeNotice> news = List();
  @override
  NewActivityState clone() {
    return NewActivityState()..news = news;
  }
}

NewActivityState initState() {
  return NewActivityState()..news = List();
}
