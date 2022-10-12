import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GalleryAction { action, back }

class GalleryActionCreator {
  static Action onAction() {
    return const Action(GalleryAction.action);
  }

  static Action back() {
    return const Action(GalleryAction.back);
  }
}
