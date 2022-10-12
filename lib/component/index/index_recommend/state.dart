import 'package:fish_redux/fish_redux.dart';

class IndexRecommendState implements Cloneable<IndexRecommendState> {
  @override
  IndexRecommendState clone() {
    return IndexRecommendState();
  }
}

IndexRecommendState initState(Map<String, dynamic> args) {
  return IndexRecommendState();
}
