import 'package:fish_redux/fish_redux.dart';

enum IndexBannerAction { onClick, onIndexChange }

class IndexBannerActionCreator {
  static Action onClick(int index) {
    return Action(IndexBannerAction.onClick, payload: index);
  }

  static Action onIndexChange(int index) {
    return Action(IndexBannerAction.onIndexChange, payload: index);
  }
}
