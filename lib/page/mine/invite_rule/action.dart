import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum InviteRuleAction { action }

class InviteRuleActionCreator {
  static Action onAction() {
    return const Action(InviteRuleAction.action);
  }
}
