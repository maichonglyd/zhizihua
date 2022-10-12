import 'package:fish_redux/fish_redux.dart';

class IndexViewPagerState implements Cloneable<IndexViewPagerState> {
  @override
  IndexViewPagerState clone() {
    return IndexViewPagerState();
  }
}

IndexViewPagerState initState() {
  return IndexViewPagerState();
}
