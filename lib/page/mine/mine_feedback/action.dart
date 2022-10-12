import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FeedbackAction {
  action,
  update,
  feedback,
}

class FeedbackActionCreator {
  static Action onAction() {
    return const Action(FeedbackAction.action);
  }

  static Action update() {
    return const Action(FeedbackAction.update);
  }

  static Action feedback() {
    return const Action(FeedbackAction.feedback);
  }
}
