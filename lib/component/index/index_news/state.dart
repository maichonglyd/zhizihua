import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

class IndexNewsState implements Cloneable<IndexNewsState> {
  List<AppIndexTextListData> news = List();
  @override
  IndexNewsState clone() {
    return IndexNewsState()..news = news;
  }
}

IndexNewsState initState() {
  return IndexNewsState()..news = List();
}
