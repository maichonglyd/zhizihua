import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class IndexRecommendState implements Cloneable<IndexRecommendState> {
  @override
  IndexRecommendState clone() {
    return IndexRecommendState();
  }
}

IndexRecommendState initState(Map<String, dynamic> args) {
  return IndexRecommendState();
}
